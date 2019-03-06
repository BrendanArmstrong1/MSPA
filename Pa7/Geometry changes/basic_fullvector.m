% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
%rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125*8;        % grid size (horizontal)
dy = 0.0125*8;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

Nf = [];
ijtrack = [];
for ij=0.325:1:10
    rw = ij;
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                           rh,rw,side,dx,dy); 

% First consider the fundamental TE mode:

[Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');
Nf = [Nf,neff];
ijtrack = [ijtrack,ij];
fprintf(1,'neff = %.6f\n',neff);


for i=1:nmodes
    
    figure(1);
    subplot(121);
    plot(ijtrack,Nf)
    %contourmode(x,y,Hx(:,:,i));
    title('Neff vs. rw'); xlabel('rw'); ylabel('neff'); 
    %for v = edges, line(v{:}); end

    subplot(122);
    contourmode(x,y,Hy(:,:,i));
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
   
    % Next consider the fundamental TM mode
    % (same calculation, but with opposite symmetry)
end
pause(0.2)
end
%[Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000S');

%fprintf(1,'neff = %.6f\n',neff);
%for i=1:nmodes
    
    
 %   figure(2);
 %  subplot(121);
 %   contourmode(x,y,Hx(:,:,i));
 %   title('Hx (TM mode)'); xlabel('x'); ylabel('y'); 
 %   for v = edges, line(v{:}); end

 %   subplot(122);
 %   contourmode(x,y,Hy(:,:,i));
 %   title('Hy (TM mode)'); xlabel('x'); ylabel('y'); 
 %   for v = edges, line(v{:}); end
 %   pause(.5)
%end