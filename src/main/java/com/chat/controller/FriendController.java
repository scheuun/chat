package com.chat.controller;

import com.chat.model.Friend;
import com.chat.service.FriendService;
import com.chat.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class FriendController {
    @Autowired
    FriendService friendService;

    @Autowired
    MemberService memberService;

    @GetMapping("/friend/frdList")
    public String frdList(HttpSession session, Model model) {
        model.addAttribute("friends", friendService.selectFrd((String) session.getAttribute("id")));
        return "friend/frdList";
    }

    @PostMapping("/friend/insertFrd")
    @ResponseBody
    public void insertFrd(Friend friend, HttpSession session, Model model, String your_id) {
        String my_id =  (String) session.getAttribute("id");
        friend.setMy_id(my_id);
        if (friendService.chkFrd(friend.getYour_id()) == 0 || my_id != your_id) {
            friendService.insertFrd(friend);
        } else {
            model.addAttribute("dup", friendService.chkFrd(friend.getYour_id()));
        }
    }

//    @PostMapping("/chkFrd")
//    @ResponseBody
//    public int chkFrd(String your_id) {
//        return friendService.chkFrd(your_id);
//    }
}
