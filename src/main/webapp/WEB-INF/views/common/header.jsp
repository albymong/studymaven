<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .navbar { position: fixed; top: 0; width: 100%; display: flex; justify-content: space-between; align-items: center; padding: 1rem 5%; background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(10px); z-index: 1000; box-shadow: 0 1px 0 rgba(0,0,0,0.05); }
    .logo { font-size: 1.5rem; font-weight: 800; color: #3b82f6; text-decoration: none; letter-spacing: -0.5px; }
    .user-nav { display: flex; align-items: center; gap: 1.5rem; }
    .user-name { font-size: 0.9rem; color: #4b5563; font-weight: 500; }
    .nav-btn { padding: 0.5rem 1rem; font-size: 0.875rem; border-radius: 6px; text-decoration: none; transition: all 0.2s; font-weight: 500; }
    .btn-outline { border: 1px solid #d1d5db; color: #374151; }
    .btn-outline:hover { background: #f3f4f6; }
    .btn-primary { background: #3b82f6; color: white; }
    .btn-primary:hover { background: #2563eb; }
</style>
<nav class="navbar">
    <a href="/main" class="logo">Studymaven</a>
    <div class="user-nav">
        <c:if test="${not empty loginUser}">
            <span class="user-name"><c:out value="${loginUser.name}"/>님 환영합니다</span>
            <a href="/main/logout" class="nav-btn btn-outline">로그아웃</a>
        </c:if>
        <c:if test="${empty loginUser}">
            <a href="/login" class="nav-btn btn-primary">로그인</a>
        </c:if>
    </div>
</nav>