package com.tianpei.crud.test;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.tianpei.crud.bean.Department;
import com.tianpei.crud.bean.Employee;
import com.tianpei.crud.dao.DepartmentMapper;
import com.tianpei.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MepperTest {
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	SqlSession sqlSession;
    @Test
	public void testCRUD(){
    	departmentMapper.insertSelective(new Department(null,"项目部"));
    	departmentMapper.insertSelective(new Department(null,"测试部"));
	}
    @Test
    public void testCRUD1(){
    	EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
    	for(int i=1; i<=1000;i++){
    	String uid = UUID.randomUUID().toString().substring(0,5);
    		employeeMapper.insertSelective(new Employee(null,uid,"M",uid+"@tianpei.com",1));
    	}
    } 
    @Test
    public void getAll() {
    	List<Employee> list = employeeMapper.selectByExampleWithDept(null);
    	for (Employee employee : list) {
    		System.out.println(employee.toString());
		}
    }
}
