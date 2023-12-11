package com.chat.controller;

import com.chat.model.Room;
import com.chat.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class RoomController {
    @Autowired
    RoomService roomService;

    @RequestMapping(value ="/room/list", method = {RequestMethod.GET, RequestMethod.POST})
    public String frdList(HttpSession session, Model model) {
        String id = (String) session.getAttribute("id");
        List<Room> roomList = roomService.selectRoom(id, id);
        if (roomList.size() == 0) model.addAttribute("none", "채팅방 목록이 존재하지 않습니다.");
        else model.addAttribute("rooms", roomList);
        return "room/list";
    }

    @PostMapping("/room/insertRoom")
    @ResponseBody
    public void insertRoom(Room room) {
        roomService.insertRoom(room);
    }

    @PostMapping("/room/chkRoom")
    @ResponseBody
    public int chkRoom(String creator_id, String invitee_id) {
        return roomService.chkRoom(creator_id, invitee_id);
    }

    @PostMapping("room/delRoom")
    @ResponseBody
    public void delRoom(int room_num) { roomService.delRoom(room_num); }
}
