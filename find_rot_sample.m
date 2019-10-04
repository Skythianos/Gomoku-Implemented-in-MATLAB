%-------------------------------------------------------------------------
% FIELD: the (bigger) matrix, in which the sample will be searched
% FIELD_dimension: the size of FIELD
% B,A: coordinates of the square which must be part of the sample
%      (B row, A column)
% sample: a (smaller) matrix, which might be contained by the FIELD 
%-------------------------------------------------------------------------
% rot_found: 4x4 matrix, each row represents a direction, for one row:
%            1. value - 1 if found, 0 if not found
%            2-3. value - coordinates of the corner of the sample
%            4. value - direction of the match
%-------------------------------------------------------------------------
function rot_found=find_rot_sample(FIELD,FIELD_dimension,B,A,sample)

% Initialization of the return variable
rot_found=[0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];

% Checking the four different rotations of minta
for ii=0:1
    
    % 0°, 90°
    sample1=rot90(sample,-ii);
    found=find_sample(FIELD,FIELD_dimension,B,A,sample1);
    if(found(1)==1)
        rot_found(ii+1,:)=[1 found(2) found(3) ii+1];
    end
    
    % 45°, 135°
    sample2=rotate45(sample1);
    found=find_sample_diag(FIELD,FIELD_dimension,B,A,sample2,-(-1)^ii);
    if(found(1)==1)
        rot_found(ii+1+2,:)=[1 found(2) found(3) ii+1+2];    
    end

end