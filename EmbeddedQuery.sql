select a.Name,a.MeetingNumber,replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(a.Status,1,'Requested'),2,'Qualifying'),3,'Planning'),4,'Execution'),5,'Reconciliation'),6,'Measure'),7,'Closed'),8,'Postponed'),9,'Cancelled'),10,'Void') as Status,replace(replace(a.CancellationFees,0,'No'),1,'Yes') as CancellationFees,c.Name as Type,a.StartDate,a.EndDate,replace(replace(replace(replace(replace(replace(replace(replace(replace (b.Frequency,0,'MISSING'),1,'One-off'),2,'Annual'),3,'Semi-Annual'),4,'Quarterly'),5,'Monthly'),6,'Weekly'),7,'Daily'),99,'Other') as Frequency,a.MeetingPlanningGroups,f.Name as ServiceLevel,a.MeetingGeographicUnit,a.MeetingOrganizationalUnit,replace(replace(b.RequirePaymentCards,0,'No'),1,'Yes') as RequirePaymentCards,

isnull( ( select h2.CardNumber + ';' as [data()]  
from MeetingPaymentCards h1 join PaymentCards h2 on h2.PaymentCardID=h1.PaymentCardID 
where h1.MeetingID=a.MeetingID   for XML Path ('')  ) , 'None') as PaymentCards,

replace(replace(replace(a.Site,1,'Internal'),2,'External'),0,'MISSING') as Site,replace(replace(replace(a.AudienceType,0,'MISSING'),1,'Internal'),2,'External') as AudienceType,g.Name as TravelMethod,replace(replace(b.TravelProviderSystemsReady,0,'No'),1,'Yes') as TravelSystemsReady,h.Name as RegistrationTool,replace(replace(replace(replace(a.Site,1,'Internal'),2,'External'),3,'Both'),0,'Unknown') as Site,a.MeetingCountryCode,a.MeetingStateCode,a.MeetingCity,a.Venue,i.Name as VenueType,b.AirportCountryCode,b.AirportStateCode,b.AirportCity,b.AirportCode,a.LeadPlanners,a.Planners,a.WebDesign,a.ProductionCoordinator,a.Registration,isnull( ( select a2.Name + ';' as [data()]  from MeetingFacilities a2 where a2.MeetingID=a.MeetingID   for XML Path ('')  ) , 'None') as Facilities 
from MeetingsReportView a 
join Meetings b on a.MeetingID=b.meetingID 
left join StandardNames c on c.StandardNameID=a.TypeID 
left join StandardNames d on d.StandardNameID=b.SubTypeID 
left join StandardNames e on e.StandardNameID=a.PlanningEffortID
 left join StandardNames f on a.ServiceLevelID=f.StandardNameID 
 left join StandardNames g on g.StandardNameID=a.TravelMethodID 
 left join StandardNames h on h.StandardNameID=a.RegistrationTool
  left join StandardNames i on i.StandardNameID=b.VenueTypeID 
  where a.startdate>='2015-01-01' and a.StartDate<='2015-12-31' 
  and a.status!=6 and a.status!=9  and a.status!=10 and a.Name not like '%test%' 
  and a.MeetingPlanningGroups like '%Midwest%'

