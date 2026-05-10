package com.studymaven.domain;

public class BoardFileVO {
    private Long id;
    private Long boardId;
    private String originalName;
    private String storedName;
    private Long fileSize;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getBoardId() { return boardId; }
    public void setBoardId(Long boardId) { this.boardId = boardId; }
    public String getOriginalName() { return originalName; }
    public void setOriginalName(String originalName) { this.originalName = originalName; }
    public String getStoredName() { return storedName; }
    public void setStoredName(String storedName) { this.storedName = storedName; }
    public Long getFileSize() { return fileSize; }
    public void setFileSize(Long fileSize) { this.fileSize = fileSize; }
}