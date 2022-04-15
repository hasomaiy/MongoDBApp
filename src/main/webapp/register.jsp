<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="com.mongodb.MongoClient"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.FindIterable" %>
<%@page import="com.mongodb.client.MongoCursor" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% System.out.print("from"); 

String name = request.getParameter("name");
String email = request.getParameter("email");
String pass = request.getParameter("pass");
String contact = request.getParameter("contact");
//creating connection to the database 
MongoClient mongoClient = new MongoClient("localhost", 27017);

MongoDatabase db = mongoClient.getDatabase("LoginDb");



//System.out.println(empLogin);

MongoCollection<Document> collection = db.getCollection("customers");
FindIterable<Document> iter = collection.find();

MongoCursor<Document> cursor = iter.iterator();
int flag = 0;
Document result = null;
while(cursor.hasNext()){
	result = (Document) cursor.next();
	String emailDb = result.getString("email"); 
	
	if(emailDb != null && email.equals(emailDb))
	{


			flag = 1;
			break;



	
	}
	




	
	}
if(flag == 1)
{
	
	session.setAttribute("email", email);
	
	request.setAttribute("status", "faliedRegistration");
}else{
	

	//db.createCollection("login");
	Document document = new Document();
	  document.append("name", name);
	  document.append("email", email);
	  document.append("pass", pass);
	  document.append("contact", contact);
	// inserting data in the database
	db.getCollection("customers").insertOne(document);

	session.setAttribute("email", email);
	
	request.setAttribute("status", "successRegistration");
	
	
}






%>
<jsp:forward page="login.jsp">
<jsp:param name="firstName" value="Enter First Nam" />
 </jsp:forward>

</body>
</html>