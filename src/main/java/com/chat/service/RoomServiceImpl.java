package com.chat.service;

import com.chat.dao.map.RoomMap;
import com.chat.model.Room;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoomServiceImpl implements RoomService {
    @Autowired
    RoomMap roomMap;

    @Override
    public List<Room> selectRoom(String creator_id) {
        return roomMap.selectRoom(creator_id);
    }

    @Override
    public void insertRoom(Room room) {
        roomMap.insertRoom(room);
    }

    @Override
    public int chkRoom(String invitee_id) {
        return roomMap.chkRoom(invitee_id);
    }
}
