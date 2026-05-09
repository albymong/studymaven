<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Studymaven - AI 지식 플랫폼</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #fcfcfc; color: #1f2937; line-height: 1.6; padding-top: 70px; }
        
        /* Hero Section */
        .hero { height: 70vh; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%); padding: 0 20px; }
        .hero-content { max-width: 800px; }
        .hero h1 { font-size: 3.5rem; font-weight: 800; color: #111827; line-height: 1.2; margin-bottom: 1.5rem; letter-spacing: -1px; }
        .hero p { font-size: 1.25rem; color: #4b5563; margin-bottom: 2.5rem; }
        .hero-btns { display: flex; gap: 1rem; justify-content: center; }
        .cta-btn { padding: 1rem 2rem; font-size: 1.1rem; font-weight: 600; border-radius: 12px; text-decoration: none; transition: all 0.3s; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); }
        .cta-primary { background: #3b82f6; color: white; }
        .cta-primary:hover { background: #2563eb; transform: translateY(-2px); box-shadow: 0 10px 15px -3px rgba(59, 130, 246, 0.3); }
        .cta-secondary { background: white; color: #374151; border: 1px solid #d1d5db; }
        .cta-secondary:hover { background: #f9fafb; transform: translateY(-2px); }

        /* Recent Content Section */
        .section { padding: 5rem 5%; max-width: 1200px; margin: 0 auto; }
        .section-header { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 2rem; }
        .section-title { font-size: 2rem; font-weight: 700; color: #111827; }
        .section-subtitle { color: #6b7280; font-size: 1rem; }
        
        .content-card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); overflow: hidden; border: 1px solid #f3f4f6; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #f9fafb; padding: 1rem; text-align: left; font-weight: 600; color: #6b7280; font-size: 0.875rem; text-transform: uppercase; border-bottom: 1px solid #f3f4f6; }
        td { padding: 1.25rem 1rem; border-bottom: 1px solid #f3f4f6; color: #374151; font-size: 1rem; }
        tr:last-child td { border-bottom: none; }
        tr:hover { background: #fbfbfb; }
        .post-link { color: #111827; text-decoration: none; font-weight: 500; transition: color 0.2s; }
        .post-link:hover { color: #3b82f6; }
        
        .view-all-btn { display: inline-block; margin-top: 2rem; color: #3b82f6; text-decoration: none; font-weight: 600; transition: opacity 0.2s; }
        .view-all-btn:hover { opacity: 0.8; }

        /* Admin Section */
        .admin-panel { background: #f8fafc; padding: 3rem 5%; border-top: 1px solid #e2e8f0; text-align: center; }
        .admin-title { font-size: 1.25rem; font-weight: 600; color: #475569; margin-bottom: 1.5rem; }
        .admin-btns { display: flex; justify-content: center; gap: 1rem; }
        .admin-btn { padding: 0.75rem 1.5rem; background: white; border: 1px solid #cbd5e1; color: #64748b; border-radius: 8px; text-decoration: none; font-size: 0.875rem; transition: all 0.2s; }
        .admin-btn:hover { background: #f1f5f9; color: #1e293b; border-color: #94a3b8; }

        @media (max-width: 768px) {
            .hero h1 { font-size: 2.5rem; }
            .hero-btns { flex-direction: column; }
            .navbar { padding: 1rem 20px; }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
 
    <section class="hero">
        <div class="hero-content">
            <h1>AI 시대를 위한<br>스마트한 지식 저장소</h1>
            <p>복잡한 AI 용어부터 실무 지식까지, Studiumaven에서 함께 학습하고 공유하세요.</p>
            <div class="hero-btns">
                <a href="/board" class="cta-btn cta-primary">커뮤니티 방문하기</a>
                <a href="/term" class="cta-btn cta-secondary">용어사전 둘러보기</a>
            </div>
        </div>
    </section>
 
    <section class="section">
        <div class="section-header">
            <div>
                <h2 class="section-title">최신 인사이트</h2>
                <span class="section-subtitle">커뮤니티에서 공유된 최신 게시글입니다.</span>
            </div>
            <div class="section-subtitle">전체 게시글 <c:out value="${total}"/>개</div>
        </div>
        <div class="content-card">
            <table>
                <thead>
                    <tr>
                        <th style="width: 80px; text-align: center;">No</th>
                        <th>제목</th>
                        <th style="width: 150px; text-align: center;">작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="vo" items="${list}" begin="0" end="5">
                        <tr>
                            <td style="text-align: center; color: #9ca3af;"><c:out value="${vo.id}"/></td>
                            <td><a href="/board/view/${vo.id}?page=1" class="post-link"><c:out value="${vo.title}"/></a></td>
                            <td style="text-align: center; color: #6b7280;"><c:out value="${vo.createDate}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div style="text-align: right;">
            <a href="/board" class="view-all-btn">모든 게시글 보기 →</a>
        </div>
    </section>
 
    <c:if test="${loginUser.role == 'ADMIN'}">
        <section class="admin-panel">
            <div class="admin-title">관리자 전용 도구</div>
            <div class="admin-btns">
                <a href="/term/import" class="admin-btn">용어 데이터 가져오기</a>
                <a href="/term/write" class="admin-btn">신규 용어 등록</a>
            </div>
        </section>
    </c:if>
</body>
</html>