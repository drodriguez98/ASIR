--  TRIGGERS

create or replace trigger nome_trigger before / after evento (insert / update / delete)
declare
begin
end;
/


-- Exemplo 1: amosar mensaxe na taboa de log cada vez que se insire un novo empregado

create table log (mensaxe varchar2(250), data_i timestamp);
create or replace trigger emp_log before insert on employees
begin
    insert into log values ('insirese en employees', systimestamp);
end;
/


-- Exemplo 2: amosar mensaxe na taboa de log cada vez que se actualiza o salario dun empregado (por cada un / táboa)

create table log (mensaxe varchar2(256), data_i timestamp);
create or replace trigger emp_log before update on employees for each row
begin
    insert into log values ('actualizase en employees o valor' ||:old.salary|| 'ao novo valor' ||:new.salary, systimestamp);
end;
/
update employees set salary = salary * 1.1 where department_id is null;


--  TIPO 1 --> TRIGGERS QUE EVITAN O EVENTO ANTE UNHA SITUACIÓN (TRIGGERS BEFORE)


-- Exemplo 3: modificar o trigger anterior para que pete ao intentar actualizar o salario dun empregado se dito campo é nulo

create table log (mensaxe varchar2(256), data_i timestamp);
create or replace trigger emp_log before update on employees for each row
begin
    insert into log values ('actualizase en employees o valor' ||:old.salary|| 'ao novo valor' ||:new.salary, systimestamp);
    if :old.salary is null then
        raise_aplication_error(-20002, 'Salario nulo');
    end if;
end;
/
update employees set salary = salary * 1.1 where department_id is null; 


-- Exemplo 4: Ao inserir un novo traballador ou actualizar os seus datos verificar cun trigger se un traballador é enfermero/a (E) ou médico/a (M):

    --  Permitir se o tipo é M, especialidade not null  e andar null
    --  Permitir tamén se o tipo é F, especialidade null e andar not nul

create table trab (id number, nome varchar2 (50), tipo varchar2 (50), especialidade varchar2 (50), andar varchar2 (50));
create or replace trigger trab_comprob before insert or update on trab for each row
begin
    if :new.tipo = 'M' and :new.especialidade is not null and :new.andar is null then
    null;
    elsif :new.tipo = 'E' and :new.especialidade is null and :new.andar is not null then
    null;
    else 
        raise_application_error(-20001, 'Erro ao inserir');
    end if;
end;
/

insert into trab values (77045, 'Diego', 'E', null, '5º'); --> no da error
insert into trab values (77045, 'Diego', 'E', null, null); --> tiene que dar error


-- Exemplo 4: Ao inserir un novo médico verificar cun trigger se a súa primary key (id) non é nula, é dicir, aparece tamén na táboa traballadores. Se non aparece, aparece un erro e non se pode inserir a fila.

create table trab (id number, nome varchar2 (50));
alter table trab add constraint pk_trab_id primary key (id);
create table med (id number, especialidade varchar2 (50));
alter table med add constraint pk_med_id primary key (id);
create table enf (id number, andar varchar2 (50));
alter table enf add constraint pk_enf_id primary key (id);

create or replace trigger comp_trab before insert or update on med for each row
declare v_trab trab%rowtype;
begin
    select * into v_trab from trab where id=:new.id;
exception
    when no_data_found then
        raise_application_error(-20002, 'El médico debe estar dado de alta como trabajador');
end; 
/


--  Exemplo 5: O mesmo que anterior, pero o id do novo médico non pode ter un nulo na especialidade.

create table trab (id number, nome varchar2 (50));
alter table trab add constraint pk_trab_id primary key (id);
create table med (id number, especialidade varchar2 (50));
alter table med add constraint pk_med_id primary key (id);
create table enf (id number, andar varchar2 (50));
alter table enf add constraint pk_enf_id primary key (id);

create or replace trigger comp_trab before insert or update of especialidade on med for each row
declare v_trab trab%rowtype;
begin
    select * into v_trab from trab where id=:new.id;
        if :new.id is  null or :new.especialidade is null then
            raise_application_error(-20002, 'Los campos no pueden tener nulos');
        end if;
exception
    when no_data_found then
        raise_application_error(-20003, 'El médico debe estar dado de alta como trabajador');
end; 
/

--  Exemplo 6: O mesmo que anterior, pero o id do novo médico non pode coincidir co dun enfermeiro

create or replace trigger comp_trab before insert or update of especialidade on med for each row
declare 
    v_trab trab%rowtype;
    v_enf enf%rowtype;
begin
    select * into v_trab from trab where id=:new.id;
        if :new.id is  null or :new.especialidade is null then
            raise_application_error(-20002, 'Los campos no pueden tener nulos');
        end if;
        begin
            select * into v_enf from enf where id=:new.id;
            raise_application_error(-20003, 'El id ' ||:new.id || ' ya está dado de alta como enfermero');
        exception
            when no_data_found then
                null;
        end;
