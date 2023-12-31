package de.schipplock.web.tilstory.business.settings.control;

import de.schipplock.web.tilstory.business.settings.entity.Setting;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Stateless
public class SettingsManager {

    @PersistenceContext
    EntityManager em;

    private static final String APPLICATION_BASEURL = "application.baseurl";

    private static final String APPLICATION_NAME = "application.name";

    private static final String POST_AUTHOR = "post.author";

    private static final String PHONE = "phone";

    private static final String EMAIL = "email";

    private static final String IMPRINT = "imprint";

    private static final String PRIVACY_POLICY = "privacy.policy";

    public static final String[] SETTING_KEYS = new String[] {
            APPLICATION_BASEURL,
            APPLICATION_NAME,
            POST_AUTHOR,
            PHONE,
            EMAIL,
            IMPRINT,
            PRIVACY_POLICY
    };

    private static final Map<String, Setting> SETTINGS = new HashMap<>();

    public SettingsManager() {
    }

    public void load() {
        TypedQuery<Setting> settingTypedQuery = em.createQuery("SELECT NEW Setting(key, value) FROM Setting", Setting.class);
        List<Setting> settingsList = settingTypedQuery.getResultList();
        settingsList.forEach(setting -> SETTINGS.put(setting.getKey(), setting));
    }

    public void set(String key, String value) {
        SETTINGS.get(key).setValue(value);
    }

    public void save() {
        SETTINGS.forEach((key, setting) -> em.merge(setting));
    }

    public static String uploadDir() {
        return System.getenv("UPLOAD_DIR");
    }

    public static String baseUrl() {
        return SETTINGS.get(APPLICATION_BASEURL).getValue();
    }

    public static String name() {
        return SETTINGS.get(APPLICATION_NAME).getValue();
    }
    public static String author() {
        return SETTINGS.get(POST_AUTHOR).getValue();
    }

    public static String phone() {
        return SETTINGS.get(PHONE).getValue();
    }

    public static String reversedEmail() {
        return new StringBuffer(SETTINGS.get(EMAIL).getValue()).reverse().toString();
    }

    public static String email() {
        return SETTINGS.get(EMAIL).getValue();
    }

    public static String imprint() {
        return SETTINGS.get(IMPRINT).getValue();
    }

    public static String privacyPolicy() {
        return SETTINGS.get(PRIVACY_POLICY).getValue();
    }
}
