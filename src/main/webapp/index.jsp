<%@page import="com.mongodb.BasicDBList"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.lang.reflect.Array"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@page import="com.mongodb.MongoClient"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.FindIterable" %>
<%@page import="com.mongodb.client.MongoCursor" %>
<%@page import="com.mongodb.BasicDBObject" %>

<html>
<head>
<meta charset="UTF-8">
<title>MongoDb App</title>
<!-- CSS only -->
<link rel="stylesheet" href="style.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">
</head>
<body>

<%@include file="landing.jsp" %>

	<table id="dtBasicExample" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
		<thead>
		    <tr>
		      <th class="th-sm">Name
		      </th>
		      <th class="th-sm">User Name
		      </th>
		      <th class="th-sm">Email
		      </th>
		      <th class="th-sm">Accounts
		      </th>
		    </tr>
 		</thead>
	<tbody>
	<% 
		MongoClient mongoClient = new MongoClient("localhost", 27017);
		
		MongoDatabase db = mongoClient.getDatabase("sample_analytics");
		
		MongoCollection<Document> collection = db.getCollection("customers");
		FindIterable<Document> iter = collection.find();

		if(!search_value.isEmpty()){
			Document regexQuery = new Document();
			regexQuery.append("$regex", String.format(".*((?i)%s).*", search_value));
			BasicDBList obj = new BasicDBList();
			obj.add(new BasicDBObject("name", regexQuery));
			obj.add(new BasicDBObject("address", regexQuery));
			obj.add(new BasicDBObject("email", regexQuery));
			obj.add(new BasicDBObject("birthdate", regexQuery));
			BasicDBObject query = new BasicDBObject("$or",obj);

			iter = collection.find(query);
		}
		
		MongoCursor<Document> cursor = iter.iterator();
		
		Document result = null;
		while(cursor.hasNext()){
			result = (Document) cursor.next();
	%>		
	    <tr>
	      <td><%= result.getString("name") %></td>
	      <td><a href="customerDetails.jsp?Id=<%=result.get("_id")%>" class="link-primary"><%= result.getString("username") %></a></td>
	      <td><%= result.getString("email") %></td>
	      <%
	     
	    	ArrayList <Integer> account = (ArrayList<Integer>) result.get("accounts");
	    	
	    	StringBuilder sb = new StringBuilder();
	      	String st = "";
	      %> <td>
	      
	      <%
	 for (int i = 0 ; i <account.size(); i ++)
	 {
		
			 st = account.get(i).toString();
		
	      %>
	      
	   <a href="accountDetails.jsp?Id=<%=st%>&userid =<%=result.get("_id")%> " class="link-primary"><%=st%></a>
	    	<%
	    	}
	      

	    %>
	    </td>	
	    </tr>
			
	<%		
		}
	%>  
	</tbody>
</table>
	<script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.21/js/jquery.dataTables.min.js"
      integrity="sha512-BkpSL20WETFylMrcirBahHfSnY++H2O1W+UnEEO4yNIl+jI2+zowyoGJpbtk6bx97fBXf++WJHSSK2MV4ghPcg=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    ></script>
    <script src="script.js"></script>
</body>
</html>