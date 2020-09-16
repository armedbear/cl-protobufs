;;; Copyright 2020 Google LLC
;;;
;;; Use of this source code is governed by an MIT-style
;;; license that can be found in the LICENSE file or at
;;; https://opensource.org/licenses/MIT.

(defpackage #:cl-protobufs.test.vector
  (:use #:cl
        #:clunit
        #:cl-protobufs.repeated-proto
        #:cl-protobufs)
  (:export :run))

(in-package #:cl-protobufs.test.vector)

(defsuite vector-suite (cl-protobufs.test:root-suite))

(defun run ()
  "Run all tests in the test suite."
  (cl-protobufs.test:run-suite 'vector-suite))

(deftest test-vector-push-extend (vector-suite)
  (let ((vector-proto (make-repeated-proto)))
    (loop for i from 1 to 1000
          do
       (assert-eq (repeated-proto.push-repeated-int32 i vector-proto) i)
       (assert-eq (repeated-proto.push-repeated-int64 i vector-proto) i)
       (assert-eq (repeated-proto.push-repeated-uint32 i vector-proto) i)
       (assert-eq (repeated-proto.push-repeated-uint64 i vector-proto) i)
       (assert-eq (repeated-proto.push-repeated-sint32 i  vector-proto) i)
       (assert-eq (repeated-proto.push-repeated-sint64 i vector-proto) i)
       (assert-eq (repeated-proto.push-repeated-fixed32 i vector-proto) i)
       (assert-eq (repeated-proto.push-repeated-fixed64 i vector-proto) i)
       (assert-eq
           (repeated-proto.push-repeated-sfixed32 i vector-proto) i)
       (assert-eql
           (repeated-proto.push-repeated-sfixed64 i vector-proto) i)
       (assert-eql (repeated-proto.push-repeated-float (coerce i 'float) vector-proto)
           (coerce i 'float))
       (assert-eql (repeated-proto.push-repeated-double (coerce i 'double-float) vector-proto)
           (coerce i 'double-float))
       (assert-eql
           (repeated-proto.push-repeated-bool (= (mod i 2) 0) vector-proto)
           (= (mod i 2) 0))
       (assert-equal
           (repeated-proto.push-repeated-string (write-to-string i) vector-proto)
           (write-to-string i)))
    (assert vector-proto)))


(deftest test-vector-push-extend-serialization (vector-suite)
  (let ((vector-proto (make-repeated-proto))
        (list-proto (make-repeated-list-proto)))
    ;; push-* returns the same value as was passed in on successful push.
    (loop for i from 1 to 10
          do
       (assert-eq (push-repeated-int32 i vector-proto) i)
       (assert-eq (push-repeated-int64 i vector-proto) i)
       (assert-eq (push-repeated-uint32 i vector-proto) i)
       (assert-eq (push-repeated-uint64 i vector-proto) i)
       (assert-eq (push-repeated-sint32 i  vector-proto) i)
       (assert-eq (push-repeated-sint64 i vector-proto) i)
       (assert-eq (push-repeated-fixed32 i vector-proto) i)
       (assert-eq (push-repeated-fixed64 i vector-proto) i)
       (assert-eq (push-repeated-sfixed32 i vector-proto) i)
       (assert-eq (push-repeated-sfixed64 i vector-proto) i)
       (assert-eq (push-repeated-float (coerce i 'float) vector-proto)
           (coerce i 'float))
       (assert-eql (repeated-proto.push-repeated-double (coerce i 'double-float)
                                                        vector-proto)
           (coerce i 'double-float))
       (assert-eql (push-repeated-bool (= (mod i 2) 0) vector-proto)
           (= (mod i 2) 0))
       (assert-equal (push-repeated-string (write-to-string i) vector-proto)
           (write-to-string i)))
    (loop for i from 1 to 10
          do
       (push i (repeated-list-proto.repeated-int32 list-proto))
       (push i (repeated-list-proto.repeated-int64 list-proto))
       (push i (repeated-list-proto.repeated-uint32 list-proto))
       (push i (repeated-list-proto.repeated-uint64 list-proto))
       (push i (repeated-list-proto.repeated-sint32 list-proto))
       (push i (repeated-list-proto.repeated-sint64 list-proto))
       (push i (repeated-list-proto.repeated-fixed32 list-proto))
       (push i (repeated-list-proto.repeated-fixed64 list-proto))
       (push i (repeated-list-proto.repeated-sfixed32 list-proto))
       (push i (repeated-list-proto.repeated-sfixed64 list-proto))
       (push (coerce i 'float) (repeated-list-proto.repeated-float list-proto))
       (push (coerce i 'double-float)
             (repeated-list-proto.repeated-double list-proto))
       (push (= (mod i 2) 0) (repeated-list-proto.repeated-bool list-proto))
       (push (write-to-string i) (repeated-list-proto.repeated-string list-proto)))
    ;; TODO(jgodbout):
    ;; This is annoying, the vector push pushes to the back
    ;; where the list push pushes to the front. Fix this...
    (setf (repeated-list-proto.repeated-int32 list-proto)
          (nreverse (repeated-list-proto.repeated-int32 list-proto)))

    (setf (repeated-list-proto.repeated-int64 list-proto)
          (nreverse (repeated-list-proto.repeated-int64 list-proto)))

    (setf (repeated-list-proto.repeated-uint32 list-proto)
          (nreverse (repeated-list-proto.repeated-uint32 list-proto)))

    (setf (repeated-list-proto.repeated-uint64 list-proto)
          (nreverse (repeated-list-proto.repeated-uint64 list-proto)))

    (setf (repeated-list-proto.repeated-sint32 list-proto)
          (nreverse (repeated-list-proto.repeated-sint32 list-proto)))

    (setf (repeated-list-proto.repeated-sint64 list-proto)
          (nreverse (repeated-list-proto.repeated-sint64 list-proto)))

    (setf (repeated-list-proto.repeated-fixed32 list-proto)
          (nreverse (repeated-list-proto.repeated-fixed32 list-proto)))

    (setf (repeated-list-proto.repeated-fixed64 list-proto)
          (nreverse (repeated-list-proto.repeated-fixed64 list-proto)))

    (setf (repeated-list-proto.repeated-sfixed32 list-proto)
          (nreverse (repeated-list-proto.repeated-sfixed32 list-proto)))

    (setf (repeated-list-proto.repeated-sfixed64 list-proto)
          (nreverse (repeated-list-proto.repeated-sfixed64 list-proto)))

    (setf (repeated-list-proto.repeated-float list-proto)
          (nreverse (repeated-list-proto.repeated-float list-proto)))

    (setf (repeated-list-proto.repeated-double list-proto)
          (nreverse (repeated-list-proto.repeated-double list-proto)))

    (setf (repeated-list-proto.repeated-bool list-proto)
          (nreverse (repeated-list-proto.repeated-bool list-proto)))

    (setf (repeated-list-proto.repeated-string list-proto)
          (nreverse (repeated-list-proto.repeated-string list-proto)))

    (let ((vector-serialized (serialize-object-to-bytes vector-proto 'repeated-proto))
          (list-serialized (serialize-object-to-bytes list-proto 'repeated-list-proto)))
      (assert-equalp vector-serialized list-serialized))))
