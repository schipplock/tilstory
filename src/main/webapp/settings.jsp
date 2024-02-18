<%@ page contentType="text/html;charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="settings" uri="/WEB-INF/settings.tld" %>
<jsp:include page="/WEB-INF/includes/admin/header.jsp" />
<section>
    <c:if test="${not empty param.status and param.status eq 'success'}">
        <div id="status-success">Die Einstellungen wurden erfolgreich geändert.</div>
    </c:if>
    <c:if test="${not empty param.status and param.status eq 'kaputt'}">
        <div id="status-error">Irgendwas ist schief gelaufen.</div>
    </c:if>
    <form method="POST" action='${pageContext.request.contextPath}/settings'>
        application.baseurl:<br />
        <input type="text" name="application.baseurl" value="${settings:baseurl()}" /><br />
        application.name:<br />
        <input type="text" name="application.name" value="${settings:name()}" /><br />
        post.author:<br />
        <input type="text" name="post.author" value="${settings:author()}" /><br />
        phone:<br />
        <input type="text" name="phone" value="${settings:phone()}" /><br />
        email:<br />
        <input type="text" name="email" value="${settings:email()}" /><br />
        imprint:<br />
        <textarea rows="10" name="imprint">${settings:imprint()}</textarea><br />
        privacy.policy:<br />
        <textarea rows="10" name="privacy.policy">${settings:privacyPolicy()}</textarea><br /><br />
        <input type="submit" value="Speichern" />
    </form>
</section>
<jsp:include page="/WEB-INF/includes/footer.jsp" />