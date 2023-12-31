package de.schipplock.web.tilstory;

import de.schipplock.web.tilstory.business.settings.control.SettingsManager;
import jakarta.inject.Inject;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import java.util.logging.Logger;

@WebServlet(name = "startup servlet", urlPatterns = "/startup", loadOnStartup = 1)
public class ApplicationStartupServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ApplicationStartupServlet.class.getName());

    @Inject
    SettingsManager settingsManager;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        settingsManager.load();
        LOGGER.info("TILStory booted up, yay!");
    }
}
