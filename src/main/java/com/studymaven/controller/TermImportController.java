package com.studymaven.controller;

import com.studymaven.domain.MemberVO;
import com.studymaven.domain.TermVO;
import com.studymaven.service.TermService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/term")
public class TermImportController {
    @Autowired
    private TermService service;

    @GetMapping("/import")
    public String importForm(HttpSession session) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
            return "redirect:/login";
        }
        return "term/import";
    }

    @PostMapping("/import")
    public String importData(@RequestParam("file") MultipartFile file, HttpSession session, Model model) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
            return "redirect:/login";
        }

        if (file.isEmpty()) {
            model.addAttribute("error", "파일을 선택해주세요.");
            return "term/import";
        }

        try {
            List<TermVO> terms = new ArrayList<>();
            String filename = file.getOriginalFilename();
            
            if (filename != null && filename.endsWith(".csv")) {
                terms = parseCSV(file);
            } else if (filename != null && filename.endsWith(".json")) {
                terms = parseJSON(file);
            } else {
                model.addAttribute("error", "CSV 또는 JSON 파일만 지원합니다.");
                return "term/import";
            }

            int count = 0;
            for (TermVO term : terms) {
                term.setAuthorId(loginUser.getId());
                service.create(term);
                count++;
            }

            model.addAttribute("success", count + "개의 용어를 등록했습니다.");
            model.addAttribute("count", count);

        } catch (Exception e) {
            model.addAttribute("error", "오류: " + e.getMessage());
        }

        return "term/import";
    }

    private List<TermVO> parseCSV(MultipartFile file) throws Exception {
        List<TermVO> terms = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8))) {
            String line;
            boolean first = true;
            while ((line = reader.readLine()) != null) {
                if (first) { first = false; continue; }
                String[] parts = line.split(",", -1);
                if (parts.length >= 3) {
                    TermVO term = new TermVO();
                    term.setTitle(parts[0].trim().replace("\"", ""));
                    term.setDefinition(parts[1].trim().replace("\"", ""));
                    term.setContent(parts.length > 2 ? parts[2].trim().replace("\"", "") : "");
                    term.setCategory(parts.length > 3 ? parts[3].trim().replace("\"", "") : "");
                    terms.add(term);
                }
            }
        }
        return terms;
    }

    private List<TermVO> parseJSON(MultipartFile file) throws Exception {
        List<TermVO> terms = new ArrayList<>();
        String content = new String(file.getBytes(), StandardCharsets.UTF_8);
        
        // Simple JSON array parsing
        int start = content.indexOf("[");
        int end = content.lastIndexOf("]");
        if (start >= 0 && end > start) {
            String arrayContent = content.substring(start, end + 1);
            
            // Extract each object
            int braceStart = -1;
            int braceCount = 0;
            StringBuilder current = new StringBuilder();
            
            for (int i = 0; i < arrayContent.length(); i++) {
                char c = arrayContent.charAt(i);
                if (c == '{') {
                    if (braceCount == 0) braceStart = i;
                    braceCount++;
                    current.append(c);
                } else if (c == '}') {
                    braceCount--;
                    current.append(c);
                    if (braceCount == 0) {
                        TermVO term = parseJsonObject(current.toString());
                        if (term != null && term.getTitle() != null) {
                            terms.add(term);
                        }
                        current = new StringBuilder();
                    }
                } else if (braceCount > 0) {
                    current.append(c);
                }
            }
        }
        return terms;
    }

    private TermVO parseJsonObject(String json) {
        try {
            TermVO term = new TermVO();
            
            term.setTitle(extractJsonValue(json, "term"));
            term.setDefinition(extractJsonValue(json, "english"));
            term.setContent(extractJsonValue(json, "desc"));
            term.setCategory(extractJsonValue(json, "category"));
            
            return term;
        } catch (Exception e) {
            return null;
        }
    }

    private String extractJsonValue(String json, String key) {
        String pattern = "\"" + key + "\"\\s*:\\s*\"([^\"]*)\"";
        java.util.regex.Pattern p = java.util.regex.Pattern.compile(pattern);
        java.util.regex.Matcher m = p.matcher(json);
        return m.find() ? m.group(1) : null;
    }
}