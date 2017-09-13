clear all
clc
% Trying to include data without knowing where its placed 

filename = ("FarmUID_6aee2a89-0592-4bd3-b25b-dcab5752cba9_HouseID_3.mat");
load(filename)

%Find all the temperature data and place it in batches in a struct 
for i = 1:length(batchData.SampleInterval_1_hours)
    if isempty(batchData.SampleInterval_1_hours{i}.TS)
        
    else    
        temp_data_place_tmp = find(cellfun(@(x) ~isempty(strfind(lower(x),'temperature_mean')), {batchData.SampleInterval_1_hours{i}.dataInfo.field}')');

        for j = 1:length(temp_data_place_tmp)
            if getfield(batchData.SampleInterval_1_hours{i}.dataInfo(temp_data_place_tmp(j)), 'field') == "Temperature_mean";
                temp_data_place = temp_data_place_tmp(j);
            end
        end

        temp.(['B', num2str(i)]) = batchData.SampleInterval_1_hours{i}.data(temp_data_place,:)';
    end
   
end

%Find all the weight data and place it in batches in a struct 
for i = 1:length(batchData.SampleInterval_1_hours)
    if isempty(batchData.SampleInterval_1_hours{i}.TS)
        
    else    
        weight_data_place_tmp = find(cellfun(@(x) ~isempty(strfind(lower(x),'broilerweight_c_mean')), {batchData.SampleInterval_1_hours{i}.dataInfo.field}')');

        for j = 1:length(weight_data_place_tmp)
            if getfield(batchData.SampleInterval_1_hours{i}.dataInfo(weight_data_place_tmp(j)), 'field') == "BroilerWeight_C_mean";
                weight_data_place = weight_data_place_tmp(j);
            end
        end

        weight.(['B', num2str(i)]) = batchData.SampleInterval_1_hours{i}.data(weight_data_place,:)';
    end
   
end


%Ploting data 

for i = 1:length(batchData.SampleInterval_1_hours)
    
    xlabel('Weight[Kg]')
    ylabel('Temperature[Degrees]')
    plot(weight.(['B', num2str(i)]),temp.(['B', num2str(i)]),'.')
    hold on
end