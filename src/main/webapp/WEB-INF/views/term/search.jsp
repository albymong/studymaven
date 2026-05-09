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
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; padding: 80px 20px 20px 20px; }
        .container { max-width: 1100px; margin: 0 auto; }
        h1 { color: #111; margin-bottom: 20px; }
        .search-box { display: flex; gap: 8px; margin-bottom: 32px; }
        .search-box input { flex: 1; padding: 14px; border: 1px solid #d1d5db; border-radius: 8px; font-size: 16px; transition: border 0.2s; }
        .search-box input:focus { outline: none; border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1); }
        .search-box button { padding: 14px 24px; background: #3b82f6; color: white; border: none; border-radius: 8px; font-size: 16px; cursor: pointer; font-weight: 600; transition: background 0.2s; }
        .search-box button:hover { background: #2563eb; }
        
        /* Grid Layout */
        .term-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 20px; }
        .card { background: white; border-radius: 12px; border: 1px solid #e5e7eb; padding: 24px; transition: all 0.3s ease; cursor: pointer; display: flex; flex-direction: column; justify-content: space-between; }
        .card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.08); border-color: #3b82f6; }
        
        .term-title { font-size: 20px; font-weight: 700; color: #111; margin-bottom: 12px; text-decoration: none; display: block; line-height: 1.3; }
        .term-title:hover { color: #3b82f6; }
        .term-def { color: #4b5563; font-size: 15px; margin-bottom: 20px; line-height: 1.5; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; }
        
        .term-footer { display: flex; flex-wrap: wrap; align-items: center; gap: 8px; font-size: 13px; color: #9ca3af; border-top: 1px solid #f3f4f6; padding-top: 16px; }
        .category { color: #3b82f6; font-weight: 600; background: #eff6ff; padding: 2px 8px; border-radius: 4px; margin-right: 4px; }
        .tag { padding: 2px 8px; background: #f3f4f6; border-radius: 4px; color: #6b7280; }
        
        .empty { text-align: center; color: #6b7280; padding: 60px; font-size: 18px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; }
        .btn-import { background: #3b82f6; color: white; padding: 8px 16px; border-radius: 6px; text-decoration: none; font-size: 14px; margin-left: 12px; font-weight: 500; transition: background 0.2s; }
        .btn-import:hover { background: #2563eb; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="container">
        <div class="header">
            <h1>용어사전</h1>
            <div>
                <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.role eq 'ADMIN'}">
                    <a href="<c:url value='/term/import'/>" class="btn-import">용어 가져오기</a>
                </c:if>
                <a href="<c:url value='/main'/>" class="btn-secondary" style="padding: 8px 16px; background: #6b7280; color: white; text-decoration: none; border-radius: 6px; font-size: 14px; margin-left: 8px; font-weight: 500;">메인으로</a>
            </div>
        </div>
        <form class="search-box" action="<c:url value='/term'/>" method="get">
            <input type="text" name="q" placeholder="궁금한 AI 용어를 검색해보세요" value="${query}">
            <button type="submit">검색</button>
        </form>
        <c:if test="${empty list}">
            <div class="empty">검색 결과가 없습니다.</div>
        </c:if>
        <div class="term-grid">
            <c:forEach var="vo" items="${list}">
                <div class="card" onclick="location.href='<c:url value='/term/view/${vo.id}'/>'">
                    <div>
                        <a href="<c:url value='/term/view/${vo.id}'/>" class="term-title"><c:out value="${vo.title}"/></a>
                        <p class="term-def"><c:out value="${vo.definition}"/></p>
                    </div>
                    <div class="term-footer">
                        <c:if test="${vo.category != null}">
                            <span class="category"><c:out value="${vo.category}"/></span>
                        </c:if>
                        <c:if test="${vo.tags != null}">
                            <c:forEach var="tag" items="${fn:split(vo.tags, ',')}">
                                <span class="tag"><c:out value="${tag}"/></span>
                            </c:forEach>
                        </c:if>
                        <span style="margin-left: auto;">작성자: <c:out value="${vo.authorName}"/></span>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>