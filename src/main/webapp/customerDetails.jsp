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

					 		<td style="vertical-align : middle;text-align:center;" class="submission" rowspan="3">
	                        <a href="editCustomerDetails.jsp?Id=<%=id%>">Edit</a>
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
	                                <span class="glyphicon glyphicon-bookmark text-primary"></span> 
	                                email                                                
	                            </strong>
	                        </td>
	                        <td class="text-primary">
	                            <%= result.getString("email") %>   
	                        </td>
	                        
	                        
	                    </tr>
	                    
	                    <tr class="blank_row" rowspan="3">
    					<td colspan="3"></td>
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
				
<!-- Account details -->
<table id="dtBasicExample" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
				  <thead>
				    <tr>
				    
				      <th scope="col">Account Id</th>
				      <th scope="col">Products</th>
				      <th scope="col">Limit</th>
				      
				    </tr>
				  </thead>

	<% 	
	MongoCollection<Document> account_collection = db.getCollection("accounts");
	ArrayList<Integer> account_list = (ArrayList<Integer>)result.get("accounts");
	
		
	
   	for(int i = 0; i < account_list.size();i++)
   				{
   		
   		BasicDBObject account_query = new BasicDBObject();
   		account_query.put("account_id",account_list.get(i));
   		
   		
   			
   		MongoCursor<Document> account_cursor = account_collection.find(account_query).iterator();
   		//MongoCursor<Document> cursor = collection.find(query).iterator();
   		
   		Document account_result = null;
   		while(account_cursor.hasNext())
   		{
   			account_result = account_cursor.next();
   			
   		
			%>
	
			
				  <tbody>
				  	<tr>
				   		<td><%=account_result.getInteger("account_id") %> </td>
				  		<td><%=account_result.get("products") %> </td>
				  		<td><%=account_result.getInteger("limit") %> </td>
				  		
				  	
				  	</tr>
				  
		
				  
				  </tbody>
								
				
				
				<%
   		
   		}
   				}
   		
   	
   		 %>
   		 <th class="submission" colspan="3"><div align="center"><a href="index.jsp">Back</a> </div></th>
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