exception
    when no_data_found then
        raise_application_error(-20004, 'El médico debe estar dado de alta como trabajador');
end; 
/


-- Crear un trigger para que no se pueda introducir un valor negativo en el salario de un nuevo trabajador

alter table trab add salario number;

create or replace trigger comp_salario before insert or update of salario on trab for each row
begin
    if :new.salario <0 then
        raise_application_error(-20005, 'El valor del salario no puede ser negativo');
    end if;
end;
/ 


--  TIPO 2 --> TRIGGERS QUE CAMBIAN LOS VALORES DE LOS CAMPOS QUE SE INSERTAN O ACTUALIZAN. Sólo pueden ser before.

-- Crear una secuencia y un trigger que incremente el id cada vez que se inserte un nuevo trabajador si dicho id es nulo (

create sequence id_increm
start with 1
increment by 2;

create or replace trigger id_increm before insert or update of id on trab for each row

begin
    if :new.id is null then
        :new.id := id_increm.nextval;
    end if;  
end;
/

-- Aunque hoy en día se puede generar un id como identidad al crear la propia tabla con 'generated as identity'. Si añadimos 'by default on null' sólo se aplicará cuando el id del nuevo trabajador sea nulo. Por ejemplo:

create table proba (
id number generated by default on null as identity, 
nome varchar2(64)
);


insert into proba (id, nome) values (4, 'Javi');
commit;


--  TIPO 3 --> TRIGGERS QUE MODIFICAN OTRAS TABLAS (insert, update o delete en la otra tabla). Pueden ser before o after.

create table plantas (
numero number,
tipo varchar2 (64),
num_enf number);

-- El campo num_enf de la tabla plantas necesita contar el número de filas de la tabla enfermeros que están en esa planta --> A PARTIR DE AQUÍ ESTÁ TODO MAL

create or replace trigger cont_enf after insert or update of planta or delete on enf for each statement;
declare

    cursor c_plantas is select * from plantas;
    v_enf number;
   
begin
    for v_enf in c_plantas loop
        select count (*) into v_enf from enf where planta=v_pisos.id;
        update plantas set num_enf=v_enf where id=v_pisos.id;
    end loop;
end;
/

-- v2

create or replace trigger cont_enf after insert or update of planta or delete on enf for each statement;
declare
    cursor c_pisos is select * from plantas;
begin
    for v_pisos in c_pisos loop
        select count (*) into v_enf from enf where planta=v_pisos.id;
    end loop;
end;
/

-- TRIGGERS COMPUESTOS (esquema)

create or replace trigger "nome" for "evento/s" on "taboa" compound trigger
before statement is
begin -- seleccionamos da táboa e gardamos os datos noutro sitio
    null;
end;
before each row is -- usamos :new e :old xunto cos datos gardados no paso anterior
begin
    null;
end;
after each row is -- gardamos os :new e :old noutro sitio
begin
    null;
end;
after statement is -- usamos os datos da táboa xunto cos :new e :old gardados no paso anterior
begin
    null;
end;
end;
/


-- Trigger compuesto que controla el campo calculado numenf en los inserts y updates de la tabla enf.     
-- El trigger debe actualizar el número de enfermeras únicamente de la planta que cambia. 

create table enf (id number, andar number);
create table andares (numero number, tipo varchar2 (50), numenf number);
create table plantenf (planta number, cuenta number);

create or replace trigger controlaEnf 
for insert or update of andar or delete on enf 
compound trigger

before statement is
cursor c_enf is select andares.id,count(enf.id) as conta from enf right join andares on
enf.andar=andares.id group by andares.id;
begin   
    for v_enf in c_enf loop
        insert into contaenf2(andar,numenf) values (v_enf.id, v_enf.conta);
    end loop;
end before statement;

before each row is
    v_temp contaenf%ROWTYPE;
begin       -- hai new e old pero non fozo na táboa, fozo na temporal
    if inserting or updating then
        select * into v_temp from contaenf2 where andar=:new.andar;
        update andares set numenf=v_temp.numenf+1 where id=:new.andar;
    end if;
    if deleting then
        select * into v_temp from contaenf2 where andar=:old.andar;
        update andares set numenf=v_temp.numenf-1 where id=:old.andar;
    end if;
end before each row;

after each row is
begin
null;
end after each row;

after statement is
begin
    null;
end after statement;
end;


--  Lo mismo que el anterior pero de otra forma         **CORREGIR**

create or replace trigger controlaEnf for insert or update on enf 
compound trigger

before statement is
begin
    null;
end before statement;

before each row is
begin
    null;
end before each row;

after each row is
begin
null;
end after each row;

after statement is
declare
    v_conta number;
begin
    for v_enftemp in c_enftemp loop
        select count (*) into v_conta from enf where andar = v_enftemp.andar;
        if v_conta >= 3 then
            raise_application_error(-20001, 'No puede haber más de 3 enfermer@s por planta!!');
        end if; 
    end loop;
end after statement;
end;
/       
