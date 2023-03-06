addpath('VERSION ANTERIOR APIMO\');
addpath('VERSION ANTERIOR APIMO\API_MO');
addpath('src\');
SOFAstart;
addpath('VERSION ANTERIOR APIMO\HRTFs\SADIE\D1_HRIR_SOFA')
addpath('VERSION ANTERIOR APIMO\HRTFs\SADIE\D2_HRIR_SOFA')
addpath('VERSION ANTERIOR APIMO\HRTFs\SADIE\H3_HRIR_SOFA')
addpath('VERSION ANTERIOR APIMO\HRTFs\SADIE\H5_HRIR_SOFA')
addpath('VERSION ANTERIOR APIMO\HRTFs\SADIE\H7_HRIR_SOFA')
addpath('VERSION ANTERIOR APIMO\HRTFs\SADIE\H9_HRIR_SOFA')
addpath('VERSION ANTERIOR APIMO\HRTFs\SADIE\H11_HRIR_SOFA')
addpath('VERSION ANTERIOR APIMO\HRTFs\SADIE\H13_HRIR_SOFA')
addpath('VERSION ANTERIOR APIMO\HRTFs\SADIE\H15_HRIR_SOFA')
addpath('VERSION ANTERIOR APIMO\HRTFs\SADIE\H17_HRIR_SOFA')
addpath('VERSION ANTERIOR APIMO\HRTFs\SADIE\H19_HRIR_SOFA')

addpath('VERSION ANTERIOR APIMO\HRTFs\ARI')
addpath('VERSION ANTERIOR APIMO\HRTFs\CIPIC')

%% 
 Umbral = 0.1:0.01:0.6;
% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\SADIE\D2\','D2_44K_16bit_256tap_FIR_SOFA',Umbral);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hrtf1 = SOFAload('D1_44K_16bit_256tap_FIR_SOFA.sofa');
% hrtf1 = SOFAload('D2_44K_16bit_256tap_FIR_SOFA.sofa');
 hrtf1 = SOFAload('H3_44K_16bit_256tap_FIR_SOFA.sofa');
% %hrtf3 = SOFAload('H3_44K_16bit_256tap_FIR_SOFA2_0_30.sofa');
% %hrtf2 = SOFAload('H3_48K_24bit_256tap_FIR_SOFA.sofa');
 hrtf3 = SOFAload('H5_44K_16bit_256tap_FIR_SOFA.sofa');
% hrtf4 = SOFAload('H7_44K_16bit_256tap_FIR_SOFA.sofa');
% hrtf5 = SOFAload('H9_44K_16bit_256tap_FIR_SOFA.sofa');
% hrtf6 = SOFAload('H11_44K_16bit_256tap_FIR_SOFA.sofa');
% hrtf7 = SOFAload('H13_44K_16bit_256tap_FIR_SOFA.sofa');
% hrtf8 = SOFAload('H15_44K_16bit_256tap_FIR_SOFA.sofa');
% hrtf9 = SOFAload('H17_44K_16bit_256tap_FIR_SOFA.sofa');
% hrtf10 = SOFAload('H19_44K_16bit_256tap_FIR_SOFA.sofa');
%% 

% carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie D1');
%  for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf1,'C:\Users\Ludio\Desktop\Archivos ITD\D1', P);
%  end
% % 
% % carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\Sadie H3');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf2,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H3\H3_44K_16bit_256tap_FIR_SOFA', 0.3);
% end
% % 
% % carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H5');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf3,'C:\Users\Ludio\Desktop\Archivos ITD\H5', P);
% end
% % 
% % carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H7');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf4,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H7\H7_96K_24bit_512tap_FIR_SOFA', P);
% end
% % 
% % carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H9');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf5,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H9\H9_44K_16bit_256tap_FIR_SOFA', P);
% end
% % 
% % carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H11');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf6,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H11\H11_44K_16bit_256tap_FIR_SOFA', P);
% end
% % 
% % carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H13');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf7,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H13\H13_44K_16bit_256tap_FIR_SOFA', P);
% end
% % 
% % carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H15');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf8,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H15\H15_44K_16bit_256tap_FIR_SOFA', P);
% end
% % 
% % carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H17');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf9,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H17\H17_44K_16bit_256tap_FIR_SOFA', P);
% end
% % 
% % carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H19');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf10,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H19\H19_44K_16bit_256tap_FIR_SOFA', P);
% end

