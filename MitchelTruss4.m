% Static force analysis of 2D TBar (Fig 3.3 of Skelton & de Oliviera 2009)
% By Thomas Bewley, UC San Diego (+ faculty fellow at JPL)
clear; clf; figure(1);

% Free [Q=Q_(dim x q)] and fixed [Q=Q_(dim x q)] node locations
dim=2;
a=sin(pi/6)/sin(pi/6+pi/8);
corner=zeros(5,1);
corner(1)=1;
for i=2:5
    corner(i)=corner(1)*a^(i-1);
end
Q=[];
for i=0:4 %set up free and fixed nodes
    for k=0:4-i
        theta=(i-k)*pi/8;
        r=corner(i+k+1);
        if i+k==4
            P(:,i+1)=[r*cos(theta);r*sin(theta)];
        else
            Q(:,end+1)=[r*cos(theta);r*sin(theta)];
        end
    end
end
q=size(Q,2);p=size(P,2);n=q+p;
% Connectivity matrix
C(  1,4)=1; C(  1,11)=-1;       % bars 
C(  2,1)=1; C(  2,2)=-1;
C(  3,2)=1; C(  3,3)=-1;
C(  4,3)=1; C(  4,4)=-1;
C(  5,7)=1; C(  5,12)=-1; b=10;
C(  6,5)=1; C(  6,6)=-1;       % bars 
C(  7,6)=1; C(  7,7)=-1;
C(  8,9)=1; C(  8,13)=-1;
C(  9,8)=1; C(  9,9)=-1;
C(  10,10)=1; C(  10,14)=-1; b=10;
C(b+1,15)=1; C(b+1,10)=-1;       % strings 
C(b+2,1)=1; C(b+2,5)=-1;    
C(b+3,5)=1; C(b+3,8)=-1;    
C(b+4,8)=1; C(b+4,10)=-1;    
C(b+5,14)=1; C(b+5,9)=-1;    
C(b+6,2)=1; C(b+6,6)=-1;    
C(b+7,6)=1; C(b+7,9)=-1;    
C(b+8,13)=1; C(b+8,7)=-1;    
C(b+9,3)=1; C(b+9,7)=-1; s=10;
C(b+10,12)=1; C(b+10,4)=-1; s=10;

U(1:dim,1:q)=0; %external force
U(1:dim,1)=[1;-1];
[c_bars,t_strings,V]=tensegrity_statics(b,s,q,p,dim,Q,P,C,U)
tensegrity_plot(Q,P,C,b,s,U,V,true,1.0); grid on;