package com.chat.service;

import com.chat.model.Room;
import java.util.List;

public interface RoomService {
    List<Room> selectRoom(String creator_id, String invitee_id);
    void insertRoom(Room room);
    int chkRoom(String creator_id, String invitee_id);
    void delRoom(int room_num);
}
