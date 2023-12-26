package com.chat.controller;

import com.chat.model.Message;
import com.chat.service.MemberService;
import com.chat.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.ImportAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.net.Socket;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
@ServerEndpoint("/chat/chat")
public class MessageController extends Socket {

    @Autowired
    MessageService messageService;

    @Autowired
    MemberService memberService;

    private static final Map<String, Session> activeSessions = new ConcurrentHashMap<>();

    @GetMapping("/chat/chat")
    public String chat(HttpSession httpSession, Model model, @RequestParam("room_num") int room_num) {
        String id = (String) httpSession.getAttribute("id");
        model.addAttribute("messages", messageService.selectMsg(room_num));
        return "chat/chat";
    }

    @OnClose
    public void onClose(Session session) {
        activeSessions.remove(session.getId());
    }

    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        System.out.println("Received message: " + message);
        session.getBasicRemote().sendText(message);
    }

    @PostMapping("/chat/insertMsg")
    @ResponseBody
    public void insertMsg(HttpSession httpSession, Message message) {
        message.setSender_id(memberService.selectMem((String) httpSession.getAttribute("id")).getId());
        messageService.insertMsg(message);
    }
}
