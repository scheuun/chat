package com.chat.dao.map;

import com.chat.model.Room;

public interface RoomMap {
    Room selectRoom(int creator_num);
    void insertRoom(Room room);
}
