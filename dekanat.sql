DROP DATABASE IF EXISTS dekanat;
CREATE DATABASE dekanat;
USE dekanat;

DROP TABLE IF EXISTS faculty; 
CREATE TABLE faculty (
	id SERIAL PRIMARY KEY,
   	name_faculty VARCHAR(100) COMMENT 'Название факультета',
   	INDEX name_faculty(name_faculty)
);

INSERT INTO faculty (name_faculty) VALUES
  ('Факультет базового телекоммуникационного образования (ФБТО)'),
  ('Факультет информационных систем и технологий (ФИСТ)'),
  ('Факультет телекоммуникаций и радиотехники (ФТР)'
);

DROP TABLE IF EXISTS kafedra; 
CREATE TABLE kafedra (
	id SERIAL PRIMARY KEY,
   	name_kafedra VARCHAR(100) COMMENT 'Название кафедры',
   	faculty_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем кафедру с факультетом',
   	INDEX name_kafedra(name_kafedra),
   	FOREIGN KEY (faculty_id) REFERENCES faculty(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO kafedra (name_kafedra, faculty_id) VALUES
  ('Кафедра высшей математики (ВМ)', '1'),
  ('Кафедра теоретических основ радиотехники и связи (ТОРС)', '1'),
  ('Кафедра иностранных языков (ИНО)', '2'),
  ('Кафедра информатики и вычислительной техники (ИВТ)', '2'),
  ('Кафедра информационной безопасности (ИБ)', '3'),
  ('Кафедра сетей и систем связи (ССС)', '3'
);

DROP TABLE IF EXISTS lecturer; 
CREATE TABLE lecturer (
	id SERIAL PRIMARY KEY,
   	full_name_lecturer VARCHAR(100) COMMENT 'ФИО преподавателя',
   	kafedra_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем преподавателя с кафедрой',
   	INDEX lectuer_full_name(full_name_lecturer),
   	FOREIGN KEY (kafedra_id) REFERENCES kafedra(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO lecturer (full_name_lecturer, kafedra_id) VALUES
  ('Евстафьева Ольга Андреевна', '1'),
  ('Кирилов Дмитрий Дмитриевич', '1'),
  ('Иванов Иван Иванович', '1'),
  ('Сидоров Олег Олегович', '2'),
  ('Потапова Любовь Александровна', '2'),
  ('Арефьев Алексей Сергеевич', '2'),
  ('Алышев Юрий Витальевич', '3'),
  ('Докучаев Александр Владимирович', '3'),
  ('Зайцева Наталья Валентиновна', '3'),
  ('Жуков Сергей Владимирович', '4'),
  ('Анисимова Наталья Викторовна', '4'),
  ('Васильева Валентина Николаевна', '4'),
  ('Добрынин Петр Васильевич', '5'),
  ('Верхова Марина Викторовна', '5'),
  ('Бородина Екатерина Витальевна', '5'),
  ('Романова Виктория Владимировна', '6'),
  ('Аркадьева Инна Станиславовна', '6'),
  ('Колесникова Ангелина Юрьевна', '6'
);

DROP TABLE IF EXISTS lesson; 
CREATE TABLE lesson (
	id SERIAL PRIMARY KEY,
   	lesson_name VARCHAR(100) COMMENT 'Название предмета',
   	INDEX name_lesson(lesson_name)
);

INSERT INTO lesson (lesson_name) VALUES
  ('Физика'),
  ('Информатика'),
  ('Математическая статистика'),
  ('Философия'),
  ('Иностранный язык'),
  ('Проектирование Базы Данных'),
  ('Менеджент'),
  ('История'),
  ('Дискретная математика'),
  ('Программирование'),
  ('Операционные системы'),
  ('Вычислительная техника'),
  ('Экономика'),
  ('УТКПО'
);

DROP TABLE IF EXISTS auditorium; 
CREATE TABLE auditorium (
	id SERIAL PRIMARY KEY,
   	auditorium_number BIGINT UNIQUE COMMENT 'Номер аудитории',
   	INDEX number_auditorium(auditorium_number)
);

INSERT INTO auditorium (auditorium_number) VALUES
  ('133'),
  ('233'),
  ('333'),
  ('334'),
  ('144'),
  ('200'),
  ('180'),
  ('410'),
  ('213'),
  ('300'),
  ('111'),
  ('408'),
  ('322'),
  ('400'),
  ('222'),
  ('336'),
  ('444'
);

DROP TABLE IF EXISTS groupp; 
CREATE TABLE groupp (
	id SERIAL PRIMARY KEY,
   	znach_groupp VARCHAR(100) COMMENT 'Обозначение группы(номер и буква)',
	kafedra_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем точное обозначение группы с кафедрой',
	INDEX groupp_znach(znach_groupp),
	FOREIGN KEY (kafedra_id) REFERENCES kafedra(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO groupp (znach_groupp, kafedra_id) VALUES
  ('90П', '1'),
  ('91П', '1'),
  ('160', '1'),
  ('166', '2'),
  ('13', '2'),
  ('773А', '2'),
  ('133', '3'),
  ('83Е', '3'),
  ('66У', '3'),
  ('140П', '4'),
  ('314', '4'),
  ('25К', '4'),
  ('180П', '5'),
  ('213У', '5'),
  ('106', '5'),
  ('98', '6'),
  ('18', '6'),
  ('226', '6'
);

DROP TABLE IF EXISTS exam_schedule; 
CREATE TABLE exam_schedule (
	id SERIAL PRIMARY KEY,
   	date_ DATE NOT NULL,
   	time_ VARCHAR(100),
   	lecturer_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем расписание с преподавателем',
   	lesson_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем расписание с предметом',
   	auditorium_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем расписание с номером аудитории',
   	groupp_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем расписание с группой',
   	kafedra_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем расписание с кафедрой',
   	FOREIGN KEY (lecturer_id) REFERENCES lecturer(id) ON UPDATE CASCADE ON DELETE CASCADE,
   	FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON UPDATE CASCADE ON DELETE CASCADE,
   	FOREIGN KEY (auditorium_id) REFERENCES auditorium(id) ON UPDATE CASCADE ON DELETE CASCADE,
   	FOREIGN KEY (groupp_id) REFERENCES groupp(id) ON UPDATE CASCADE ON DELETE CASCADE,
   	FOREIGN KEY (kafedra_id) REFERENCES kafedra(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO exam_schedule (date_, time_, lecturer_id, lesson_id, auditorium_id, groupp_id, kafedra_id) VALUES
  ('2021.01.15', '14:00', '1', '1', '1', '1', '5'),
  ('2021.01.19', '15:30', '2', '2', '2', '1', '5'),
  ('2021.01.23', '9:00', '3', '3', '3', '1', '5'),
  ('2021.01.27', '12:45', '4', '4', '4', '2', '5'),
  ('2021.01.31', '11:00', '5' , '5', '7', '2', '5'),
  ('2021.02.4', '13:00', '6', '6', '5', '2', '5'),
  ('2021.02.8', '8:00', '7' , '7', '6', '2', '5'),
  ('2021.02.12', '15:00', '8', '8', '8', '3', '5'),
  ('2021.02.16', '13:00', '9', '9', '9', '3', '5'),
  ('2021.02.19', '14:00', '10', '10', '1', '3', '5'),
  ('2021.02.24', '9:45', '11', '11', '4', '4', '4'),
  ('2021.02.28', '9:10', '12', '12', '8', '4', '4'),
  ('2021.03.04', '12:45', '13', '13', '7', '4', '4'),
  ('2021.03.10', '13:45', '14', '14', '2', '5', '4'),
  ('2021.03.14', '10:00', '15', '1', '6', '5', '4'),
  ('2021.03.18', '11:00', '16', '2', '1', '5', '4'),
  ('2021.03.22', '14:00', '17', '3', '9', '6', '4'),
  ('2021.03.26', '8:30', '18', '4', '7', '6', '4'
);

DROP TABLE IF EXISTS students; 
CREATE TABLE students (
	id SERIAL PRIMARY KEY,
   	full_name_students VARCHAR(100) COMMENT 'ФИО Студента',
   	num_zach BIGINT UNIQUE COMMENT 'Номер зачетной книжки',
   	groupp_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем студентов с группой',
   	INDEX students_full_name(full_name_students),
    FOREIGN KEY (groupp_id) REFERENCES groupp(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO students (full_name_students, num_zach, groupp_id) VALUES
  ('Агапов А.Д.', '180033', '1'),
  ('Алексеева А.А.', '180088', '1'),
  ('Алемасов А.А.', '193395', '1'),
  ('Арефьев Д.А.', '193063', '1'),
  ('Астахов А.В', '193509', '2'),
  ('Бабошин А.Д.', '203317', '2'),
  ('Батуллин Б.У.', '183500', '2'),
  ('Блохин А.А', '193247', '2'),
  ('Богданов Н.А.', '193246', '2'),
  ('Бузуев А.А.', '193053', '3'),
  ('Булковский М.Ю.', '193514', '3'),
  ('Вахламова В.П.', '193228', '3'),
  ('Гареев Р.Р.', '193245', '3'),
  ('Емельдяжев А.В.', '193408', '3'),
  ('Казаку Д.', '193059', '4'),
  ('Кормишков Д.С.', '193518', '4'),
  ('Куталин К.Е.', '193046', '4'),
  ('Лебедев Р.И', '193047', '4'),
  ('Мамичева Н.Д.', '193051', '4'),
  ('Мещеряков Д.А.', '193515', '5'),
  ('Михайлов А.В.', '193238', '5'),
  ('Петров В.В.', '193243', '5'),
  ('Решетников К.А.', '193414', '5'),
  ('Решетников Н.А.', '193399', '5'),
  ('Сивохин И.А.', '193232', '6'),
  ('Супонов И.И.', '193415', '6'),
  ('Тепсуркаев И.Д.', '193418', '6'),
  ('Трубников В.С.', '193224', '6'),
  ('Чеботарева Н.Г.', '193507', '6'
);

DROP TABLE IF EXISTS result_session; 
CREATE TABLE result_session (
	id SERIAL PRIMARY KEY,
	assessment VARCHAR(100) COMMENT 'Оценка за зачет или экзамен',
   	lesson_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем результаты с дисциплинами',
   	exam_schedule_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем результаты с зачетами и экзаменами',
   	students_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем результаты со студентами',
   	groupp_id BIGINT UNSIGNED NOT NULL COMMENT 'Связываем результаты с группой',
    FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (students_id) REFERENCES students(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (groupp_id) REFERENCES groupp(id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO result_session (assessment, lesson_id, exam_schedule_id, students_id, groupp_id) VALUES
  ('5', '1', '1', '19', '1'),
  ('4', '2', '2', '19', '1'),
  ('5', '3', '3', '19', '1'),
  ('4', '1', '1', '18', '1'),
  ('неявка', '2','2','18', '1'),
  ('5', '3', '3', '18', '1'),
  ('4', '1', '1', '17', '1'),
  ('2', '2', '2', '17', '1'),
  ('3', '3', '3', '17', '1'),
  ('неявка', '1', '1', '16', '1'),
  ('5', '2', '2', '16', '1'),
  ('3', '3', '3', '16', '1'),
  ('2', '1', '1', '15', '1'),
  ('неявка', '2', '2', '15', '1'),
  ('2', '3', '3', '15', '1'
);

/* Расписание сессии */
SELECT 
	es.date_ AS "Дата экзамена(зачета)", es.time_ AS "Время экзамена(зачета)", le.full_name_lecturer AS "ФИО Преподавателя",
	l2.lesson_name AS "Дисциплина", a2.auditorium_number AS "Номер аудитории", k2.name_kafedra AS "Кафедра", g2.znach_groupp AS "Группа"
FROM 
	exam_schedule AS es 
JOIN lecturer AS le ON es.lecturer_id = le.id
JOIN lesson l2 ON es.lesson_id = l2.id
JOIN auditorium a2 ON es.auditorium_id = a2.id
JOIN kafedra k2 ON es.kafedra_id = k2.id
JOIN groupp  AS g2 ON es.groupp_id = g2.id;

/*Ведомость по всем предметам у группы*/
SELECT 
	s2.full_name_students AS "ФИО студента", s2.num_zach AS "Номер зачетной книжки", l.lesson_name AS "Дисциплина", 
	rs.assessment AS "Оценка",  g2.znach_groupp AS "Номер группы"
FROM 
	result_session AS rs
JOIN lesson AS l ON rs.lesson_id = l.id
JOIN students AS s2 ON rs.students_id = s2.id
JOIN groupp AS g2 ON rs.groupp_id = g2.id;

/*Ведомость по одному предмету у группы*/
SELECT 
	s2.full_name_students AS "ФИО студента", s2.num_zach AS "Номер зачетной книжки", l.lesson_name AS "Дисциплина", rs.assessment AS "Оценка",  g2.znach_groupp AS "Номер группы"
FROM 
	result_session AS rs
JOIN lesson AS l ON rs.lesson_id = l.id
JOIN students AS s2 ON rs.students_id = s2.id
JOIN groupp AS g2 ON rs.groupp_id = g2.id
WHERE l.lesson_name = "Информатика";

/* Отдельный вывод расписания сессии по преподавателю */
SELECT 
	es.date_ AS "Дата экзамена(зачета)", es.time_ AS "Время экзамена(зачета)", le.full_name_lecturer AS "ФИО Преподавателя",
	l2.lesson_name AS "Дисциплина", a2.auditorium_number AS "Номер аудитории", k2.name_kafedra AS "Кафедра", g2.znach_groupp AS "Группа"
FROM 
	exam_schedule AS es 
JOIN lecturer AS le ON es.lecturer_id = le.id
JOIN lesson l2 ON es.lesson_id = l2.id
JOIN auditorium a2 ON es.auditorium_id = a2.id
JOIN kafedra k2 ON es.kafedra_id = k2.id
JOIN groupp  AS g2 ON es.groupp_id = g2.id
WHERE le.full_name_lecturer = "Кирилов Дмитрий Дмитриевич";

/* Отдельный вывод расписания сессии по группам */
SELECT 
	es.date_ AS "Дата экзамена(зачета)", es.time_ AS "Время экзамена(зачета)", le.full_name_lecturer AS "ФИО Преподавателя",
	l2.lesson_name AS "Дисциплина", a2.auditorium_number AS "Номер аудитории", k2.name_kafedra AS "Кафедра", g2.znach_groupp AS "Группа"
FROM 
	exam_schedule AS es 
JOIN lecturer AS le ON es.lecturer_id = le.id
JOIN lesson l2 ON es.lesson_id = l2.id
JOIN auditorium a2 ON es.auditorium_id = a2.id
JOIN kafedra k2 ON es.kafedra_id = k2.id
JOIN groupp  AS g2 ON es.groupp_id = g2.id
WHERE g2.znach_groupp = "90П";

/* Отдельный вывод расписания сессии по кафедрам */
SELECT 
	es.date_ AS "Дата экзамена(зачета)", es.time_ AS "Время экзамена(зачета)", le.full_name_lecturer AS "ФИО Преподавателя",
	l2.lesson_name AS "Дисциплина", a2.auditorium_number AS "Номер аудитории", k2.name_kafedra AS "Кафедра", g2.znach_groupp AS "Группа"
FROM 
	exam_schedule AS es 
JOIN lecturer AS le ON es.lecturer_id = le.id
JOIN lesson l2 ON es.lesson_id = l2.id
JOIN auditorium a2 ON es.auditorium_id = a2.id
JOIN kafedra k2 ON es.kafedra_id = k2.id
JOIN groupp  AS g2 ON es.groupp_id = g2.id
WHERE k2.name_kafedra = "Кафедра информационной безопасности (ИБ)";


/* Расписание сессии(проверка по дням) */
SELECT 
	 g2.znach_groupp AS "Группа", es.time_ AS "Время экзамена(зачета)",
	 es.date_ AS "Дата экзамена(зачета)", a2.auditorium_number AS "Номер аудитории", l2.lesson_name AS "Дисциплина"
FROM 
	exam_schedule AS es 
JOIN auditorium a2 ON es.auditorium_id = a2.id
JOIN groupp  AS g2 ON es.groupp_id = g2.id
JOIN lesson l2 ON es.lesson_id = l2.id;

/* Успеваемость в группе */
SELECT g.znach_groupp AS "Группа",
       SUM(assessment = '5') as "Отлично",
       SUM(assessment = '4') as "Хорошо",
       SUM(assessment = '3') as "Удовлетворительно",
       SUM(assessment = '2') as "Неудовлетворительно",
       SUM(assessment = 'неявка') as "Неявка",
       ROUND((SUM(assessment))/COUNT(*),2) as "Средний балл по группе"
FROM result_session AS rs
JOIN groupp AS g ON rs.exam_schedule_id = g.id;

/* Отдельный вывод расписания на текущую дату */
SELECT 
	es.date_ AS "Дата экзамена(зачета)", es.time_ AS "Время экзамена(зачета)", le.full_name_lecturer AS "ФИО Преподавателя",
	l2.lesson_name AS "Дисциплина", a2.auditorium_number AS "Номер аудитории", k2.name_kafedra AS "Кафедра", g2.znach_groupp AS "Группа"
FROM 
	exam_schedule AS es 
JOIN lecturer AS le ON es.lecturer_id = le.id
JOIN lesson l2 ON es.lesson_id = l2.id
JOIN auditorium a2 ON es.auditorium_id = a2.id
JOIN kafedra k2 ON es.kafedra_id = k2.id
JOIN groupp  AS g2 ON es.groupp_id = g2.id
WHERE es.date_ = "2021-02-28";



