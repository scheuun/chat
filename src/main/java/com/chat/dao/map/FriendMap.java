package com.chat.dao.map;

import com.chat.model.Friend;

import java.util.List;

public interface FriendMap {
    List<Friend> selectFrd(String my_id);
    int chkFrd(String your_id);
    void insertFrd(Friend friend);
}
