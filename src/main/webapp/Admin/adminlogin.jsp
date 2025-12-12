<%@ include file="../header.jsp"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<title>Adminlogin</title>

<style>
	body {
		display: flex;
		flex-direction: column;  /* ← stack heading + form vertically */
		justify-content: center; /* center vertically */
		align-items: center;     /* center horizontally */
		width: 100vw;
		height: 100vh;
		margin: 0;
		background: #f7f7f7;
	}

	.hero {
		width: 500px;
		padding: 20px;
		border: 1px solid #ccc;
		border-radius: 8px;
		background: #fff;
	}
</style>
</head>
<body>

	<div class="text-center mb-4">
		<h1>MHP株式会社</h1>
		<h2>営業サポートシステム　従業員ログインページ</h2>
	</div>

	<div class="hero">
		<form action="${pageContext.request.contextPath}/Adminloginpageservlet" method="post">
			<div class="mb-3">
				<label for="exampleInputEmail1" class="form-label">Email address</label>
				<input type="email" class="form-control" id="inputemail" name="inputemail" aria-describedby="emailHelp">
				<div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
			</div>

			<div class="mb-3">
				<label for="exampleInputPassword1" class="form-label" >Password</label>
				<input type="password" class="form-control" id="inputpassword" name="inputpassword">
			</div>


			<button type="submit" class="btn btn-primary">Submit</button>
		</form>
	</div>

</body>
</html>