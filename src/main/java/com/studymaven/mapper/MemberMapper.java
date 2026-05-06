package com.studymaven.mapper;

import com.studymaven.domain.MemberVO;
import java.util.Map;

public interface MemberMapper {
    MemberVO selectByUserid(Map<String, Object> params);
}