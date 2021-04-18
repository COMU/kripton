use std::collections::HashSet;
use std::time::Instant;

/*
Strong Repunits
Problem 346

The number 7 is special, because 7 is 111 written in base 2, and 11 written in base 6
(i.e. 7(10) = 11(6) = 111(2)). In other words, 7 is a repunit in at least two bases b > 1.

We shall call a positive integer with this property a strong repunit.
It can be verified that there are 8 strong repunits below 50: {1,7,13,15,21,31,40,43}.
Furthermore, the sum of all strong repunits below 1000 equals 15864.

Find the sum of all strong repunits below 10^12.

---

repunitNumbers = []
for n in 2 .. 1_000_000_000_000 {
    repunitcount = 0;
    for base in 2 .. n {
        if (isRepunit(n, base)) {
            repunitcount++;
        }

        if (repunitcount == 2) break;
    }

    if (repunitcount == 2) {
        repunitNumbers.add(n);
    }
}

11(x) = (1 * x^0) + (1 * x^1) = 1 + x
111(x) = (1 * x^0) + (1 * x^1) + (1 * x^2)

n < x*x


7 -> 111(2), 11(6)
13 -> 111(3), 11(12)
15 -> 1111(2), 11(14)
21 -> 111(4), 11(20)
31 -> 11111(2), 111(5), 11(30)
40 -> 1111(3), 11(39)
43 -> 111(6), 11(42)
*/

fn main() {
    let start = Instant::now();
    let limit = 1_000_000_000_000;
    let mut numbers = HashSet::new();

    numbers.insert(1);

    for base in 2..((limit as f64).sqrt().ceil() as i64) {
        let mut number = 1 + base + (base * base); //(1)111(base)
        let mut power = base * base; //(base^2)
        while number < limit {
            numbers.insert(number);
            power = power * base;
            number = number + power;
        }
    }

    let mut sum = 0;
    for number in numbers {
        sum = sum + number;
    }

    print!("Result is: {}\n", sum);
    print!("Elapsed time: {} ms", start.elapsed().as_millis());
}
