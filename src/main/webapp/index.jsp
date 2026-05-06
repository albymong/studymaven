<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Studymaven</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .container { text-align: center; }
        h1 { font-size: 48px; color: #111; margin-bottom: 32px; }
        .btn { display: inline-block; padding: 16px 32px; background: #3b82f6; color: white; text-decoration: none; border-radius: 8px; font-size: 18px; margin: 8px; }
        .btn:hover { background: #2563eb; }
        .btn-secondary { background: #10b981; }
        .btn-secondary:hover { background: #059669; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Studymaven</h1>
        <a href="/login" class="btn">로그인</a>
        <a href="/join" class="btn btn-secondary">회원가입</a>
    </div>
</body>
</html>