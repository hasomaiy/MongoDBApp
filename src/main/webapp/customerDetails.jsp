<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="com.mongodb.MongoClient"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.BasicDBObject" %>
<%@page import="com.mongodb.client.MongoCursor" %>
<%@page import="org.bson.types.ObjectId" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
	<% 
		String id = request.getParameter("Id");
	%>

	<% 
		MongoClient mongoClient = new MongoClient("localhost", 27017);
		MongoDatabase db = mongoClient.getDatabase("sample_analytics");
		MongoCollection<Document> collection = db.getCollection("customers");
		
		BasicDBObject query = new BasicDBObject();
		query.put("_id",new ObjectId(id));

		MongoCursor<Document> cursor = collection.find(query).iterator();

		Document result = null;
		while(cursor.hasNext()){
			result = (Document) cursor.next();
	%>
	
<div class="container bootstrap snippets bootdey">
	<div class="panel-body inf-content">
	    <div class="row">
	        <div class="col-md-4">
	            <img alt="" style="width:400px;" title="" class="img-circle img-thumbnail isTooltip" src="https://bootdey.com/img/Content/avatar/avatar7.png" data-original-title="Usuario"> 
	        </div>
	        <div class="col-md-6">
	            <strong>Information</strong><br>
	            <div class="table-responsive">
	            <table class="table table-user-information">
	                <tbody>
	                    <tr>        
	                        <td>
	                            <strong>
	                                <span class="glyphicon glyphicon-asterisk text-primary"></span>
	                                Name                                                
	                            </strong>
	                        </td>
	                        <td class="text-primary">
	                            <%= result.getString("name") %>
	                        </td>
	                    </tr>
	                    <tr>    
	                        <td>
	                            <strong>
	                                <span class="glyphicon glyphicon-user  text-primary"></span>    
	                                address                                                
	                            </strong>
	                        </td>
	                        <td class="text-primary">
	                            <%= result.getString("address") %>     
	                        </td>
	                    </tr>
	                    <tr>        
	                        <td>
	                            <strong>
	                                <span class="glyphicon glyphicon-cloud text-primary"></span>  
	                                birthdate                                                
	                            </strong>
	                        </td>
	                        <td class="text-primary">
	                            <%= result.getDate("birthdate") %>   
	                        </td>
	                    </tr>
	
	                    <tr>        
	                        <td>
	                            <strong>
	                                <span class="glyphicon glyphicon-bookmark text-primary"></span> 
	                                email                                                
	                            </strong>
	                        </td>
	                        <td class="text-primary">
	                            <%= result.getString("email") %>   
	                        </td>
	                    </tr>                        
	                </tbody>
	            </table>
	            
	            <table class="table table-striped">
				  <thead>
				    <tr>
				      <th scope="col">#</th>
				      <th scope="col">Tier</th>
				      <th scope="col">Benefits</th>
				      <th scope="col">Active</th>
				    </tr>
				  </thead>
				  <tbody>
				    <tr>
				      <th scope="row">1</th>
				      <td></td>
				      <td>Otto</td>
				      <td>@mdo</td>
				    </tr>
				    <tr>
				      <th scope="row">2</th>
				      <td>Jacob</td>
				      <td>Thornton</td>
				      <td>@fat</td>
				    </tr>
				    <tr>
				      <th scope="row">3</th>
				      <td>Larry</td>
				      <td>the Bird</td>
				      <td>@twitter</td>
				    </tr>
				  </tbody>
				</table>
	            </div>
	        </div>
	    </div>
</div>
</div>
<%		
		}
	%>                                          
</body>
</html>