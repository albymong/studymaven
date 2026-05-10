<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 수정</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f5f5f5; padding: 80px 20px 20px 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        h1 { color: #333; margin-bottom: 20px; }
        .card { background: white; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); padding: 24px; }
        .form-group { margin-bottom: 16px; }
        label { display: block; font-weight: 600; color: #374151; margin-bottom: 6px; }
        input[type="text"], textarea { width: 100%; padding: 10px 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; font-family: inherit; }
        input[type="text"]:focus, textarea:focus { outline: none; border-color: #3b82f6; ring: 2px solid #3b82f6; }
        textarea { min-height: 200px; resize: vertical; }
        .actions { display: flex; gap: 12px; margin-top: 24px; }
        .btn { padding: 10px 20px; background: #3b82f6; color: white; text-decoration: none; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; }
        .btn:hover { background: #2563eb; }
        .btn-secondary { background: #6b7280; }
        .btn-secondary:hover { background: #4b5563; }
        .existing-files { margin-bottom: 12px; padding: 12px; background: #f9fafb; border-radius: 6px; border: 1px solid #e5e7eb; }
        .existing-files h4 { font-size: 14px; color: #374151; margin-bottom: 8px; }
        .file-list { list-style: none; display: flex; flex-direction: column; gap: 4px; }
        .file-item { font-size: 13px; color: #6b7280; display: flex; align-items: center; }
        .file-item span { margin-right: 8px; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="container">
        <h1>게시판 수정</h1>
        <div class="card">
<form action="<c:url value='/board/edit/${vo.id}?page=${page}'/>" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${vo.id}">
                    <div class="form-group">
                        <label for="title">제목</label>
                        <input type="text" id="title" name="title" value="${vo.title}" required>
                    </div>
                    <div class="form-group">
                        <label for="content">내용</label>
                        <textarea id="content" name="content" required>${vo.content}</textarea>
                    </div>
                    <div class="form-group">
                        <label>현재 첨부 파일</label>
                        <div class="existing-files">
                            <ul class="file-list">
                                <c:forEach var="file" items="${files}">
                                    <li class="file-item">
                                        <span>📎</span> <c:out value="${file.originalName}"/> (<c:out value="${file.fileSize}"/> bytes)
                                    </li>
                                </c:forEach>
                                <c:if test="${empty files}">
                                    <span style="font-size: 13px; color: #9ca3af;">첨부된 파일이 없습니다.</span>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="files">첨부 파일 (최대 10개, 새로 업로드 시 기존 파일은 삭제됩니다)</label>
                        <input type="file" id="files" name="files" multiple style="border: none; padding: 0;">
                    </div>
                    <div class="actions">
                    <button type="submit" class="btn">저장</button>
                    <a href="<c:url value='/board?page=${page}'/>" class="btn btn-secondary">목록</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>