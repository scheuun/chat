package com.chat.dao.map;

import com.chat.model.Friend;

public interface MessageMap {
    Friend selectMsg(int room_num);
    void insertFrd(Friend friend);
}
