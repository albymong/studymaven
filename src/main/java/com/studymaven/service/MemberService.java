package com.studymaven.service;

import com.studymaven.domain.MemberVO;
import com.studymaven.mapper.MemberMapper;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
    @Autowired
    private MemberMapper mapper;

    public MemberVO login(String userid, String password) {
        Map<String, Object> params = new HashMap<>();
        params.put("userid", userid);
        params.put("password", password);
        return mapper.selectByUserid(params);
    }

    public boolean checkDuplicate(String userid) {
        return mapper.selectByUseridOnly(userid) != null;
    }

    public void join(MemberVO vo) {
        mapper.insert(vo);
    }
}