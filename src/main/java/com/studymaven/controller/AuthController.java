package com.studymaven.controller;

import com.studymaven.domain.MemberVO;
import com.studymaven.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {
    @Autowired
    private MemberService service;

    @GetMapping(value = {"", "/"})
    public String index() {
        return "main/index";
    }

    @GetMapping("/login")
    public String loginForm() {
        return "main/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("userid") String userid, @RequestParam("password") String password, HttpSession session, Model model) {
        MemberVO vo = service.login(userid, password);
        if (vo != null) {
            session.setAttribute("loginUser", vo);
            return "redirect:/main";
        }
        model.addAttribute("error", "아이디 또는 비밀번호가 일치하지 않습니다.");
        return "main/login";
    }

    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}