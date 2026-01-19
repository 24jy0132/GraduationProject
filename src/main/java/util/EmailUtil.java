//package util;
//
//import java.net.PasswordAuthentication;
//import java.util.Properties;
//
//import jakarta.mail.Authenticator;
//import jakarta.mail.Session;
//import jakarta.mail.Transport;
//import jakarta.mail.internet.InternetAddress;
//import jakarta.mail.internet.MimeMessage;
//
//import com.mysql.cj.protocol.Message;
//
//import model.Reservation;
//
//public class EmailUtil {
//
//    public static void sendReservationMail(Reservation r) {
//        final String FROM = "restaurant@example.com";
//        final String PASSWORD = "app-password";
//
//        Properties prop = new Properties();
//        prop.put("mail.smtp.host", "smtp.gmail.com");
//        prop.put("mail.smtp.port", "587");
//        prop.put("mail.smtp.auth", "true");
//        prop.put("mail.smtp.starttls.enable", "true");
//
//        Session session = Session.getInstance(prop,
//          new Authenticator() {
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(FROM, PASSWORD);
//            }
//        });
//
//        try {
//            Message msg = new MimeMessage(session);
//            msg.setFrom(new InternetAddress(FROM));
//            msg.setRecipients(
//              Message.RecipientType.TO,
//              InternetAddress.parse(r.getCustomerEmail())
//            );
//            msg.setSubject("Reservation Confirmation");
//
//            msg.setText(
//                "Reservation Date: " + r.getReservationDate() + "\n" +
//                "Start Time: " + r.getStartTime() + "\n" +
//                (r.getEndTime() != null ? "End Time: " + r.getEndTime() + "\n" : "") +
//                "Thank you for your reservation."
//            );
//
//            Transport.send(msg);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//}