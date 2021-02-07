let digitChain = [];

function findEightyNine(maxNumber){
    let number=0, countOfOnes=0;

    for(let i=2; i < maxNumber; i++){

        number = squareSum(i);

        if(digitChain[number] === 1){ // dizide bu sayinin bir degeri var mi ve bu degeri 1'e esit mi diye kontrol ederim
            countOfOnes++;
            continue;
        }
        if(digitChain[number] === 89){
            continue;
        }

        let result = findDigitChain(i); // dizi icerisinde bulamadiysak o zaman ornegin 44 sayisi icin 1'e mi yoksa 89'a mi gidiyor diye hesaplama yaparim.

        if(result === 1){
            countOfOnes++;
            digitChain[number] = 1;
        }else {
            digitChain[number] = 89;
        }
    }

    return (maxNumber - 2) - countOfOnes; // birlerin sayisini cikaririz
}

function squareSum(num){
    let sum = 0;
    while(num){
        sum += (num%10)*(num%10);
        num = Math.floor(num/10);
    }

    return sum;
}

function findDigitChain(num){
    let x = num;
    while(x !== 1 && x !== 89){
        if(digitChain[x] === 89){
            return 89;
        }
        if(digitChain[x] === 1){
            return 1;
        }

        x = squareSum(x);
    }

    return x;
}

console.log(findEightyNine(10_000_000));