package com.chat.service;

import com.chat.model.Room;
import java.util.List;

public interface RoomService {
    List<Room> selectRoom(String creator_id);
    void insertRoom(Room room);
    int chkRoom(String invitee_id);
    void delRoom(int room_num);
}
