package de.schipplock.web.tilstory;

import de.schipplock.web.tilstory.business.settings.control.SettingsManager;
import jakarta.servlet.jsp.tagext.BodyTagSupport;
import org.commonmark.parser.Parser;
import org.commonmark.renderer.html.HtmlRenderer;
import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;

import java.io.IOException;

public class PostRenderer extends BodyTagSupport {

    @Override
    public int doAfterBody() {
        var bc = getBodyContent();
        try {
            // null-party going on here :D, fingers crossed...
            String rendered = HtmlRenderer.builder().build().render(Parser.builder().build().parse(bc.getString()));
            var renderedBody = Jsoup.clean(rendered, SettingsManager.baseUrl(), Safelist.relaxed().preserveRelativeLinks(true));
            bc.clearBody();
            bc.getEnclosingWriter().write(renderedBody);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return SKIP_BODY;
    }
}
