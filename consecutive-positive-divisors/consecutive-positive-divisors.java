class Main {

   public static int consecutivePositiveDivisors(int maxNumber){
   
       int count = 0;
   
       int[] newNumberDivisorArray = calculateDivisorsCount(maxNumber);
      
       for(int i = 2; i < maxNumber; i++) {
           count = newNumberDivisorArray[i] == newNumberDivisorArray[i+1] ? count + 1 : count;
       }
   
       return count;
   }

   public static int[] calculateDivisorsCount(int num) {
       int[] numberDivisorArray = new int[num+1];
   
       for(int i = 1; i <= num; i++){
           for(int j = 1; i*j <= num; j++){
               numberDivisorArray[i*j]++;
           }
       }
   
       return numberDivisorArray;
   }
   
   public static void main(String[] args) {
      System.out.println(consecutivePositiveDivisors(10000000));
   }

}