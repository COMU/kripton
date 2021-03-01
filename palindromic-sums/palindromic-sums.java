import java.lang.Math;
import java.util.*;

class Main {
   public static long checkForPalindromicSums(long limit) {
      HashSet<Long> acceptedPalindromes = new HashSet<>();
      int root = (int) Math.floor(Math.sqrt(limit/2));
      long sum = 0;
      long squareSums = 0;
      
      for(int k = 1; k < root; k++) {
         for(int n = k+1; n < root; n++) {
            squareSums = (long) Math.floor((n*(n+1)*(2*n+1) - k*(k-1)*(2*k-1))/6);          //k^2 + (k+1)^2 + (k+2)^2+...+(k+n-1)^2
            
            if(squareSums > limit)
               break;
               
            if(!acceptedPalindromes.contains(squareSums) && isPalindrome(squareSums)) {
               sum += squareSums;
               acceptedPalindromes.add(squareSums);
            }
         }
      }
      
      return sum;
   }
   
   private static boolean isPalindrome(long number) {
      String str = number+"";
      int n = str.length();
      
      for (int i = 0; i < n/2; i++) {
         if (str.charAt(i) != str.charAt(n - i - 1)) {
             return false;
         }
      }
   
      return true;
   }
   
   public static void main(String[] args) {
   
      long limit = 100000000;
      
      System.out.println("Palindromic sums under 10^8 : " + checkForPalindromicSums(limit));
      
   }
   

}