package com.pro.jacat.calendar.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.jacat.calendar.vo.CalendarVO;

@Repository
public class CalendarRepository {
	private final SqlSession template;
	
	public CalendarRepository(SqlSession template) {
		this.template = template;
	}

	public void insertCalendarOne(CalendarVO calendar) {
		template.insert("calendarMapper.insertCalendarOne", calendar);
	}

	public List<CalendarVO> selectCalendarAll(String id) {
		return template.selectList("calendarMapper.selectCalendarAll", id);
	}

}
