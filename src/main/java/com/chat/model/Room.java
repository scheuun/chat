package com.chat.model;

public class Room {
    private int room_num;
    private String room_name;
    private int creator_num ;

    public int getRoom_num() {
        return room_num;
    }

    public void setRoom_num(int room_num) {
        this.room_num = room_num;
    }

    public String getRoom_name() {
        return room_name;
    }

    public void setRoom_name(String room_name) {
        this.room_name = room_name;
    }

    public int getCreator_num() {
        return creator_num;
    }

    public void setCreator_num(int creator_num) {
        this.creator_num = creator_num;
    }
}
