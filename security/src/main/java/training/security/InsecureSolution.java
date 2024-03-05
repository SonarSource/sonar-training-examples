package training.security;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

public class InsecureSolution {

  public void badFunction(HttpServletRequest request) throws IOException {
    String obj = request.getParameter("data");
    ObjectMapper mapper = new ObjectMapper();
    // mapper.enableDefaultTyping();
    String val = mapper.readValue(obj, String.class);
    File tempDir;
    String baseDir = "/mySecureDirectory";
    tempDir = File.createTempFile("prefix", "suffix", new File(baseDir));
    tempDir.delete();
    tempDir.mkdir();
    Files.exists(Paths.get(baseDir, obj));
  }

  public String taintedSQL(HttpServletRequest request, Connection connection) throws Exception {
    String user = request.getParameter("user");
    String query = "SELECT userid FROM users WHERE username = ?";
    PreparedStatement statement = connection.prepareStatement(query);
    statement.setString(1, user);
    ResultSet resultSet = statement.executeQuery(query);
    return resultSet.getString(0);
  }
  
  public String hotspotSQL(Connection connection, String user) throws Exception {
	  PreparedStatement statement = null;
    String query =  "select userid from users WHERE username=?";
	  statement = connection.prepareStatement(query);
    statement.setString(1, user);
	  ResultSet rs = statement.executeQuery();
	  return rs.getString(0);
	}


  public void modResponse(HttpServletResponse response) {
    Cookie c = new Cookie("SECRET", "SECRET");
    c.setSecure(true);
    response.addCookie(c);
  }

  public KeyPair weakKey() {
    KeyPairGenerator keyPairGen;
    try {
      keyPairGen = KeyPairGenerator.getInstance("RSA");
      keyPairGen.initialize(512);
      return keyPairGen.genKeyPair();
    } catch (NoSuchAlgorithmException e) {
      return null;
    }
  }

  // --------------------------------------------------------------------------
  // Custom sources, sanitizer and sinks example
  // See file s3649JavaSqlInjectionConfig.json in root directory 
  // --------------------------------------------------------------------------

  public String getInput(String name) {
    // Empty (fake) source
    // To be a real source this should normally return something from an input
    // that can be user manipulated e.g. an HTTP request, a cmd line parameter, a form input...
    return "Hello World and " + name;
  }

  public void storeData(String input) {
    // Empty (fake) sink
    // To be a real sink this should normally build an SQL query from the input parameter
  }

  public void verifyData(String input) {
    // Empty (fake) sanitizer (sic)
    // To be a real sanitizer this should normally examine the input and sanitize it
    // for any attempt of user manipulation (eg escaping characters, quoting strings etc...)
  }

  public void processParam(String input) {
    // Empty method just for testing
  }

  public void doSomething() {
    String myInput = getInput("Olivier"); // Get data from a source
    processParam(myInput);
    storeData(myInput);                   // store data w/o sanitizing --> Injection vulnerability 
  }

  public void doSomethingSanitized() {
    String myInput = getInput("Cameron"); // Get data from a source
    verifyData(myInput);                  // Sanitize data
    processParam(myInput);
    storeData(myInput);                   // store data after sanitizing --> No injection vulnerability 
  }
}
