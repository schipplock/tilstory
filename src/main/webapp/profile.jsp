<%@ page contentType="text/html;charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/includes/admin/header.jsp" />
<section>
    <c:if test="${not empty param.status and param.status eq 'success'}">
        <div id="status-success">Das Passwort wurde erfolgreich geändert.</div>
    </c:if>
    <c:if test="${not empty param.status and param.status eq 'kaputt'}">
        <div id="status-error">Irgendwas ist schief gelaufen.</div>
    </c:if>
    <c:if test="${not empty param.status and param.status eq 'password-mismatch'}">
        <div id="status-error">Die Passwörter waren nicht identisch.</div>
    </c:if>
    <form method="POST" action='${pageContext.request.contextPath}/profile'>
        Benutzername:<br />
        <input type="text" disabled required value="<%= request.getUserPrincipal().getName() %>" /><br />
        Passwort:<br />
        <input type="password" name="password1" required /><br />
        Passwort wiederholen:<br />
        <input type="password" name="password2" required /><br /><br />
        <input type="submit" value="Speichern" />
    </form>
</section>
<jsp:include page="/WEB-INF/includes/footer.jsp" />