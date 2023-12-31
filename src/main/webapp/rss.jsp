<%@ page session="false" language="java" contentType="application/rss+xml; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="settings" uri="/WEB-INF/settings.tld" %>
<fmt:setLocale value="en_US" scope="page" />
<sql:query var="posts" dataSource="postgres">
    select id, guid, subject, created from posts where draft is not true order by id desc
</sql:query>
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
<title>${settings:name()}</title>
<link>${settings:baseurl()}</link>
<description>Kurze Texte von ${settings:author()}</description>
<language>de-de</language>
<atom:link href="${settings:baseurl()}/rss.jsp" rel="self" type="application/rss+xml" />
<c:forEach var="post" items="${posts.rows}">
<item>
<title>${post.subject}</title>
<link>${settings:baseurl()}/?postId=${post.guid}#post${post.guid}</link>
<guid isPermaLink="true">${settings:baseurl()}/?postId=${post.guid}#post${post.guid}</guid>
<pubDate><fmt:formatDate value="${post.created}" type="both" pattern="EEE, dd MMM yyyy HH:mm:ss Z" /></pubDate>
</item>
</c:forEach>
</channel>
</rss>
