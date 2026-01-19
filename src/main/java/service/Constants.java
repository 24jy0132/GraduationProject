package service;

import java.time.LocalTime;

public class Constants {
    public static final LocalTime OPEN = LocalTime.of(17, 0);
    public static final LocalTime CLOSE = LocalTime.of(22, 0);
    public static final int SLOT_MINUTES = 15;
    public static final int DURATION_MINUTES = 120; // 2 hours
    public static final LocalTime LAST_START =
            CLOSE.minusMinutes(DURATION_MINUTES); // 20:00
}