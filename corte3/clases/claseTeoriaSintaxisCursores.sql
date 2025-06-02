--cursores
--es un apuntador a un conjunto de datos de solo lectura
--permiten procesar la informacion uno a uno
--se declaran con una consulta con o sin parametros
--se usan con otros comandos


--estructura
begin
	declare
	open
	fetch
	close
	commit 
	rollback
end




do
$$ 
declare
	reg_user users%ROWTYPE;
	cur_user cursor for select * from users where country = 'colombia'
begin 
	open cur_user;
		fetch cur_user into reg_user;
		raise notice 'el usuario es %:', reg_user.country;
	close cur_user;
end
$$ language plpgsql;




do
$$ 
declare
	reg_user users%ROWTYPE;
	cur_user cursor for select * from users where country = 'colombia'
begin 
	open cur_user;
		fetch cur_user into reg_user;
		while(FOUND) loop
			raise notice 'el usuario es %:', reg_user.country;
		end loop
	close cur_user;
end
$$ language plpgsql;





--explicito: variable que almacena una consulta o mas 
--explicito

do
$$ 
declare
	reg_user users%ROWTYPE;
	cur_user cursor for select * from users where country = 'colombia'
begin 
	raise notice 'inicio la iteracion';
	for reg_user in cur_user loop
		raise notice 'Usuario es %', reg_user;
	end loop;
	raise notice 'fin iteracion';
end
$$ language plpgsql;


--implicit: no declarar una variable row type
--implicito

do
$$ 
declare
	reg_user users%ROWTYPE;
begin 
	raise notice 'inicio la iteracion';
	for reg_user in select * from users where country = 'colombia' loop
		raise notice 'Usuario es %', reg_user;
	end loop;
	raise notice 'fin iteracion';
end
$$ language plpgsql;


