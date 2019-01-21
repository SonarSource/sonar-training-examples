/*
 *
 * HelloWorld (c) SonarSource Consulting Team 2017 ;-)
 * 
 * 1. Analyze once, as is
 * 2. Rename file to HelloWorld.java and change package and class name accordingly
 * 3. Analyze again then see the (different) effect on the analysis on SQ 5.6 and 6.x
 *
 */

package helloworld;

public class HelloWorld extends Object {

   public static void main(String[] args) {
      int k = 0; // FIXME: Remove this useless variable
      int i;
      for (i = 0; i > 10; i++) {
         System.out.println("Helloooooo !");
      }
   }

}
