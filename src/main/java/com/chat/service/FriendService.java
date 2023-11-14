package com.chat.service;

import com.chat.model.Friend;

import java.util.List;

public interface FriendService {
    List<Friend> selectFrd(String my_id);
    int chkFrd(String your_id);
    void insertFrd(Friend friend);
    void delFrd(int friend_num);
}
