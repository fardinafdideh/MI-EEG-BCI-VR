if C(ii)==1 && L_scl<L_scl_max %left hand enlarging
    L_scl=L_scl+(L_scl_max-L_scl_min)/stretch;
    setfield(object_nodes(9),'scale',L_scl*ones(1,3));pause(eps)%Left_Hand_Scale_Rot(.77-->1.6)
elseif (C(ii)==2  || C(ii)==3) && R_scl<R_scl_max  %right hand enlarging
    R_scl=R_scl+(R_scl_max-R_scl_min)/stretch;
    setfield(object_nodes(7),'scale',R_scl*ones(1,3));pause(eps)%Left_Hand_Scale_Rot(.77-->1.6)
end
vrdrawnow