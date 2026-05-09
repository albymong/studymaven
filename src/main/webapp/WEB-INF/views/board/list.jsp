<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%!
    String fmtDate(Object d) {
        if (d == null) return "";
        String s = d.toString();
        if (s.length() < 19) return s;
        try {
            java.time.LocalDateTime dt = java.time.LocalDateTime.parse(s.substring(0, 19).replace(" ", "T"));
            if (dt.plusDays(7).isAfter(java.time.LocalDateTime.now())) return s.substring(0, 16);
            return s.substring(0, 10);
        } catch (Exception e) { return s; }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; padding: 80px 20px 20px 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        h1 { color: #333; margin-bottom: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .btn { padding: 10px 20px; background: #3b82f6; color: white; text-decoration: none; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; display: inline-block; }
        .btn:hover { background: #2563eb; }
        .btn-danger { background: #ef4444; }
        .btn-danger:hover { background: #dc2626; }
        .btn-disabled { background: #9ca3af; pointer-events: none; }
        .card { background: white; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #f9fafb; padding: 12px; text-align: center; font-weight: 600; color: #374151; border-bottom: 2px solid #e5e7eb; }
        td { padding: 12px; border-bottom: 1px solid #e5e7eb; color: #374151; }
        tr:hover { background: #f9fafb; }
        .actions { display: flex; gap: 8px; }
        .actions a, .actions button { padding: 6px 12px; font-size: 12px; border-radius: 4px; }
        .btn-sm { padding: 6px 12px; background: #6b7280; color: white; text-decoration: none; border-radius: 4px; font-size: 12px; display: inline-block; }
        .btn-sm:hover { background: #4b5563; }
        .link-btn { color: #3b82f6; text-decoration: none; }
        .link-btn:hover { text-decoration: underline; }
        .empty { padding: 40px; text-align: center; color: #6b7280; }
        .pagination { display: flex; justify-content: center; gap: 8px; margin-top: 20px; }
        .pagination a, .pagination span { padding: 8px 12px; background: white; color: #374151; text-decoration: none; border-radius: 6px; border: 1px solid #d1d5db; font-size: 14px; }
        .pagination a:hover { background: #f9fafb; }
        .pagination .current { background: #3b82f6; color: white; border-color: #3b82f6; }
        .info { color: #6b7280; font-size: 14px; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="container">
        <div class="header">
            <h1>게시판</h1>
            <a href="<c:url value='/board/write?page=${currentPage}'/>" class="btn">새 글 작성</a>
        </div>
        <div class="card">
            <c:if test="${empty list}">
                <div class="empty">게시글이 없습니다.</div>
            </c:if>
            <c:if test="${not empty list}">
                <div style="display:flex;justify-content:flex-end;align-items:center;margin-bottom:8px;padding-right:12px">
                    <span class="info">총 ${total}개</span>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th style="width:60px">No</th>
                            <th>제목</th>
                            <th style="width:100px">작성자</th>
                            <th style="width:150px">작성일</th>
                            <th style="width:150px">수정일</th>
                            <th style="width:150px">작업</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="offset" value="${(currentPage - 1) * 10}" />
                        <c:forEach var="vo" items="${list}" varStatus="status">
                        <tr>
                            <td>${total - offset - status.index}</td>
                             <td><a href="<c:url value='/board/view/${vo.id}?page=${currentPage}'/>"><c:out value="${vo.title}"/></a></td>
                             <td><c:out value="${vo.writerName}"/></td>
                            <td>${vo.createDate}</td>
                            <td>${vo.updateDate}</td>
                            <td>
                                <div class="actions">
                                     <a href="<c:url value='/board/edit/${vo.id}?page=${currentPage}'/>" class="btn-sm">수정</a>
                                     <form action="<c:url value='/board/delete/${vo.id}?page=${currentPage}'/>" method="post">
                                         <button type="submit" class="btn btn-danger" onclick="return confirm('삭제하시겠습니까?')">삭제</button>
                                     </form>
                                </div>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="/board?page=${currentPage - 1}">이전</a>
                </c:if>
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="current">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="/board?page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a href="/board?page=${currentPage + 1}">다음</a>
                </c:if>
            </div>
        </c:if>
        <div style="margin-top:20px; display: flex; justify-content: flex-end; gap: 8px;">
            <a href="<c:url value='/main'/>" class="btn btn-secondary">첫페이지로</a>
        </div>
    </div>
</body>
</html>