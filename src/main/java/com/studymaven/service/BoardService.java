package com.studymaven.service;

import com.studymaven.domain.BoardVO;
import com.studymaven.mapper.BoardMapper;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {
    @Autowired
    private BoardMapper mapper;

    private static final int PAGE_SIZE = 5;

    public List<BoardVO> getAll() { return mapper.selectAll(); }
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
        return result;
    }
    public BoardVO get(Long id) { return mapper.select(id); }
    public void create(BoardVO vo) { mapper.insert(vo); }
    public void update(BoardVO vo) { mapper.update(vo); }
    public void delete(Long id) { mapper.delete(id); }
}