GRANT SELECT, INSERT, UPDATE, DELETE ON c_type, condominium, c_owner, repair TO condominium_role;
    
GRANT USAGE, SELECT, UPDATE ON c_type_id_seq TO condominium_role;
GRANT USAGE, SELECT, UPDATE ON condominium_id_seq TO condominium_role;
GRANT USAGE, SELECT, UPDATE ON c_owner_id_seq TO condominium_role;
GRANT USAGE, SELECT, UPDATE ON repair_id_seq TO condominium_role;