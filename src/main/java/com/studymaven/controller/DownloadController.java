package com.studymaven.controller;

import com.studymaven.domain.BoardFileVO;
import com.studymaven.service.BoardService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import org.springframework.web.bind.annotation.ResponseBody;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

/**
 * 다운로드 흐름: /download/prepare → 확인 화면
 *               /download/execute → 실제 파일 스트리밍
 */
@Controller
@RequestMapping("/download")
public class DownloadController {

    private static final Logger logger = LogManager.getLogger(DownloadController.class);
    @Autowired
    private BoardService boardService;

    @Value("${file.upload.dir}")
    private String uploadDir;

    /**
     * 파일 다운로드 전 확인 페이지.
     * JSP: /WEB-INF/views/download/prepare.jsp
     */
    @GetMapping("/prepare")
    public String prepare(@RequestParam("fileId") Long fileId, Model model) {
        BoardFileVO file = boardService.getFileById(fileId);
        model.addAttribute("file", file);
        return "download/prepare";
    }

    /**
     * 실제 파일을 스트리밍해서 브라우저에 다운로드.
     */
    @GetMapping("/execute")
    @ResponseBody

    public void execute(@RequestParam("fileId") Long fileId, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain;charset=UTF-8");
        BoardFileVO file = boardService.getFileById(fileId);
        if (file == null) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<script>alert('파일이 존재하지 않습니다.');history.back();</script>");
            return;
        }
        String dirPath = uploadDir;
        if (dirPath == null || dirPath.trim().isEmpty() || dirPath.contains("${")) {
            dirPath = System.getProperty("java.io.tmpdir");
        }
        File dir = new File(dirPath);
        logger.info("Downloading fileId={}, dirPath='{}', storedName='{}'", fileId, dirPath, file.getStoredName());
        File physical = new File(dir, file.getStoredName());
        if (!physical.exists()) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<script>alert('파일이 존재하지 않습니다.');history.back();</script>");
            return;
        }
        // Set Content-Type to ensure proper handling
        response.setContentType("application/octet-stream");
        // RFC 5987‑encoded filename for UTF‑8 safety
        String encodedName = URLEncoder.encode(file.getOriginalName(), StandardCharsets.UTF_8.name())
                .replaceAll("\\+", "%20");
        response.setHeader("Content-Disposition",
                "attachment; filename=\"" + file.getOriginalName() + "\"; filename*=UTF-8''" + encodedName);
        response.setContentLengthLong(physical.length());
        try (InputStream in = new FileInputStream(physical);
             OutputStream out = response.getOutputStream()) {
            byte[] buffer = new byte[8192];
            int len;
            while ((len = in.read(buffer)) != -1) {
                out.write(buffer, 0, len);
            }
        }
    }
}
