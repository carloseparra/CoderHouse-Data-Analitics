--clase 7

/* 1
SELECT COUNT (AsignaturasID) as cant_asignaturas 
FROM [CoderHouse].[dbo].[Asignaturas]
where Area = 5
*/

/* 2
SELECT [Nombre]
      ,[Documento]
      ,[Telefono]
	  ,[Fecha de Nacimiento]
  FROM [CoderHouse].[dbo].[Estudiantes]
 WHERE [Profesion] = '6' AND [Fecha de Nacimiento] BETWEEN '1970-01-01' AND '2000-10-10'
 */

/* 3
 SELECT [Nombre], [Apellido],  UPPER([Nombre] +'-'+[Apellido]) AS Nombres_Apellidos
  FROM [CoderHouse].[dbo].[Staff]
 WHERE YEAR([Fecha Ingreso]) = '2021'
*/

/* 4
  SELECT COUNT([Encargado_ID]) AS CantEncargados , REPLACE (Tipo, 'Encargado ','') AS NuevoTipo
  FROM [CoderHouse].[dbo].[Encargado]
  GROUP BY Tipo
*/


/* 5
  SELECT SUM([Costo])/COUNT([Nombre]) As Promedio, Tipo, Jornada
     FROM [CoderHouse].[dbo].[Asignaturas]
  GROUP BY Tipo, Jornada 
  ORDER BY Promedio DESC
*/

/* 6
SELECT  DATEDIFF(YEAR,[Fecha de Nacimiento],GETDATE())
-(CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR,[Fecha de Nacimiento],GETDATE()),[Fecha de Nacimiento])>GETDATE() THEN
      1
   ELSE
      0 
   END) as Edad
FROM Estudiantes--
WHERE DATEDIFF(YEAR,[Fecha de Nacimiento],GETDATE())
-(CASE
   WHEN DATEADD(YY,DATEDIFF(YEAR,[Fecha de Nacimiento],GETDATE()),[Fecha de Nacimiento])>GETDATE() THEN
      1
   ELSE
      0 
   END) >= 18
ORDER BY Edad ASC
*/

/* 7
SELECT [Nombre]
      ,[Apellido]
      ,[Correo]
      ,[Camada]
      ,[Fecha Ingreso]
FROM [CoderHouse].[dbo].[Staff]
WHERE Correo LIKE '%.edu' and DocentesID > 100; 
*/

/*
SELECT TOP (10) [Documento]
      ,[Domicilio]
      ,[Codigo Postal]
      ,[Nombre]
	  ,[Fecha Ingreso]
  FROM [CoderHouse].[dbo].[Estudiantes]
  ORDER BY [Fecha Ingreso] ASC
  */

  --consignas clase 8

  /* 1.- Indicar por jornada la cantidad de docentes que dictan y sumar los costos. 
  Esta información sólo se desea visualizar para las asignaturas de desarrollo web.
  El resultado debe contener todos los valores registrados en la primera tabla, 
  Renombrar la columna del cálculo de la cantidad de docentes como cant_docentes y 
  la columna de la suma de los costos como suma_total. 
  Keywords: Asignaturas,Staff, DocentesID, Jornada, Nombre, costo. */

SELECT t2.Jornada,
       count(t1.DocentesID) as cant_docentes,
       sum(t2.costo) as suma_total  
FROM DBO.Staff t1
INNER JOIN  Asignaturas t2 on t1.Asignatura=t2.AsignaturasID 
WHERE T2.Nombre='Desarrollo Web'
GROUP BY t2.Jornada

/* 2.- Se requiere saber el id del encargado, el nombre, el apellido y cuantos son los docentes que tiene asignados cada encargado. 
Luego filtrar los encargados que tienen como resultado 0 ya que son los encargados que NO tienen asignado un docente. 
Renombrar el campo de la operación como Cant_Docentes. 
Keywords: Docentes_id, Encargado, Staff, Nombre, Apellido,Encargado_ID.*/

SELECT t1.Encargado_ID,
       t1.Nombre,
       t1.Apellido,
       count(t2.DocentesID)as Cant_docentes
