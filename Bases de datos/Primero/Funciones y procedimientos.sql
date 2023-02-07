--  Para imprimir cosas por pantalla: 

set serveroutput on;


--  Crear funciones:

create function area_triangulo (base number, altura number)
return number
as 
    area number;
    
begin 
    area:=base*altura/2;
    return area;
end;
/


--  Llamar a funciones creadas 

select area_triangulo (1,3) as area from dual;


--  Condiciones con if

if condicion then
    sentencias
end if;


--  Crear una funci�n almacenado que divida dos n�meros e imprima por pantalla la divisi�n si el primer n�mero es mayor que el segundo o la frase "es menor" si es menor

set serveroutput on;
create or replace function division (num1 number, num2 number)
return number 

as 
    d number;

begin

    if num1 > num2 then
    
        d:=num1/num2;
        return d;
    
    else 
    
        dbms_output.put_line('El primer n�mero es menor que el segundo');
    
    end if;

end division;
/

select division (10,5) from dual;


--  Crear un procedimiento almacenado que divida dos n�meros e imprima por pantalla la divisi�n si el primer n�mero es mayor que el segundo

set serveroutput on;

create or replace procedure div (num1 number, num2 number)

as 
    d number;

begin

    if num1 > num2 then
    
      d:=num1/num2;
      
      dbms_output.put_line('la div es '||d);
    
    end if;

end div;
/

execute div (4,2);

--  Crear un procedimiento almacenado que divida dos n�meros e imprima por pantalla la divisi�n si el primer n�mero es mayor que el segundo o la frase "es menor" si es menor

set serveroutput on;

create or replace procedure division (num1 number, num2 number)

as 
    d number;

begin

    if num1 > num2 then
    
        d:=num1/num2;
        dbms_output.put_line('El resultado de la divisi�n es '||d);
    
    else 
        
        dbms_output.put_line('El primer n�mero es menor que el segundo')
    
    end if;

end division;
/


--  Condiciones con case

case

    when a=1 then
        "sentencias";
        
    when a=2 then
        "sentencias";
        
    when a=3 then
        "sentencias";

end case;


--  Bucle infinito con loop

loop
    
    "sentencias";
    
    exit when "condicion";

end loop;


--  Programa que imprima por pantalla los 10 primeros n�meros

set serveroutput on;

create or replace procedure contador (final number) as 

    c number;

begin 

    c:=1;

    loop
    
        dbms_output.put_line(c);
        c:=c+1;
    
        exit when c > final;

    end loop;

end;
/

execute contador(10);


--  Programa que calcule el factorial de un n�mero

set serveroutput on;

create or replace procedure factorial (numero number) as

    fact number;
    acumulador number;
    
begin
    
    fact := numero;
    acumulador := fact;
    
    loop    
    
        fact := fact - 1;
        acumulador := acumulador * fact;
        
        exit when fact = 1;
    
    end loop;
    
    dbms_output.put_line(acumulador);

end;
/

execute factorial(4);


--  Programa que calcule el factorial de un n�mero (con while)

set serveroutput on;

create or replace procedure factorial (numero number) as

    fact number;
    acumulador number;
    
begin
    
    fact := numero;
    acumulador := fact;
    
    while fact != 1 loop    
    
        fact := fact - 1;
        acumulador := acumulador * fact;
        
    end loop;
    
    dbms_output.put_line(acumulador);

end;
/

execute factorial(4);

        
-- Crear un programa que sume los n�meros entre 5 y el n�mero del par�metro

set serveroutput on;

create or replace procedure suma (num number) as

    acumulador number;

begin
    
    acumulador := 0;
    
    if num > 5 then

        for n in 5..num loop
        
        acumulador := acumulador + n;
            
        end loop;
    
        dbms_output.put_line(acumulador);

    else
    
        dbms_output.put_line(5);
    
    end if;

end;
/

execute suma(8);
    
    










    
    

    


    









































