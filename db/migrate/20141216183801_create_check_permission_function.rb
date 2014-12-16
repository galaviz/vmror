class CreateCheckPermissionFunction < ActiveRecord::Migration
  def up
    execute "
    CREATE OR REPLACE FUNCTION permissions(pProfile_id integer DEFAULT 0, pAction varchar(100) DEFAULT '', OUT UserPermission bigint , OUT ActionPermission bigint , OUT Permission integer )
      RETURNS setof record AS
    $BODY$BEGIN
            return query SELECT 
                    CASE WHEN SUM(CASE WHEN (ProfilePrivilege IS NULL) THEN 0 ELSE 1 END) IS NULL THEN 0 ELSE SUM(CASE WHEN (ProfilePrivilege IS NULL) THEN 0 ELSE 1 END)END AS UserPermission,
                    CASE WHEN COUNT(ac.id) IS NULL THEN 0 ELSE COUNT(ac.id) END ActionPermission,
                    CASE WHEN (SELECT EXISTS(SELECT 1 FROM actions WHERE command = pAction)) THEN CASE WHEN SUM(everyPermission)>=1 THEN 1 ELSE CASE WHEN (CASE WHEN SUM(CASE WHEN (ProfilePrivilege IS NULL) THEN 0 ELSE 1 END) IS NULL THEN 0 ELSE SUM(CASE WHEN (ProfilePrivilege IS NULL) THEN 0 ELSE 1 END) END)= CASE WHEN SUM(1) IS NULL THEN 0 ELSE SUM(1) END THEN 1 ElSE 0 END END ELSE 0 END AS Permission
                    
            FROM 
                    action_permissions ac
            LEFT JOIN 
                    actions a ON a.ID=ac.action_id
            LEFT JOIN 
                    (
                            SELECT permission_id AS ProfilePrivilege 
                            FROM profile_permissions 
                            WHERE active = true AND profile_id = pProfile_id
                    ) AS pp ON pp.ProfilePrivilege = ac.permission_id
    
            LEFT JOIN 
                    (
                            SELECT COUNT(p.id) AS everyPermission 
                            FROM permissions p LEFT JOIN profile_permissions pp2 ON pp2.permission_id=p.ID 
                            WHERE p.command='fullAccess' AND pp2.profile_id = pProfile_id
                    ) TFA ON 1=1
            WHERE 
                    a.command = pAction
                    AND 
                    ac.active = true;
    END;$BODY$
      LANGUAGE plpgsql VOLATILE
      COST 100;
    ALTER FUNCTION permissions(integer, varchar)
      OWNER TO postgres;"
  end

  def down
    execute "DROP FUNCTION IF EXISTS permissions(integer, varchar)"
  end
end
