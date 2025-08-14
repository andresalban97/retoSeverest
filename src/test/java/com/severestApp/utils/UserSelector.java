package com.severestApp.utils;

import java.util.List;
import java.util.Map;
import java.util.Random;


public class UserSelector {
    
    public  class User{
        public String _id;
        public String idUsuario;
        public boolean hasCart;

        public User(String _id, String idUsuario, boolean hasCart) {
            this._id = _id;
            this.idUsuario = idUsuario;
            this.hasCart = hasCart;
    }


}
    public User selectRandomUserWithCart(List<Map<String,Object>> usersWithCart) {
        if (usersWithCart.isEmpty()) 
            return null;
        Random r = new Random();
        Map<String,Object> map = usersWithCart.get(r.nextInt(usersWithCart.size()));
        User selected = new User(
            (String) map.get("_id"),
            (String) map.get("idUsuario"),
        true
    );
        return selected;
}
    
    public User selectRandomUserWithoutCart(List<Map<String, Object>> allUsers) {
         if (allUsers.isEmpty()) 
            return null;
        Random r = new Random();
        Map<String, Object> map = allUsers.get(r.nextInt(allUsers.size()));
        User selected = new User((String) map.get("idUsuario"), (String) map.get("_id"), true);
        selected.idUsuario = (String) map.get("idUsuario");
        selected._id      = (String) map.get("_id");
        selected.hasCart  = true;
        return selected;
}


}
