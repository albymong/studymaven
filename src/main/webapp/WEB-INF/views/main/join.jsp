<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .join-box { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); width: 100%; max-width: 360px; }
        h1 { text-align: center; margin-bottom: 24px; color: #111; }
        .form-group { margin-bottom: 16px; }
        label { display: block; margin-bottom: 6px; font-weight: 600; color: #374151; }
        input { width: 100%; padding: 10px 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; }
        input:focus { outline: none; border-color: #3b82f6; }
        .btn { width: 100%; padding: 12px; background: #10b981; color: white; border: none; border-radius: 6px; font-size: 14px; cursor: pointer; }
        .btn:hover { background: #059669; }
        .error { color: #ef4444; font-size: 14px; margin-bottom: 16px; text-align: center; }
        .links { text-align: center; margin-top: 16px; }
        .links a { color: #3b82f6; text-decoration: none; }
        .links a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="join-box">
        <h1>회원가입</h1>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form action="/join" method="post">
            <div class="form-group">
                <label for="userid">아이디</label>
                <input type="text" id="userid" name="userid" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" required>
            </div>
            <button type="submit" class="btn">회원가입</button>
        </form>
        <div class="links">
            <a href="/login">로그인</a>
        </div>
    </div>
</body>
</html>