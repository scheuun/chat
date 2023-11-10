package com.chat.service;

import com.chat.dao.map.MemberMap;
import com.chat.model.Member;
import com.chat.config.SHA256;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.NoSuchAlgorithmException;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService{
    @Autowired
    MemberMap memberMap;

    @Override
    public int joinMember(Member member) throws NoSuchAlgorithmException {
        SHA256 sha256 = new SHA256();
        member.setPwd(sha256.encrypt(member.getPwd()));
        return memberMap.joinMember(member);
    }

    @Override
    public int idCheck(String nickname) {
        return memberMap.idCheck(nickname);
    }

    @Override
    public String login(String id) {
        return memberMap.login(id);
    }

    @Override
    public String findId(String email) {
        return memberMap.findId(email);
    }

    @Override
    public int findPwd(String id, String email) {
        return memberMap.findPwd(id, email);
    }

    @Override
    public void updatePwd(Member member) {
        memberMap.updatePwd(member);
    }

    @Override
    public List<Member> searchId(String keyword) {
        return memberMap.searchId(keyword);
    }

    @Override
    public Member selectMem(String id) {
        return memberMap.selectMem(id);
    }

    @Override
    public void updateMem(Member member) {
        memberMap.updateMem(member);
    }
}
