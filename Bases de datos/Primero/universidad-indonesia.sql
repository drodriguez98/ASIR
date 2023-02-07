--      Procedemento 1

create or replace procedure parametros(p_id in employees.employee_id%type, dinero in out number) as
v_salario number;
begin
    select salary into v_salario from employees where employee_id=p_id;
    update employees set salary = salary * 1.1 where employee_id=p_id;
    dinero := dinero - (v_salario * 0.1);
    if dinero < 0 then
        raise_application_error(-20001,'No hay dinero');
    end if;
    dbms_output.put_line(dinero);
end;
/
declare
x number;
begin
    x := 35000;
    parametros(100,x);
end;
/

create or replace procedure parametrosCursor(dinero in out number) as
cursor c_emp is  select * from employees order by salary;
subida number;
begin
    for emp in c_emp loop
        subida := emp.salary * 0.1;
        dinero := dinero - subida;
        exit when dinero < subida or c_emp%notfound;
        update employees set salary = salary * 1.1 where employee_id=emp.employee_id;
    end loop;
    dbms_output.put_line('No hay más dinero o todos los usuarios actualizados');
end;
/
declare
x number;
begin
    x := 300000;
    parametrosCursor(x);
end;
/

--      Procedemento 2

select * from employees order by salary;



--  BOLETÍN 1 --> Universidad de Indonesia


--      1. Imprimir el salario de Neena

set serveroutput on;

create or replace procedure salary_emp as

sal_emp employees.salary%type;

begin

    select salary into sal_emp from employees where first_name='Neena';
    dbms_output.put_line('El salario de Neena es '|| sal_emp);

end;
/

execute salary_emp;


--      2. Modificar el script anterior para imprimir una línea de asteriscos, 
--      luego la información del salario y luego otra línea de asteriscos.

set serveroutput on;

create or replace procedure salary_emp2 as

sal_emp employees.salary%type;

begin

    select salary into sal_emp from employees where first_name='Neena';
    dbms_output.put_line('***********************************');
    dbms_output.put_line('El salario de Neena es '|| sal_emp);
    dbms_output.put_line('***********************************');

end;
/

execute salary_emp2;


--      3.  Modificar el script anterior para parametrizarlo de modo que cualquier 
--      nombre pueda ser ingresado para revelar el salario de ese empleado. Capturar excepción 
--      no existen empleados con dicho nombre o si existe más de una entrada de un mismo empleado.

set serveroutput on;

create or replace procedure salary_emp3 (v_name varchar2) as

v_sal number;

begin

    select salary into v_sal from employees where first_name=v_name;
    dbms_output.put_line('***********************************');
    dbms_output.put_line('El salario del empleado es '|| v_sal);
    dbms_output.put_line('***********************************');
    
exception
    
    when no_data_found then
        null;
    
    when too_many_rows then
        raise_application_error(-20001, 'Hay muchos ' || v_name);

end;
/

execute salary_emp3('Steven');


--      4.  Modificar el script anterior empleando un cursor para mostrar el salario de varios 
--      trabajadores con el mismo nombre (evitar excepción too_many_rows).

set serveroutput on;

create or replace procedure salary_emp4 (v_name varchar2) as

v_sal number;

cursor c_sal is select first_name, salary from employees where first_name=v_name;

begin

    for emp in c_sal loop
    
    dbms_output.put_line('***********************************');
    dbms_output.put_line('El salario del empleado '|| emp.first_name ||' es '|| emp.salary);
    dbms_output.put_line('***********************************');
    
    end loop;
    
exception
    
    when no_data_found then
        null;

end;
/

execute salary_emp4('Steven');
