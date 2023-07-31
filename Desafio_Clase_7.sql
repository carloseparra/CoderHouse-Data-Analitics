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
