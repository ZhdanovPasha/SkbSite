package com.kantiana.skb.validator;

import com.kantiana.skb.model.Booking;
import com.kantiana.skb.model.EquipmentType;
import com.kantiana.skb.model.EquipmentTypeCount;
import com.kantiana.skb.model.RequestEquipment;
import com.kantiana.skb.service.BookingService;
import com.kantiana.skb.service.EquipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;

import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Set;

@Component
public class BookingValidatorImpl implements BookingValidator {
    @Autowired
    BookingService bookingService;
    @Autowired
    EquipmentService equipmentService;

    @Override
    public void validateAddingToBasket(EquipmentType chosenEquipment, Set<EquipmentType> basket, Errors errors) {
        if (basket.contains(chosenEquipment)) {
            errors.rejectValue("id", "Duplicate.basket.equipment");
        }
    }

    @Override
    public void validateBooking(RequestEquipment requestEquipment, Errors errors) {
        List<EquipmentTypeCount> chosenEquipments = requestEquipment.getEquipmentTypeCountList();
        Date chosenDay = requestEquipment.getSqlDate();
        int chosenTimeMask = requestEquipment.getChosenTimeMask();
        validateChosenDay(chosenDay, errors);
        validateChosenTime(chosenTimeMask, errors);
        validateCount(chosenEquipments, errors);
        if (errors.hasErrors()) {
            return;
        }
        for (EquipmentTypeCount etc : chosenEquipments) {
            validateChosenEquipment(etc, chosenDay, chosenTimeMask, errors);
        }
    }

    private void validateChosenDay(Date chosenDay, Errors errors) {
        if (chosenDay == null) {
            errors.rejectValue("date", "NotEmpty.booking.date");
            return;
        }
        Date today = getToday();
        if (chosenDay.compareTo(today) < 0) {
            errors.rejectValue("date", "NotValid.booking.date");
        }
    }

    private void validateChosenTime(int chosenTimeMask, Errors errors) {
        if (chosenTimeMask == 0) {
            errors.rejectValue("chosenTime", "NotEmpty.booking.chosenTime");
        }
    }

    private void validateCount(List<EquipmentTypeCount> chosenEquipments, Errors errors) {
        for (EquipmentTypeCount etc : chosenEquipments) {
            if (etc.getCount() == null) {
                errors.rejectValue("equipmentTypeCountList", "NotEmpty.equipment.count");
                return;
            }
            if (etc.getCount() <= 0) {
                errors.rejectValue("equipmentTypeCountList", "NotValid.equipment.count.notPositive");
            }
            else if (etc.getCount() > equipmentService.countByEquipmentTypeId(etc.getId())) {
                Object[] arg = {etc.getCount(), etc.getName()};
                errors.rejectValue("equipmentTypeCountList", "NotValid.equipment.count.tooMany", arg, "");
            }
        }
    }

    private boolean canBook(EquipmentTypeCount chosenEquipment, Date chosenDay, int chosenTimeMask) {
        final int TIME_RANGES_COUNT = 19; // Размер нужно как-то получать
        int bookedEquipmentsCounts[] = new int[TIME_RANGES_COUNT];
        List<Booking> bookings = bookingService.findByDayAndEquipmentType(chosenDay, chosenEquipment.getId());
        int allEquipmentCount = equipmentService.countByEquipmentTypeId(chosenEquipment.getId());
        // Сюда можно написать Димину оптимизацию
        for (int i = 0; i < TIME_RANGES_COUNT; ++i) {
            bookedEquipmentsCounts[i] = 0;
        }
        for (Booking booking : bookings) {
            for (int i = 0; i < TIME_RANGES_COUNT; ++i) {
                if ((booking.getTimeMask() & (1 << i)) != 0) {
                    ++bookedEquipmentsCounts[i];
                }
            }
        }
        int timeMask2 = 0;
        for (int i = 0; i < TIME_RANGES_COUNT; ++i) {
            if (allEquipmentCount - bookedEquipmentsCounts[i] >= chosenEquipment.getCount()) {
                timeMask2 |= (1 << i);
            }
        }
        return (chosenTimeMask & timeMask2) == chosenTimeMask;
    }

    private void validateChosenEquipment(EquipmentTypeCount chosenEquipment, Date chosenDay, int chosenTimeMask, Errors errors) {
        if (!canBook(chosenEquipment, chosenDay, chosenTimeMask)) {
            Object[] arg = {chosenEquipment.getName()};
            errors.rejectValue("equipmentTypeCountList", "NotFree.equipment", arg, "");
        }
    }

    private Date getToday() {
        Date today = new Date(System.currentTimeMillis());
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        try {
            java.util.Date utilDate = format.parse(today.toString());
            today.setTime(utilDate.getTime());
        }
        catch (ParseException pEx) {
            pEx.printStackTrace();
        }
        return today;
    }
}
