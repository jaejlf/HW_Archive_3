CREATE OR REPLACE PROCEDURE Insert_Booking(
	input_user IN user_booking_table.user_id%TYPE := null,
	run_id IN user_booking_table.running_movie_id%TYPE := null,
	theater_id IN user_booking_table.theater_id%TYPE := null,
	adult_only IN movie_info_table.adult_only %TYPE := null,
	seat_id IN user_booking_table.seat_id%TYPE := null
)

IS
   book_id  NUMBER;
   book_exist NUMBER := -1;
   age NUMBER;

   no_adult_error EXCEPTION;
   no_user_error EXCEPTION;
   booking_info_error EXCEPTION;
BEGIN
   IF input_user is null THEN
      RAISE no_user_error; 
   END IF;
 
   IF run_id is null OR theater_id IS null OR adult_only IS null OR seat_id IS null THEN
      RAISE booking_info_error; 
   END IF;

   -- 청불
   IF adult_only = '1' THEN
      age := how_old(input_user);
      IF age<19 THEN 
         RAISE no_adult_error; 
      END IF; 
   END IF;

   -- book_id
   SELECT MAX(booking_id)+1
   INTO book_id
   FROM user_booking_table;

   INSERT INTO user_booking_table VALUES(input_user, run_id, theater_id, seat_id, book_id);
   COMMIT;
   
   EXCEPTION 
   WHEN no_adult_error 
     THEN RAISE_APPLICATION_ERROR(-20001,'성인 아님');
   WHEN no_user_error 
     THEN RAISE_APPLICATION_ERROR(-20002,'예매자 존재 안함');
   WHEN booking_info_error 
     THEN RAISE_APPLICATION_ERROR(-20003,'예매정보 입력값 없음');
END;
/