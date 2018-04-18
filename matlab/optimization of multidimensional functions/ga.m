function ga(n, individuals, generation)

   NIND = individuals;           
   MAXGEN = generation;        
   NVAR = n;   
   PRECI = 10;
       
% Get boundaries of objective function
   FieldDR = rotatedHyperEllipsoid([], 1, n);

% Create population
   Chrom = crtbp(NIND, NVAR*PRECI);

% Reset count variables
   gen = 0;
   Best = NaN*ones(MAXGEN,1);
  
% Build matrix for bs2rv   
    FieldDD = [ 
        rep([PRECI],[1, NVAR]); FieldDR; 
        rep([1; 0; 1 ;1], [1, NVAR])
    ];

   while gen < MAXGEN,

   % Calculate objective function for population
      ObjV = rotatedHyperEllipsoid(bs2rv(Chrom, FieldDD), 3, n);

   % Draw plot for best case   
      Best(gen+1) = min(ObjV); 
      plot(Best);
      xlabel('Generation') 
      ylabel('Object function') 
      title(['Axis parallel hyper-ellipsoid function, n = ' num2str(NVAR) ', generations = ' num2str(MAXGEN) ', individuals = ' num2str(NIND) '.']);
      drawnow;

   % Make steps of genetic alghoritm
      FitnV = ranking(ObjV);
      SelCh = select(Chrom, FitnV);
      SelCh = recombin(SelCh);
      SelCh = mutate(SelCh);
      Chrom = reins(Chrom, SelCh);
      gen=gen+1;
      
   end
end


function ObjVal = rotatedHyperEllipsoid(Chrom, rtn_type, n)

   Dim = n;
   [Nind,Nvar] = size(Chrom);

   if Nind == 0
      % return text of title for graphic output
      if rtn_type == 2
         ObjVal = ['Rotated Hyper-Ellipsoid 1b-' int2str(Dim)];
      % evaluate fucntion
      elseif rtn_type == 3
         ObjVal = 0;
      % define size of boundary-matrix and values
      else         
         ObjVal = [-65.536; 65.536];
         ObjVal = ObjVal(1:2,ones(Dim,1));
      end
   % if Dim variables, compute values of function
   elseif Nvar == Dim
      ObjVal = sum(cumsum(Chrom').^2)';
   else
      error('size of matrix Chrom is not correct');
   end
end


% Utils functions

function MatOut = rep(MatIn,REPN)
    % Get size of input matrix
       [N_D,N_L] = size(MatIn);

    % Calculate
       Ind_D = rem(0:REPN(1)*N_D-1,N_D) + 1;
       Ind_L = rem(0:REPN(2)*N_L-1,N_L) + 1;

    % Create output matrix
       MatOut = MatIn(Ind_D,Ind_L);
end



