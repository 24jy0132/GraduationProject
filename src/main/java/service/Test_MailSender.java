package service;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class Test_MailSender {
	public static void send() throws MessagingException {

        // SMTP 設定（例：Gmail）
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // 認証情報
        Session session = Session.getInstance(props,
            new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                        "t.h3733@gmail.com",
                        "omgeipgbhtwrxfrt"
                    );
                }
            }
        );

        // メール作成
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress("t.h3733@gmail.com"));
        message.setRecipients(
            Message.RecipientType.TO,
            InternetAddress.parse("24jy0134@jec.ac.jp")
        );
        message.setSubject("Jakarta Mail テスト");
        message.setText("Tomcat 10 + Jakarta Mail 送信テストです。");

        // 送信
        Transport.send(message);
    }
}
