package com.chat.controller;

import com.chat.model.Room;
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
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
@ServerEndpoint("/chat/chat")
public class MessageController extends Socket {
    @Autowired
    RoomService roomService;

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

//        if (isValid(httpSession, request)) {
//            System.out.println("connected");
//            activeSessions.put(session.getId(), session);
//            System.out.println(session.getId());
//        } else {
//            System.out.println("unconnected");
//            try {
//                session.close();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
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

//    private boolean isValid (HttpSession httpSession, HttpServletRequest request) {
//        List<Room> roomList = roomService.selectRoom(request.getParameter("room_num"));
//        boolean result = false;
//
//        for (int i = 0; i < roomList.size(); i++) {
//            String creator_id = roomList.get(i).getCreator_id();
//            String invitee_id = roomList.get(i).getInvitee_id();
//            if (httpSession.getAttribute("id").equals(creator_id)
//                    || httpSession.getAttribute("id").equals(invitee_id)) result = true;
//        }
//        return result;
//    }
}
