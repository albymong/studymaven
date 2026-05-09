<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>용어 등록</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; padding: 80px 20px 20px 20px; }
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
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="container">
        <h1>용어 등록</h1>
        <div class="card">
            <form action="<c:url value='/term/write'/>" method="post">
                <div class="form-group">
                    <label for="title">용어명</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="definition">정의</label>
                    <textarea id="definition" name="definition" required></textarea>
                </div>
                <div class="form-group">
                    <label for="content">상세 설명</label>
                    <textarea id="content" name="content"></textarea>
                </div>
                <div class="form-group">
                    <label for="category">카테고리</label>
                    <input type="text" id="category" name="category" list="categoryList">
                    <datalist id="categoryList">
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat}"/>
                        </c:forEach>
                    </datalist>
                </div>
                <div class="form-group">
                    <label for="tags">태그 (쉼표로 구분)</label>
                    <input type="text" id="tags" name="tags" placeholder="예: AI, 머신러닝, 데이터">
                </div>
        <div class="actions">
            <button type="submit" class="btn">저장</button>
            <a href="<c:url value='/term'/>" class="btn btn-secondary">목록으로</a>
            <a href="<c:url value='/main'/>" class="btn btn-secondary">첫페이지</a>
        </div>
            </form>
        </div>
    </div>
</body>
</html>