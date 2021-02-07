function consecutivePositiveDivisors(maxNumber){

    let currentNumber = 0, nextNumber = 0, count = 0;

    let newNumberDivisorArray = calculateDivisorsCount(maxNumber);

    for(let i = 2; i < maxNumber; i++){
        currentNumber = i;
        nextNumber = i + 1;

        if(newNumberDivisorArray[currentNumber] === newNumberDivisorArray[nextNumber]){

            count++;
        }
    }

    return count;
}

function calculateDivisorsCount(num){
    let numberDivisorArray = [num+1];

    for(let i = 0; i < num+1; i++){
        numberDivisorArray[i] = 0;
    }

    for(let i = 1; i <= num; i++){
        for(let j = 1; i*j <= num; j++){
            numberDivisorArray[i*j]++;
        }
    }

    return numberDivisorArray;
}

consecutivePositiveDivisors(10_000_000);