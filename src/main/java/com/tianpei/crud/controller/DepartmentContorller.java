package com.tianpei.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tianpei.crud.bean.Department;
import com.tianpei.crud.bean.Msg;
import com.tianpei.crud.service.DepartmentService;

@Controller
@CrossOrigin
public class DepartmentContorller {
   @Autowired
   private	DepartmentService departmentService;
   
   @RequestMapping("/depts")
   @ResponseBody
   public Msg getDepts(){
	  
	   List<Department> list = departmentService.getDepts();
	   return Msg.success().add("depts", list);
   }
}
