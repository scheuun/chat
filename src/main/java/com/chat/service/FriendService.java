package com.chat.service;

import com.chat.model.Friend;

public interface FriendService {
    Friend selectFrd(int my_num);
    void insertFrd(Friend friend);
}
