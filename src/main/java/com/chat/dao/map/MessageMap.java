package com.chat.dao.map;

import com.chat.model.Message;
import java.util.List;

public interface MessageMap {
    List<Message> selectMsg(int room_num);
    void insertMsg(Message message);
}
