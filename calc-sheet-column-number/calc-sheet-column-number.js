/**
 * @param {string} s
 * @return {number}
 */
function titleToNumber(s) {
    let result = 0;
    let unit = 1;

    for (let j = s.length - 1; j >= 0; j--){
        result += (convertCharToAscii(s.charAt(j)) - 64) * unit;
        unit *= 26;
    }

    return result;
}

function convertCharToAscii(inputChar){
    let index = 0;
    return inputChar.charCodeAt(index);
}

console.log(titleToNumber("A"));
console.log(titleToNumber("AB"));
console.log(titleToNumber("ZY"));
console.log(titleToNumber("AAA"));
