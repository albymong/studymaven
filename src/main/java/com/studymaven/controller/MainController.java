package com.studymaven.controller;

import com.studymaven.domain.BoardVO;
import com.studymaven.domain.MemberVO;
import com.studymaven.service.BoardService;
import jakarta.servlet.http.HttpSession;
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
        model.addAttribute("list", result.get("list"));
        model.addAttribute("total", result.get("total"));
        model.addAttribute("loginUser", loginUser);
        return "main/main";
    }
}