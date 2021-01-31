/**
 * @param {string} s
 * @return {number}
 */
function titleToNumber(s) {
    let result = 0;
    let unit = 1;

    for (let i = 0, j = s.length - 1; i < s.length; i++, j--){
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