module SlotsHelper

  def amount_of_slots_in_day(date)
    Slot.all.select{|instance| instance.start_time.to_date == date}.length
  end


  def month_string(num)
    if num == 1
      "January"
    elsif num == 2
      "February"
    elsif num == 3
      "March"
    elsif num == 4
      "April"
    elsif num == 5
      "May"
    elsif num == 6
      "June"
    elsif num == 7
      "July"
    elsif num == 8
      "August"
    elsif num == 9
      "September"
    elsif num == 10
      "October"
    elsif num == 11
      "November"
    elsif num == 12
      "December"
    end
  end

  def your_appointment(slot)
    slot.appointments.find{|app| app.student == current_user}
  end

  def already_joined?(slot)
    slot.students.map(&:id).include?(current_user.id)
  end

  def display_time(datetime)
    t = datetime.to_time
    min = string_increase_for_min(t.min)
    if min.to_s.length == 1 then min = "0" + min end
    "#{t.hour}:#{min}"
  end


  def amount_of_students(slot)
    slot.students.count
  end

  def full?(slot)
    slot.capacity <= amount_of_students(slot)
  end

  def sort_by_start(slots)
    slots.sort_by(&:start_time).reverse
  end

  def slot_times
    times = []
    minutes = 0
    hours = 9
    until hours == 18
      if minutes == 60
        hours += 1
        minutes = 0
      end
        t = Time.new(2002, 10, 31, hours, minutes, 0)
        times << t
      minutes += 30
    end
    times
  end

  def string_increase_for_min(min)
    min = min.to_s
    if min.length == 1
       min = "0" + min
    else
      min
    end
  end

  def slots_in_this_time(year,month,day,hour,min)
    t = DateTime.new(year,month,day,hour,min)
    Slot.all.select{|slot| slot.start_time <= t && slot.end_time  >= t}
  end

  def over?(slot)
    DateTime.now >= slot.end_time
  end

  def length_of_month(month,year)
    case month
    when 1
      31
    when 2
      if year % 4 == 0
        29
      else
        28
      end
    when 3
      31
    when 4
      30
    when 5
      31
    when 6
      30
    when 7
      31
    when 8
      31
    when 9
      30
    when 10
      31
    when 11
      30
    when 12
      31
    end
  end
end
