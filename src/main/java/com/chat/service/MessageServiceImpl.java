package com.chat.service;

import com.chat.dao.map.MessageMap;
import com.chat.model.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    MessageMap messageMap;


    @Override
    public List<Message> selectMsg(int room_num) {
        return messageMap.selectMsg(room_num);
    }

    @Override
    public void insertMsg(Message message) {
       messageMap.insertMsg(message);
    }
}
