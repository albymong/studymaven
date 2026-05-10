package com.studymaven.mapper;

import com.studymaven.domain.BoardFileVO;
import com.studymaven.domain.BoardVO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface BoardMapper {
    List<BoardVO> selectAll();
    List<BoardVO> selectPage(Map<String, Object> params);
    int count();
    BoardVO select(Long id);
    void insert(BoardVO vo);
    void update(BoardVO vo);
    void delete(Long id);
    List<BoardFileVO> selectFiles(Long boardId);
    void deleteFiles(Long boardId);
    BoardFileVO selectById(Long fileId);
    BoardFileVO selectByStoredName(String storedName);
    void insertFile(BoardFileVO fileVO);
}