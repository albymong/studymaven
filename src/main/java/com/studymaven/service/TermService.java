package com.studymaven.service;

import com.studymaven.domain.TermVO;
import com.studymaven.mapper.TermMapper;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TermService {
    @Autowired
    private TermMapper mapper;

    public List<TermVO> search(String query) { 
        Map<String, Object> params = new HashMap<>();
        params.put("query", query);
        return mapper.search(params); 
    }
    public TermVO get(Long id) { return mapper.select(id); }
    public List<TermVO> getAll() { return mapper.selectAll(); }
    public void create(TermVO vo) { mapper.insert(vo); }
    public void update(TermVO vo) { mapper.update(vo); }
    public void delete(Long id) { mapper.delete(id); }
    public List<String> getCategories() { return mapper.selectCategories(); }
}