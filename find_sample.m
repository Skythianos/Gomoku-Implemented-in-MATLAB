%-------------------------------------------------------------------------
% FIELD: the (bigger) matrix, in which the sample will be searched
% FIELD_dimension: the size of FIELD
% B,A: coordinates of the square which must be part of the sample
%      (B row, A column)
% sample: a (smaller) matrix, which might be contained by the FIELD 
%-------------------------------------------------------------------------
% found: a vector of 3 elements
%            1. value - 1 if found, 0 if not found
%            2-3. value - coordinates of the corner of the sample
%-------------------------------------------------------------------------
function found=find_sample(FIELD,FIELD_dimension,B,A,sample)

% Initialization of the cycle counters
ii=0;
jj=0;

% Initialization of the return variable
found=[0 0 0];

% Getting the dimensions of the sample matrix
[sample_rows sample_columns]=size(sample);

% Initialization  of the diffmat matrix, which records the differences
% between the FIELD matrix and the sample matrix
diffmat=ones(sample_rows,sample_columns);


% For different B (bb)-...
for bb=B:-1:B-(sample_rows-1)

    % (If reaching the edge of FIELD, stop)
    if(bb<1)
        break;
    else

        % ...-A (aa) pairs:
        for aa=A:-1:A-(sample_columns-1)

            % (If reaching the edge of FIELD, stop)
            if(aa<1)
                break;
            else
                
                % If, with the actual B-A (bb-aa) combination, the sample fits the
                % FIELD
                if(bb+sample_rows-1<=FIELD_dimension && aa+sample_columns-1<=FIELD_dimension)
                    
                    % Takes the part of FIELD, which has to be compared
                    FIELD_PART=FIELD(bb:bb+sample_rows-1,aa:aa+sample_columns-1);
                    
                    % Where matching the sample, the value of diffmat is
                    % zero
                    diffmat=(FIELD_PART-sample).*sample;
                    
                    % If each element of diffmat is zero
                    if(sum(abs(diffmat(:)))==0)
                        
                        % There is a complete match, set found
                        found=[1 bb aa];
                        break;
                        
                    end
                    
                end
                                
            end
            
        end
        
    end
    
end