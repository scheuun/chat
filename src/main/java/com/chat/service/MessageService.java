package com.chat.service;

import com.chat.model.Message;

import java.util.List;

public interface MessageService {
    List<Message> selectMsg(int room_num);
    void insertMsg(Message message);
}
