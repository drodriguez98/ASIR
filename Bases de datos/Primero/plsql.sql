--  No daría error porque el id es la clave primaria y sólo devuelve una fila

select nome, salario into o_nome, o_salario from emp where id=10;


--  Daría error porque la ciudad no es la clave primaria y  devuelve varias filas

select nome, salario into o_nome, o_salario from emp where city='MADRID';



--  Procedimiento con parámetros con una sola fila --> select into

set serveroutput on;

create or replace procedure listanombre (P_CITY employee.city%type) as
    v_employeename employee.employeename%type;
begin
    select employeename into v_employeename from employee where city=P_CITY;
    dbms_output.put_line(v_employeename);
end;
/

execute listanombre('SEATTLE');



--  Procedimiento con parámetros con una sóla fila y select * --> select into

set serveroutput on;

create or replace procedure listanombre (P_CITY employee.city%type) as
    v_emp employee%rowtype;
begin
    select * into v_emp from employee where city=P_CITY;
    dbms_output.put_line(v_emp.employeeid || ' ' || v_emp.employeename);
end;
/

execute listanombre('KANSAS CITY');



--  Cuando el select devuelve varias filas 

    --> cursor: guarda todas las filas que devuelva el select
    --> open: abre el cursor
    --> fetch: asigna el valor actual del cursor a una variable y pasa a la siguiente fila
    --> close: cierra el cursor



--  Imprimir en pantalla el id y nombre de cada empleado de una determinada ciudad empleando un cursor y un loop básico

set serveroutput on;

create or replace procedure listanombre (P_CITY employee.city%type) as
    cursor c_emp is  select * from employee where city=P_CITY;
    v_emp c_emp%rowtype;
    
begin

    open c_emp;
    
        loop
        
            fetch c_emp into v_emp;
            exit when c_emp%notfound;
            dbms_output.put_line(v_emp.employeeid || ' ' || v_emp.employeename);

        end loop;
        
    close c_emp;
    
end;
/

execute listanombre('KANSAS CITY');



--  Imprimir en pantalla el id y nombre de cada empleado de una determinada ciudad empleando un cursor y un loop con while

set serveroutput on;

create or replace procedure listanombre (P_CITY employee.city%type) as
    cursor c_emp is  select * from employee where city=P_CITY;
    v_emp c_emp%rowtype;
    
begin

    open c_emp;
    
    fetch c_emp into v_emp;
    
        while c_emp%found loop
        
            dbms_output.put_line(v_emp.employeeid || ' ' || v_emp.employeename);
            
            fetch c_emp into v_emp;

        end loop;
        
    close c_emp;
    
end;
/

execute listanombre('KANSAS CITY');



--  Imprimir en pantalla el id y nombre de cada empleado de una determinada ciudad empleando un cursor y un loop con for

set serveroutput on;

create or replace procedure listanombre (P_CITY employee.city%type) as
    cursor c_emp is select * from employee where city=P_CITY;
    
begin

    for v_emp in c_emp loop 
    
        dbms_output.put_line(v_emp.employeeid || ' ' || v_emp.employeename);

    end loop;
        
close c_emp;
    
end;
/

execute listanombre('KANSAS CITY');



--  Imprimir en pantalla el id y nombre de cada empleado de una determinada ciudad empleando un for (sin cursor)

set serveroutput on;

create or replace procedure listanombre (P_CITY employee.city%type) as

begin

    for v_emp in (select * from employee where city=P_CITY) loop 
    
        dbms_output.put_line(v_emp.employeeid || ' ' || v_emp.employeename);

    end loop;
        
close c_emp;
    
end;
/

execute listanombre('KANSAS CITY');