% Graficas_elevacion_0(hrtf1,'C:\Users\Ludio\Desktop\Archivos ITD\D1\','D1_44K_16bit_256tap_FIR_SOFA')
 Graficas_elevacion_0(hrtf1,'C:\Users\Ludio\Desktop\Archivos ITD\H5_1K\','H3_44K_16bit_256tap_FIR_SOFA')
% Graficas_elevacion_0(hrtf3,'C:\Users\Ludio\Desktop\Archivos ITD\H5_1K\','H5_44K_16bit_256tap_FIR_SOFA')
% Graficas_elevacion_0(hrtf4,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H7\','H7_44K_16bit_256tap_FIR_SOFA')
% Graficas_elevacion_0(hrtf5,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H9\','H9_44K_16bit_256tap_FIR_SOFA')
% Graficas_elevacion_0(hrtf6,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H11\','H11_44K_16bit_256tap_FIR_SOFA')
% Graficas_elevacion_0(hrtf7,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H13\','H13_44K_16bit_256tap_FIR_SOFA')
% Graficas_elevacion_0(hrtf8,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H15\','H15_44K_16bit_256tap_FIR_SOFA')
% Graficas_elevacion_0(hrtf9,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H17\','H17_44K_16bit_256tap_FIR_SOFA')
% Graficas_elevacion_0(hrtf10,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE\H19\','H19_44K_16bit_256tap_FIR_SOFA')

% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\D1\','D1_44K_16bit_256tap_FIR_SOFA',0.22);
% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\D1\','D1_44K_16bit_256tap_FIR_SOFA',0.44);
% 
% [ITDt2, ITDww2, TdiffITD2, bestUmbral2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\SADIE\H3\','H3_44K_16bit_256tap_FIR_SOFA',Umbral);
% [ITDt2, ITDww2, TdiffITD2, bestUmbral2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H3\','H3_44K_16bit_256tap_FIR_SOFA',0.45);
% [ITDt2, ITDww2, TdiffITD2, bestUmbral2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H3\','H3_44K_16bit_256tap_FIR_SOFA',0.3);
% 
% [ITDt3, ITDww3, TdiffITD3, bestUmbral3] = Function_MetodoUmbralYGraficas(hrtf3,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H5\','H5_48K_24bit_256tap_FIR_SOFA',0.43);
% [ITDt3, ITDww3, TdiffITD3, bestUmbral3] = Function_MetodoUmbralYGraficas(hrtf3,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H5\','H5_48K_24bit_256tap_FIR_SOFA',0.21);
% 
% [ITDt4, ITDww4, TdiffITD4, bestUmbral4] = Function_MetodoUmbralYGraficas(hrtf4,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H7\','H7_96K_24bit_512tap_FIR_SOFA',0.43);
% [ITDt4, ITDww4, TdiffITD4, bestUmbral4] = Function_MetodoUmbralYGraficas(hrtf4,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H7\','H7_96K_24bit_512tap_FIR_SOFA',0.19);

%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 hrtf1 = SOFAload('ARI_NH2_hrtf_M_dtf 256.sofa');
% hrtf2 = SOFAload('ARI_NH8_hrtf_M_dtf 256.sofa');
% hrtf3 = SOFAload('ARI_NH10_hrtf_M_dtf 256.sofa');
 hrtf4 = SOFAload('ARI_NH12_hrtf_M_dtf 256.sofa');
% hrtf5 = SOFAload('ARI_NH14_hrtf_M_dtf 256.sofa');
% hrtf6 = SOFAload('ARI_NH16_hrtf_M_dtf 256.sofa');
% hrtf7 = SOFAload('ARI_NH18_hrtf_M_dtf 256.sofa');
% hrtf8 = SOFAload('ARI_NH21_hrtf_M_dtf 256.sofa');
% hrtf9 = SOFAload('ARI_NH25_hrtf_M_dtf 256.sofa');
% hrtf10 = SOFAload('ARI_NH27_hrtf_M_dtf 256.sofa');
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf1,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH2\ARI_NH2_hrtf_M_dtf 256', P);
% end
 Graficas_elevacion_0(hrtf1,'C:\Users\Ludio\Desktop\Archivos ITD\NH2\','ARI_NH2_hrtf_M_dtf 256')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf2,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH8\ARI_NH8_hrtf_M_dtf 256', P);
% end
% Graficas_elevacion_0(hrtf2,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH8\','ARI_NH8_hrtf_M_dtf 256')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf3,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH10\ARI_NH10_hrtf_M_dtf 256', P);
% end
% Graficas_elevacion_0(hrtf3,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH10\','ARI_NH10_hrtf_M_dtf 256')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf4,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH12\ARI_NH12_hrtf_M_dtf 256', P);
% end
 Graficas_elevacion_0(hrtf4,'C:\Users\Ludio\Desktop\Archivos ITD\NH12\','ARI_NH12_hrtf_M_dtf 256')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf5,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH14\ARI_NH14_hrtf_M_dtf 256', P);
% end
% Graficas_elevacion_0(hrtf5,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH14\','ARI_NH14_hrtf_M_dtf 256')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf6,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH16\ARI_NH16_hrtf_M_dtf 256', P);
% end
% Graficas_elevacion_0(hrtf6,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH16\','ARI_NH16_hrtf_M_dtf 256')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf7,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH18\ARI_NH18_hrtf_M_dtf 256', P);
% end
% Graficas_elevacion_0(hrtf7,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH18\','ARI_NH18_hrtf_M_dtf 256')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf8,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH21\ARI_NH21_hrtf_M_dtf 256', P);
% end
% Graficas_elevacion_0(hrtf8,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH21\','ARI_NH21_hrtf_M_dtf 256')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf9,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH25\ARI_NH25_hrtf_M_dtf 256', P);
% end
% Graficas_elevacion_0(hrtf9,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH25\','ARI_NH25_hrtf_M_dtf 256')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf10,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH27\ARI_NH27_hrtf_M_dtf 256', P);
% end
% Graficas_elevacion_0(hrtf10,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\ARI\NH27\','ARI_NH27_hrtf_M_dtf 256')

%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 hrtf1 = SOFAload('CIPIC_subject_003_hrir_final.sofa');
% hrtf2 = SOFAload('CIPIC_subject_009_hrir_final.sofa');
% hrtf3 = SOFAload('CIPIC_subject_012_hrir_final.sofa');
 hrtf4 = SOFAload('CIPIC_subject_015_hrir_final.sofa');
% hrtf5 = SOFAload('CIPIC_subject_018_hrir_final.sofa');
% hrtf6 = SOFAload('CIPIC_subject_021_hrir_final.sofa');
% hrtf7 = SOFAload('CIPIC_subject_027_hrir_final.sofa');
% hrtf8 = SOFAload('CIPIC_subject_033_hrir_final.sofa');
% hrtf9 = SOFAload('CIPIC_subject_048_hrir_final.sofa');
% hrtf10 = SOFAload('CIPIC_subject_051_hrir_final.sofa');
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf1,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\003\CIPIC_subject_003_hrir_final', P);
% end
 Graficas_elevacion_0(hrtf1,'C:\Users\Ludio\Desktop\Archivos ITD\003\','CIPIC_subject_003_hrir_final')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf2,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\009\CIPIC_subject_009_hrir_final', P);
% end
% Graficas_elevacion_0(hrtf2,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\009\','CIPIC_subject_009_hrir_final')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf3,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\012\CIPIC_subject_012_hrir_final', P);
% end
% Graficas_elevacion_0(hrtf3,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\012\','CIPIC_subject_012_hrir_final')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf4,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\015\CIPIC_subject_015_hrir_final', P);
% end
 Graficas_elevacion_0(hrtf4,'C:\Users\Ludio\Desktop\Archivos ITD\015\','CIPIC_subject_015_hrir_final')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf5,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\018\CIPIC_subject_018_hrir_final', P);
% end
% Graficas_elevacion_0(hrtf5,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\018\','CIPIC_subject_018_hrir_final')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf6,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\021\CIPIC_subject_021_hrir_final', P);
% end
% Graficas_elevacion_0(hrtf6,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\021\','CIPIC_subject_021_hrir_final')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf7,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\027\CIPIC_subject_027_hrir_final', P);
% end
% Graficas_elevacion_0(hrtf7,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\027\','CIPIC_subject_027_hrir_final')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf8,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\033\CIPIC_subject_033_hrir_final', P);
% end
% Graficas_elevacion_0(hrtf8,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\033\','CIPIC_subject_033_hrir_final')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf9,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\048\CIPIC_subject_048_hrir_final', P);
% end
% Graficas_elevacion_0(hrtf9,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\048\','CIPIC_subject_048_hrir_final')
% 
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf10,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\051\CIPIC_subject_051_hrir_final', P);
% end
% Graficas_elevacion_0(hrtf10,'C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\CIPIC\051\','CIPIC_subject_051_hrir_final')

%% 

% % % % % % % %
%Umbral = 0.1:0.01:0.6;
% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\SADIE\D1\','D1_44K_16bit_256tap_FIR_SOFA',Umbral);
% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\D1\','D1_44K_16bit_256tap_FIR_SOFA',0.22);
% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\D1\','D1_44K_16bit_256tap_FIR_SOFA',0.44);
% porcAciertos1 = CalculoOutlayers(ITDt1,ITDww1(:,3));
% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = PruebaFrecorteyUmbral(hrtf1,'D1_44K_16bit_256tap_FIR_SOFA');

% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\SADIE\D2\','D2_44K_16bit_256tap_FIR_SOFA',Umbral);

%  [ITDt2, ITDww2, TdiffITD2, bestUmbral2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\SADIE\H3\','H3_44K_16bit_256tap_FIR_SOFA',Umbral);
% [ITDt2, ITDww2, TdiffITD2, bestUmbral2,hrtf2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H3\','H3_44K_16bit_256tap_FIR_SOFA',0.45);
% [ITDt2, ITDww2, TdiffITD2, bestUmbral2,hrtf2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H3\','H3_44K_16bit_256tap_FIR_SOFA',0.3);
% %porcAciertos2 = CalculoOutlayers(ITDt2,ITDww2(:,3));

%  [ITDt3, ITDww3, TdiffITD3, bestUmbral3] = Function_MetodoUmbralYGraficas(hrtf3,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\SADIE\H5\','H5_48K_24bit_256tap_FIR_SOFA',Umbral);
% [ITDt3, ITDww3, TdiffITD3, bestUmbral3] = Function_MetodoUmbralYGraficas(hrtf3,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H5\','H5_48K_24bit_256tap_FIR_SOFA',0.43);
% [ITDt3, ITDww3, TdiffITD3, bestUmbral3] = Function_MetodoUmbralYGraficas(hrtf3,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H5\','H5_48K_24bit_256tap_FIR_SOFA',0.21);
% % porcAciertos3 = CalculoOutlayers(ITDt3,ITDww3(:,3));

%  [ITDt4, ITDww4, TdiffITD4, bestUmbral4] = Function_MetodoUmbralYGraficas(hrtf4,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\SADIE\H7\','H7_96K_24bit_512tap_FIR_SOFA',Umbral);
% [ITDt4, ITDww4, TdiffITD4, bestUmbral4] = Function_MetodoUmbralYGraficas(hrtf4,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H7\','H7_96K_24bit_512tap_FIR_SOFA',0,43);
% [ITDt4, ITDww4, TdiffITD4, bestUmbral4] = Function_MetodoUmbralYGraficas(hrtf4,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H7\','H7_96K_24bit_512tap_FIR_SOFA',0.19);
% % porcAciertos4 = CalculoOutlayers(ITDt4,ITDww4(:,3));

% [ITDt5, ITDww5, TdiffITD5, bestUmbral5] = Function_MetodoUmbralYGraficas(hrtf5,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H9\','H9_44K_16bit_256tap_FIR_SOFA');
% % porcAciertos5 = CalculoOutlayers(ITDt5,ITDww5(:,3));
% [ITDt6, ITDww6, TdiffITD6, bestUmbral6] = Function_MetodoUmbralYGraficas(hrtf6,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H11\','H11_44K_16bit_256tap_FIR_SOFA');
% % porcAciertos6 = CalculoOutlayers(ITDt6,ITDww6(:,3));
% [ITDt7, ITDww7, TdiffITD7, bestUmbral7] = Function_MetodoUmbralYGraficas(hrtf7,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H13\','H13_44K_16bit_256tap_FIR_SOFA');
% % porcAciertos7 = CalculoOutlayers(ITDt7,ITDww7(:,3));
% [ITDt8, ITDww8, TdiffITD8, bestUmbral8] = Function_MetodoUmbralYGraficas(hrtf8,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H15\','H15_44K_16bit_256tap_FIR_SOFA');
% % porcAciertos8 = CalculoOutlayers(ITDt8,ITDww8(:,3));
% [ITDt9, ITDww9, TdiffITD9, bestUmbral9] = Function_MetodoUmbralYGraficas(hrtf9,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H17\','H17_44K_16bit_256tap_FIR_SOFA');
% % porcAciertos9 = CalculoOutlayers(ITDt9,ITDww9(:,3));
% [ITDt10, ITDw10, TdiffITD10, bestUmbral10] = Function_MetodoUmbralYGraficas(hrtf10,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\SADIE\H19\','H19_44K_16bit_256tap_FIR_SOFA');
%% 

%  carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie D1');
%  for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf1,'D1_44K_16bit_256tap_FIR_SOFA', P, carp);
%  end

% carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H3');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf2,'H3_44K_16bit_256tap_FIR_SOFA', P, carp);
% end
% 
% carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H5');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf3,'H5_48K_24bit_256tap_FIR_SOFA', P, carp);
% end
% 
% carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H7');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf4,'H7_96K_24bit_512tap_FIR_SOFA', P, carp);
% end
% 
% carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H9');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf5,'H9_44K_16bit_256tap_FIR_SOFA', P, carp);
% end
% 
% carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H11');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf6,'H11_44K_16bit_256tap_FIR_SOFA', P, carp);
% end
% 
% carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H13');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf7,'H13_44K_16bit_256tap_FIR_SOFA', P, carp);
% end
% 
% carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H15');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf8,'H15_44K_16bit_256tap_FIR_SOFA', P, carp);
% end
% 
% carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H17');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf9,'H17_44K_16bit_256tap_FIR_SOFA', P, carp);
% end
% 
% carp = uigetdir('C:\Users\Ludio\OneDrive - Universidad de Málaga\ITD\TFG David\Prueba 0 elevacion\SADIE', 'Sadie H19');
% for P=0.1:0.01:0.6
%     GuardarSofaConRetardos(hrtf10,'H19_44K_16bit_256tap_FIR_SOFA', P, carp);
% end
%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\ARI\NH2\','ARI_NH2_hrtf_M_dtf 256', Umbral);
%  [ITDt2, ITDww2, TdiffITD2, bestUmbral2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\ARI\NH8\','ARI_NH8_hrtf_M_dtf 256', Umbral);
%  [ITDt3, ITDww3, TdiffITD3, bestUmbral3] = Function_MetodoUmbralYGraficas(hrtf3,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\ARI\NH10\','ARI_NH10_hrtf_M_dtf 256', Umbral);
%  [ITDt4, ITDww4, TdiffITD4, bestUmbral4] = Function_MetodoUmbralYGraficas(hrtf4,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\ARI\NH12\','ARI_NH12_hrtf_M_dtf 256', Umbral);

% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\ARI\NH2\','ARI_NH2_hrtf_M_dtf 256', 0.1);
% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\ARI\NH2\','ARI_NH2_hrtf_M_dtf 256', 0.3);
%[ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\ARI\NH2\','ARI_NH2_hrtf_M_dtf 256', 0.6);

% [ITDt2, ITDww2, TdiffITD2, bestUmbral2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\ARI\NH8\','ARI_NH8_hrtf_M_dtf 256', 0.1);
% [ITDt2, ITDww2, TdiffITD2, bestUmbral2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\ARI\NH8\','ARI_NH8_hrtf_M_dtf 256', 0.3);
% [ITDt2, ITDww2, TdiffITD2, bestUmbral2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\ARI\NH8\','ARI_NH8_hrtf_M_dtf 256', 0.6);
% 
% [ITDt3, ITDww3, TdiffITD3, bestUmbral3] = Function_MetodoUmbralYGraficas(hrtf3,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\ARI\NH10\','ARI_NH10_hrtf_M_dtf 256', 0.1);
% [ITDt3, ITDww3, TdiffITD3, bestUmbral3] = Function_MetodoUmbralYGraficas(hrtf3,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\ARI\NH10\','ARI_NH10_hrtf_M_dtf 256', 0.3);
% [ITDt3, ITDww3, TdiffITD3, bestUmbral3] = Function_MetodoUmbralYGraficas(hrtf3,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\ARI\NH10\','ARI_NH10_hrtf_M_dtf 256', 0.6);
% 
% [ITDt4, ITDww4, TdiffITD4, bestUmbral4] = Function_MetodoUmbralYGraficas(hrtf4,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\ARI\NH12\','ARI_NH12_hrtf_M_dtf 256', 0.1);
% [ITDt4, ITDww4, TdiffITD4, bestUmbral4] = Function_MetodoUmbralYGraficas(hrtf4,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\ARI\NH12\','ARI_NH12_hrtf_M_dtf 256', 0.3);
% [ITDt4, ITDww4, TdiffITD4, bestUmbral4] = Function_MetodoUmbralYGraficas(hrtf4,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\ARI\NH12\','ARI_NH12_hrtf_M_dtf 256', 0.6);


% % % [ITDt5, ITDww5, TdiffITD5, bestUmbral5] = Function_MetodoUmbralYGraficas(hrtf5,'ARI_NH14_hrtf_M_dtf 256');
% % % [ITDt6, ITDww6, TdiffITD6, bestUmbral6] = Function_MetodoUmbralYGraficas(hrtf6,'ARI_NH16_hrtf_M_dtf 256');
% % % [ITDt7, ITDww7, TdiffITD7, bestUmbral7] = Function_MetodoUmbralYGraficas(hrtf7,'ARI_NH18_hrtf_M_dtf 256');
% % % [ITDt8, ITDww8, TdiffITD8, bestUmbral8] = Function_MetodoUmbralYGraficas(hrtf8,'ARI_NH21_hrtf_M_dtf 256');
% % % [ITDt9, ITDww9, TdiffITD9, bestUmbral9] = Function_MetodoUmbralYGraficas(hrtf9,'ARI_NH25_hrtf_M_dtf 256');
% % % [ITDt10, ITDw10, TdiffITD10, bestUmbral10] = Function_MetodoUmbralYGraficas(hrtf10,'ARI_NH27_hrtf_M_dtf 256');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 

%hrtf1 = SOFAload('CIPIC_subject_003_hrir_final.sofa');
% hrtf2 = SOFAload('CIPIC_subject_009_hrir_final.sofa');
% hrtf3 = SOFAload('CIPIC_subject_012_hrir_final.sofa');
%hrtf4 = SOFAload('CIPIC_subject_015_hrir_final.sofa');
% hrtf5 = SOFAload('CIPIC_subject_018_hrir_final.sofa');
% hrtf6 = SOFAload('CIPIC_subject_021_hrir_final.sofa');
% hrtf7 = SOFAload('CIPIC_subject_027_hrir_final.sofa');
% hrtf8 = SOFAload('CIPIC_subject_033_hrir_final.sofa');
% hrtf9 = SOFAload('CIPIC_subject_048_hrir_final.sofa');
% hrtf10 = SOFAload('CIPIC_subject_051_hrir_final.sofa');

% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\CIPIC\003\','CIPIC_subject_003_hrir_final', Umbral);
% [ITDt2, ITDww2, TdiffITD2, bestUmbral2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\CIPIC\009\','CIPIC_subject_009_hrir_final', Umbral);
% [ITDt3, ITDww3, TdiffITD3, bestUmbral3] = Function_MetodoUmbralYGraficas(hrtf3,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\CIPIC\012\','CIPIC_subject_012_hrir_final', Umbral);
% [ITDt4, ITDww4, TdiffITD4, bestUmbral4] = Function_MetodoUmbralYGraficas(hrtf4,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Umbrales\CIPIC\015\','CIPIC_subject_015_hrir_final', Umbral);


% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\CIPIC\003\','CIPIC_subject_003_hrir_final', 0.15);
% [ITDt1, ITDww1, TdiffITD1, bestUmbral1] = Function_MetodoUmbralYGraficas(hrtf1,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\CIPIC\003\','CIPIC_subject_003_hrir_final', 0.45);

% [ITDt2, ITDww2, TdiffITD2, bestUmbral2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\CIPIC\009\','CIPIC_subject_009_hrir_final', 0.3);
% [ITDt2, ITDww2, TdiffITD2, bestUmbral2] = Function_MetodoUmbralYGraficas(hrtf2,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\CIPIC\009\','CIPIC_subject_009_hrir_final', 0.55);
% 
% [ITDt3, ITDww3, TdiffITD3, bestUmbral3] = Function_MetodoUmbralYGraficas(hrtf3,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\CIPIC\012\','CIPIC_subject_012_hrir_final', 0.3);
% [ITDt3, ITDww3, TdiffITD3, bestUmbral3] = Function_MetodoUmbralYGraficas(hrtf3,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\CIPIC\012\','CIPIC_subject_012_hrir_final', 0.55);

% [ITDt4, ITDww4, TdiffITD4, bestUmbral4] = Function_MetodoUmbralYGraficas(hrtf4,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\CIPIC\015\','CIPIC_subject_015_hrir_final', 0.15);
% [ITDt4, ITDww4, TdiffITD4, bestUmbral4] = Function_MetodoUmbralYGraficas(hrtf4,'C:\Users\Ludio\Desktop\TFG\Imagenes ITDs\Umbral\Filtro Butterworth\Frec Corte\CIPIC\015\','CIPIC_subject_015_hrir_final', 0.45);

% % % [ITDt5, ITDww5, TdiffITD5, bestUmbral5] = Function_MetodoUmbralYGraficas(hrtf5,'CIPIC_subject_018_hrir_final');
% % % [ITDt6, ITDww6, TdiffITD6, bestUmbral6] = Function_MetodoUmbralYGraficas(hrtf6,'CIPIC_subject_021_hrir_final');
% % % [ITDt7, ITDww7, TdiffITD7, bestUmbral7] = Function_MetodoUmbralYGraficas(hrtf7,'CIPIC_subject_027_hrir_final');
% % % [ITDt8, ITDww8, TdiffITD8, bestUmbral8] = Function_MetodoUmbralYGraficas(hrtf8,'CIPIC_subject_033_hrir_final');
% % % [ITDt9, ITDww9, TdiffITD9, bestUmbral9] = Function_MetodoUmbralYGraficas(hrtf9,'CIPIC_subject_048_hrir_final');
% % % [ITDt10, ITDw10, TdiffITD10, bestUmbral10] = Function_MetodoUmbralYGraficas(hrtf10,'CIPIC_subject_051_hrir_final');
% % % % % % % %%
%% 
% ITDww1 = hrtf1.SourcePosition;
% for x = 1:length(hrtf1.SourcePosition(:,1))
%     ITDt1(x) =Threshold(hrtf1,hrtf1.SourcePosition(x,1), hrtf1.SourcePosition(x,2));
%     ITDww1(x,3) = ITDw(0.088,343.2,deg2rad(hrtf1.SourcePosition(x,1)),hrtf1.SourcePosition(x,2));
% end
%
% carp = uigetdir('C:\Users\Ludio\Desktop\TFG\Imagenes ITDs',"D1_44K_16bit_256tap_FIR_SOFA");
% carp2 = uigetdir('C:\Users\Ludio\Desktop\TFG\Imagenes ITDs', "D1_44K_16bit_256tap_FIR_SOFA archivo figura");

% rtograd = a * 180/pi;
% figure
% surf(rtograd,b,T','EdgeColor',"none",'EdgeColor',"#0072BD",'FaceAlpha',1); ylabel('Elevacion'); xlabel('Azimut');
% txt = ("D1_44K_16bit_256tap_FIR_SOFA 2 Umbral= 0.3");
% title(txt,'Interpreter','none');
% hold on;
% Reordenar(ITDww1(:,1),ITDww1(:,2),abs(ITDt1'));
% fig = gcf;
% txt2 = [carp2+"\"+txt];
% txt =[carp+"\"+txt];
% savefig(txt2+'.fig');
% saveas(fig,txt+'.jpg');
% hold off;
% %    -----------------------------------------------------------------------
% figure
% txt = ("D1_44K_16bit_256tap_FIR_SOFA 2 Umbral= 0.3");
% m = unique(ITDww1(:,1));
% n = unique(ITDww1(:,2));
% datos = nan(length(m),length(n));

%
% for p = 1:length(ITDt1)
%     datos(m==ITDww1(p,1),n==ITDww1(p,2)) = abs(ITDt1(p));
% end
% surf(m',n',datos'); ylabel('Elevacion'); xlabel('Azimut');
% title(txt,'Interpreter','none');
% fig = gcf;
% txt2 = [carp2+"\"+txt];
% txt =[carp+"\"+txt];
% savefig(txt2+'.fig');
% saveas(fig,txt+'.jpg');
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ITDww2 = hrtf2.SourcePosition;
% for x = 1:length(hrtf2.SourcePosition(:,1))
%     ITDt2(x) = Threshold(hrtf2,hrtf2.SourcePosition(x,1), hrtf2.SourcePosition(x,2));
%     ITDww2(x,3) = ITDw(0.088,343.2,deg2rad(hrtf2.SourcePosition(x,1)),hrtf2.SourcePosition(x,2));
% end
%
% carp = uigetdir('C:\Users\Ludio\Desktop\TFG\Imagenes ITDs',"H3_44K_16bit_256tap_FIR_SOFA");
% carp2 = uigetdir('C:\Users\Ludio\Desktop\TFG\Imagenes ITDs', "H3_44K_16bit_256tap_FIR_SOFA archivo figura");
%
% figure
% surf(rtograd,b,T','EdgeColor',"none",'EdgeColor',"#0072BD",'FaceAlpha',1); ylabel('Elevacion'); xlabel('Azimut');
% txt = ("H3_44K_16bit_256tap_FIR_SOFA 2 Umbral= 0.3");
% title(txt,'Interpreter','none');
% hold on;
% Reordenar(ITDww2(:,1),ITDww2(:,2),abs(ITDt2'));
% fig = gcf;
% txt2 = [carp2+"\"+txt];
% txt =[carp+"\"+txt];
% savefig(txt2+'.fig');
% saveas(fig,txt+'.jpg');
% hold off;
% %    -----------------------------------------------------------------------
% figure
% txt = ("H3_44K_16bit_256tap_FIR_SOFA 2 Umbral= 0.3");
% m = unique(ITDww2(:,1));
% n = unique(ITDww2(:,2));
% datos = nan(length(m),length(n));
% for p = 1:length(ITDt2)
%     datos(m==ITDww2(p,1),n==ITDww2(p,2)) = abs(ITDt2(p));
% end
% surf(m',n',datos'); ylabel('Elevacion'); xlabel('Azimut');
% title(txt,'Interpreter','none');
% fig = gcf;
% txt2 = [carp2+"\"+txt];
% txt =[carp+"\"+txt];
% savefig(txt2+'.fig');
% saveas(fig,txt+'.jpg');

% diffITD1 = []; diffITD2 = []; diffITD3 = []; diffITD4 = [];
% format long;
% [nr1,nc1] = size(ITDt1); [nr2,nc2] = size(ITDt2); [nr3,nc3] = size(ITDt3); [nr4,nc4] = size(ITDt4);
% diffITD1(nr1,nc1) = 0; diffITD2(nr2,nc2) = 0; diffITD3(nr3,nc3) = 0; diffITD4(nr4,nc4) = 0; %#ok<NASGU>
%
% diffITD1 = abs(ITDt1 - ITDww1(:,3));
% diffITD2 = abs(ITDt2 - ITDww2(:,3));
% diffITD3 = abs(ITDt3 - ITDww3(:,3));
% diffITD4 = abs(ITDt4 - ITDww4(:,3));
%
% SUM1(length(nc1)) = 0; SUM2(length(nc2)) = 0; SUM3(length(nc3)) = 0; SUM4(length(nc4)) = 0;
% BU = [];
% for i = 1:nc1
%     SUM1(i) = sum(diffITD1(:,i));
% end
% for i = 1:nc2
%     SUM2(i) = sum(diffITD2(:,i));
% end
% for i = 1:nc3
%     SUM3(i) = sum(diffITD3(:,i));
% end
% for i = 1:nc4
%     SUM4(i) = sum(diffITD4(:,i));
% end
%
%  BU(1) = Umbral_41(SUM1==min(SUM1));
%  BU(2) = Umbral_41(SUM2==min(SUM2));
%  BU(3) = Umbral_41(SUM3==min(SUM3));
%  BU(4) = Umbral_41(SUM4==min(SUM4)) %#ok<NOPTS>