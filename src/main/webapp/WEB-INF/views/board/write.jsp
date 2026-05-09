<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 작성</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; padding: 80px 20px 20px 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        h1 { color: #333; margin-bottom: 20px; }
        .card { background: white; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 24px; }
        .form-group { margin-bottom: 16px; }
        label { display: block; font-weight: 600; color: #374151; margin-bottom: 6px; }
        input[type="text"], textarea { width: 100%; padding: 10px 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; font-family: inherit; }
        input[type="text"]:focus, textarea:focus { outline: none; border-color: #3b82f6; ring: 2px solid #3b82f6; }
        textarea { min-height: 200px; resize: vertical; }
        .actions { display: flex; gap: 12px; margin-top: 24px; }
        .btn { padding: 10px 20px; background: #3b82f6; color: white; text-decoration: none; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; }
        .btn:hover { background: #2563eb; }
        .btn-secondary { background: #6b7280; }
        .btn-secondary:hover { background: #4b5563; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="container">
        <h1>게시판 작성</h1>
        <div class="card">
            <form action="/board/write" method="post">
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" name="content" required></textarea>
                </div>
                <div class="actions">
                    <button type="submit" class="btn">저장</button>
                    <a href="<c:url value='/board?page=${page}'/>" class="btn btn-secondary">목록으로</a>
                    <a href="<c:url value='/main'/>" class="btn btn-secondary">첫페이지</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>