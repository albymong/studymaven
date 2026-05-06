package com.studymaven.controller;

import com.studymaven.domain.BoardVO;
import com.studymaven.domain.MemberVO;
import com.studymaven.service.BoardService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

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
                      @RequestParam(value="page", defaultValue="1") int page,
                      HttpSession session) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser != null) {
            service.create(vo, loginUser.getId());
        }
        return "redirect:/board?page=" + page;
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable("id") Long id, @RequestParam(value="page", defaultValue="1") int page, Model model) {
        BoardVO vo = service.get(id);
        model.addAttribute("vo", vo);
        model.addAttribute("page", page);
        return "board/edit";
    }

    @PostMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, @ModelAttribute BoardVO vo, @RequestParam(value="page", defaultValue="1") int page) {
        vo.setId(id);
        service.update(vo);
        return "redirect:/board?page=" + page;
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id, @RequestParam(value="page", defaultValue="1") int page) {
        service.delete(id);
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