package com.pro.jacat.mail.service;

import java.util.concurrent.ThreadLocalRandom;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailService {

	private final JavaMailSender mailSender;

	@Autowired
	public MailService(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	public String sendMail(String email) {
		String code = null;
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			// 메일 수신 시 표시될 이름 설정
			messageHelper.setFrom("jsun3394@naver.com", "자캣");
			// 메일 제목
			messageHelper.setSubject("자캣 인증번호");
			// 코드 받을 메일
			messageHelper.setTo(email);
			// 전송할 코드
			code = Integer.toString(generateAuthNo());
			
			// 메일 내용
			messageHelper.setText(code);
			// 메일 전송
			mailSender.send(message);

		} catch (Exception e) {
			code = null;
			e.printStackTrace();
		}
		return code;
	}

	// 6자리 난수 생성하기
	public int generateAuthNo() {
		int code = ThreadLocalRandom.current().nextInt(100000, 1000000);
		return code;
	}

}
