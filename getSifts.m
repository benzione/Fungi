function d = getSifts(I, iSize, iStep)

[k1,d1] = vl_dsift(I,'size', iSize, 'step', iStep);
% [k2,d2]=vl_dsift(I,'size', 8, 'step', 2);
% [k3,d3]=vl_dsift(I,'size', 12, 'step', 2);
%[k4,d4]=vl_dsift(I,'size', 12, 'step', 2);

% d=[d1,d2,d3];
d = d1;