%_________________________________________________________________________________
%  Barnacles Algorithm source codes version 1.0
%
%  Developed in MATLAB R2014a
%
%  Author and programmer: Dr. Mohd Herwan Sulaiman
%
%         e-Mail: mherwan@ieee.org
%                 herwan@ump.edu.my
%
%       Homepage: http://ee.ump.edu.my/herwan
%
%   Main paper:
%   
%   This program is using the framework of GOA invented by Mirjalili
%   http://www.alimirjalili.com/GOA.html
%   
%____________________________________________________________________________________

%  
%function [TargetFitness,TargetPosition,Convergence_curve,Trajectories,fitness_history, position_history]=BMO(N,pl, Max_iter, lb,ub, dim, fobj)
function[bestSolution, bestFitness, iteration] = BMO(k, dimension, maxFEs, dataset,dataLabels, testData, testDataLabels, dictionary)

dim=dimension;
pl=7;
N=30;


ub=1;
lb=0;

tic
disp('BMO Algorithm is now estimating the global optimum of the problem....')

flag=0;
if size(ub,1)==1
    ub=ones(dim,1)*ub;
    lb=ones(dim,1)*lb;
end

if (rem(dim,2)~=0) % this algorithm should be run with a even number of variables. This line is to handle odd number of variables
    dim = dim+1;
    ub = [ub; 100];
    lb = [lb; -100];
    flag=1;
end

%Initialize the population of barnacles
BarnaclesPositions=initialization(N,dim,ub,lb);
BarnaclesFitness = zeros(1,N);  
B_Fitness  =  zeros(1,N);
fitness_history=zeros(N,maxFEs);
%position_history=zeros(N,Max_iter,dim);
position_history=zeros(N,dim,maxFEs);
Convergence_curve=zeros(1,maxFEs);
Trajectories=zeros(N,maxFEs);


