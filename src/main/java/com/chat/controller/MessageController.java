package com.chat.controller;

import com.chat.model.Room;
import com.chat.service.MemberService;
import com.chat.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.server.ServerEndpointConfig;
import java.io.IOException;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
@ServerEndpoint("/chat/chat")
public class MessageController extends Socket {

    @Autowired
    RoomService roomService;

    @Autowired
    MemberService memberService;

    private static final Map<String, Session> activeSessions = new ConcurrentHashMap<>();

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
        activeSessions.put(newUser.getId(), newUser);
        System.out.println(newUser.getId());
        activeSessions.forEach((sessionId, session) -> {
            System.out.println("Session ID: " + sessionId);
        });
    }

    @OnMessage
    public void getMsg(Session recieveSession, String msg, @PathParam("room_num") int room_num) {
        String senderId = recieveSession.getId();
        System.out.println(room_num);

        for (Session session : activeSessions.values()) {
            String targetUserId = (String) session.getUserProperties().get("id");

            // 방에 속한 사용자들 간에만 메시지 전송
            if (targetUserId != null && roomService.isMemRoom(room_num, targetUserId, targetUserId) > 0) {
                try {
                    if (session.getId().equals(senderId)) {
                        // 메시지를 보낸 사람에게는 '나'로 표시
                        session.getBasicRemote().sendText("나 : " + msg);
                    } else {
                        // 다른 사람에게는 '상대'로 표시
                        session.getBasicRemote().sendText("상대 : " + msg);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
