package com.tianpei.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.tianpei.crud.bean.Employee;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml", "classpath:springmvc.xml"})
public class PageTest {
	@Autowired
	WebApplicationContext context;

	MockMvc mockMvc;

	@Before
	public void initMokMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
    @Test
	public void testPage() throws Exception {
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		MockHttpServletRequest request = result.getRequest();
		PageInfo<Employee> pi = (PageInfo<Employee>) request.getAttribute("pageInfo");
		System.out.println("��ǰҳ�룺" + pi.getPageNum());
		System.out.println("��ҳ�룺" + pi.getPages());
		System.out.println("�ܼ�¼����" + pi.getTotal());
		System.out.println("��ҳ����Ҫ������ʾ��ҳ��");
		int[] nums = pi.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(i);
		}
		List<Employee> list = pi.getList();
		for (Employee employee : list) {
			System.out.println("ID: " + employee.getEmpId() + "==> name: " + employee.getEmpName());
		}

	}
}