FROM Encargado t1
LEFT JOIN staff t2 on t1.Encargado_ID=t2.Encargado
GROUP by t1.Encargado_ID,t1.Nombre,t1.Apellido
HAVING COUNT(t2.DocentesID) = 0


/* 3.- Se requiere saber todos los datos de asignaturas que no tienen un docente asignado.El modelo de la consulta debe partir
desde la tabla docentes. Keywords: Staff, Encargado, Asignaturas, costo, Area.*/ 





/* 4.- Se quiere conocer la siguiente información de los docentes. El nombre completo 
concatenar el nombre y el apellido. Renombrar NombresCompletos, el documento, 
hacer un cálculo para conocer los meses de ingreso. Renombrar meses_ingreso, 
el nombre del encargado. Renombrar NombreEncargado, el teléfono del encargado. 
Renombrar TelefonoEncargado, el nombre del curso o carrera, la jornada y el nombre del área. 
Solo se desean visualizar solo los que llevan más de 3 meses.Ordenar los meses de ingreso de mayor a menor.  
Keywords: Encargo,Area,Staff,jornada, fecha ingreso.*/




/* 5.- Se requiere una listado unificado con nombre, apellido, documento y una marca indicando a que base corresponde. 
Renombrar como Marca Keywords: Encargo,Staff,Estudiantes
*/


/*clase 9 - Ejercicio 1 - Indicadores para nivel operativoAnálisis de docentes por camada: 
Número de documento, nombre de docente y camada para identificar la camada mayor y la menor según el numero de la  camada. 
Número de documento, nombre de docente y camada para identificar la camada con fecha de ingreso Mayo 2021. 
Agregar un campo indicador que informe cuales son los registros ”mayor o menor” y los que son “Mayo 2021” y ordenar el listado de menor a mayor por camada.

Nota: para el ejercicio 1, los dos análisis deben encontrarse en el mismo reporte. Identificar si es necesario unificar o reunir la consulta SQL.
*/SELECT Documento,       Nombre,	   Camada,	   'Menor' AS IndicadorFROM StaffWHERE Camada = (SELECT TOP 1 Camada                FROM Staff                ORDER BY Camada ASC)UNIONSELECT Documento,       Nombre,	   Camada,	   'Mayor' AS IndicadorFROM StaffWHERE Camada = (SELECT TOP 1 Camada                FROM Staff                ORDER BY Camada DESC)UNIONSELECT Documento,       Nombre,	   Camada,	   'Mayo 2021' AS IndicadorFROM StaffWHERE [Fecha Ingreso] BETWEEN '2021-05-01' AND '2021-05-31'

/*clase 9 - Ejercicio 2 - Indicadores para nivel operativoAnálisis diario de estudiantes: 
Por medio de la fecha de ingreso de los estudiantes identificar: cantidad total de estudiantes.
Mostrar los periodos de tiempo separados por año, mes y día, y presentar la información ordenada por la fecha que mas ingresaron estudiantes.
*/
SELECT COUNT([Fecha Ingreso]) Cant_Estudiantes,       DATEPART(YEAR, [Fecha Ingreso]) Año,	   DATEPART(MONTH, [Fecha Ingreso]) Mes,	   DATEPART(DAY, [Fecha Ingreso]) DíaFROM EstudiantesGROUP BY [Fecha Ingreso]ORDER BY COUNT([Fecha Ingreso]) DESC


--Ejercicio 2--SELECT COUNT(EstudiantesID) AS Cantidad_Estudiantes,       [Fecha Ingreso],	   DAY([Fecha Ingreso]) AS DIA,	   MONTH([Fecha Ingreso]) AS MES,	   YEAR([Fecha Ingreso]) AS AÑOFROM dbo.estudiantesGROUP BY [Fecha Ingreso]ORDER BY COUNT([Fecha Ingreso]) DESC

/*clase 9 - Ejercicio 3 - Indicadores para nivel operativoAnálisis de encargados con mas docentes a cargo: 
Identificar el top 10 de los encargados que tiene más docentes a cargo, filtrar solo los que tienen a cargo docentes. 
Ordenar de mayor a menor para poder tener el listado correctamente.
*/
Select top (10)       t1.Encargado_ID,       t1.Nombre,       t1.Documento,	   t1.Tipo AS Tipo_docente,       COUNT(t2.DocentesID) as cantFROM Encargado t1LEFT JOIN Staff t2 on t2.Encargado=t1.Encargado_ID --Where TRIM(t1.Tipo) = 'Encargado Docentes'Group by t1.Encargado_ID,         t1.Nombre,		 t1.Documento,		 t1.TipoHAVING t1.Tipo like '%Docentes%'Order by cant desc;

