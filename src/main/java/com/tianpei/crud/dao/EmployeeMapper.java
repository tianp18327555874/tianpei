package com.tianpei.crud.dao;

import com.tianpei.crud.bean.Employee;
import com.tianpei.crud.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
  
   

    
    int deleteByExample(EmployeeExample example);

    
    int deleteByPrimaryKey(Integer empId);

    
    int insert(Employee record);

    
    int insertSelective(Employee record);

   
    List<Employee> selectByExample(EmployeeExample example);

    Employee selectByPrimaryKey(Integer empId);
   
    List<Employee> selectByExampleWithDept(EmployeeExample example);

    Employee selectByPrimaryKeyWithDept(Integer empId);
    
    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    
    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

   
    int updateByPrimaryKeySelective(Employee record);

   
    int updateByPrimaryKey(Employee record);


	long countByExample(EmployeeExample example);
}