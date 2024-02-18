<%@ page contentType="text/html;charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<jsp:include page="/WEB-INF/includes/admin/header.jsp" />
<section id="new-post">
<form method="POST" action='<%= response.encodeURL("j_security_check") %>'>
    Benutzername:<br />
    <input type="text" name="j_username" required autofocus /><br />
    Passwort:<br />
    <input type="password" name="j_password" required /><br /><br />
    <input type="submit" value="Anmelden" />
</form>
</section>
<jsp:include page="/WEB-INF/includes/footer.jsp" />