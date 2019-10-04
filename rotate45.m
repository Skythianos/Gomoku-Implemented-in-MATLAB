%-------------------------------------------------------------------------
% MATRIX: a matrix, which will be rotated by 45°
%-------------------------------------------------------------------------
% rotated: MATRIX rotated by 45°, extra unused elements of rotated are
%          set to zero
%-------------------------------------------------------------------------
function rotated=rotate45(MATRIX)

% Measuring the size of the MATRIX matrix
[number_of_rows number_of_columns]=size(MATRIX);

% Preparing a matrix with the size of the future rotated matrix (full 0)
rotated=zeros(number_of_rows+number_of_columns-1);

% Filling up the right positions with the right values
for ii=0:number_of_rows-1
    for jj=0:number_of_columns-1
       rotated(number_of_columns+ii-jj,ii+jj+1)=MATRIX(ii+1,jj+1);
    end
end
