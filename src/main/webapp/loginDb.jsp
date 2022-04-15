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


<%

String name = request.getParameter("username");
String password = request.getParameter("password");
String empLogin = request.getParameter("empLogin");// on / null
//System.out.println(empLogin);

//creating connection to the database 
MongoClient mongoClient = new MongoClient("localhost", 27017);

MongoDatabase db = mongoClient.getDatabase("LoginDb");
MongoCollection<Document> collection = db.getCollection("customers");
FindIterable<Document> iter = collection.find();

MongoCursor<Document> cursor = iter.iterator();
int flag = 0;
Document result = null;
while(cursor.hasNext()){
	result = (Document) cursor.next();
	String dbname = result.getString("email"); 
	String dbpass = result.getString("pass"); 
	if(dbname != null && name.equals(dbname))
	{
		
		//System.out.println("login" + dbname + " "+ name );
		if(password.equals(dbpass) )
		{
			flag = 1;
			break;

			
		}
		flag = 2;
	
	}
	
		//System.out.println("login" + dbname + " "+ name );


	
	}
if(flag == 1){
	session.setAttribute("userName", name);
	session.setAttribute("empLogin", empLogin);
	request.setAttribute("status", "success");
	%>	
	
	<jsp:forward page="index.jsp">
		<jsp:param name="login" value = "success"/>
		 </jsp:forward>
		

<%
}
else if(flag == 2)
{
	session.setAttribute("userName", name);
	session.setAttribute("empLogin", empLogin);
	request.setAttribute("status", "falied");
%>
	<jsp:forward page="login.jsp">
<jsp:param name="login" value= "falied"/>
 </jsp:forward>

<%
}
else{
	session.setAttribute("userName", null);
	session.setAttribute("empLogin", empLogin);
	request.setAttribute("status", "falied");
	%>
	<jsp:forward page="login.jsp">
<jsp:param name="login" value= "falied"/>
 </jsp:forward>

<%

	
}

%>

</body>
</html>