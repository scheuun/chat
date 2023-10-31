package com.chat.service;

import com.chat.dao.map.FriendMap;
import com.chat.model.Friend;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FriendServiceImpl implements FriendService {

   @Autowired
    FriendMap friendMap;

    @Override
    public Friend selectFrd(int my_num) {
        return friendMap.selectFrd(my_num);
    }

    @Override
    public void insertFrd(Friend friend) {
        friendMap.insertFrd(friend);
    }
}
