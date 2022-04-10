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
         String id = request.getParameter("Id");
         String name=request.getParameter("name");
         String address=request.getParameter("address");
         String email=request.getParameter("email");
         System.out.println(id);
         System.out.println(name);
         System.out.println(address);
         System.out.println(email);
         
         MongoClient mongoClient = new MongoClient("localhost", 27017);
         MongoDatabase db = mongoClient.getDatabase("sample_analytics");
         MongoCollection<Document> collection = db.getCollection("customers");
         
         BasicDBObject query = new BasicDBObject();
         query.put("_id",new ObjectId(id));
         
         
         BasicDBObject updateFields = new BasicDBObject();
         updateFields.put("name", name);
         updateFields.put("address", address);
         updateFields.put("email", email);
         
         BasicDBObject updateQuery = new BasicDBObject();
         updateQuery.put("$set", updateFields);
         collection.updateOne(query, updateQuery); 
         
         %>
      <% 
         response.sendRedirect("customerDetails.jsp?Id="+id);
         %> 
   </body>
</html>