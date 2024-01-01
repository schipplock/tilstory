<%@ page session="false" language="java" contentType="text/css; charset=UTF-8" trimDirectiveWhitespaces="true" %>
@font-face {
    font-family: "robotoregular";
    src: url("${pageContext.request.contextPath}/fonts/roboto-regular-webfont.woff2") format("woff2"),
    url("${pageContext.request.contextPath}/fonts/roboto-regular-webfont.woff") format("woff");
    font-weight: normal;
    font-style: normal;
}

html {
    background: #ffffff url("${pageContext.request.contextPath}/graphics/background_tile.png") repeat;
}

body {
    margin: 0 auto;
    max-width: 30em;
    font-size: 0.9em;
    font-family: "robotoregular", "Arial", sans-serif;
    line-height: 1.5;
    padding: 1em 1em;
    color: #566b78;
}

img {
    max-width: 100%;
}

a:link, a:visited, a:link h1, a:visited h1 {
    color: #42bcad;
    text-decoration: none;
}

h2 {
    margin-top: 1em;
    padding-top: 1em;
}

h1,
h2,
strong {
    color: #333;
}

main {
    background: url("${pageContext.request.contextPath}/graphics/y-tile.png") repeat-y center center;
}

header {
    box-sizing:border-box;
    border: 1px solid #41c4a6;
    margin-bottom: 10px;
    background-color:#fff;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
    width:100%;
    text-align:center;
    border-radius: 5px 5px 0 0;
}

header h1 {
    padding:0;
    margin: 0 0 0 10px;
    color: #444444;
    text-shadow: 1px 1px 2px #c0c0c0;
}

header h2 {
    color: #444444;
    font-size:0.6em;
    padding:0;
    margin: 0 0 10px 10px;
}

header h3 {
    color: #c1c8c2;
    font-size:0.6em;
    padding:3px 0 3px 0;
    margin:0;
    border-top-width:1px;
    border-top-color: #d8fff6;
    border-top-style:solid;
}

section {
    box-sizing:border-box;
    border: 1px solid #41c4a6;
    padding: 10px 10px 10px 10px;
    margin-bottom: 10px;
    font-size:0.8em;
    background-color:#fff;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}

section h1 {
    padding:0;
    margin: 0 0 5px;
    font-size:0.8em;
}

section.post {
    box-sizing:border-box;
    padding:0;
    width:100%;
}

section.postcontentless {
    box-sizing:border-box;
    width:100%;
}

section.postcontentless:nth-child(odd) {
    background-color:#fff;
}

section.postcontentless:nth-child(even) {
    background-color: #fafafa;
}

section.post:nth-child(odd) {
    border: 1px solid #41c4a6;
}

section.post:nth-child(even) {
    border: 1px solid #41c4a6;
}

section.post h1.subject {
    padding: 0 0 0 10px;
    margin: 10px 0 0;
    text-shadow: 1px 1px 2px #c0c0c0;
    text-align:left;
}

section.post h2.author {
    color: #adadad;
    font-size:0.8em;
    margin-bottom:10px;
    margin-left: 31px;
}

section.post h2.error-description {
    color: #adadad;
    font-size:0.8em;
    margin-bottom:10px;
}

section.postcontentless h1.subject {
    text-align:left;
    margin:0;
    font-size: 1em;
    text-shadow: 0 0 0;
}

section.post h1,
section.post h2,
section.post h3,
section.post h4,
section.post h5,
section.post h6 {
    padding: 0 0 0 10px;
    margin:0;
    border-top:0;
}

section.post h1 {font-size: 1.6em}
section.post h2 {font-size: 1.5em}
section.post h3 {font-size: 1.4em}
section.post h4 {font-size: 1.3em}
section.post h5 {font-size: 1.2em}
section.post h6 {font-size: 1.1em}

section.post p {
    padding:10px;
    margin:0;
    border-top: 1px solid #41c4a6;
}

section.post p.created {
    color: #8bbcb4;
    border-top: 1px solid #41c4a6;
    font-size:0.6em;
}

section.post blockquote {
    border:0;
    padding:0;
    margin:0;
}

section.post blockquote p::before {
    content: '| ';
    left: -0.33em;
    top: -0.2em;
    font-family: monospace;
    font-weight: bold;
    color: #42bcad;
}

section.post blockquote p {
    padding:10px;
    margin:0;
    background-color: #f7f7f7;
    border-bottom: 1px solid #41c4a6;
    border-top:0;
    font-family: serif;
}

section.post pre {
    margin:0;
    padding:0;
}

section.post pre code {
    display: block;
    white-space: pre;
    -webkit-overflow-scrolling: touch;
    overflow-x: auto;
    max-width: 100%;
    min-width: 100px;
    padding:10px;
    margin:0;
    background-color: #f7f7f7;
    border-top: 1px solid #41c4a6;
    border-bottom:0;
}

section.post ul, section.post.ol {
    padding:10px;
    margin:0;
    background-color: #f7f7f7;
    border-bottom: 1px solid #41c4a6;
    border-top:0;
    list-style-type: square;
    list-style-position: inside;
}

footer {
    box-sizing:border-box;
    font-size:0.8em;
    background-color: #fff;
    border-width: 1px;
    border-color: #41c4a6;
    border-style: solid;
    padding: 10px 10px 10px;
    margin-bottom: 10px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
    width:100%;
    border-radius: 0 0 5px 5px;
}

.email {
    unicode-bidi: bidi-override;
    direction: rtl
}

caption {
    display: none;
}

footer#kontakt {
    font-size: 0.5em;
}

footer h2 {
    padding: 0;
    margin: 0
}

footer p {
    padding: 0;
    margin: 0;
}