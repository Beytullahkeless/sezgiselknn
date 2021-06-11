%_________________________________________________________________________________
%  Barnacles Algorithm source codes version 1.0
%
%  Developed in MATLAB R2012a
%
%  Author and programmer: Dr. Mohd Herwan Sulaiman
%
%         e-Mail: mherwan@ieee.org
%                 herwan@ump.edu.my
%
%       Homepage: http://ee.ump.edu.my/herwan/research/bmo
%
%   Main paper:
%   
%   This program is using the framework of GOA invented by Mirjalili
%   http://www.alimirjalili.com/GOA.html
%____________________________________________________________________________________


% This function initialize the first population of search agents
function Positions=initialization(SearchAgents_no,dim,ub,lb)

Boundary_no= size(ub,1); % number of boundaries

% If the boundaries of all variables are equal and user enter a single
% number for both ub and lb
if Boundary_no==1
    Positions=rand(SearchAgents_no,dim).*(ub-lb)+lb;
end

% If each variable has a different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        Positions(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;
    end
end