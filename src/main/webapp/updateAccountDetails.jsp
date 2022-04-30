<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@page import="com.mongodb.MongoClient"%>
<%@page import ="java.util.ArrayList" %>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.BasicDBObject" %>
<%@page import="com.mongodb.client.MongoCursor" %>
<%@page import="org.bson.types.ObjectId" %>

<html>
   <head>
      <meta charset="ISO-8859-1">
      <title>Update Customer Details Page</title>
   </head>
   <body>
      <% 
         String username = request.getParameter("username");
         int account_id = Integer.parseInt(request.getParameter("account_id"));
         int limit = Integer.parseInt(request.getParameter("limit"));
         
         //String limit=request.getParameter("limit");
         System.out.println(username);
         System.out.println(account_id);
         System.out.println(limit);
         
         MongoClient mongoClient = new MongoClient("localhost", 27017);
         MongoDatabase db = mongoClient.getDatabase("sample_analytics");       
         MongoCollection<Document> collection = db.getCollection("accounts");
         
         BasicDBObject query = new BasicDBObject();
         query.put("account_id",account_id);
         
         
         BasicDBObject updateFields = new BasicDBObject();
         updateFields.put("limit", limit);
         
         BasicDBObject updateQuery = new BasicDBObject();
         updateQuery.put("$set", updateFields);
         collection.updateOne(query, updateQuery); 
         
         
         // Maintainig logging history
         
     	MongoDatabase logindb = mongoClient.getDatabase("LoginDb");
	
		Document document = new Document();
	  	document.append("employee_id", username);
	  	document.append("account_changed", account_id);
		document.append("limit_changed_to", limit);
		document.append("update_time", (new java.util.Date()));
		
		logindb.getCollection("updateHistory").insertOne(document);
          
         %>
      <% 
         response.sendRedirect("accountDetails.jsp?Id="+account_id);
         %> 
   </body>
</html>