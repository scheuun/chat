package com.chat.dao.map;

import com.chat.model.Friend;

import java.util.List;

public interface FriendMap {
    List<Friend> selectFrd(String my_id);
    int chkFrd(String my_id, String your_id);
    void insertFrd(Friend friend);
    void delFrd(int friend_num);
}
