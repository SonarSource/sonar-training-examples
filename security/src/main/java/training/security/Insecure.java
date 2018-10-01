package training.security;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

public class Insecure {

	public void badFunction(HttpServletRequest request) throws IOException {
		String obj = request.getParameter("data");
		ObjectMapper mapper = new ObjectMapper();
		mapper.enableDefaultTyping();
		String val = mapper.readValue(obj, String.class);
		File tempDir;
		tempDir = File.createTempFile("", ".");
		tempDir.delete();
		tempDir.mkdir();
		Files.exists(Paths.get("/tmp/", obj));
	}

	public void hackRequest(HttpServletRequest request, Connection connection) {
		String user = request.getParameter("user");
		String password = "password";
		password = request.getParameter("pass");
		String query = "SELECT * FROM users WHERE user = '" + user + "' AND pass = '" + password + "'";
		try {
			java.sql.Statement statement = connection.createStatement();
			java.sql.ResultSet resultSet = statement.executeQuery(query);
			if (resultSet.next()) {
				Object obj = new Object();
				HashMap map = new HashMap<>();
				Enumeration names = request.getParameterNames();
				while (names.hasMoreElements()) {
					String name = (String) names.nextElement();
					map.put(name, request.getParameterValues(name));
				}
				BeanUtils.populate(obj, map);
			}
		} catch (Exception e) {
		}
	}

	public void modResponse(HttpServletResponse response) {
		Cookie c = new Cookie("SECRET", "SECRET");
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

}
