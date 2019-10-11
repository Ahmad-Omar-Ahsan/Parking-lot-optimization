%enumerated type denoting licences of vehicles
enum VEHICLES;

%Time of day in question;
enum ToD = {DAY, NIGHT};

% variable to store time of day;
ToD: time;

% variable defining number of rows of the parking lot;
int:n;
set of int: ROW = 1..n;

%variable defining number of columns of the parking lot;
int: m;
set of int: COL = 1..m;

%a 2d array which has information on the maintenance cost of the parking lot;
array[ROW, COL] of int: cost;

%different types of vehicles each is a subset of the VEHICLE set;
set of VEHICLES: sedans;
set of VEHICLES: trucks;
set of VEHICLES: bikes;

%decision variable which will provide us with the row and column numbers of each vehicle;
array[VEHICLES] of var ROW: r;
array[VEHICLES] of var COL: c;

%constraint which prevents two vehicles from occupying the same spot; 
constraint forall(v1,v2 in VEHICLES where v1<v2)
(abs(r[v1] - r[v2])+ abs(c[v1]-c[v2]) > 0);
%constraint which prevents surrounding spots to be occupied around a truck;
constraint forall(v in VEHICLES, t in trucks where v != t)
(abs(r[v] - r[t]) + abs(c[v]-c[t]) > 1);

%constraint which prevents the next spot to be occupied beside a sedan;
constraint forall(v in VEHICLES, s in sedans where v != s)
(abs(c[v] - c[s]) > 1);

%during the day time trucks are positioned on the upper portion of the parking lot;
constraint if time = DAY then
 forall(t in trucks)(r[t] <= (n+1) div 2) endif;
 
 %during night time trucks are positioned on the lower portion of the parking lot;
constraint if time = NIGHT then
forall(s in sedans)(r[s] <= (n+1) div 2) endif;

%the aim is to find an arrangement which will have the least amount of maintenance cost;
var int: totalCost = sum(v in VEHICLES)(cost[r[v],c[v]]);
solve minimize totalCost;

  
output["Total cost:$",show(totalCost) , "\n" ,"Vehicles: ",show(VEHICLES),"\n","Row number of vehicles:", show(r) ,"\n","Column number of vehicles", show(c)];
