
fun convertTitleToNumber(title: String): Int{
    val base: Int = 26
    var converted: Int = 0
    var temp: Int = 0

    for (i in title.length downTo 1){
        converted += (title[i-1].toInt()-64) * calculatePow(temp,base)
        temp += 1
    }
    return converted
}

fun calculatePow(exponent: Int, base: Int): Int {
    return (Math.pow(base.toDouble(), exponent.toDouble())).toInt()
}


fun main(args: Array<String>) {
    println("Enter text: ")
    val stringInput: String = readLine()!!
    println("$stringInput :  ${convertTitleToNumber(stringInput)}")
}

