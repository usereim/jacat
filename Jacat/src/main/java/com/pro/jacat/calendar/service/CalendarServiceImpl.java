package com.pro.jacat.calendar.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pro.jacat.calendar.repository.CalendarRepository;
import com.pro.jacat.calendar.vo.CalendarVO;

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

}
