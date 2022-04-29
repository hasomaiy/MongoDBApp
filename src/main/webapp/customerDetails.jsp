<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@page import="com.mongodb.MongoClient"%>
<%@page import ="java.util.ArrayList" %>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.BasicDBObject" %>

<%@page import="com.mongodb.DBObject" %>
<%@page import="com.mongodb.util.JSON" %>

<%@page import="com.mongodb.client.MongoCursor" %>
<%@page import="org.bson.types.ObjectId" %>

<%@page import="java.net.HttpURLConnection" %>
<%@page import="java.net.URL" %>





<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>	
	<%@include file="landing.jsp" %>
	
	<% 
		String id = request.getParameter("Id");
				
		// (String)request.getAttribute("empLogin");
		
	String empLogin =	(String)session.getAttribute("empLogin");
		%>
	<% 
		MongoClient mongoClient = new MongoClient("localhost", 27017);
		MongoDatabase db = mongoClient.getDatabase("sample_analytics");
		MongoCollection<Document> collection = db.getCollection("customers");
		
		
		BasicDBObject query = new BasicDBObject();
		query.put("_id",new ObjectId(id));

		MongoCursor<Document> cursor = collection.find(query).iterator();

		Document result = null;
		Document newdoc = null;
		while(cursor.hasNext()){
			result = (Document) cursor.next();
			//DBObject obj = (DBObject) JSON.parse((String)result.get("tier_and_details"));
			
			//  = (DBObject)result.get("tier_and_details");
			//System.out.println("THis is"+" " +result);
			//System.out.println("THis is"+" " +obj.keySet() );
			
	%>
	
<div class="container bootstrap snippets bootdey">
	<div class="panel-body inf-content">
	    <div class="row">
	        <div class="col-md-4">      <%
	        // need to give the default path
	        String imagePath_jpg = "https://financialservicecompanyimages.s3.amazonaws.com/" + result.getString("username") + ".jpg"; 
	        String imagePath_gif = "https://financialservicecompanyimages.s3.amazonaws.com/" + result.getString("username") + ".gif"; 
	        String imagePath_PNG = "https://financialservicecompanyimages.s3.amazonaws.com/" + result.getString("username") + ".PNG"; 
	        URL url;
	        int responseCode;
	        HttpURLConnection huc;
	        String imagePath = null;
	        
	        try {
	          		url = new URL(imagePath_jpg);
	            	huc = (HttpURLConnection) url.openConnection();

	            	responseCode = huc.getResponseCode();

					//Assert.assertEquals(HttpURLConnection.HTTP_OK, responseCode);
				
					            System.out.println(responseCode);
					            

	       if(responseCode == 200)
	       {
	    	 //  System.out.println(imagePath);
	    	   imagePath = imagePath_jpg;
	       }
	        
	       
	       if(imagePath == null)
	       {
	    	   
	    					url = new URL(imagePath_gif);
           					huc = (HttpURLConnection) url.openConnection();

           					responseCode = huc.getResponseCode();
            				if(responseCode == 200)
						 	       {
						 	    	   
						 	    	   imagePath = imagePath_gif;
						 	       }
	    	   
	       }
	      
	       if(imagePath ==  null)
	       {
					    	   	url = new URL(imagePath_PNG);
					           	huc = (HttpURLConnection) url.openConnection();
				
					           	responseCode = huc.getResponseCode();
					            if(responseCode == 200)
							 	       {
							 	    	   
							 	    	   imagePath = imagePath_PNG;
							 	       }
	    	   
	    	   
	       }
	       
	        
	        } catch (Exception E) {
	            System.out.println(E);
	        }
	        
	       
	        %>
	        
	        
	        
	        
	        
	            <img alt="" style="width:400px;" title="" class="img-circle img-thumbnail isTooltip" src= "<%= imagePath %>" data-original-title="Usuario"> 
	        
	        
	        
	        
	        
	        
	        
	        <%
	      ///  if(session.getAttribute("empLogin")== "null")
	       // {
	        	
	      //  }
	        imagePath = null;
	        %>
	        
	           
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
							<% System.out.println(empLogin);
							if (empLogin != null && empLogin.equals("on"))
							{
							%>
					 		<td style="vertical-align : middle;text-align:center;" class="submission" rowspan="3">
	                        <a href="editCustomerDetails.jsp?Id=<%=id%>">Edit</a>
	                        </td>
	                        <%} %>

	                      
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
	            <%
	            Document obj = (Document)result.get("tier_and_details");
	            if(!obj.isEmpty())
	            {
	            %>
				  <thead>
				    <tr>
				      <th scope="col">Tier</th>
				      <th scope="col">Benefits</th>
				      <th scope="col">Active</th>
				    </tr>
				  </thead>
				   <%
	           
				//System.out.println("THis is"+" " +obj);
				for(String key : obj.keySet())
				{
					Document obj_under = (Document)	obj.get(key);
				//	System.out.println(obj_under.getString("tier"));
					
			
	            
	            
	            
	            %>
				  <tbody>
				    <tr>
				      <td><%=obj_under.getString("tier")%></td>
				      <td><%=obj_under.get("benefits")%></td>
				      <td><%=obj_under.get("active")%></td>
				    </tr>
			
				  </tbody>
				  <%
				}
	            }
				%>
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
				   		<td> <a href="accountDetails.jsp?Id=<%=account_result.getInteger("account_id").toString()%>" 
				   		class="link-primary"><%=account_result.getInteger("account_id") %></a></td>
				   		 			   		 
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
