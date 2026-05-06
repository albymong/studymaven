package com.studymaven.mapper;

import com.studymaven.domain.BoardVO;
import java.util.List;
import java.util.Map;

public interface BoardMapper {
    List<BoardVO> selectAll();
    List<BoardVO> selectPage(Map<String, Object> params);
    int count();
    BoardVO select(Long id);
    void insert(BoardVO vo);
    void update(BoardVO vo);
    void delete(Long id);
}