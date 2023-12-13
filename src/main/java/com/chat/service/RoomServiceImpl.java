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
    public List<Room> selectRoom(String creator_id, String invitee_id) {
        return roomMap.selectRoom(creator_id, invitee_id);
    }

    @Override
    public void insertRoom(Room room) {
        roomMap.insertRoom(room);
    }

    @Override
    public int chkRoom(String creator_id, String invitee_id) {
        return roomMap.chkRoom(creator_id, invitee_id);
    }

    @Override
    public void delRoom(int room_num) {
        roomMap.delRoom(room_num);
    }

    @Override
    public int isMemRoom(int room_num, String creator_id, String invitee_id) {
        return roomMap.isMemRoom(room_num, creator_id, invitee_id);
    }


}
