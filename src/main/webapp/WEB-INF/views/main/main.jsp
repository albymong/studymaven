<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Studymaven</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; padding: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; background: white; padding: 16px 24px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 24px; }
        .logo { font-size: 24px; font-weight: 700; color: #111; }
        .user-info { display: flex; align-items: center; gap: 16px; }
        .user-name { color: #374151; }
        .btn { padding: 8px 16px; background: #6b7280; color: white; text-decoration: none; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; }
        .btn:hover { background: #4b5563; }
        .btn-danger { background: #ef4444; }
        .btn-danger:hover { background: #dc2626; }
        .card { background: white; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); overflow: hidden; margin-bottom: 24px; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #f9fafb; padding: 12px; text-align: left; font-weight: 600; color: #374151; border-bottom: 2px solid #e5e7eb; }
        td { padding: 12px; border-bottom: 1px solid #e5e7eb; color: #374151; }
        .link-btn { color: #3b82f6; text-decoration: none; }
        .link-btn:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div style="max-width: 800px; margin: 0 auto;">
        <div class="header">
            <div class="logo">Studymaven</div>
            <div class="user-info">
                <span class="user-name">${loginUser.name}님 환영합니다</span>
                <form action="/logout" method="post">
                    <button type="submit" class="btn btn-danger">로그아웃</button>
                </form>
            </div>
        </div>
        <div class="card">
            <div style="padding: 16px; border-bottom: 1px solid #e5e7eb; display: flex; justify-content: space-between; align-items: center;">
                <h2 style="color: #111;">최근 게시글</h2>
                <span style="color: #6b7280;">총 ${total}개</span>
            </div>
            <table>
                <thead>
                    <tr>
                        <th style="width:60px">No</th>
                        <th>제목</th>
                        <th style="width:150px">작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="vo" items="${list}" begin="0" end="5">
                    <tr>
                        <td>${vo.id}</td>
                        <td><a href="/board/view/${vo.id}?page=1" class="link-btn">${vo.title}</a></td>
                        <td>${vo.createDate}</td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div style="text-align: center;">
            <a href="/board" class="btn" style="background: #3b82f6;">전체 게시글 보기</a>
            <a href="/term" class="btn" style="background: #10b981;">용어사전</a>
            <c:if test="${loginUser.role == 'ADMIN'}">
                <a href="/term/import" class="btn" style="background: #8b5cf6;">용어 가져오기</a>
            </c:if>
        </div>
    </div>
</body>
</html>