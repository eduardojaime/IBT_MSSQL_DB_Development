-- select * from examples.ElectronicGadget

ALTER VIEW Examples.ElectronicGadget
AS
	SELECT GadgetId, GadgetNumber, GadgetType,
	UPPER(GadgetType) AS UpperGadgetType
	FROM Examples.Gadget
	WHERE GadgetType = 'Electronic'
-- PREVENTS INSERTING OR UPDATING DATA
WITH CHECK OPTION;
GO

INSERT INTO Examples.ElectronicGadget (GadgetId, GadgetNumber, GadgetType)
VALUES (6,'00000006' ,'Manual')

UPDATE Examples.ElectronicGadget
SET GadgetType = 'Manual'
WHERE GadgetId = '00000004'