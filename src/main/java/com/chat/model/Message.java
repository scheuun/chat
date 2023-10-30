package com.chat.model;

import java.sql.Timestamp;

public class Message {
    private int msg_num;
    private int room_num;
    private int sender_num;
    private String message;
    private Timestamp time;

    public int getMsg_num() {
        return msg_num;
    }

    public void setMsg_num(int msg_num) {
        this.msg_num = msg_num;
    }

    public int getRoom_num() {
        return room_num;
    }

    public void setRoom_num(int room_num) {
        this.room_num = room_num;
    }

    public int getSender_num() {
        return sender_num;
    }

    public void setSender_num(int sender_num) {
        this.sender_num = sender_num;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }
}