/*clase 9 - Ejercicio 4 - Indicadores para nivel operativoAnálisis de profesiones con mas estudiantes: 
Identificar la profesión y la cantidad de estudiantes que ejercen, mostrar el listado solo de las profesiones que tienen mas de 5 estudiantes.
Ordenar de mayor a menor por la profesión que tenga mas estudiantes.
*/
SELECT P.Profesiones,       COUNT(E.EstudiantesID) Cant_EstudiantesFROM Profesiones PINNER JOIN Estudiantes EON P.ProfesionesID = E.ProfesionGROUP BY P.ProfesionesHAVING COUNT(P.ProfesionesID) > 5ORDER BY Cant_Estudiantes DESC



/*clase 9 - Ejercicio 5 - Indicadores para nivel operativo
Análisis de estudiantes por área de educación: 
Identificar: nombre del área, si la asignatura es carrera o curso , a qué jornada pertenece, cantidad de estudiantes y monto total del costo de la asignatura. 
Ordenar el informe de mayor a menor por monto de costos total tener en cuenta los docentes que no tienen asignaturas ni estudiantes asignados, también sumarlos.
*/
SELECT DISTINCT t1.Nombre Nombre_Area,       t2.Tipo Tipo_Asignatura,	   t2.Jornada,	   SUM(t2.Costo) as Costo_Total,	   COUNT(t4.EstudiantesID) AS Total_EstudiantesFROM Area t1LEFT JOIN Asignaturas t2 ON t1.AreaID = t2.AreaLEFT JOIN Staff t3 ON t2.AsignaturasID = t3.AsignaturaLEFT JOIN Estudiantes t4 ON t3.DocentesID = t4.Docente GROUP BY t1.Nombre,         t2.Tipo,	     t2.JornadaORDER BY Costo_Total DESC

/*clase 9 - Ejercicio 1 - Indicadores para nivel tácticoAnálisis mensual de estudiantes por área: 
Identificar para cada área: el año y el mes (concatenados en formato YYYYMM), cantidad de estudiantes y monto total de las asignaturas. 
Ordenar por mes del más actual al más antiguo y por cantidad de clientes de mayor a menor.
*/


/*clase 9 - Ejercicio 2 - Indicadores para nivel tácticoAnálisis encargado tutores jornada noche: 
Identificar el nombre del encargado, el documento, el numero de la camada(solo el numero) y la fecha de ingreso del tutor.
Ordenar por camada de forma mayor a menor.
*/

/*clase 9 - Ejercicio 3 - Indicadores para nivel tácticoAnálisis asignaturas sin docentes o tutores: 
Identificar el tipo de asignatura, la jornada, la cantidad de áreas únicas y la cantidad total de asignaturas que no tienen asignadas docentes o tutores.
Ordenar por tipo de forma descendente.
*/

/*clase 9 - Ejercicio 4 - Indicadores para nivel tácticoAnálisis asignaturas mayor al promedio: 
Identificar el nombre de la asignatura, el costo de la asignatura y el promedio del costo de las asignaturas por área. 
Una vez obtenido el dato, del promedio se debe visualizar solo las carreras que se encuentran por encima del promedio. 
*/

/*clase 9 - Ejercicio 5 - Indicadores para nivel tácticoAnálisis aumento de salario docentes: 
Identificar el nombre, documento, el área, la asignatura y el aumento del salario del docente, este ultimo calcularlo sacándole un porcentaje al costo de la asignatura, todos las áreas tienen un porcentaje distinto, Marketing-17%, Diseño-20%, Programacion-23%, Producto-13%, Data-15%, Herramientas 8%
Nota: para el ejercicio 5, los dos indicadores deben encontrarse en el mismo reporte, identificar si es necesario unificar o reunir la consulta SQL.
*/