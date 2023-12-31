package de.schipplock.web.tilstory.business.posts.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "files")
public class FileUpload {

    @Id
    @SequenceGenerator(name = "file_seq_gen", sequenceName = "file_seq", initialValue = 1, allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "file_seq_gen")
    private Long id;

    @Column(name = "filename")
    private String fileName;

    @ManyToOne
    @JoinColumn(name = "post_id")
    private Post post;

    public FileUpload() {
    }

    public FileUpload(Post post, String fileName) {
        this.post = post;
        this.fileName = fileName;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileName() {
        return fileName;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public Post getPost() {
        return post;
    }
}
