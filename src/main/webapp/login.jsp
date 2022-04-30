<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Login</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
//System.out.println(request.getAttribute("status"));
//System.out.println(session.getAttribute("userName"));


%>
<input type = "hidden" id = "status" value = "<%= request.getAttribute("status") %>" >
<input type = "hidden" id = "session" value = "<%= session.getAttribute("userName") %>" >
<input type = "hidden" id = "session_email" value = "<%= session.getAttribute("email") %>" >
<%
//session.setAttribute("email", " ");
//System.out.println(request.getAttribute("status"));
%>
	<div class="main">

		<!-- Sing in  Form -->
		<section class="sign-in">
			<div class="container">
				<div class="signin-content">
					<div class="signin-image">
						<figure>
							<img src="images/signin-image.jpg" alt="sing up image">
						</figure>
						<a href="registration.jsp" class="signup-image-link">Create an
							account </a>
					</div>

					<div class="signin-form">
						<h2 class="form-title">Sign up</h2>
						<form name = "login" action="loginDb.jsp" class="register-form"
							id="login-form">
							<div class="form-group">
								<label for="username"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="username" id="username"
									placeholder="Your Email" />
							</div>
							<div class="form-group">
								<label for="password"><i class="zmdi zmdi-lock"></i></label> <input
									type="password" name="password" id="password"
									placeholder="Password" />
							</div>
							<div class="form-group">
								<input type="checkbox" name="empLogin" id="remember-me"
									class="agree-term" /> <label for="remember-me"
									class="label-agree-term"><span><span></span>
									</span>Employee Login</label>
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signin" id="signin"
									class="form-submit" value="Log in" />
							</div>
						</form>
					
					</div>
				</div>
			</div>
		</section>

	</div>

	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	<script type = "text/javascript">
	var status =  "";
	var session_email = "";
	 		status = document.getElementById("status").value;

		var session = document.getElementById("session").value;
			session_email = document.getElementById("session_email").value;
		console.log(status);
		if(status == "falied")
			{
			
			if(session== "null")
				{
				
				swal("user name invalid! Please Try again")
				}
			else {
				swal("password invalid! Please Try again"+ session)
			}
			}
		
		if(status == "faliedRegistration")
		{
	
			
			swal(session_email+"! "+"This email alreay register! Please Try again")
			
		
		}else if (status == "successRegistration")
			{
			swal("Registration Success! Your user name is "+session_email)
			
			}
	
	</script>
	
	
</body>
</html>