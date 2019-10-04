%-------------------------------------------------------------------------
% FIELD: the matrix, which represents the game field
% n: cycle counter of the game
%-------------------------------------------------------------------------
% AUTO_PUT: a vector of two elements, which are the coordinates of a
%           randomly chosen empty square of the FIELD
%-------------------------------------------------------------------------
function [AUTO_PUT]=put_random(FIELD,n)

% Looks up the empty (value=8) elements of the FIELD matrix
[ii,jj]=find(FIELD==8);

% Randomly chooses a pair of coordinates
A=jj(ceil(n*rand)); % column
B=ii(ceil(n*rand)); % row

% Returns the chosen values on the outpot
AUTO_PUT=[A B];
