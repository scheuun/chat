package com.chat.controller;

import com.chat.model.Friend;
import com.chat.service.FriendService;
import com.chat.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class FriendController {
    @Autowired
    FriendService friendService;

    @Autowired
    MemberService memberService;

    @PostMapping("/friend/insertFrd")
    @ResponseBody
    public void insertFrd(Friend friend, HttpSession session) {
       int my_num =  memberService.myPage((String) session.getAttribute("id")).getMember_num();

        friend.setMy_num(my_num);

        System.out.println(friend.getMy_num());
        System.out.println(friend.getYour_num());

        friendService.insertFrd(friend);
    }
}
