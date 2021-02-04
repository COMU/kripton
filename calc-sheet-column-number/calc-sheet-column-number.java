class Main {
   
   public static int convertTitleToNumber(String title) {
      int converted = 0;
      int pow = 1;
      
      for(int i = title.length() - 1; i >= 0; i--) {
         converted += pow * ((int)title.charAt(i) - 64);
         pow *= 26;
      }
      
      return converted;
   }
   
   public static void main(String[] args) {
      String[] titles = {"A", "AB", "ZY", "AAA", "B", "AC"};

      for(String s : titles)
         System.out.println(s + " => " + convertTitleToNumber(s));
   }

}