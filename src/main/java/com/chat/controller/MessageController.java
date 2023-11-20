package com.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
@ServerEndpoint("/chat")
public class MessageController {
    private static final Map<String, Session> activeSessions = new ConcurrentHashMap<>();

    @GetMapping("/chat/chat")
    public String chat() {
        return "chat/chat";
    }



    @OnOpen
    public void open(Session session) {
        System.out.println("connected");
        activeSessions.put(session.getId(), session);
        System.out.println(session.getId());
    }

    @OnClose
    public void onClose(Session session) {
        activeSessions.remove(session.getId());
    }

    @OnMessage
    public void getMsg(Session receiveSession, String msg) {
        for (Session session : activeSessions.values()) {
            if (!receiveSession.getId().equals(session.getId())) {
                try {
                    session.getBasicRemote().sendText("상대: " + msg);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                try {
                    session.getBasicRemote().sendText("나: " + msg);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
