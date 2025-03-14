package com.chwangteng.www.controller;

import com.chwangteng.www.Utils.ConstVar;
import com.chwangteng.www.param.AdminUpdatePasswordRequestParam;
import com.chwangteng.www.param.ResetPasswordRequestParam;
import com.chwangteng.www.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    //Administrator resets student and teacher passwords
    @RequestMapping("/resetPassword.action")
    public ModelAndView resetPassword(@RequestBody ResetPasswordRequestParam resetPasswordRequestParam)   {
        int rows = adminService.resetPassword(resetPasswordRequestParam.getUsername(),
                resetPasswordRequestParam.getType());
        if(rows==1){
            Map<String,Object> map = new HashMap<String,Object>();
            if(resetPasswordRequestParam.getType()==ConstVar._TEACHER_)
                map.put(ConstVar._KEY_MESSAGE_, "The password has been reset to the last 6 digits of the ID");
            if(resetPasswordRequestParam.getType()==ConstVar._STUDENT_)
                map.put(ConstVar._KEY_MESSAGE_, "The password has been reset to the last 6 digits of the student number");
            return new ModelAndView(new MappingJackson2JsonView(),map);
        }else if(rows==ConstVar._ERROR_NOTFOUND){
            Map<String,Object> map = new HashMap<String,Object>();
            map.put(ConstVar._KEY_CODE_, ConstVar._ERROR_NOTFOUND);
            if(resetPasswordRequestParam.getType()==ConstVar._TEACHER_)
                map.put(ConstVar._KEY_MESSAGE_, "The teacher does not exist" );
            if(resetPasswordRequestParam.getType()==ConstVar._STUDENT_)
                map.put(ConstVar._KEY_MESSAGE_, "The student does not exist");
            return new ModelAndView(new MappingJackson2JsonView(),map);
        }else{
            Map<String,Object> map = new HashMap<String,Object>();
            map.put(ConstVar._KEY_CODE_, ConstVar._ERROR_COMMON_);
            map.put(ConstVar._KEY_MESSAGE_, "Unknown error, reset failed");
            return new ModelAndView(new MappingJackson2JsonView(),map);
        }
    }

    //The administrator changes the passwords of students and teachers
    @RequestMapping("/updatePassword.action")
    public ModelAndView updatePassword(@RequestBody AdminUpdatePasswordRequestParam adminUpdatePasswordRequestParam)   {
        int rows = adminService.updatePassword(adminUpdatePasswordRequestParam.getUsername(),
                adminUpdatePasswordRequestParam.getType(),
                adminUpdatePasswordRequestParam.getPassword());
        if(rows==1){
            Map<String,Object> map = new HashMap<String,Object>();
            map.put(ConstVar._KEY_MESSAGE_, "Password changed");
            return new ModelAndView(new MappingJackson2JsonView(),map);
        }else if(rows==ConstVar._ERROR_NOTFOUND){
            Map<String,Object> map = new HashMap<String,Object>();
            map.put(ConstVar._KEY_CODE_, ConstVar._ERROR_NOTFOUND);
            if(adminUpdatePasswordRequestParam.getType()==ConstVar._TEACHER_)
                map.put(ConstVar._KEY_MESSAGE_, "The teacher does not exist");
            if(adminUpdatePasswordRequestParam.getType()==ConstVar._STUDENT_)
                map.put(ConstVar._KEY_MESSAGE_, "The student does not exist");
            return new ModelAndView(new MappingJackson2JsonView(),map);
        }else{
            Map<String,Object> map = new HashMap<String,Object>();
            map.put(ConstVar._KEY_CODE_, ConstVar._ERROR_COMMON_);
            map.put(ConstVar._KEY_MESSAGE_, "Unknown error, modify failed");
            return new ModelAndView(new MappingJackson2JsonView(),map);
        }
    }
}
