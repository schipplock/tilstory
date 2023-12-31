package de.schipplock.web.tilstory.business.posts.control;

import de.schipplock.web.tilstory.business.posts.entity.FileUpload;
import de.schipplock.web.tilstory.business.posts.entity.Post;
import de.schipplock.web.tilstory.business.settings.control.SettingsManager;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;

@Stateless
public class PostManager {

    private static final Logger LOGGER = Logger.getLogger(PostManager.class.getName());

    @PersistenceContext
    private EntityManager em;

    public Post createPost(String subject, String body, boolean isDraft, Collection<Part> fileParts, String[] fileNamesForDeletion) throws IOException {
        UUID uuid = UUID.randomUUID();
        Post post = new Post(uuid, subject, body, isDraft);
        post.setFileUploads(handleFileUploads(post, fileParts));
        post.setFileUploads(deleteSelectedFilesForPost(post, fileNamesForDeletion));

        if (!isDraft) {
            post.setCreated(LocalDateTime.now());
        }

        return em.merge(post);
    }

    public Post updatePost(long postId, String subject, String body, boolean isDraft, Collection<Part> fileParts, String[] fileNamesForDeletion) throws IOException {
        Post post = getPostById(postId);
        post.setSubject(subject);
        post.setBody(body);
        post.setDraft(isDraft);
        post.setFileUploads(handleFileUploads(post, fileParts));
        post.setFileUploads(deleteSelectedFilesForPost(post, fileNamesForDeletion));

        if (!isDraft) {
            post.setUpdated(LocalDateTime.now());
            if (post.getCreated() == null) {
                post.setCreated(LocalDateTime.now());
                post.setUpdated(null);
            }
        }

        return em.merge(post);
    }

    public void deletePost(long postId) throws IOException {
        Post post = getPostById(postId);
        post.setFileUploads(deleteAllUploadedFilesForPost(post));
        em.remove(em.merge(post));
    }

    public Post getPostById(Long postId) {
        TypedQuery<Post> query = em.createQuery("SELECT p FROM Post p WHERE id = :id", Post.class);
        return query.setParameter("id", postId).getSingleResult();
    }

    private List<FileUpload> deleteSelectedFilesForPost(Post post, String[] fileNamesForDeletion) throws IOException {
        var fileUploads = post.getFileUploads();
        if (fileNamesForDeletion == null) {
            return fileUploads;
        }
        for (var file: fileNamesForDeletion) {
            Files.deleteIfExists(Path.of(SettingsManager.uploadDir(), String.valueOf(post.getGuid()), file));
            fileUploads.removeIf(fileUpload -> fileUpload.getFileName().equals(file));
        }
        return fileUploads;
    }

    private List<FileUpload> handleFileUploads(Post post, Collection<Part> fileParts) throws IOException {
        var fileUploads = post.getFileUploads();
        if (!fileParts.isEmpty()) {
            Path targetDirectory = Path.of(SettingsManager.uploadDir(), String.valueOf(post.getGuid()));
            if (!Files.exists(targetDirectory)) {
                Files.createDirectory(targetDirectory);
            }

            for (var filePart : fileParts) {
                fileUploads.add(new FileUpload(post, filePart.getSubmittedFileName()));
                filePart.write(Path.of(targetDirectory.toString(), filePart.getSubmittedFileName()).toString());
            }
        }
        return fileUploads;
    }

    private List<FileUpload> deleteAllUploadedFilesForPost(Post post) throws IOException {
        File[] files = Path.of(SettingsManager.uploadDir(), String.valueOf(post.getGuid())).toFile().listFiles();
        var fileUploads = post.getFileUploads();
        if (files == null) {
            return fileUploads;
        }
        for (var file: files) {
            if (file.delete()) {
                fileUploads.removeIf(fileUpload -> file.getName().equals(fileUpload.getFileName()));
                LOGGER.info(String.format("file '%s' successfully deleted", file));
            } else {
                LOGGER.severe(String.format("failed to delete file '%s'", file));
            }
        }
        Files.delete(Path.of(SettingsManager.uploadDir(), String.valueOf(post.getId())));
        return fileUploads;
    }
}
