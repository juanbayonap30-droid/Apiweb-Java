<%@ page contentType="text/html; charset=UTF-8" %>
<nav style="background:#2c3e50;padding:0.8rem 2rem;display:flex;align-items:center;gap:1.5rem;">
    <span style="color:#fff;font-weight:bold;font-size:1.1rem;margin-right:auto;">GestionApp</span>
    <a href="${pageContext.request.contextPath}/usuarios" style="color:#ecf0f1;text-decoration:none;padding:0.4rem 0.9rem;border-radius:4px;">Ver usuarios</a>
    <a href="${pageContext.request.contextPath}/usuarios?action=nuevo" style="color:#ecf0f1;text-decoration:none;padding:0.4rem 0.9rem;border-radius:4px;background:#27ae60;">+ Nuevo</a>
    <a href="${pageContext.request.contextPath}/api-colombia" style="color:#ecf0f1;text-decoration:none;padding:0.4rem 0.9rem;border-radius:4px;background:#c0392b;">🇨🇴 API Colombia</a>
    <a href="${pageContext.request.contextPath}/logout" style="color:#ecf0f1;text-decoration:none;padding:0.4rem 0.9rem;border-radius:4px;background:#e74c3c;">Cerrar sesión</a>
</nav>
