package com.chat.service;

import com.chat.dao.map.FriendMap;
import com.chat.model.Friend;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FriendServiceImpl implements FriendService {

   @Autowired
    FriendMap friendMap;

    @Override
    public List<Friend> selectFrd(String my_id) {
        return friendMap.selectFrd(my_id);
    }

    @Override
    public int chkFrd(String my_id, String your_id) {
        return friendMap.chkFrd(my_id, your_id);
    }

    @Override
    public void insertFrd(Friend friend) {
        friendMap.insertFrd(friend);
    }

    @Override
    public void delFrd(int friend_num) { friendMap.delFrd(friend_num); }
}
