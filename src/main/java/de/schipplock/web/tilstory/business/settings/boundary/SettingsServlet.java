package de.schipplock.web.tilstory.business.settings.boundary;

import de.schipplock.web.tilstory.business.settings.control.SettingsManager;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;

@WebServlet("/settings")
public class SettingsServlet extends HttpServlet {

    @Inject
    private SettingsManager settingsManager;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Arrays.stream(SettingsManager.SETTING_KEYS).forEach(setting -> settingsManager.set(setting, req.getParameter(setting)));
        settingsManager.save();
        resp.sendRedirect(String.format("%s/settings.jsp?status=success", req.getContextPath()));
    }
}
