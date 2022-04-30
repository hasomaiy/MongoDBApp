<%@page import="java.text.DecimalFormat"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.lang.invoke.MethodHandles.Lookup"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@page import = "java.util.ArrayList" %>
<%@page import = "java.util.Iterator" %>
<%@page import="com.mongodb.MongoClient"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.BasicDBObject" %>
<%@page import="com.mongodb.client.MongoCursor" %>
<%@page import="org.bson.types.ObjectId" %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account Details</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<%@include file="landing.jsp" %>
<% 
		String id = request.getParameter("Id");
		String username =	(String)session.getAttribute("userName");
		int account_id = Integer.parseInt(id);
		System.out.println(username);
	%>


<%

MongoClient mongoClient = new MongoClient("localhost", 27017);
MongoDatabase db = mongoClient.getDatabase("sample_analytics");

MongoCollection<Document> transaction_collection = db.getCollection("transactions");
MongoCollection<Document> collection = db.getCollection("accounts");

BasicDBObject query = new BasicDBObject();
query.put("account_id",account_id);

BasicDBObject transaction_query = new BasicDBObject();
transaction_query.put("account_id",account_id);

MongoCursor<Document> cursor = collection.find(query).iterator();
MongoCursor<Document> transaction_cursor = transaction_collection.find(transaction_query).iterator();

Document result = null;

while(cursor.hasNext()){
	result = (Document) cursor.next();


%>

<div class="container bootstrap snippets bootdey">
<div class="panel-body inf-content">
    <div class="row">
    
        <div class="col-md-6">
            <strong>Information</strong><br>
            <div class="table-responsive">
            <form name="ingredient" id="ingredient" action="updateAccountDetails.jsp" method="post" >
            <table class="table table-user-information">
                <tbody>
                    <tr>        
                        <td>
                            <strong>
                                <span class="glyphicon glyphicon-asterisk text-primary"></span>
                                Account ID                                                
                            </strong>
                        </td>
                        <td class="text-primary">
                            <%= result.get("account_id") %>
                        </td>
                    </tr>
                    <tr>    
                        <td>
                            <strong>
                                <span class="glyphicon glyphicon-user  text-primary"></span>    
                                Limit                                                
                            </strong>
                        </td>
                        <td class="text-primary">                        
                            <input name="limit" type="number" min="10000" max="50000" class="number" id="limit" value="<%=result.get("limit")%>" />     
                        </td>
                        
                       
                              <td class="submission" colspan="6">
                                 <input type="hidden" name="account_id" value="<%=result.get("account_id")%>"/>
                                 <input type="hidden" name="username" value="<%=username%>"/>
                                 <input name="s" type="submit" class="button" value="UPDATE" />
                              </td>
                          
                        	          
                    </tr>
                    <tr>        
                        <td>
                            <strong>
                                <span class="glyphicon glyphicon-cloud text-primary"></span>  
                                Products                                                
                            </strong>
                        </td>
                        <td class="text-primary">
                            <%= result.get("products") %>   
                        </td>
                    </tr>

                                                   
                </tbody>
            </table>
            </form>
            
            
            <%
            
            
            result = null;
            //DecimalFormat df = new DecimalFormat("#,#0.00");
            while(transaction_cursor.hasNext()){
            	result = (Document) transaction_cursor.next();
			ArrayList<Document> transactions = (ArrayList<Document>)result.get("transactions");
            
            %>
			<table class="table table-user-information">
			
			<tbody>
			 <tr>        
                        <td>
                            <strong>
                                <span class="glyphicon glyphicon-cloud text-primary"></span>  
                                Transaction Count                                               
                            </strong>
                        </td>
                        <td class="text-primary">
                            <%= result.get("transaction_count") %>   
                        </td>
                    </tr>
			      <tr>        
                        <td>
                            <strong>
                                <span class="glyphicon glyphicon-cloud text-primary"></span>  
                                Bucket Start Date                                                
                            </strong>
                        </td>
                        <td class="text-primary">
                            <%= result.getDate("bucket_start_date") %>   
                        </td>
                    </tr>
                       <tr>        
                        <td>
                            <strong>
                                <span class="glyphicon glyphicon-cloud text-primary"></span>  
                                Bucket End Date                                                
                            </strong>
                        </td>
                        <td class="text-primary">
                            <%= result.getDate("bucket_end_date") %>   
                        </td>
                    </tr>
                    
                    	<tr>	
                              <th class="submission" colspan="2">
                                 <div align="center"><a href="accountDetails.jsp?Id=<%=id%>">Back</a> </div>
                              </th>
                           </tr>
			
			
			</tbody>
			
			</table>
			
					
			<%} %>
            </div>
        </div>
    </div>
</div>
</div>
<%		
	}
%>
    <script src="script.js"></script>
</body>

</html>