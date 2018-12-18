(ns rep.core-test
  (:require
    [clojure.test :refer :all]
    [nrepl.server]
    [rep.core])
  (:import
    (java.io ByteArrayOutputStream OutputStreamWriter)))

(defn- rep
  [& args]
  (let [server (nrepl.server/start-server)
        starting-dir (System/getProperty "user.dir")]
    (try
      (System/setProperty "user.dir" (str starting-dir "/target"))
      (spit (str starting-dir "/target/.nrepl-port") (str (:port server)))
      (let [out (ByteArrayOutputStream.)
            err (ByteArrayOutputStream.)]
        (let [exit-code (binding [*out* (OutputStreamWriter. out)
                                  *err* (OutputStreamWriter. err)]
                          (apply rep.core/rep args))]
          {:stdout (.toString out)
           :stderr (.toString err)
           :exit-code exit-code}))
      (finally
        (System/setProperty "user.dir" starting-dir)
        (nrepl.server/stop-server server)))))

(deftest t-rep
  (testing "basic evaluation of code"
    (is (= "4\n" (:stdout (rep "(+ 2 2)")))
      "non-option arguments are evaluated and the results are printed")
    (is (= "hello\nnil\n" (:stdout (rep "(println 'hello)")))
      "output is printed to stdout")
    (is (= "error" (:stderr (rep "(.write ^java.io.Writer *err* \"error\")")))
      "error is printed to stderr")
    (is (= 0 (:exit-code (rep "(+ 2 2)")))
      "exits with zero")))
