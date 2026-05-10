package com.studymaven.controller;

import com.studymaven.domain.BoardVO;
import com.studymaven.domain.MemberVO;
import com.studymaven.mapper.BoardMapper;
import com.studymaven.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http. HttpSession;
import java.time.LocalDateTime;
import java.util.*;
import java.util.Map;
import java.util.Objects;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService service;

    @GetMapping("")
    public String list(@RequestParam(value="page", defaultValue="1") int page, Model model) {
        Map<String, Object> result = service.getPage(page);
        List<BoardVO> list = (List<BoardVO>) result.get("list");
        for (BoardVO vo : list) {
            vo.setCreateDate(formatDate(vo.getCreateDate()));
            vo.setUpdateDate(formatDate(vo.getUpdateDate()));
        }
        model.addAttribute("list", list);
        model.addAttribute("currentPage", result.get("currentPage"));
        model.addAttribute("totalPages", result.get("totalPages"));
        model.addAttribute("total", result.get("total"));
        return "board/list";
    }

    @GetMapping("/view/{id}")
    public String view(@PathVariable("id") Long id, @RequestParam(value="page", defaultValue="1") int page, Model model) {
        BoardVO vo = service.get(id);
        vo.setCreateDate(formatDate(vo.getCreateDate()));
        vo.setUpdateDate(formatDate(vo.getUpdateDate()));
        model.addAttribute("vo", vo);
        // Add attached files for display
        model.addAttribute("files", service.getFiles(id));
        model.addAttribute("page", page);
        return "board/view";
    }

    @GetMapping("/write")
    public String writeForm(@RequestParam(value="page", defaultValue="1") int page, Model model) {
        model.addAttribute("vo", new BoardVO());
        model.addAttribute("page", page);
        return "board/write";
    }

    @PostMapping("/write")
    public String write(@ModelAttribute BoardVO vo,
                        @RequestParam(value="files", required=false) List<MultipartFile> files,
                        @RequestParam(value="page", defaultValue="1") int page,
                        HttpSession session, RedirectAttributes rt) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        
        if (files != null && files.size() > 10) {
            rt.addFlashAttribute("message", "파일은 최대 10개까지만 업로드 가능합니다.");
            return "redirect:/board/write?page=" + page;
        }
        
        service.create(vo, loginUser.getId(), files);
        rt.addFlashAttribute("message", "게시글이 등록되었습니다.");
        return "redirect:/board?page=" + page;
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable("id") Long id, @RequestParam(value="page", defaultValue="1") int page, Model model, HttpSession session, RedirectAttributes rt) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        BoardVO vo = service.get(id);
        if (vo == null) return "redirect:/board?page=" + page;
        if (loginUser == null || (!Objects.equals(vo.getWriterId(), loginUser.getId()) && !"ADMIN".equals(loginUser.getRole()))) {
            rt.addFlashAttribute("message", "수정 권한이 없습니다.");
            return "redirect:/board?page=" + page;
        }
        model.addAttribute("vo", vo);
        model.addAttribute("files", service.getFiles(id));
        model.addAttribute("page", page);
        return "board/edit";
    }
 
    @PostMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, @ModelAttribute BoardVO vo, 
                       @RequestParam(value="files", required=false) List<MultipartFile> files,
                       @RequestParam(value="page", defaultValue="1") int page, HttpSession session, RedirectAttributes rt) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        BoardVO existing = service.get(id);
        if (loginUser == null || existing == null || (!Objects.equals(existing.getWriterId(), loginUser.getId()) && !"ADMIN".equals(loginUser.getRole()))) {
            rt.addFlashAttribute("message", "수정 권한이 없습니다.");
            return "redirect:/board?page=" + page;
        }
        
        if (files != null && files.size() > 10) {
            rt.addFlashAttribute("message", "파일은 최대 10개까지만 업로드 가능합니다.");
            return "redirect:/board/edit/" + id + "?page=" + page;
        }
        
        vo.setId(id);
        service.update(vo, files);
        rt.addFlashAttribute("message", "게시글이 수정되었습니다.");
        return "redirect:/board?page=" + page;
    }
 
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id, @RequestParam(value="page", defaultValue="1") int page, HttpSession session, RedirectAttributes rt) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        BoardVO existing = service.get(id);
        if (loginUser == null || existing == null || (!Objects.equals(existing.getWriterId(), loginUser.getId()) && !"ADMIN".equals(loginUser.getRole()))) {
            rt.addFlashAttribute("message", "삭제 권한이 없습니다.");
            return "redirect:/board?page=" + page;
        }
        service.delete(id);
        rt.addFlashAttribute("message", "게시글이 삭제되었습니다.");
        return "redirect:/board?page=" + page;
    }

    private String formatDate(String s) {
        if (s == null || s.length() < 19) return s;
        try {
            LocalDateTime dt = LocalDateTime.parse(s.substring(0, 19).replace(" ", "T"));
            if (dt.plusDays(7).isAfter(LocalDateTime.now())) {
                return s.substring(0, 16);
            }
            return s.substring(0, 10);
        } catch (Exception e) { return s; }
    }
}