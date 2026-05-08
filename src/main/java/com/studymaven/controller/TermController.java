package com.studymaven.controller;

import com.studymaven.domain.MemberVO;
import com.studymaven.domain.TermVO;
import com.studymaven.service.TermService;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/term")
public class TermController {
    @Autowired
    private TermService service;

    @GetMapping("")
    public String search(@RequestParam(value="q", defaultValue="") String q, Model model) {
        List<TermVO> list = q.isEmpty() ? service.getAll() : service.search(q);
        for (TermVO vo : list) {
            vo.setCreateDate(formatDate(vo.getCreateDate()));
            vo.setUpdateDate(formatDate(vo.getUpdateDate()));
        }
        List<String> categories = service.getCategories();
        model.addAttribute("list", list);
        model.addAttribute("query", q);
        model.addAttribute("categories", categories);
        return "term/search";
    }

    @GetMapping("/view/{id}")
    public String view(@PathVariable("id") Long id, Model model) {
        TermVO vo = service.get(id);
        if (vo != null) {
            vo.setCreateDate(formatDate(vo.getCreateDate()));
            vo.setUpdateDate(formatDate(vo.getUpdateDate()));
        }
        model.addAttribute("vo", vo);
        return "term/view";
    }

    @GetMapping("/write")
    public String writeForm(Model model) {
        List<String> categories = service.getCategories();
        model.addAttribute("vo", new TermVO());
        model.addAttribute("categories", categories);
        return "term/write";
    }

    @PostMapping("/write")
    public String write(@ModelAttribute TermVO vo, HttpSession session) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser != null && "ADMIN".equals(loginUser.getRole())) {
            vo.setAuthorId(loginUser.getId());
            service.create(vo);
        }
        return "redirect:/term";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable("id") Long id, Model model) {
        TermVO vo = service.get(id);
        List<String> categories = service.getCategories();
        model.addAttribute("vo", vo);
        model.addAttribute("categories", categories);
        return "term/edit";
    }

    @PostMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, @ModelAttribute TermVO vo, HttpSession session) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser != null && "ADMIN".equals(loginUser.getRole())) {
            vo.setId(id);
            service.update(vo);
        }
        return "redirect:/term";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id, HttpSession session) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser != null && "ADMIN".equals(loginUser.getRole())) {
            service.delete(id);
        }
        return "redirect:/term";
    }

    private String formatDate(String s) {
        if (s == null || s.length() < 19) return s;
        try {
            java.time.LocalDateTime dt = java.time.LocalDateTime.parse(s.substring(0, 19).replace(" ", "T"));
            if (dt.plusDays(7).isAfter(java.time.LocalDateTime.now())) {
                return s.substring(0, 16);
            }
            return s.substring(0, 10);
        } catch (Exception e) { return s; }
    }
}