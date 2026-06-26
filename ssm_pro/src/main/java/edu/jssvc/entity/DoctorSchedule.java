package edu.jssvc.entity;

import java.sql.Timestamp;

/**
 * 医生排班实体
 * @author itdjy
 * @date 2026年6月23日
 */
public class DoctorSchedule {
	private int id;
	private int doctorId;
	private String hospitalName;
	private String officesName;
	private String scheduleDate;
	private String timeSlot;
	private int maxPatients;
	private int bookedCount;
	private int status;
	private Timestamp createTime;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getDoctorId() {
		return doctorId;
	}
	public void setDoctorId(int doctorId) {
		this.doctorId = doctorId;
	}
	public String getHospitalName() {
		return hospitalName;
	}
	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}
	public String getOfficesName() {
		return officesName;
	}
	public void setOfficesName(String officesName) {
		this.officesName = officesName;
	}
	public String getScheduleDate() {
		return scheduleDate;
	}
	public void setScheduleDate(String scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	public String getTimeSlot() {
		return timeSlot;
	}
	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}
	public int getMaxPatients() {
		return maxPatients;
	}
	public void setMaxPatients(int maxPatients) {
		this.maxPatients = maxPatients;
	}
	public int getBookedCount() {
		return bookedCount;
	}
	public void setBookedCount(int bookedCount) {
		this.bookedCount = bookedCount;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	@Override
	public String toString() {
		return "DoctorSchedule [id=" + id + ", doctorId=" + doctorId + ", hospitalName=" + hospitalName
				+ ", officesName=" + officesName + ", scheduleDate=" + scheduleDate + ", timeSlot=" + timeSlot
				+ ", maxPatients=" + maxPatients + ", bookedCount=" + bookedCount + ", status=" + status
				+ ", createTime=" + createTime + "]";
	}
}
