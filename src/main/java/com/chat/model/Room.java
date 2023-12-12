package com.chat.model;

import java.sql.Timestamp;

public class Room {
    private int room_num;
    private String room_name;
    private String creator_id ;
    private String invitee_id;
    private String creator_nn ;
    private String invitee_nn;
    private Timestamp time;

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

    public String getCreator_id() {
        return creator_id;
    }

    public void setCreator_id(String creator_id) {
        this.creator_id = creator_id;
    }

    public String getInvitee_id() {
        return invitee_id;
    }

    public void setInvitee_id(String invitee_id) {
        this.invitee_id = invitee_id;
    }

    public String getCreator_nn() {
        return creator_nn;
    }

    public void setCreator_nn(String creator_nn) {
        this.creator_nn = creator_nn;
    }

    public String getInvitee_nn() {
        return invitee_nn;
    }

    public void setInvitee_nn(String invitee_nn) {
        this.invitee_nn = invitee_nn;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }
}
