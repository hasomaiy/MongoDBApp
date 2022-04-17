<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Login</title>

<!-- Font Icon -->
<!-- Main css -->
<link rel="stylesheet" href="css/style.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

</head>
<body>

<input type = "hidden" id = "status" value = "<%= request.getAttribute("status") %>" >
<input type = "hidden" id = "session" value = "<%= session.getAttribute("userName") %>" >
<input type = "hidden" id = "session_email" value = "<%= session.getAttribute("email") %>" >

<section class="vh-100 gradient-custom">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12 col-md-8 col-lg-6 col-xl-5">
        <div class="card bg-dark text-white" style="border-radius: 1rem;">
          <div class="card-body p-5 text-center">

            <div class="mb-md-5 mt-md-4 pb-5">

              <h2 class="fw-bold mb-2 text-uppercase">Login</h2>
              <p class="text-white-50 mb-5">Please enter your login and password!</p>
			  <form name = "login" action="loginDb.jsp" class="register-form"
							id="login-form">
	              <div class="form-outline form-white mb-4">
	                <input type="email" id="username" class="form-control form-control-lg" placeholder="Email" name="username"/>
	                <!-- <label class="form-label" for="typeEmailX">Email</label> -->
	              </div>

	              <div class="form-outline form-white mb-4">
	                <input type="password" id="password" class="form-control form-control-lg" placeholder="Password"  name="password"/>
	                <!-- <label class="form-label" for="typePasswordX">Password</label> -->
	              </div>

	              <p class="small mb-5 pb-lg-2"><a class="text-white-50" href="#!">Forgot password?</a></p>

	              <button class="btn btn-outline-light btn-lg px-5 form-submit" name="signin" id="signin" type="submit">Login</button>

	              <div class="d-flex justify-content-center text-center mt-4 pt-1">
	                <a href="#!" class="text-white"><i class="fab fa-facebook-f fa-lg"></i></a>
	                <a href="#!" class="text-white"><i class="fab fa-twitter fa-lg mx-4 px-2"></i></a>
	                <a href="#!" class="text-white"><i class="fab fa-google fa-lg"></i></a>
	              </div>
			  </form>
            </div>

            <div>
              <p class="mb-0">Don't have an account? <a href="registration.jsp" class="text-white-50 fw-bold">Sign Up</a>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

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