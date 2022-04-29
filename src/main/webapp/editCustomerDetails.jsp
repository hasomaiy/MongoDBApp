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
      <title>Edit Customer Details Page</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
   </head>
   <body>
   <header>
  <div class="collapse bg-dark" id="navbarHeader">
    <div class="container">
      <div class="row">
        <div class="col-sm-8 col-md-7 py-4">
          <h4 class="text-white">About</h4>
          <p class="text-muted">This is a Banking System for people.</p>
        </div>
        <div class="col-sm-4 offset-md-1 py-4">
          <h4 class="text-white">Contact</h4>
          <ul class="list-unstyled">
            <li><a href="#" class="text-white">Follow on Twitter</a></li>
            <li><a href="#" class="text-white">Like on Facebook</a></li>
            <li><a href="#" class="text-white">Email me</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <div class="navbar navbar-dark bg-dark shadow-sm">
    <div class="container">
      <a href="#" class="navbar-brand d-flex align-items-center">
        <strong>Financial Services Company</strong>
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
       <button class="navbar-toggler" type="button" onclick="window.location='/FinancialServiceCompany/';">Logout</button>
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
  </div>
</header>
      <% 
         String id = request.getParameter("Id");
         System.out.println(id);
         %>
      <% 
         MongoClient mongoClient = new MongoClient("localhost", 27017);
         MongoDatabase db = mongoClient.getDatabase("sample_analytics");
         MongoCollection<Document> collection = db.getCollection("customers");
         
         
         BasicDBObject query = new BasicDBObject();
         query.put("_id",new ObjectId(id));
         
         MongoCursor<Document> cursor = collection.find(query).iterator();
         
         Document result = null;
         if (cursor.hasNext()){
         	result = (Document) cursor.next();
         }
         %>
      <h2>Edit Customer Details </h2>
      <form name="ingredient" id="ingredient" action="updateCustomerDetails.jsp" method="post" >
         <div class="container bootstrap snippets bootdey">
            <div class="panel-body inf-content">
               <div class="row">
                  <div class="col-md-4">
                     <img alt="" style="width:400px;" title="" class="img-circle img-thumbnail isTooltip" src="https://bootdey.com/img/Content/avatar/avatar7.png" data-original-title="Usuario"> 
                  </div>
                  <div class="col-md-6">
                     <strong>Information</strong><br>
                     <div class="table-responsive">
                        <table class="table table-user-information" width="332" height="252" border="0" align="center" cellpadding="2" cellspacing="2">
                           <tr>
                              <th height="33" colspan="2">
                                 <div align="center"></div>
                              </th>
                           </tr>
                           <tr>
                              <th>Name </th>
                              <td><input name="name" type="text" class="text" id="name" value="<%=result.getString("name")%>" /></td>
                           </tr>
                           <tr>
                              <th>Address </th>
                              <td><input name="address" type="text" size=50 class="text" id="address" value="<%=result.getString("address")%>" /></td>
                           </tr>
                           <tr>
                              <th>Email</th>
                              <td><input name="email" type="text" class="text" id="email" value="<%=result.getString("email")%>" /></td>
                           </tr>
                           <tr>
                              <td class="submission" colspan="6">
                                 <input type="hidden" name="Id" value="<%=id%>"/>
                                 <input name="s" type="submit" class="button" value="UPDATE" />
                              </td>
                           </tr>
                           <tr>
                              <th class="submission" colspan="2">
                                 <div align="center"><a href="customerDetails.jsp?Id=<%=id%>">Back</a> </div>
                              </th>
                           </tr>
                        </table>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </form>
   </body>
</html>