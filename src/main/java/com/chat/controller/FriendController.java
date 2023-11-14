package com.chat.controller;

import com.chat.model.Friend;
import com.chat.service.FriendService;
import com.chat.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class FriendController {
    @Autowired
    FriendService friendService;

    @Autowired
    MemberService memberService;

    @RequestMapping(value = "/friend/frdList", method = {RequestMethod.GET, RequestMethod.POST})
    public String frdList(HttpSession session, Model model) {
        List<Friend> friendList = friendService.selectFrd((String) session.getAttribute("id"));
        if (friendList.size() == 0) model.addAttribute("none", "친구 목록이 존재하지 않습니다.");
        else model.addAttribute("friends", friendList);
        return "friend/frdList";
    }

    @PostMapping("/friend/chkFrd")
    @ResponseBody
    public int chkFrd(String your_id) {
        return friendService.chkFrd(your_id);
    }

    @PostMapping("/friend/insertFrd")
    @ResponseBody
    public void insertFrd(Friend friend, HttpSession session, Model model, String your_id) {
        String my_id =  (String) session.getAttribute("id");
        friend.setMy_id(my_id);
            friendService.insertFrd(friend);
            model.addAttribute("dup", friendService.chkFrd(friend.getYour_id()));
    }

    @PostMapping("/friend/delFrd")
    @ResponseBody
    public void delFrd(int friend_num) {
        friendService.delFrd(friend_num);
    }
}
