(define (filter pred x)
  (if (null? x)
    x
    (if (pred (car x))
      (cons (car x) (filter pred (cdr x)))
      (filter pred (cdr x)))))

(define (readlines)
  (let
    (
      (line (read-line))
    )
    (if (eof-object? line)
      '()
      (cons line (readlines)))))

(define (product x y)
  (if (null? x)
    x
    (append
      (map (lambda (v) (cons (car x) v)) y)
      (product (cdr x) y))))

(define (find x)
  (filter (lambda (x) (eq? 2020 (+ (car x) (cdr x)))) (product x x)))

(display (find (map string->number (readlines))))

(define (find3 x)
  (filter (lambda (x) (eq? 2020 (+ (car x) (cadr x) (cddr x)))) (product x (product x x))))

(display (find3 (map string->number (readlines))))
