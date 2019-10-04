%-------------------------------------------------------------------------
% FIELD: the matrix, which represents the game field
% FIELD_dimension: the size of the game field
% samples: a cell array which stores the samples and their degrees;
%          the first column stores the samples,
%          the second column stores the degrees
%-------------------------------------------------------------------------
% FIELD_2: the copy of FIELD, with the empty squares labelled according
%          to their degree of "degree"
%-------------------------------------------------------------------------
function FIELD_2=evaluate(FIELD,FIELD_dimension,samples)

% Looks up the empty squares of the FIELD
[yy xx]=find(FIELD==8);

% Creates a copy of the FIELD
FIELD_2=FIELD;

% For every empty square
for nn=1:size(yy)
    
    % In all four directions
    for direction=1:4
        
        % For all the stored samples
        for ii=1:size(samples,1)
            
            % Virtually puts the stone of the player to whom the actual
            % sample belongs on the actual square
            FIELD(yy(nn),xx(nn))=min(samples{ii,1});
            
            % In direction 1 (-)
            if(direction==1)
                 
                % Prepare the sample
                sample=samples{ii,1};
                
                % Check if the sample is found
                found=find_sample(FIELD,FIELD_dimension,yy(nn),xx(nn),sample);
                
                % If the sample is found, adds the degree of the actual
                % sample to the actual square in FIELD_2
                if(found(1)==1)
                    FIELD_2(yy(nn),xx(nn))=FIELD_2(yy(nn),xx(nn))+samples{ii,2}+(samples{ii,2}/5)*mod(min(samples{ii,1}),2);
                end
                
            end

            % In direction 2 (|)
            if(direction==2)

                % Prepare the sample
                sample=samples{ii,1};
                sample=rot90(sample,-1);

                % Check if the sample is found
                found=find_sample(FIELD,FIELD_dimension,yy(nn),xx(nn),sample);

                % If the sample is found, adds the degree of the actual
                % sample to the actual square in FIELD_2
                if(found(1)==1)
                    FIELD_2(yy(nn),xx(nn))=FIELD_2(yy(nn),xx(nn))+samples{ii,2}+(samples{ii,2}/5)*mod(min(samples{ii,1}),2);
                end

            end

            % In direction 3 (/ in matrix, \ in GUI)
            if(direction==3)

                % Prepare the sample
                sample=samples{ii,1};
                sample=rotate45(sample);

                % Check if the sample is found
                found=find_sample_diag(FIELD,FIELD_dimension,yy(nn),xx(nn),sample,-1);

                % If the sample is found, adds the degree of the actual
                % sample to the actual square in FIELD_2
                if(found(1)==1)
                    FIELD_2(yy(nn),xx(nn))=FIELD_2(yy(nn),xx(nn))+samples{ii,2}+(samples{ii,2}/5)*mod(min(samples{ii,1}),2);
                end

            end

            % In direction 4 (\ in matrix, / in GUI)
            if(direction==4)
                
                % Prepare the sample
                sample=samples{ii,1};
                sample=rot90(sample,-1);
                sample=rotate45(sample);

                % Check if the sample is found
                found=find_sample_diag(FIELD,FIELD_dimension,yy(nn),xx(nn),sample,1);

                % If the sample is found, adds the degree of the actual
                % sample to the actual square in FIELD_2
                if(found(1)==1)
                    FIELD_2(yy(nn),xx(nn))=FIELD_2(yy(nn),xx(nn))+samples{ii,2}+(samples{ii,2}/5)*mod(min(samples{ii,1}),2);
                end

            end

        end

    end

    % Reset the (virtually) changed square of FIELD to its original value
    % (8 = empty)
    FIELD(yy(nn),xx(nn))=8;

end
            
            
            
            