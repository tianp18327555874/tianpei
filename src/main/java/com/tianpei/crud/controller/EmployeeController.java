package com.tianpei.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tianpei.crud.bean.Employee;
import com.tianpei.crud.bean.Msg;
import com.tianpei.crud.service.EmployeeService;

@Controller
@CrossOrigin("*")
public class EmployeeController {
	
	
  @Autowired
  private EmployeeService employeeService;
  @RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
  @ResponseBody
  public Msg deleteEmp(@PathVariable("ids")String empIds){
	  if(empIds.contains("-")){
		  //多个删除split("-")用来分割的方法
		  String [] str_empIds = empIds.split("-");
		  //定义一个集合来接收从前端传到后端遍历后的值
		  List<Integer> delete_empIds = new ArrayList<Integer>();
		  for (String string_empIds : str_empIds) {
			  //从前端传到后端遍历后的值添加到集合中
			  delete_empIds.add(Integer.parseInt(string_empIds));
		  }
		  //传到service批量删除
		  employeeService.deleteBatch(delete_empIds);
	  }else{
		  employeeService.deleteEmp(Integer.parseInt(empIds));
	  }
	  return Msg.success();
  }
  /**
   * 
   * 不能直接发送ajax 的 put请求如果发送会出现
   * You have an error in your SQL syntax; check the manual that corresponds 
   * to your MySQL server version for the right syntax to use near 'where emp_id = 1011' at line 3错误
   * 
   * 保存跟新员工的方法
   * 问题请求体中有数据
   * 但是Employee对象中没有数据
   * Employee [empId=1011, empName=null, gender=null, email=null, dId=null, department=null]
   * 只发送这样的sql 么有set条件update tbl_emp where emp_id = 1014
   * 错误原因：
   *  tomcat将请求体中封装成一个Map
   *  取值是request.getParameter("empName");
   *  spring封装pojo对象的时候不会封装成Map集合，会把pojo中的属性值以request.getParameter("empName");
   *  解决方案在web文件中配置
      <filter>
      <filter-name>HttpPutFormContentFilter</filter-name>
      <filter-class>org.springframework.web.filter.HttpPutFormContentFilter</filter-class>
      </filter>
     <filter-mapping>
      <filter-name>HttpPutFormContentFilter</filter-name>
      <url-pattern>/*</url-pattern>
      </filter-mapping>这段代码
   * @return
   */
  @RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
  @ResponseBody
  public Msg saveEmp(Employee employee){
	     employeeService.updateEmp(employee);
	     return Msg.success();
  }
  
  /**
   * 按照员工ID查询员工
   * @param empId
   * @return
   */
  @RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
  @ResponseBody
  public Msg getEmp(@PathVariable("id") Integer empId){
	  Employee employee = employeeService.getEmp(empId);
	  return Msg.success().add("employee", employee);
  }
  
  /**
   * 检验用户名是否可用
   */
   @RequestMapping("/checkuser")
   @ResponseBody
   public Msg checkUser(@RequestParam("empName")String empName){
	  String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
	  //matches是否匹配给定的正则表达式
	  if(!empName.matches(regx)){
		return Msg.fail().add("va_msg", "用户名必须为6-16为数字和字母的组合或2-5个中文");
	  }
	 boolean b = employeeService.checkUser(empName);
	 if(b){
		 return Msg.success(); 
		}else{
		  return Msg.fail().add("va_msg","用户名不可用");
	  }
	 
   }
    /**
     * 添加所有信息
     * @Valid封装对象以后对象里面的数据要进行校验
     * @param employee
     * @return
     */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
    @ResponseBody
    public Msg empSave(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			//校验失败,应返回失败,在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<String, Object>();
			//result.getFieldErrors()显示所有的错误信息
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				//fieldError.getField()错误的字段名fieldError.getDefaultMessage()错误信息
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields",map);
		}else{
			employeeService.empSave(employee);
			return Msg.success();
		}
		
    }
    /**
     * 查询所有
     * @param pn
     * @return
     */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn){
	    PageHelper.startPage(pn,10);
		PageInfo<Employee> page = new PageInfo<Employee>(employeeService.getAll(),5);
		return Msg.success().add("pageInfo",page);
	}
}
