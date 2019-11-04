% Static force analysis of 2D TBar (Fig 3.3 of Skelton & de Oliviera 2009)
% By Thomas Bewley, UC San Diego (+ faculty fellow at JPL)
clear; clf; figure(1);

% Free [Q=Q_(dim x q)] and fixed [Q=Q_(dim x q)] node locations:
r=1;dim=3;
Q=[];P=[];
for i=1:4
    Q(1:dim,i)=[r*cos(pi/2*(i-1));r*sin(pi/2*(i-1));0];
    Q(1:dim,i+4)=[r*cos(pi/2*(i)+pi/4);r*sin(pi/2*(i)+pi/4);h];
end
q=size(Q,2);p=size(P,2);
n=p+q;

% Connectivity matrix
C(  1,1)=1; C(  1,5)=-1;       % bars 
C(  2,2)=1; C(  2,6)=-1;
C(  3,3)=1; C(  3,7)=-1;
C(  4,4)=1; C(  4,8)=-1;bb=10;b=4
C(  5,1)=1; C(  5,2)=-1; 
C(  6,2)=1; C(  6,3)=-1;       % bars 
C(  7,3)=1; C(  7,4)=-1;
C(  8,4)=1; C(  8,1)=-1;
C(  9,5)=1; C(  9,6)=-1;
C(  10,6)=1; C(  10,7)=-1;
C(bb+1,7)=1; C(bb+1,8)=-1;       % strings 
C(bb+2,8)=1; C(bb+2,5)=-1;    
C(bb+3,1)=1; C(bb+3,8)=-1;    
C(bb+4,2)=1; C(bb+4,5)=-1;    
C(bb+5,2)=1; C(bb+5,6)=-1;    
C(bb+6,4)=1; C(bb+6,7)=-1;    
C(bb+7,6)=1; C(bb+7,4)=-1;    
C(bb+8,7)=1; C(bb+8,1)=-1;    
C(bb+9,8)=1; C(bb+9,2)=-1;
C(bb+10,5)=1; C(bb+10,3)=-1; s=16;

U(1:dim,1:q)=0; %external force
for i=1:4
   U(1:dim,i)=[0;0;-1];
end
for i=5:8
    U(1:dim,i)=[0;0;1];
end
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U)
tensegrity_plot(Q,P,C,b,s,U,V,true,1.0); grid on;