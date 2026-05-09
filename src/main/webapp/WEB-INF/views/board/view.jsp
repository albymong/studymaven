<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 보기</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; padding: 80px 20px 20px 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        h1 { color: #333; margin-bottom: 20px; }
        .card { background: white; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 24px; }
        .title { font-size: 24px; font-weight: 600; color: #111; margin-bottom: 16px; }
        .meta { color: #6b7280; font-size: 14px; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 1px solid #e5e7eb; }
        .meta span { margin-right: 16px; }
        .content { color: #374151; line-height: 1.6; white-space: pre-wrap; }
        .actions { margin-top: 24px; display: flex; gap: 12px; }
        .btn { padding: 10px 20px; background: #3b82f6; color: white; text-decoration: none; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; }
        .btn:hover { background: #2563eb; }
        .btn-secondary { background: #6b7280; }
        .btn-secondary:hover { background: #4b5563; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="container">
        <h1>게시판 보기</h1>
        <div class="card">
            <div class="title"><c:out value="${vo.title}"/></div>
 
            <div class="meta">
                <span>작성자: <c:out value="${vo.writerName}"/></span>
                <span>작성일: <c:out value="${vo.createDate}"/></span>
                <span>수정일: <c:out value="${vo.updateDate}"/></span>
            </div>
 
            <div class="content"><c:out value="${vo.content}"/></div>
            <div class="actions">
                <a href="/board/edit/${vo.id}?page=${page}" class="btn">수정</a>
                <a href="/board?page=${page}" class="btn btn-secondary">목록</a>
                <a href="/main" class="btn btn-secondary">첫페이지</a>
            </div>
        </div>
    </div>
</body>
</html>