package com.chat.service;

import com.chat.model.Member;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public interface MemberService {
    int joinMember(Member member) throws NoSuchAlgorithmException;
    int idCheck(String id);
    String login(String id);
    String findId(String email);
    int findPwd(String id, String email);
    void updatePwd(Member member);
    List<Member> searchId(String keyword);
    Member myPage(String id);
    void updateMem(Member member);
}
