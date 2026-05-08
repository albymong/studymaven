<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${vo.title}"/> - 용어사전</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .card { background: white; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 24px; }
        .title { font-size: 24px; font-weight: 600; color: #111; margin-bottom: 16px; }
        .definition { font-size: 18px; color: #374151; margin-bottom: 16px; font-weight: 500; }
        .content { color: #4b5563; line-height: 1.6; white-space: pre-wrap; margin-bottom: 24px; padding: 16px; background: #f9fafb; border-radius: 6px; }
        .meta { color: #6b7280; font-size: 14px; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 1px solid #e5e7eb; }
        .meta span { margin-right: 16px; }
        .category { color: #3b82f6; font-weight: 500; }
        .tag { display: inline-block; padding: 4px 8px; background: #e5e7eb; border-radius: 4px; font-size: 12px; margin-right: 4px; }
        .actions { display: flex; gap: 12px; }
        .btn { padding: 10px 20px; background: #6b7280; color: white; text-decoration: none; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; display: inline-block; text-align: center; }
        .btn:hover { background: #4b5563; }
        .btn-danger { background: #ef4444; }
        .btn-danger:hover { background: #dc2626; }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="title"><c:out value="${vo.title}"/></div>
            <div class="definition"><c:out value="${vo.definition}"/></div>
            <c:if test="${vo.content != null && vo.content != ''}">
                <div class="content"><c:out value="${vo.content}"/></div>
            </c:if>
            <div class="meta">
                <c:if test="${vo.category != null}">
                    <span class="category"><c:out value="${vo.category}"/></span> | 
                </c:if>
                <c:if test="${vo.tags != null}">
                    <c:forEach var="tag" items="${fn:split(vo.tags, ',')}">
                        <span class="tag"><c:out value="${tag}"/></span>
                    </c:forEach>
                </c:if>
                <br>
                작성자: <c:out value="${vo.authorName}"/> | 작성일: <c:out value="${vo.createDate}"/> | 수정일: <c:out value="${vo.updateDate}"/>
            </div>
            </div>
            <div class="actions">
                <a href="/term" class="btn">목록</a>
                <c:if test="${loginUser.role == 'ADMIN'}">
                    <a href="/term/edit/${vo.id}" class="btn">수정</a>
                    <form action="/term/delete/${vo.id}" method="post" style="display:inline">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('삭제하시겠습니까?')">삭제</button>
                    </form>
                </c:if>
            </div>
        </div>
        <div style="margin-top:20px">
            <a href="/main" class="btn" style="background:#3b82f6">← 메인으로</a>
        </div>
    </div>
</body>
</html>