<%@ include file="header.jsp"%>
<title>Top Page</title>
</head>
<body>

    <div class="container-fluid">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg bg-danger py-3">
            <div class="container">
                <!-- Brand -->
                <a class="navbar-brand fw-bold text-white" href="index.jsp"> <img
                    src="img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png" height="40" width="40" alt="Logo" class="me-2">
                    Welcome From Mesa
                </a>

                <!-- Toggler button -->
                <button class="navbar-toggler" type="button"
                    data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false"
                    aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Navbar links and login -->
                <div class="collapse navbar-collapse justify-content-end"
                    id="navbarSupportedContent">
                    <ul class="navbar-nav mb-2 mb-lg-0 d-flex gap-4">
                        <li class="nav-item"><a class="nav-link active text-white"
                            href="#"><i class="bi bi-house-fill me-1"></i>Home</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="MenuListServlet"><i
                                class="bi bi-menu-down me-1"></i>Menu</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="#"><i
                                class="bi bi-calendar-check me-1"></i>Reservation</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="contact.jsp"><i
                                class="bi bi-telephone-fill me-1"></i>Contact</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="map.jsp"><i
                                class="bi bi-pin-map-fill me-1"></i>Map</a></li>
                    </ul>

                    <!-- Login link -->
                    <a class="nav-link active text-white fw-bold ms-lg-3 mt-2 mt-lg-0"
                        href="login.jsp"> <i class="bi bi-box-arrow-in-right me-1"></i>Login
                    </a>
                </div>
            </div>
        </nav>

        <!-- Carousel -->
        <div id="carouselExampleInterval" class="carousel slide mt-2"
            data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active" data-bs-interval="10000">
                    <img src="img/h1.jpg" class="d-block w-100" alt="h1" height="750"
                        width="800">
                </div>
                <div class="carousel-item" data-bs-interval="2000">
                    <img src="img/h2.jpg" class="d-block w-100" alt="h2" height="750">
                </div>
                <div class="carousel-item">
                    <img src="img/h3.jpg" class="d-block w-100" alt="h3" height="750">
                </div>
                <div class="carousel-item">
                    <img src="img/h4.jpg" class="d-block w-100" alt="h4" height="750">
                </div>
            </div>
            <button class="carousel-control-prev" type="button"
                data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button"
                data-bs-target="#carouselExampleInterval" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        <%@ include file="footer.jsp"%>
    </div>

</body>

</html>