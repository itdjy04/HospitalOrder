package edu.jssvc.service;

import java.util.List;

import edu.jssvc.entity.DoctorSchedule;

public interface DoctorScheduleService {
	// 根据ID查询
	public DoctorSchedule findById(int id);

	// 根据医生ID查询所有排班
	public List<DoctorSchedule> findByDoctorId(int doctorId);

	// 分页查询所有排班
	public List<DoctorSchedule> findAll(int start, int size);

	// 查询排班总数
	public int countAll();

	// 按条件查询排班数量
	public int countByCondition(String doctorName, String hospitalName, String scheduleDate);

	// 按条件分页查询排班
	public List<DoctorSchedule> findByCondition(String doctorName, String hospitalName, String scheduleDate, int start, int size);

	// 新增排班
	public int insert(DoctorSchedule schedule);

	// 删除排班
	public int delete(int id);

	// 切换排班状态
	public int toggleStatus(int id, int status);

	// 增加已预约数
	public int incrementBookedCount(int id);

	// 减少已预约数
	public int decrementBookedCount(int id);

	// 获取医生有排班的日期列表
	public List<String> findAvailableDates(int doctorId);

	// 获取医生某日的可用时段
	public List<DoctorSchedule> findAvailableSlots(int doctorId, String scheduleDate);
}
