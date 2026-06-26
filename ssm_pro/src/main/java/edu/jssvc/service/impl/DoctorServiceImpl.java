package edu.jssvc.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.jssvc.dao.DoctorDao;
import edu.jssvc.entity.Doctor;
import edu.jssvc.entity.Hospital;
import edu.jssvc.service.DoctorService;

@Service
public class DoctorServiceImpl implements DoctorService {

	@Autowired
	private DoctorDao doctorDao;

	@Override
	public List<Doctor> findAreaByHosAndOfficeName(String hospitalName, String OfficeName) {
		// TODO Auto-generated method stub
		return doctorDao.findAreaByHosAndOfficeName(hospitalName, OfficeName);
	}

	// 查询医生
	@Override
	public Doctor findDoctorById(int id) {
		// TODO Auto-generated method stub
		return doctorDao.findDoctorById(id);
	}

	@Override
	public List<Doctor> findDoctorByRe(Map<String, Object> doctorMap) {
		// TODO Auto-generated method stub
		return doctorDao.findDoctorByRe(doctorMap);
	}

	@Override
	public int findDoctorByReNum(List<Hospital> hospital) {
		// TODO Auto-generated method stub
		return doctorDao.findDoctorByReNum(hospital);
	}

	@Override
	public List<Doctor> findDoctorByCondition(Doctor doctor, int start, int size) {
		if (doctor.getDoctorAdministrative() != null && doctor.getDoctorAdministrative().equals("默认")) {
			doctor.setDoctorAdministrative(null);
		}
		if (doctor.getDoctorTitle() != null && doctor.getDoctorTitle().equals("默认")) {
			doctor.setDoctorTitle(null);
		}
		if (doctor.getDoctorDegree() != null && doctor.getDoctorDegree().equals("默认")) {
			doctor.setDoctorDegree(null);
		}
		return doctorDao.findDoctorByCondition(doctor.getHospitalName(), doctor.getOfficesName(), doctor.getDoctorName(),
				doctor.getDoctorAdministrative(), doctor.getDoctorTitle(), doctor.getDoctorDegree(),start,size);
	}

	@Override
	public int findDoctorNum(Doctor doctor) {
		if (doctor.getDoctorAdministrative() != null && doctor.getDoctorAdministrative().equals("默认")) {
			doctor.setDoctorAdministrative(null);
		}
		if (doctor.getDoctorTitle() != null && doctor.getDoctorTitle().equals("默认")) {
			doctor.setDoctorTitle(null);
		}
		if (doctor.getDoctorDegree() != null && doctor.getDoctorDegree().equals("默认")) {
			doctor.setDoctorDegree(null);
		}
		return doctorDao.findDoctorNum(doctor.getHospitalName(), doctor.getOfficesName(), doctor.getDoctorName(),
				doctor.getDoctorAdministrative(), doctor.getDoctorTitle(), doctor.getDoctorDegree());
	}

	@Override
	public List<String> findDoctorTitle() {
		// TODO Auto-generated method stub
		return doctorDao.findDoctorTitle();
	}

	@Override
	public List<String> findDoctorAdministrative() {
		// TODO Auto-generated method stub
		return doctorDao.findDoctorAdministrative();
	}

	@Override
	public List<String> findDoctorDegree() {
		// TODO Auto-generated method stub
		return doctorDao.findDoctorDegree();
	}

	@Override
	public int insertDoctor(Doctor doctor) {
		return doctorDao.insertDoctor(doctor);
	}

	@Override
	public int updateDoctor(Doctor doctor) {
		return doctorDao.updateDoctor(doctor);
	}

	@Override
	public int deleteDoctor(int id) {
		return doctorDao.deleteDoctor(id);
	}

}