%Calculate the fitness of initial barnacles
FE=0;
for i=1:size(BarnaclesPositions,1)
    if flag == 1
        BarnaclesFitness(1,i)= testFunction(k, dataset, dataLabels, testData, testDataLabels, BarnaclesPositions(i,1:end-1), dictionary);%fobj(BarnaclesPositions(i,1:end-1));
    else
        BarnaclesFitness(1,i)= testFunction(k, dataset, dataLabels, testData, testDataLabels, BarnaclesPositions(i,:)', dictionary);%fobj(BarnaclesPositions(i,:));

    end
    FE=FE +1;
    fitness_history(i,1)=BarnaclesFitness(1,i);
    %position_history(i,1,:)=BarnaclesPositions(i,:);
    position_history(i,:,1)=BarnaclesPositions(i,:);
    Trajectories(:,1)=BarnaclesPositions(:,1);
end
BarnaclesPositions;
BarnaclesFitness;
[sorted_fitness,sorted_indexes]=sort(BarnaclesFitness);

% Find the best barnacle in the first population 
for newindex=1:N
    Sorted_barnacle(newindex,:)=BarnaclesPositions(sorted_indexes(newindex),:);
end
BarnaclesPositions=Sorted_barnacle;
BarnaclesFitness=sorted_fitness;
TargetPosition=Sorted_barnacle(1,:);
WorstPosition=Sorted_barnacle(N,:);
TargetFitness=sorted_fitness(1);
WorstFitness=sorted_fitness(N);
Convergence_curve(1)=TargetFitness;
% Main loop
 % Start from the second iteration since the first iteration was dedicated to calculating the fitness of barnacle
while FE<maxFEs
    
      
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Start Barnacles Algorithm
    
     % Selection (barnacle find the mating by using its penis to neighbor
     % using similar with DE
     k1 = randperm(N);
     k2 = randperm(N);
     
     k1x= BarnaclesPositions(k1,:);
     k2x= BarnaclesPositions(k2,:);
     
     select =[k1' k2']; % nak cari yang <7
     kurang_7 = abs(select(:,1)-select(:,2));
     id_over7 = find((kurang_7)>pl) ;% if more than 7 the barnacle will not mating
     id_same = find((kurang_7)==0); % if 0 means self mating or spermcast
     
     S_i=zeros(size(BarnaclesPositions,1),dim); % S_i = pop x var
     temp1=zeros(size(BarnaclesPositions,1),dim);
     temp2=zeros(size(BarnaclesPositions,1),dim);
     
     for kk=1:size(BarnaclesPositions,1) % 1 : N
     
         for kkk=1:size(BarnaclesPositions,2)
             
             p=randn(); %p eqn 11

             temp1(kk,kkk)=p*k1x(kk,kkk);
             temp2(kk,kkk)=(1-p)*k2x(kk,kkk); %q=1-p  eqn 12
             S_i(kk,kkk)=((temp1(kk,kkk)+temp2(kk,kkk)));
         end
     end
    X_new = S_i;
    id_same;
    
     if id_over7~=0
         for k=1:size(id_over7,1)
             X_temp3(k,:)=k2x(id_over7(k),:);
             X_temp3(k,:)=(rand().*X_temp3(k,:)')';
             X_new(id_over7(k),:)=X_temp3(k,:);
         end
     end

     BarnaclesPositions_temp=X_new  ;% offspring yang terhasil
     
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BarnaclesPositions

    Barnaclesoffspring=BarnaclesPositions_temp ;
    
    % concatenate 
    Barnaclescolony= [BarnaclesPositions;Barnaclesoffspring];
    
    
    for i=1:size(Barnaclescolony,1)
        % Relocate barnacles that go outside the search space 
        %Tp=Barnaclescolony(i,:)>ub';
        %Tm=Barnaclescolony(i,:)<lb';
        Barnaclescolony(i,:)= BoundaryControl(Barnaclescolony(i,:), lb,ub);%(Barnaclescolony(i,:).*(~(Tp+Tm)))+ub'.*Tp+lb'.*Tm;
  
        % Calculating the objective values for all barnacles
        if flag == 1
            BarnaclesFitness(1,i)=testFunction(k, dataset, dataLabels, testData, testDataLabels, Barnaclescolony(i,1:end-1)', dictionary);%fobj(Barnaclescolony(i,1:end-1));
        else
            BarnaclesFitness(1,i)= testFunction(k, dataset, dataLabels, testData, testDataLabels, Barnaclescolony(i,:)', dictionary);%testFunction(Barnaclescolony(i,:)', fhd, fNumber);%fobj(Barnaclescolony(i,:));
        end
        FE = FE + 1;
    end        
   
    % sorting
    
    [sorted_fitness,sorted_indexes]=sort(BarnaclesFitness);
    
        for newindex=1:N*2
            Sorted_barnacle(newindex,:)=Barnaclescolony(sorted_indexes(newindex),:);
        end

        %select the best top N
    %    Sorted_barnacle
        BarnaclesPositions=Sorted_barnacle(1:N,:);
        SortfitbestN = sorted_fitness(1:N);
        
     
        fitness_history(:,FE)=SortfitbestN';
        %position_history(:,l,:)=BarnaclesPositions
        position_history(:,:,FE)=BarnaclesPositions;
        %Update the target

         
        if SortfitbestN(1)<TargetFitness
            TargetPosition=BarnaclesPositions(1,:);
            %TargetFitness=BarnaclesFitness(1,i);
            TargetFitness=SortfitbestN(1);
        end
        %end
%    TargetFitness=sorted_fitnesscomb(1)    ;
    Convergence_curve(FE)=TargetFitness;
    %disp(['In iteration #', num2str(l), ' , target''s objective = ', num2str(TargetFitness)])
    
    
end


if (flag==1)
    TargetPosition = TargetPosition(1:dim-1);
end
bestSolution = TargetPosition;
bestFitness = TargetFitness;
iteration = FE;
time=toc


function pop=BoundaryControl(pop,low,up)
[popsize,dim]=size(pop);
for i=1:popsize
    for j=1:dim                
        k=rand<rand; % you can change boundary-control strategy
        if pop(i,j)<low(j), if k, pop(i,j)=low(j); else pop(i,j)=rand*(up(j)-low(j))+low(j); end, end        
        if pop(i,j)>up(j),  if k, pop(i,j)=up(j);  else pop(i,j)=rand*(up(j)-low(j))+low(j); end, end        
    end
end
return