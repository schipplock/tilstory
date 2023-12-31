package de.schipplock.web.tilstory.business.posts.boundary;

import static java.lang.String.format;

import java.io.IOException;
import java.util.*;
import java.util.logging.Logger;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import de.schipplock.web.tilstory.business.posts.control.PostManager;

@WebServlet("/post")
@MultipartConfig
public class PostServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(PostServlet.class.getName());

    @Inject
    private PostManager postManager;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        var postId = req.getParameter("id") == null ? 0L : req.getParameter("id").isBlank() ? 0L : Long.parseLong(req.getParameter("id"));
        var subject = req.getParameter("subject");
        var body = req.getParameter("body");
        var isDraft = Boolean.parseBoolean(req.getParameter("draft"));
        var fileParts = getFileParts(req);
        var fileNamesForDeletion = req.getParameterValues("files");

        if (isCreatePost(req)) {
            var post = postManager.createPost(subject, body, isDraft, fileParts, fileNamesForDeletion);
            postId = post.getId();
            LOGGER.info(format("post %d created with subject '%s'", postId, post.getSubject()));
        }

        if (isUpdatePost(req)) {
            var post = postManager.updatePost(postId, subject, body, isDraft, fileParts, fileNamesForDeletion);
            postId = post.getId();
            LOGGER.info(format("post %d updated", postId));
        }

        if (isDeletePost(req)) {
            postManager.deletePost(postId);
            LOGGER.info(format("post %d deleted", postId));
        }

        if (isDraft) {
            resp.sendRedirect(format("%s/admin.jsp?id=%s", req.getContextPath(), postId));
            return;
        }

        resp.sendRedirect(format("%s/admin.jsp", req.getContextPath()));
    }

    private boolean isCreatePost(HttpServletRequest req) {
        return !isUpdatePost(req) && !isDeletePost(req);
    }

    private boolean isUpdatePost(HttpServletRequest req) {
        return req.getParameter("id") != null && !req.getParameter("id").isEmpty() && !isDeletePost(req);
    }

    private boolean isDeletePost(HttpServletRequest req) {
        return req.getParameter("_method") != null && "delete".equalsIgnoreCase(req.getParameter("_method"));
    }
    
    private Collection<Part> getFileParts(HttpServletRequest req) throws IOException, ServletException {
        var parts = req.getParts();
        Set<Part> fileParts = new HashSet<>();
        if (parts == null || parts.isEmpty()) {
            return fileParts;
        }
        parts.forEach(part -> {
            if ("file".equals(part.getName()) && part.getSize() > 0) {
                fileParts.add(part);
            }
        });
        return fileParts;
    }

}
