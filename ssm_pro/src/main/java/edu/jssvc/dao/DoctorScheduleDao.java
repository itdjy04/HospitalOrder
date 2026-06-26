package edu.jssvc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import edu.jssvc.entity.DoctorSchedule;

public interface DoctorScheduleDao {
	// 根据ID查询排班
	public DoctorSchedule findById(int id);

	// 根据医生ID和日期查询排班
	public List<DoctorSchedule> findByDoctorIdAndDate(@Param("doctorId") int doctorId, @Param("scheduleDate") String scheduleDate);

	// 根据医生ID查询所有排班
	public List<DoctorSchedule> findByDoctorId(int doctorId);

	// 分页查询所有排班
	public List<DoctorSchedule> findAll(@Param("start") int start, @Param("size") int size);

	// 查询排班总数
	public int countAll();

	// 按条件查询排班数量
	public int countByCondition(@Param("doctorName") String doctorName, @Param("hospitalName") String hospitalName,
			@Param("scheduleDate") String scheduleDate);

	// 按条件分页查询排班
	public List<DoctorSchedule> findByCondition(@Param("doctorName") String doctorName,
			@Param("hospitalName") String hospitalName, @Param("scheduleDate") String scheduleDate,
			@Param("start") int start, @Param("size") int size);

	// 新增排班
	public int insert(DoctorSchedule schedule);

	// 删除排班
	public int delete(int id);

	// 切换排班状态
	public int toggleStatus(@Param("id") int id, @Param("status") int status);

	// 增加已预约数
	public int incrementBookedCount(int id);

	// 减少已预约数
	public int decrementBookedCount(int id);

	// 根据医生ID获取有排班的日期列表
	public List<String> findAvailableDates(int doctorId);

	// 根据医生ID和日期获取可用时段
	public List<DoctorSchedule> findAvailableSlots(@Param("doctorId") int doctorId, @Param("scheduleDate") String scheduleDate);
}
