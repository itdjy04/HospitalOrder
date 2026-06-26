package edu.jssvc.service;

import java.util.List;
import java.util.Map;

import edu.jssvc.entity.Doctor;
import edu.jssvc.entity.Hospital;

public interface DoctorService {
	// 根据地区医院名称和科室查询
	public List<Doctor> findAreaByHosAndOfficeName(String hospitalName, String OfficeName);

	// 通过id查询医生信息
	public Doctor findDoctorById(int id);

	// 推荐开通预约挂号的医院的医生
	public List<Doctor> findDoctorByRe(Map<String, Object> doctorMap);

	// 推荐开通预约挂号的医院的医生的数量
	public int findDoctorByReNum(List<Hospital> hospital);

	// 通过条件查询医生
	public List<Doctor> findDoctorByCondition(Doctor doctor, int start, int size);

	// 查询查询医生数量
	public int findDoctorNum(Doctor doctor);

	// 查询医生职称
	public List<String> findDoctorTitle();

	// 查询医生行政职位
	public List<String> findDoctorAdministrative();

	// 查询医生学位
	public List<String> findDoctorDegree();

	// 新增医生
	public int insertDoctor(Doctor doctor);

	// 更新医生
	public int updateDoctor(Doctor doctor);

	// 删除医生
	public int deleteDoctor(int id);

}
