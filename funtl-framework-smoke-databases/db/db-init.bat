@echo off
rem /**
rem  * Copyright &copy; 2015-2016 ����Ҽ������ All rights reserved.
rem  *
rem  * Author: ������
rem  */
echo.
echo [��Ϣ] �ؽ��������ݿⲢ�����ʼ���ݡ�
echo.
pause
echo.
echo [��Ϣ] �˲���������������ݱ�����ݣ����ָ���ʼ״̬��
echo.
echo [��Ϣ] ȷ�ϼ����𣿷�����رմ��ڡ�
echo.
pause
echo.
echo [��Ϣ] �����ȷ�ϼ����𣿷�����رմ��ڡ�
echo.
pause
echo.

cd %~dp0
cd ..

call mvn clean antrun:run -Pinit-db -e

cd db
pause