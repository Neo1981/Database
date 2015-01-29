select a.MeetingNumber as 'Meeting #',a.Name as 'Meeting Name',a.StartDate,a.EndDate,a.MeetingPlanningGroups,
(g.firstname+' '+g.lastname) as 'Web Expert',replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(a.Status,1,'Requested'),2,'Qualifying'),3,'Planning'),4,'Execution'),5,'Reconciliation'),6,'Measure'),7,'Closed'),8,'Postponed'),9,'Cancelled'),10,'Void') as 'Meeting Status',a.TotalAttendeesEstimate as 'Attendees Estimate',replace(replace(replace(replace(replace(replace(replace(a.WebSiteStatus,0,'Unknown'),1,'Pending'),2,'Building'),3,'Under Review'),4,'Live'),5,'Closed'),6,'Cancelled') as 'Website Status',a.WebSiteDraftDate as '1st Draft',a.WebSiteGoLiveDate as 'Live Date',
w.Name as 'Form Name',w.Attendees,
('https://meetingsandevents.jpmorganchase.com/Metron/forms/MeetingFormFiller.aspx?id='+(convert(nvarchar(50),w.FormID))) as 'Dot Com', ('https://meetingsandevents-int.jpmchase.net/Metron/forms/MeetingFormFiller.aspx?id='+(convert(nvarchar(50),w.FormID))) as 'Internal link'

from MeetingsReportView a  
left join Meetings e on e.meetingid=a.MeetingID  
left join Teams f on f.MeetingID=a.MeetingID and (f.Roles & 33554432 = 33554432) and Not(f.Roles & 1048576 = 1048576) 
left join Resources g on g.ResourceID=f.ResourceID  
left join FormsView w on w.MeetingID=a.MeetingID

where a.StartDate>='2014-01-01' and a.StartDate<='2015-12-31'  
and a.Name not like '%test%' and a.status!=6 and a.status!=10 and 
a.status!=9 and a.status!=9  and g.firstname!='' and a.WebSiteStatus!=6 
and w.Published=1

order by StartDate asc 
