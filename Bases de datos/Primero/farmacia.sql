-- Para borrar en cascada. Por ejemplo, para que al borrar un cliente de la tabla clientes se borren también aquellas filas de la tabla pedidos en las que aparece dicho cliente.

alter table pedidos add constraint ped_fk foreign key (cliente) references clientes (cli_id) on delete cascade;


-- Crear una función que calcule el gasto en salarios de un departamento

set serveroutput on;

create or replace function gasto_salarial (p_dep employees.department_id%type)

return number as

    cursor c_sal is select salary from employees where department_id=p_dep;  
    suma number;

begin

    suma := 0;
    
    for v_sal in c_sal loop
    
        suma := suma + v_sal.salary;
    
    end loop; 
    
    return suma;
    
end;
/

select gasto_salarial(10) from dual;


--  Crear un procedimiento que procese cada empleado e imprima por pantalla si su salario está entre el mínimo y el máximo del trabajo que realiza

set serveroutput on;

create or replace procedure proba_salario  as
    cursor c_emp is select * from employees;
    salmin jobs.min_salary%type;
    salmax jobs.max_salary%type;
    
begin
    
    for v_emp in c_emp loop
    
        select min_salary, max_salary into salmin, salmax from jobs where job_id=v_emp.job_id;
        
        case
        
            when v_emp.salary>salmax then
            
                dbms_output.put_line(v_emp.first_name || ' cobra demasiado ');
                
            
            when v_emp.salary<salmin then
            
                dbms_output.put_line(v_emp.first_name || ' cobra poco ');
            
            else
            
                dbms_output.put_line(v_emp.first_name || ' cobra correcto ');
        
        end case;
       
    end loop;

end;
/

execute proba_salario;



-- Listar todos los departamentos con todos los gastos de salario 

set serveroutput on;

create or replace procedure suma_salarial as

    cursor c_dep is select * from departments;
    cursor c_emp (p_emp number) is select * from employees where department_id=p_emp;
    v_suma number;

begin

    for v_dep in c_dep loop
    
        dbms_output.put(v_dep.department_name);
        
        v_suma := 0;
        
        for v_emp in c_emp (v_dep.department_id) loop
        
            v_suma := v_suma + v_emp.salary;
            
        end loop;

        dbms_output.put_line('  '|| v_suma);
            
    end loop;
    
end;
/

execute suma_salarial;


--  Excepciones (con función)

set serveroutput on;

create or replace function division (a number, b number) return number as

    v_ret number;
    negativo exception;
    
begin

    if a < 0 or b < 0 then
    
        raise negativo;
        
    end if;
    
    v_ret := a/b;
    return v_ret;

exception
    
    when negativo then
        
        return null;
end;
/

select division (10,5) from dual;


--  Excepciones (con procedimiento)

set serveroutput on;

create or replace procedure divide as division number;

begin

    select divide (10/2) into division from dual;
    dbms_output.put_line('La división es' || division);
    
end;
/

execute divide;









