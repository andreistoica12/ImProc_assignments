function H=highPassButterworthFilter(D0,n,M,N)
rfloor = floor(M/2); rceil = ceil(M/2); % midpoint along rows
cfloor = floor(N/2); cceil = ceil(N/2); % midpoint along columns
u = -rfloor:rceil-1; % centered vector along rows
v = -cfloor:cceil-1; % centered vector along columns
[V,U] = meshgrid(v,u); % mesh of size M x N
D = ((U).^2 + (V).^2).^(1/2);
H = 1./(1 + ((D0./D).^(2*n)));
end

