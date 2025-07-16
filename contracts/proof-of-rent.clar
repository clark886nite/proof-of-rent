;; ProofOfRent - On-Chain Rent Payment Tracker

(define-constant contract-owner tx-sender)

(define-map rent-agreements
  { tenant: principal }
  {
    landlord: principal,
    monthly-rent: uint,
    start-block: uint,
    end-block: uint
  })

(define-map rent-payments
  { tenant: principal, month: uint }
  { paid: bool, timestamp: uint })

;; Landlord registers rent agreement with tenant
(define-public (register-agreement (tenant principal) (monthly-rent uint) (duration-months uint))
  (let ((start stacks-block-height)
        (end (+ stacks-block-height (* duration-months u144)))) ;; Assuming ~144 blocks per month
    (begin
        (asserts! (is-eq tx-sender contract-owner) (err u100))
        (map-set rent-agreements { tenant: tenant } {
        landlord: tx-sender,
        monthly-rent: monthly-rent,
        start-block: start,
        end-block: end
      })
      (ok { agreement: "created", tenant: tenant }))))


;; Tenant pays rent for a given month
(define-public (pay-rent (month uint))
  (let (
        (agreement (unwrap! (map-get? rent-agreements { tenant: tx-sender }) (err u101)))
        (expected (get monthly-rent agreement))
        (already-paid (is-some (map-get? rent-payments { tenant: tx-sender, month: month })))
        (amount (stx-get-balance tx-sender)))
    (begin
      (asserts! (is-eq already-paid false) (err u102))
      (asserts! (is-eq amount expected) (err u103))
      (map-set rent-payments { tenant: tx-sender, month: month } {
        paid: true,
        timestamp: stacks-block-height
      })
      (try! (stx-transfer? amount (as-contract tx-sender) (get landlord agreement)))
      (ok { status: "paid", month: month }))))


;; Read-only: verify if rent is paid
(define-read-only (check-payment (tenant principal) (month uint))
  (ok (map-get? rent-payments { tenant: tenant, month: month })))

;; Read-only: view agreement
(define-read-only (get-agreement (tenant principal))
  (map-get? rent-agreements { tenant: tenant }))
