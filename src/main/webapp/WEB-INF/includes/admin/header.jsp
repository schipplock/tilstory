<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="settings" uri="/WEB-INF/settings.tld" %>
<!DOCTYPE html>
<html lang="de">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
<title>${settings:name()} Admin</title>

<header>
    <h1># <a href="${pageContext.request.contextPath}/">${settings:name()} Admin</a></h1>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">startseite</a></li>
            <li><a href="${pageContext.request.contextPath}/admin.jsp">verfassen</a></li>
            <li><a href="${pageContext.request.contextPath}/settings.jsp">einstellungen</a></li>
            <li><a href="${pageContext.request.contextPath}/profile.jsp">profil</a></li>
            <li><a href="${pageContext.request.contextPath}/admin.jsp?logoff">abmelden</a></li>
        </ul>
    </nav>
</header>
