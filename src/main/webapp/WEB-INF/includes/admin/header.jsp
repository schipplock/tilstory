<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="settings" uri="/WEB-INF/settings.tld" %>
<!DOCTYPE html>
<html lang="de">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css.jsp">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
<title>${settings:name()} Admin</title>
<main>
<header>
    <h1># <a href="${pageContext.request.contextPath}/">${settings:name()}</a></h1>
    <h2>Kurze Texte von ${settings:author()}</h2>
    <h3>
        <a href="https://github.com/schipplock/tilstory" target="_blank">TILStory 0.0.7</a> |
        <a href="${pageContext.request.contextPath}/rss.jsp">rss</a>
    </h3>
</header>
<nav id="menu">
    <b id="menulabel">menü:</b>
    <a href="${pageContext.request.contextPath}/">startseite</a> |
    <a href="${pageContext.request.contextPath}/admin.jsp">verfassen</a> |
    <a href="${pageContext.request.contextPath}/settings.jsp">einstellungen</a> |
    <a href="${pageContext.request.contextPath}/profile.jsp">profil</a> |
    <a href="${pageContext.request.contextPath}/admin.jsp?logoff">abmelden</a>
</nav>
