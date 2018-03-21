package com.tianpei.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.tianpei.crud.bean.Employee;
import com.tianpei.crud.bean.EmployeeExample;
import com.tianpei.crud.bean.EmployeeExample.Criteria;
import com.tianpei.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;

	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void empSave(Employee employee) {
		
		employeeMapper.insertSelective(employee);
		
	}
   
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count==0;
	}

	public Employee getEmp(Integer empId) {
		return employeeMapper.selectByPrimaryKey(empId);
	}

	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	public void deleteEmp(Integer empId) {
		employeeMapper.deleteByPrimaryKey(empId);
		
	}

	public void deleteBatch(List<Integer> str_empIds) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(str_empIds);
		employeeMapper.deleteByExample(example);
		
	}

	

	

	
   
	
}
