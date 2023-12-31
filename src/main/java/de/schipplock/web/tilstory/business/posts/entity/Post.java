package de.schipplock.web.tilstory.business.posts.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Entity
@Table(name = "posts")
public class Post {

    @Id
    @SequenceGenerator(name = "post_seq_gen", sequenceName = "post_seq", initialValue = 1, allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "post_seq_gen")
    private Long id;

    private UUID guid;

    private String subject;

    private String body;

    private boolean draft;

    private LocalDateTime updated;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "post", orphanRemoval = true)
    private List<FileUpload> fileUploads = new ArrayList<>();

    public Post() {}

    public Post(UUID uuid, String subject, String body, boolean draft) {
        this.guid = uuid;
        this.subject = subject;
        this.body = body;
        this.draft = draft;
    }

    public Post(Long id, String subject, String body, boolean draft) {
        this.id = id;
        this.subject = subject;
        this.body = body;
        this.draft = draft;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public UUID getGuid() {
        return guid;
    }

    public void setGuid(UUID guid) {
        this.guid = guid;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public boolean isDraft() {
        return draft;
    }

    public void setDraft(boolean draft) {
        this.draft = draft;
    }

    public List<FileUpload> getFileUploads() {
        return fileUploads;
    }

    public void setFileUploads(List<FileUpload> fileUploads) {
        this.fileUploads = fileUploads;
    }

    public LocalDateTime getUpdated() {
        return updated;
    }

    public void setUpdated(LocalDateTime updated) {
        this.updated = updated;
    }

    @PrePersist
    public void initializeUUID() {
        guid = UUID.randomUUID();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Post post = (Post) o;
        return draft == post.draft && Objects.equals(id, post.id) && Objects.equals(guid, post.guid) && Objects.equals(subject, post.subject) && Objects.equals(body, post.body) && Objects.equals(updated, post.updated) && Objects.equals(fileUploads, post.fileUploads);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, guid, subject, body, draft, updated, fileUploads);
    }

    @Override
    public String toString() {
        return "Post{" +
                "id=" + id +
                ", guid=" + guid +
                ", subject='" + subject + '\'' +
                ", body='" + body + '\'' +
                ", draft=" + draft +
                ", updated=" + updated +
                ", fileUploads=" + fileUploads +
                '}';
    }
}
