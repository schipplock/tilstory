package de.schipplock.web.tilstory.business.profile.control;

import de.schipplock.web.tilstory.business.profile.entity.User;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Stateless
public class ProfileManager {

    @PersistenceContext
    EntityManager em;

    public void updatePassword(String user, String password) {
        em.merge(new User(user, digest(password)));
    }

    private String digest(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            md.update(input.getBytes());
            byte[] digest = md.digest();
            return bytesToHex(digest);
        } catch (NoSuchAlgorithmException e) {
            return null;
        }
    }

    private String bytesToHex(byte[] bytes) {
        StringBuilder result = new StringBuilder();
        for (byte b : bytes) {
            result.append(String.format("%02x", b));
        }
        return result.toString();
    }
}
