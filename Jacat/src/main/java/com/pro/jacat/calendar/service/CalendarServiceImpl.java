package com.pro.jacat.calendar.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.pro.jacat.calendar.repository.CalendarRepository;
import com.pro.jacat.calendar.vo.CalendarVO;
import com.pro.jacat.licenseBoards.vo.UsersFavoritesLicenseVO;

@Service
public class CalendarServiceImpl implements CalendarService {
	
	private CalendarRepository calendarRepository;
	
	public CalendarServiceImpl(CalendarRepository calendarRepository) {
		this.calendarRepository = calendarRepository;
	}

	@Override
	public void insertCalendarOne(CalendarVO calendar) {
		calendarRepository.insertCalendarOne(calendar);
	}

	@Override
	public List<CalendarVO> selectCalendarAll(String id) {
		return calendarRepository.selectCalendarAll(id);
	}
	
	@Override
	public List<CalendarVO> selectCalendarAllByUsersId(CalendarVO calendar) {
		return calendarRepository.selectCalendarAllByUsersId(calendar);
	}

	@Override
	public void deleteCalendar(int dateNum) {
		calendarRepository.deleteCalendar(dateNum);
		
	}

	@Override
	public void updateCalendar(CalendarVO calendar) {
		calendarRepository.updateCalendar(calendar);
		
	}

	@Override
	public List<UsersFavoritesLicenseVO> selectLicenseTestDateAll(String id) {
		return calendarRepository.selectLicenseTestDateAll(id);
	}

}
