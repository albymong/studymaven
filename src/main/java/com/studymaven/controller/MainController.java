package com.studymaven.controller;

import com.studymaven.domain.BoardVO;
import com.studymaven.domain.MemberVO;
import com.studymaven.service.BoardService;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/main")
public class MainController {
    @Autowired
    private BoardService boardService;

    @GetMapping("")
    public String main(HttpSession session, Model model) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        Map<String, Object> result = boardService.getPage(1);
        List<BoardVO> list = (List<BoardVO>) result.get("list");
        for (BoardVO vo : list) {
            vo.setCreateDate(formatDate(vo.getCreateDate()));
        }
        model.addAttribute("list", list);
        model.addAttribute("total", result.get("total"));
        model.addAttribute("loginUser", loginUser);
        return "main/main";
    }
 
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
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