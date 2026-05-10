<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>파일 다운로드 확인</title>
    <style>
        body {font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background:#f5f5f5; padding:80px 20px;}
        .card {background:white; max-width:600px; margin:auto; padding:24px; border-radius:8px; box-shadow:0 1px 3px rgba(0,0,0,0.1);}
        .btn {display:inline-block; padding:10px 20px; background:#3b82f6; color:white; text-decoration:none; border-radius:6px;}
        .btn:hover {background:#2563eb;}
    </style>
</head>
<body>
<div class="card">
    <h2>파일 다운로드</h2>
    <p>다음 파일을 다운로드 하시겠습니까?</p>
    <p><strong><c:out value="${file.originalName}"/></strong> (<c:out value="${file.fileSize}"/> bytes)</p>
    <a class="btn" href="<c:url value='/download/execute?fileId=${file.id}'/>">다운로드</a>
    <a class="btn" style="background:#6b7280; margin-left:8px;" href="javascript:history.back();">취소</a>
</div>
</body>
</html>
