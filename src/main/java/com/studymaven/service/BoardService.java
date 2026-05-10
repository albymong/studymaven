package com.studymaven.service;

import com.studymaven.domain.BoardFileVO;
import com.studymaven.domain.BoardVO;
import com.studymaven.mapper.BoardMapper;
import java.io.File;
import java.io.IOException;
import java.util.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class BoardService {
    private static final Logger logger = LogManager.getLogger(BoardService.class);

    @Value("${file.upload.dir}")
    private String uploadDir;

    @Autowired
    private BoardMapper mapper;

    private static final int PAGE_SIZE = 10;

    public List<BoardVO> getAll() { 
        List<BoardVO> list = mapper.selectAll();
        logger.info("Board All List: {}", list);
        return list;
    }
    public Map<String, Object> getPage(int page) {
        int offset = (page - 1) * PAGE_SIZE;
        Map<String, Object> params = new HashMap<>();
        params.put("limit", PAGE_SIZE);
        params.put("offset", offset);
        List<BoardVO> list = mapper.selectPage(params);
        int total = mapper.count();
        int totalPages = (int) Math.ceil((double) total / PAGE_SIZE);
        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("currentPage", page);
        result.put("totalPages", totalPages);
        result.put("total", total);
        logger.info("Board Page {} Result: {}", page, result);
        return result;
    }
    public BoardVO get(Long id) { return mapper.select(id); }
    public void create(BoardVO vo, Long writerId, List<MultipartFile> files) {
        vo.setWriterId(writerId);
        mapper.insert(vo);
        if (files != null) {
            saveFiles(vo.getId(), files);
        }
    }
    public void update(BoardVO vo, List<MultipartFile> files) {
        mapper.update(vo);
        if (files != null && !files.isEmpty()) {
            mapper.deleteFiles(vo.getId());
            deletePhysicalFiles(vo.getId());
            saveFiles(vo.getId(), files);
        }
    }
    public void delete(Long id) {
        deletePhysicalFiles(id);
        mapper.deleteFiles(id);
        mapper.delete(id);
    }
    public List<BoardFileVO> getFiles(Long boardId) { return mapper.selectFiles(boardId); }
    public BoardFileVO getFileById(Long fileId) { return mapper.selectById(fileId); }
    public BoardFileVO getFileByStoredName(String storedName) { return mapper.selectByStoredName(storedName); }
    
    private void saveFiles(Long boardId, List<MultipartFile> files) {
        // Ensure upload directory is defined; fall back to system temp if not configured
        String dirPath = uploadDir;
        if (dirPath == null || dirPath.trim().isEmpty()) {
            dirPath = System.getProperty("java.io.tmpdir");
        }
        // Ensure trailing separator
        if (!dirPath.endsWith(File.separator)) {
            dirPath = dirPath + File.separator;
        }
        File dir = new File(dirPath);
        if (!dir.exists()) dir.mkdirs();

        for (MultipartFile file : files) {
            if (file.isEmpty()) continue;
            String originalName = file.getOriginalFilename();
            String storedName = System.currentTimeMillis() + "_" + originalName;
            try {
                file.transferTo(new File(dir, storedName));
                BoardFileVO fileVO = new BoardFileVO();
                fileVO.setBoardId(boardId);
                fileVO.setOriginalName(originalName);
                fileVO.setStoredName(storedName);
                fileVO.setFileSize(file.getSize());
                mapper.insertFile(fileVO);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void deletePhysicalFiles(Long boardId) {
        List<BoardFileVO> files = mapper.selectFiles(boardId);
        String dirPath = uploadDir;
        if (dirPath == null || dirPath.trim().isEmpty()) {
            dirPath = System.getProperty("java.io.tmpdir");
        }
        File dir = new File(dirPath);
        for (BoardFileVO file : files) {
            new File(dir, file.getStoredName()).delete();
        }
    }
}