package com.rcbank.mms;

import java.io.Serializable;

public class Principal implements Serializable {

    private static final long serialVersionUID = 5798882004228239559L;

    private String id;

    private String username;

    public Principal(String id, String username) {
        this.id = id;
        this.username = username;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String toString() {
        return username;
    }

}