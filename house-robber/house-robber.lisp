(defun rob (houses)	 ; fonksiyon tanimi
(cond ((= (length houses) 0) ; eger ev sayısı 0 ise 0 dön
        0
          )
      ((= (length houses) 1) ; ev sayısı 1 ise ilk elemanı dön
        (aref houses 0)
      )
      (t
        		(setf result (make-array (length houses))) ; çözüm dizisi oluştur
        		(setf (aref result 0) (aref houses 0)) ; ilk eleman houses[0]
        		(setf (aref result 1) (max (aref houses 0) (aref houses 1))) ; ikinci eleman max(houses[0], houses[1])
        		(loop for i from 2 to (- (length houses) 1) ; 2den son elemana kadar result[n] = max(result[n – 1], (result[n – 2] +  houses[n]) 
        			do (setf (aref result i) (max (+ (aref houses i) (aref result (- i 2))) (aref result (- i 1) )))
        		)
        		(aref result (- (length houses) 1)) ; dizinin son elemanını dön
      )
)	
)

(print (= (rob (vector 1 2 3 1)) 4))
(print (= (rob (vector 2 7 9 3 1)) 12))
