create or replace package body app_setting as

--------------------------------------------------------------------------------
--
-- Copyright (c) 1999 - 2020. All Rights Reserved.
--
-- This package will handle the /src/data/settings.json file
--
-- 
--------------------------------------------------------------------------------

procedure populate_settings
is
    l_b bfile := bfilename('src/data/','settings.json');
    l_c clob;
begin

    dbms_lob.open(l_b);
    dbms_lob.createtemporary(l_c,true);
  
    dbms_lob.loadfromfile(l_c,l_b,dbms_lob.getlength(l_b));
    dbms_output.put_line(l_c);
    -- insert into t values (c);
    -- commit;
    dbms_lob.freetemporary(l_c);

  
end populate_settings;

end app_setting;
/