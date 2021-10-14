(use '[clojure.java.shell :only [sh]])

(defn getPassInfo
  [name]
  (->> name
       (sh "pass")
       (:out)
       (clojure.string/split-lines)))

(defn gen-map
  [l pass]
  (reduce (fn [res elem] (conj res (clojure.string/split elem #":")))
    {"pass" pass}
    l))

(defn parseAutotype
  [autotype info-map]
  (map (fn [x]
         (if-let [value (get info-map x)]
           `("xdotool" "type" "--clearmodifiers" ~value)
           '("xdotool" "key" "Tab")))
    (drop 1 (clojure.string/split autotype #" "))))

;; (sh "xdotool" "type --clearmodifiers 'jj'")

(let [l (getPassInfo (first *command-line-args*))
      info-map (gen-map (->> l
                             (drop-last 1)
                             (drop 1))
                        (first l))
      autotype (last l)
      cmds (parseAutotype autotype info-map)]
  (map (fn [cmd] (apply sh cmd) (Thread/sleep 10)) cmds))



