# EDNASS2
EDNASS 2
http://channel9.msdn.com/Series/Customizing-ASPNET-Authentication-with-Identity/02

identity customise database 从5分49秒


DKK 17-Apr-2015 1:17

Using NuGet without committing packages to source control
1. Open VS2013
2. Options -> Package Manager -> General
3. Enable "Allow NuGet to download missing packages during build"
4. Right click on the Solution node in Solution Explorer and select Enable NuGet Package Restore.
5. Build

按照上面设置并且编译后，NuGet会自动下载缺少的package。如果编译后所需package还是没有自动下载，就先去packages目录删除对应的子目录（moq的目录,nunit的目录,asppose.barcode的目录），然后再编译。

layout
http://www.asp.net/web-pages/overview/ui,-layouts,-and-themes/3-creating-a-consistent-look

DKK 18-May-2015:

新建数据库LocalDB，位置\EDNASS2\LocalDB\LocalDB.mdf。
访问该数据库需要在Visual Studio的Server Explorer的Data Connections中手动添加数据库文件。
其中MedicationType，DistributionCentre已有测试数据，MedicationPackage为空。
另已有用户：
agent1@enetcare.com -- Head Office
agent2@enetcare.com -- Liverpool
doctor1@enetcare.com -- Liverpool
doctor2@enetcare.com -- Glebe
doctor3@enetcare.com -- Ultimo
doctor4@enetcare.com -- Bondi
manager1@enetcare.com -- Head Office
密码：!Qq123

