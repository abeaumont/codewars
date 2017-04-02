(ns kata)

(defn even-or-odd [number]
  (if (zero? (mod number 2)) "Even" "Odd"))
