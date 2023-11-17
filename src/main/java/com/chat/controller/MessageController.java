package com.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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
    private static final List<Session> session = new ArrayList<Session>();
    private static final Map<String, List<Session>> roomSessions = new ConcurrentHashMap<>();

    @GetMapping("/chat/chat")
    public String chat() {
        return "chat/chat";
    }

    @OnOpen
    public void open(Session newUser) {
        System.out.println("connected");
        session.add(newUser);
        System.out.println(newUser.getId());
    }

//    @OnMessage
//    public void getMsg(Session receiveSession, String msg) {
//        for (int i = 0; i < session.size(); i++) {
//            if (!receiveSession.getId().equals(session.get(i).getId())) {
//                try {
//                    session.get(i).getBasicRemote().sendText("상대: " + msg);
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            } else {
//                try {
//                    session.get(i).getBasicRemote().sendText("나: " + msg);
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    }



    @OnMessage
    public void getMsg(Session receiveSession, String message) {
        String roomNum = extractRoomNum(receiveSession.getRequestURI().getQuery());
        if (roomNum != null) {
            List<Session> sessionsInRoom = roomSessions.computeIfAbsent(roomNum, k -> new ArrayList<>());

            for (Session session : sessionsInRoom) {
                try {
                    String sender = (session.getId().equals(receiveSession.getId())) ? "나" : "상대";
                    session.getBasicRemote().sendText(sender + ": " + message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private String extractRoomNum(String query) {
        String[] params = query.split("&");
        for (String param : params) {
            String[] keyValue = param.split("=");
            if (keyValue.length == 2 && "room_num".equals(keyValue[0])) {
                return keyValue[1];
            }
        }
        return null;
    }
}
