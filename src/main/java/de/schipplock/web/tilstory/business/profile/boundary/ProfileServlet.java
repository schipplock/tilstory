package de.schipplock.web.tilstory.business.profile.boundary;

import de.schipplock.web.tilstory.business.profile.control.ProfileManager;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Inject
    private ProfileManager profileManager;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String user = req.getUserPrincipal().getName();
        String password1 = req.getParameter("password1");
        String password2 = req.getParameter("password2");

        if (user == null || password1 == null || password2 == null) {
            resp.sendRedirect(String.format("%s/profile.jsp?status=kaputt", req.getContextPath()));
            return;
        }

        if (!password1.equals(password2)) {
            resp.sendRedirect(String.format("%s/profile.jsp?status=password-mismatch", req.getContextPath()));
            return;
        }

        profileManager.updatePassword(user, password1);

        resp.sendRedirect(String.format("%s/profile.jsp?status=success", req.getContextPath()));
    }
}
