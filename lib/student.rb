class Student
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(name,grade,id=nil)
    @name=name
    @grade=grade
    @id=id
  end

  def self.create_table
    sql = <<-SQL
        CREATE TABLE IF NOT EXISTS students (
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade INTEGER)
          SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    drop_table =<<-SQL
        DROP TABLE students
       SQL
       DB[:conn].execute(drop_table)
  end

  def save
    insert_attr = <<-SQL
      INSERT INTO students(name,grade)
      VALUES (?,?)
      SQL
      DB[:conn].execute(insert_attr, self.name, self.grade)
      @id = DB[:conn].execute("SELECT id FROM students")[0][0]
  end

  def self.create(name:, grade:)
    new_student=Student.new(name,grade)
    new_student.save
    new_student
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
