package edu.jssvc.service;

import java.util.List;
import java.util.Map;

import edu.jssvc.entity.Hospital;
import edu.jssvc.entity.Office;

public interface OfficeService {

	// 通过医院名称查询科室
	public List<Office> findOfficeByHosName(String hospitalName);

	// 通过id查询科室信息
	public Office findOfficeById(int id);

	// 推荐9个开通预约挂号的医院的科室
	public List<Office> findOfficeByRe(Map<String, Object> officeMap);

	// 推荐9个开通预约挂号的医院的科室数量
	public int findOfficeByReNum(List<Hospital> hospital);

	// 通过条件查询科室
	public List<Office> findOfficeByConditon(Office office, int start, int size);
	
	// 查询查询科室数量
	public int findOrderOfficeNum(Office office);

	// 新增科室
	public int insertOffice(Office office);

	// 更新科室
	public int updateOffice(Office office);

	// 删除科室
	public int deleteOffice(int id);

}
