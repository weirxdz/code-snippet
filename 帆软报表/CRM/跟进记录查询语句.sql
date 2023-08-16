begin 
	declare @resellerid int;
	declare @deptid int;
	select @resellerid = fcu.RESELLERID  from FR_CRM_USERS fcu where fcu.ccode = '${fine_username}';
	select @deptid = fcu.DEPTID  from FR_CRM_USERS fcu where fcu.ccode = '${fine_username}';
	
	SELECT @resellerid,@deptid,LEN(@resellerid),LEN(@deptid),P.projectno ,P.ProjectName ,P.Billdate 报备日期,p.ProprietorName 业主名称,p.DesigningInstitute 设计院名称,p.CoveredArea 建筑面积,p.PiperNnum 风管数量,p.EstimatedFieldTime 预计到场时间,isnull(f.maxDate,P.Billdate) 最近跟进日期,f.maxID 最近跟进ID, D.cname 销售部门,R.cname  经销商,PS.cname  最新阶段,X.follewdetails 跟进详情,U1.cname 跟进提交人,datediff(day,isnull(f.maxDate,P.Billdate),CONVERT(varchar(100), GETDATE(), 23)) diffdays
	FROM FR_CRM_PROJECT_SUBMIT P 
	LEFT JOIN (select t.projectno ,MAX(t.dDate) maxDate ,max(t.ID) maxID
							from FR_CRM_PROJECT_FOLLOWUP t
							group by t.projectno) F ON P.projectno = F.projectno
	LEFT JOIN FR_CRM_USERS U ON P.UserID = U.ID 
	LEFT JOIN FR_CRM_PROJECT_FOLLOWUP X ON f.maxID = X.ID 
	LEFT JOIN FR_CRM_DEPT D ON  X.saledeptid = D.ID 
	LEFT JOIN FR_CRM_RESELLER R ON X.RESELLERID = R.ID 
	LEFT JOIN FR_CRM_PROJECT_STAGES PS ON  X.project_stagesID = PS.ID 
	LEFT JOIN FR_CRM_USERS U1 ON X.userID = U1.ID 
	WHERE 
	(u.RESELLERID = @resellerid and LEN(@resellerid) <> 0
		or u.DEPTID = @deptid and LEN(@deptid) <> 0 and @resellerid is null)
		AND	P.DR = 0 
	and P.approve_status = 1
	order by P.projectno desc,x.ID
	
end