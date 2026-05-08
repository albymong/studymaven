package com.studymaven.mapper;

import com.studymaven.domain.TermVO;
import java.util.List;
import java.util.Map;

public interface TermMapper {
    List<TermVO> search(Map<String, Object> params);
    TermVO select(Long id);
    List<TermVO> selectAll();
    void insert(TermVO vo);
    void update(TermVO vo);
    void delete(Long id);
    List<String> selectCategories();
}