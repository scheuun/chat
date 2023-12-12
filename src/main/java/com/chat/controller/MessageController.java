package com.chat.controller;

import com.chat.model.Room;
import com.chat.service.MemberService;
import com.chat.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

@Controller
@ServerEndpoint("/chat/chat")
public class MessageController extends Socket {
    @Autowired
    RoomService roomService;

    @Autowired
    MemberService memberService;

    private static final List<Session> activeSessions = new ArrayList<Session>();

    @GetMapping("/chat/chat")
    public String chat() {
        return "chat/chat";
    }

    @OnClose
    public void onClose(Session session) {
        activeSessions.remove(session.getId());
    }

    @OnOpen
    public void open(Session newUser) {
        System.out.println("connected");
        activeSessions.add(newUser);
        System.out.println(newUser.getId());
    }

    @OnMessage
    public void getMsg(Session recieveSession, String msg) {
        for (int i = 0; i < activeSessions.size(); i++) {
            if (!recieveSession.getId().equals(activeSessions.get(i).getId())) {
                try {
                    activeSessions.get(i).getBasicRemote().sendText("상대 : "+msg);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }else{
                try {
                    activeSessions.get(i).getBasicRemote().sendText("나 : "+msg);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
