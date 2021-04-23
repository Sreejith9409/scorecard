require 'csv'
module Student

  attr_accessor :students, :agrade_students, :bgrade_students, :cgrade_students, :above_avg_students, :below_avg_students

  def self.get_student_report
    self.construct_student_data
    self.export_to_csv
  end

  private

  def self.construct_student_data
    file_data = File.read("input.txt").split
    @students ||= []
    file_data.each do |f_data|
      data = f_data.split(",")
      id = data[0]
      s1 = self.get_student_mark(data[1])
      s2 = self.get_student_mark(data[2])
      s3 = self.get_student_mark(data[3])
      s4 = self.get_student_mark(data[4])
      total = (s1 + s2 + s3 + s4)
      @students << [data[0], s1, s2, s3, s4, total, self.calculate_grade(total)]
    end
    self.find_category_of_students
  end

  def self.get_student_mark(data)
    data.to_s.split('-')[1].to_f
  end

  def  self.calculate_grade(total)
    grade = if total >= 340
      'A'
    elsif total >= 300 and total < 340
      'B'
    else
      'C'
    end
  end

  def self.find_category_of_students
    avg_a, avg_b, avg_c = self.calculate_grade_avg
    @below_avg_students = @above_avg_students = 0
    @students.each do |s|
      case s[6]
      when 'A' then s << self.compare_average(s[5], avg_a)
      when 'B' then s << self.compare_average(s[5], avg_b)
      when 'C' then s << self.compare_average(s[5], avg_c)
      end
    end
  end

  def self.compare_average(total, grade_average)
    if total >= grade_average
      grade = 'ABOVE'
      @above_avg_students += 1
    else
      grade = 'BELOW'
      @below_avg_students += 1
    end
    grade
  end

  def self.calculate_grade_avg
    avg_a = avg_b = avg_c = a_sum = b_sum = c_sum = 0.0
    @agrade_students = @bgrade_students = @cgrade_students = 0
    @students.each do |s|
      if s[6] == 'A'
        a_sum += s[5]
        @agrade_students += 1
      elsif s[6] == "B"
        b_sum += s[5]
        @bgrade_students += 1
      else
        c_sum += s[5]
        @cgrade_students += 1
      end
    end
    avg_a = a_sum / @agrade_students if @agrade_students > 0
    avg_b = b_sum / @bgrade_students if @bgrade_students > 0
    avg_c = c_sum / @cgrade_students if @cgrade_students > 0
    [avg_a, avg_b, avg_c]
  end

  def self.export_to_csv
    csv = CSV.generate do |csv|
      csv << ["ID", "Subject1", "Subject2", "Subject3", "Subject4", "Grand-Total", "Grade", "Average-Compare"]
      print " ID | Subject 1 | Subject 2 | Subject 3 | Subject 4 | Grand-Total | Grade | Average-Compare |\n"
      @students.each do |student|
        csv << student
        printf(" %02d |     %02d    |     %02d    |     %02d    |     %02d    |     %03d     |   %s   |      %s      |\n", student[0], student[1], student[2], student[3], student[4], student[5], student[6], student[7])
      end
      csv << ["Grade report"]
      csv << ["Number of students in A Grade :: ", @agrade_students]
      csv << ["Number of students in B Grade :: ", @bgrade_students]
      csv << ["Number of students in C Grade :: ", @cgrade_students]
      csv << ["Number of students above their grade average :: ", @above_avg_students]
      csv << ["Number of students below their grade average :: ", @below_avg_students]
      print "----------------------------------------------------------------------------------------------\n"
      print "Grade report\n"
      print "\nNumber of students in A Grade :: ", @agrade_students
      print "\nNumber of students in B Grade :: ", @bgrade_students
      print "\nNumber of students in C Grade :: ", @cgrade_students
      print "\nNumber of students above their grade average :: ", @above_avg_students
      print "\nNumber of students below their grade average :: ", @below_avg_students
      print "\n----------------------------------------------------------------------------------------------\n"
    end
    begin
      FileUtils.mkdir_p "public/csv"
      File.open("#{Rails.root}/public/csv/report_card.csv", 'w') {|f| f.write(csv) }
    rescue Exception => e
      p e.to_s
    end
  end

end