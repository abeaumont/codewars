(ns clojure.bonus)

(defn bonus-time [salary bonus]
  (str "$" (if bonus (* salary 10) salary)))
