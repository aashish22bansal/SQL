CREATE SCHEMA AUTHORIZATION EXPERIMENT
    CREATE TABLE Experiment.new_product (color VARCHAR2(10)  PRIMARY KEY, quantity NUMBER) 
    CREATE VIEW Experiment.new_product_view 
      AS SELECT color, quantity FROM Experiment.new_product WHERE color = 'RED' 
   GRANT select ON Experiment.new_product_view TO Experiment_READ_ROLE
;