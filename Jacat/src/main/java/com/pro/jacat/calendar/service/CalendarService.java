package com.pro.jacat.calendar.service;

import java.util.List;

import com.pro.jacat.calendar.vo.CalendarVO;

public interface CalendarService {
	void insertCalendarOne(CalendarVO calendar);
	List<CalendarVO> selectCalendarAll(String id);

}
