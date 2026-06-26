package edu.jssvc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.jssvc.dao.DoctorScheduleDao;
import edu.jssvc.entity.DoctorSchedule;
import edu.jssvc.service.DoctorScheduleService;

@Service
public class DoctorScheduleServiceImpl implements DoctorScheduleService {
	@Autowired
	private DoctorScheduleDao doctorScheduleDao;

	@Override
	public DoctorSchedule findById(int id) {
		return doctorScheduleDao.findById(id);
	}

	@Override
	public List<DoctorSchedule> findByDoctorId(int doctorId) {
		return doctorScheduleDao.findByDoctorId(doctorId);
	}

	@Override
	public List<DoctorSchedule> findAll(int start, int size) {
		return doctorScheduleDao.findAll(start, size);
	}

	@Override
	public int countAll() {
		return doctorScheduleDao.countAll();
	}

	@Override
	public int countByCondition(String doctorName, String hospitalName, String scheduleDate) {
		return doctorScheduleDao.countByCondition(doctorName, hospitalName, scheduleDate);
	}

	@Override
	public List<DoctorSchedule> findByCondition(String doctorName, String hospitalName, String scheduleDate, int start,
			int size) {
		return doctorScheduleDao.findByCondition(doctorName, hospitalName, scheduleDate, start, size);
	}

	@Override
	public int insert(DoctorSchedule schedule) {
		return doctorScheduleDao.insert(schedule);
	}

	@Override
	public int delete(int id) {
		return doctorScheduleDao.delete(id);
	}

	@Override
	public int toggleStatus(int id, int status) {
		return doctorScheduleDao.toggleStatus(id, status);
	}

	@Override
	public int incrementBookedCount(int id) {
		return doctorScheduleDao.incrementBookedCount(id);
	}

	@Override
	public int decrementBookedCount(int id) {
		return doctorScheduleDao.decrementBookedCount(id);
	}

	@Override
	public List<String> findAvailableDates(int doctorId) {
		return doctorScheduleDao.findAvailableDates(doctorId);
	}

	@Override
	public List<DoctorSchedule> findAvailableSlots(int doctorId, String scheduleDate) {
		return doctorScheduleDao.findAvailableSlots(doctorId, scheduleDate);
	}
}
