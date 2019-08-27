enum vehicle = {Truck, Car, Bus, Motorcycle};
% size of vehicle 
array[1..2, vehicle] of int: size;
% money charged for each type of vehicle;
array[vehicle] of int: money;
% decision array depicting how many cars would be required;
array[vehicle] of var int: num_of_vehicles;
%parking lot space designated for parking;
int: space;

%the total area for each vehicle should be less than or equal to the designated parking area space;
constraint sum(i in vehicle)(size[1,i]*size[2,i]*num_of_vehicles[i])<=space; 
%negative number of vehicles should not exist;
constraint forall(i in vehicle)(num_of_vehicles[i] >= 0);

%maximising the total profit;
solve maximize sum(i in vehicle)(money[i]*num_of_vehicles[i]);

output["Profit = ", show(sum(i in vehicle)(money[i]*num_of_vehicles[i])), "\n", show(num_of_vehicles), "\n"];
