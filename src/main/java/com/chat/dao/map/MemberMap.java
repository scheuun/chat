package com.chat.dao.map;

import com.chat.model.Member;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberMap {
    int joinMember(Member member);
    int idCheck(String id);
    String login(String id);
    String findId(String email);
    int findPwd(@Param("id") String id, @Param("email") String email);
    void updatePwd(Member member);
    List<Member> searchId(String keyword);
    Member myPage(String id);
}
