package com.chat.dao.map;

import com.chat.model.Room;
import java.util.List;

public interface RoomMap {
    List<Room> selectRoom(String creator_id, String invitee_id);
    void insertRoom(Room room);
    int chkRoom(String creator_id, String invitee_id);
    void delRoom(int room_num);
}
