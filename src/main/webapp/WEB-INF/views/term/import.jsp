<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>용어 가져오기</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 600px; margin: 0 auto; }
        h1 { color: #111; margin-bottom: 20px; }
        .card { background: white; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 24px; }
        .form-group { margin-bottom: 16px; }
        label { display: block; font-weight: 600; color: #374151; margin-bottom: 6px; }
        input[type="file"] { width: 100%; padding: 10px; border: 1px solid #d1d5db; border-radius: 6px; }
        .btn { padding: 10px 20px; background: #3b82f6; color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; text-align: center; }
        .btn-secondary { background: #6b7280; margin-left: 8px; }
        .btn:hover { background: #2563eb; }
        .btn-secondary:hover { background: #4b5563; }
        .alert { padding: 12px; border-radius: 6px; margin-bottom: 16px; }
        .alert-error { background: #fee2e2; color: #dc2626; }
        .alert-success { background: #d1fae5; color: #059669; }
        .info { color: #6b7280; font-size: 14px; margin-top: 16px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>용어 가져오기</h1>
        <div class="card">
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <form action="/term/import" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="file">파일 선택 (CSV 또는 JSON)</label>
                    <input type="file" id="file" name="file" accept=".csv,.json" required>
                </div>
                <button type="submit" class="btn">가져오기</button>
                <a href="/term" class="btn btn-secondary">용어사전 바로가기</a>
            </form>
            <div class="info">
                <strong>CSV 형식:</strong> title,definition,content,category<br>
                <strong>JSON 형식:</strong> [{"term":"용어명","english":"영어명","desc":"설명","category":"카테고리"},...]
            </div>
        </div>
    </div>
    <script>
        <% if (request.getAttribute("success") != null) { %>
            alert("<%= request.getAttribute("success") %>");
        <% } else if (request.getAttribute("error") != null) { %>
            alert("<%= request.getAttribute("error") %>");
        <% } %>
    </script>
</body>
</html>