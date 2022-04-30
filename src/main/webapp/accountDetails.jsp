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
		String empLogin =	(String)session.getAttribute("empLogin");
		int account_id = Integer.parseInt(id);
//System.out.println(id);
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
                            <%= result.get("limit") %>     
                        </td>
                        <% System.out.println(empLogin);
							if (empLogin != null && empLogin.equals("on"))
							{
							%>
					 		<td style="vertical-align : middle;text-align:center;" class="submission" rowspan="1">
	                        <a href="editAccountDetails.jsp?Id=<%=id%>">Edit</a>
	                        </td>
	                        <%} %>
                        
                        
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
                                 <div align="center"><a href="index.jsp?">Back</a> </div>
                              </th>
                           </tr>
			
			
			
			</tbody>
			
			</table>
			
			<table id="dtBasicExample" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
		<thead>
		    <tr>
		      <th class="th-sm">Date
		      </th>
		      <th class="th-sm">Amount
		      </th>
		      <th class="th-sm">Transaction Code
		      </th>
		      <th class="th-sm">Symbol
		      </th>
		      <th class="th-sm">Price
		      </th>
		      <th class="th-sm">Total
		      </th>
		    </tr>
 		</thead>
 		<% 
 			Iterator<Document> it_transaction = transactions.iterator();
 		Double d_price = 0.0 ;
 		String s_price = "";
		String s_total = "";
		
 		while(it_transaction.hasNext())
 		{
 			
 			Document transactionDocment = it_transaction.next();
 			 	s_price = transactionDocment.getString("price");
 				s_total = transactionDocment.getString("total");
 			try{
 				String[] a_string = s_price.split("\\.");
 				String[] a_total = s_price.split("\\.");
 			
 				s_price = a_string[0] +"."+ a_string[1].substring(0,2);
 				s_total = a_total[0] +"."+ a_total[1].substring(0,2);
 				
 			}catch(Exception e){}
 		%>
	<tbody>
	
	    <tr>
	      <td><%= transactionDocment.get("date") %></td>
	      <td><%= transactionDocment.get("amount") %></td>
	      <td><%= transactionDocment.getString("transaction_code") %></td>
	       <td><%= transactionDocment.getString("symbol") %></td>
	      <td><%= s_price %></td>
	      <td><%= s_total %></td>
	     
	

	    </td>	
	    </tr>
	  <%}  %>
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