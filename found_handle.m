%-------------------------------------------------------------------------
% win_number: how many stones in a row are needed to win
% rot_found: vector which contains the starting coordinates and the
%            direction of the sample which was found;
%            its first value is "1" if something was found and "0" if not
% B,A: coordinates of the last stone in the FIELD matrix (B row, A column)
% FIELD: the matrix, which represents the game field
%-------------------------------------------------------------------------
% sample_to_save: the new sample which will should be saved as the
%                 antecedent to the actual sample
%-------------------------------------------------------------------------
function sample_to_save=found_handle(win_number,rot_found,B,A,FIELD)

% Initialization of the return variable
sample_to_save=zeros(1,win_number);

% Reset the actual square of the FIELD to 8 = empty (so it will be stored as empty)
FIELD(B,A)=8;

% Simplify the rot_found vector (which is actually one row of the rot_found matrix
corner=[rot_found(2) rot_found(3)];
direction=rot_found(4);

% Put together the sample which should be stored
if(direction==1)
    sample_to_save=FIELD(corner(1),corner(2):corner(2)+(win_number-1));
end

if(direction==2)
    sample_to_save=FIELD(corner(1):corner(1)+(win_number-1),corner(2))';
end

if(direction==3)
    sample_to_save=diag(rot90(FIELD(corner(1):corner(1)+(win_number-1),corner(2):corner(2)+(win_number-1)),-1))';
end

if(direction==4)
    sample_to_save=diag(FIELD(corner(1):corner(1)+(win_number-1),corner(2):corner(2)+(win_number-1)))';
end





