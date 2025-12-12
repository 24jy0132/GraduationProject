<%@ include file="../header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>Adminhome</title>

<style>
    body {
        background: #f5f5f5;
        margin: 0;
        padding: 0;
    }

    h1 {
        text-align: center;
        margin-top: 30px;
        margin-bottom: 40px;
        font-weight: 700;
        color: #333;
    }

    /* Top buttons (管理TOP / ログアウト) */
    .buttons {
        text-align: right;
        margin-bottom: 20px;
    }

    .buttons a button {
        background: #007bff;
        color: white;
        padding: 8px 25px;
        font-size: 16px;
        border: none;
        border-radius: 6px;
        margin-left: 10px;
        cursor: pointer;
        transition: 0.3s;
    }

    .buttons a button:hover {
        background: #0056b3;
    }

    /* Navigation pills styling */
    .nav-pills .nav-link {
        font-size: 18px;
        padding: 10px 18px;
        color: #333;
        border-radius: 6px;
        transition: 0.3s;
    }

    .nav-pills .nav-link:hover {
        background: #e0e0e0;
    }

    .nav-pills .nav-link.active {
        background: #007bff;
        color: white;
    }

    /* Dropdown menu styling */
    .dropdown-menu {
        font-size: 16px;
    }

    .dropdown-menu a {
        padding: 10px 15px;
    }

    .dropdown-menu a:hover {
        background: #f0f0f0;
    }
</style>

</head>
<body>
    <div class="container-fluid">
        <h1>MHP株式会社 営業サポートシステム</h1>

        <div class="container">

            <!-- Top right buttons -->
            <div class="buttons">
                <a href="https://example.com"><button>管理TOP</button></a>
                <a href="https://example.com"><button>ログアウト</button></a>
            </div>

            <!-- Navigation -->
            <div class="point">
                <ul class="nav nav-pills">

                    <li class="nav-item">
                        <a class="nav-link" href="#">予約確認</a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link" href="#">メニュー管理</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#">割引管理</a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#">
                            アンケート管理
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">アンケート作成</a></li>
                            <li><a class="dropdown-item" href="#">回答一覧表</a></li>
                            <li><a class="dropdown-item" href="#">その他</a></li>
                        </ul>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="staffregisteration.jsp">従業員管理</a>
                    </li>

                </ul>
            </div>

        </div>
    </div>
</body>
</html>