<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>용어사전</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        h1 { color: #111; margin-bottom: 20px; }
        .search-box { display: flex; gap: 8px; margin-bottom: 24px; }
        .search-box input { flex: 1; padding: 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 16px; }
        .search-box button { padding: 12px 24px; background: #3b82f6; color: white; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; }
        .search-box button:hover { background: #2563eb; }
        .card { background: white; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 20px; margin-bottom: 16px; }
        .term-title { font-size: 20px; font-weight: 600; color: #111; margin-bottom: 8px; }
        .term-def { color: #374151; margin-bottom: 8px; }
        .term-meta { color: #6b7280; font-size: 14px; }
        .tag { display: inline-block; padding: 4px 8px; background: #e5e7eb; border-radius: 4px; font-size: 12px; margin-right: 4px; }
        .category { color: #3b82f6; font-weight: 500; }
        .empty { text-align: center; color: #6b7280; padding: 40px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .link-btn { color: #3b82f6; text-decoration: none; font-weight: 500; }
        .link-btn:hover { text-decoration: underline; }
        .btn-import { background: #3b82f6; color: white; padding: 8px 16px; border-radius: 6px; text-decoration: none; font-size: 14px; margin-left: 12px; }
        .btn-import:hover { background: #2563eb; color: white; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>용어사전</h1>
            <div>
                <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.role eq 'ADMIN'}">
                    <a href="/term/import" class="btn-import">용어 가져오기</a>
                </c:if>
                <a href="/main" class="link-btn">← 메인으로</a>
            </div>
        </div>
        <form class="search-box" action="/term" method="get">
            <input type="text" name="q" placeholder="용어를 검색하세요" value="${query}">
            <button type="submit">검색</button>
        </form>
        <c:if test="${empty list}">
            <div class="empty">검색 결과가 없습니다.</div>
        </c:if>
                <c:forEach var="vo" items="${list}">
                    <div class="card">
                        <a href="/term/view/${vo.id}" class="term-title"><c:out value="${vo.title}"/></a>
                        <p class="term-def"><c:out value="${vo.definition}"/></p>
                        <div class="term-meta">
                            <c:if test="${vo.category != null}">
                                <span class="category"><c:out value="${vo.category}"/></span>
                            </c:if>
                            <c:if test="${vo.tags != null}">
                                <c:forEach var="tag" items="${fn:split(vo.tags, ',')}">
                                    <span class="tag"><c:out value="${tag}"/></span>
                                </c:forEach>
                            </c:if>
                            <span> | 작성자: <c:out value="${vo.authorName}"/> | <c:out value="${vo.createDate}"/></span>
                        </div>
                    </div>
                </c:forEach>
    </div>
</body>
</html>