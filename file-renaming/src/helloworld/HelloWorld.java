/*
 *
 * (c) SonarSource Consulting Team 2017 ;-)
 *
 * 1. Analyze once, as is
 * 2. Run ./rename.sh to rename the file, its directory, its package and its class
 * 3. Analyze again and see that the issues kept their history
 *
 * Keep the class name out of the comments above: SonarQube only follows a renamed file
 * when the new content is similar enough to the old one.
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
