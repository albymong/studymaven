package com.studymaven.controller;

import com.studymaven.domain.BoardVO;
import com.studymaven.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService service;

    @GetMapping("")
    public String list(@RequestParam(value="page", defaultValue="1") int page, Model model) {
        Map<String, Object> result = service.getPage(page);
        model.addAttribute("list", result.get("list"));
        model.addAttribute("currentPage", result.get("currentPage"));
        model.addAttribute("totalPages", result.get("totalPages"));
        model.addAttribute("total", result.get("total"));
        return "board/list";//목록
    }

    @GetMapping("/view/{id}")
    public String view(@PathVariable("id") Long id, @RequestParam(value="page", defaultValue="1") int page, Model model) {
        BoardVO vo = service.get(id);
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
    public String write(@ModelAttribute BoardVO vo, @RequestParam(value="page", defaultValue="1") int page) {
        service.create(vo);
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
}