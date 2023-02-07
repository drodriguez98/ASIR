--  1. Función que calcule el salario total de un trabajador.

set serveroutput on;

create or replace function salario_total 

return number as

begin

    select employee_id, salary + commission_pct into v_sal from  employees where salary=v_sal;  
    
end;
/

--  2. Función que devuelva true o false si el trabajador cobra bien.



--  3. Procedimiento que liste todos los trabajadores con su salario total.



--  4. Procedimiento que inserte un trabajador primero comprobando si ya existe. Comprobar también si su salario es correcto.

