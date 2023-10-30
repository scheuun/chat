package com.chat.dao.map;

import com.chat.model.Friend;

public interface FriendMap {
    Friend selectFrd(int my_num);
    void insertFrd(Friend friend);
}
