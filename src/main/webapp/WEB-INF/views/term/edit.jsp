<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>용어 수정</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        h1 { color: #111; margin-bottom: 20px; }
        .card { background: white; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 24px; }
        .form-group { margin-bottom: 16px; }
        label { display: block; font-weight: 600; color: #374151; margin-bottom: 6px; }
        input, textarea, select { width: 100%; padding: 10px 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; font-family: inherit; }
        input:focus, textarea:focus, select:focus { outline: none; border-color: #3b82f6; }
        textarea { min-height: 100px; resize: vertical; }
        .actions { display: flex; gap: 12px; margin-top: 16px; }
        .btn { padding: 10px 20px; background: #3b82f6; color: white; text-decoration: none; border-radius: 6px; border: none; cursor: pointer; }
        .btn:hover { background: #2563eb; }
        .btn-secondary { background: #6b7280; }
        .btn-secondary:hover { background: #4b5563; }
    </style>
</head>
<body>
    <div class="container">
        <h1>용어 수정</h1>
        <div class="card">
            <form action="/term/edit/${vo.id}" method="post">
                <div class="form-group">
                    <label for="title">용어명</label>
                    <input type="text" id="title" name="title" value="${vo.title}" required>
                </div>
                <div class="form-group">
                    <label for="definition">정의</label>
                    <textarea id="definition" name="definition" required>${vo.definition}</textarea>
                </div>
                <div class="form-group">
                    <label for="content">상세 설명</label>
                    <textarea id="content" name="content">${vo.content}</textarea>
                </div>
                <div class="form-group">
                    <label for="category">카테고리</label>
                    <input type="text" id="category" name="category" value="${vo.category}" list="categoryList">
                    <datalist id="categoryList">
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat}"/>
                        </c:forEach>
                    </datalist>
                </div>
                <div class="form-group">
                    <label for="tags">태그 (쉼표로 구분)</label>
                    <input type="text" id="tags" name="tags" value="${vo.tags}">
                </div>
                <div class="actions">
                    <button type="submit" class="btn">수정</button>
                    <a href="/term" class="btn btn-secondary">취소</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>