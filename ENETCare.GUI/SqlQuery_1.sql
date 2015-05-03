﻿DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'ENETCare.Presentation.Models.ApplicationDbContext'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '201503291217362_InitialCreate'
BEGIN
    CREATE TABLE [dbo].[AspNetRoles] (
        [Id] [nvarchar](128) NOT NULL,
        [Name] [nvarchar](256) NOT NULL,
        CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY ([Id])
    )
    CREATE UNIQUE INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]([Name])
    CREATE TABLE [dbo].[AspNetUserRoles] (
        [UserId] [nvarchar](128) NOT NULL,
        [RoleId] [nvarchar](128) NOT NULL,
        CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId])
    )
    CREATE INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]([UserId])
    CREATE INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]([RoleId])
    CREATE TABLE [dbo].[AspNetUsers] (
        [Id] [nvarchar](128) NOT NULL,
        [Email] [nvarchar](256),
        [EmailConfirmed] [bit] NOT NULL,
        [PasswordHash] [nvarchar](max),
        [SecurityStamp] [nvarchar](max),
        [PhoneNumber] [nvarchar](max),
        [PhoneNumberConfirmed] [bit] NOT NULL,
        [TwoFactorEnabled] [bit] NOT NULL,
        [LockoutEndDateUtc] [datetime],
        [LockoutEnabled] [bit] NOT NULL,
        [AccessFailedCount] [int] NOT NULL,
        [UserName] [nvarchar](256) NOT NULL,
        CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY ([Id])
    )
    CREATE UNIQUE INDEX [UserNameIndex] ON [dbo].[AspNetUsers]([UserName])
    CREATE TABLE [dbo].[AspNetUserClaims] (
        [Id] [int] NOT NULL IDENTITY,
        [UserId] [nvarchar](128) NOT NULL,
        [ClaimType] [nvarchar](max),
        [ClaimValue] [nvarchar](max),
        CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY ([Id])
    )
    CREATE INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]([UserId])
    CREATE TABLE [dbo].[AspNetUserLogins] (
        [LoginProvider] [nvarchar](128) NOT NULL,
        [ProviderKey] [nvarchar](128) NOT NULL,
        [UserId] [nvarchar](128) NOT NULL,
        CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey], [UserId])
    )
    CREATE INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]([UserId])
    ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[AspNetUserClaims] ADD CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
    ALTER TABLE [dbo].[AspNetUserLogins] ADD CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201503291217362_InitialCreate', N'ENETCare.Presentation.Models.ApplicationDbContext',  0x1F8B0800000000000400DD5DDB6EE338127D5F60FF41D0D3EE2263E7B2DDE80DEC19A4ED6436D84ED268A707FBD6A025DA115AA23C129549B0982F9B87FDA4FD852DEA2E5E24EA62CBDD18A011F17258552C92C56295E77F7FFC77F6D38BE71ACF38081D9FCCCDB3C9A9696062F9B643B67333A29B1FDE993FFDF8E73FCDAE6DEFC5F8256B77C1DA414F12CECD274A7797D369683D610F8513CFB1023FF4377462F9DE14D9FEF4FCF4F41FD3B3B329060813B00C63F62922D4F170FC019F0B9F58784723E4DEF93676C3B41C6A5631AA718F3C1CEE9085E7E6F5FDF5E3020578F231C021261451A06892F4338D2BD74140D30ABB1BD34084F849FDE5E710AF68E093ED6A0705C87D7CDD6168B7416E88534E2E8BE6BA4C9D9E33A6A645C70CCA8A42EA7B2D01CF2E52294DF9EE9D646DE65204395E83BCE92BE33A96E5DCBCB5715CF4C9774100FC80970B37608DE7E65D3EC455B8BBC77492759C24903701C0FDE6075F2765C41343BBDF49AE55E79353F6DF89B1885C1A05784E704403E49E181FA3B5EB58FFC2AF8FFE574CE61767EBCDC5BB376F917DF1F6EFF8E24D9953E015DA550AA0E863E0EF7000B4E14DCEBF694CABFDA67CC7BC5BA94F2215D0255820A671875E3E60B2A54FB074CEDF99C68DF382EDAC2455AECFC481F5049D6810C1E77DE4BA68EDE2BC7E5A3B26FBB766D4F3376F0719F51E3D3BDB78EAB9F161E104B0AE3E6137AE0D9F9C5DB2BC2AF3FD256D7613F81EFBAEEA5752FB65E54781C598F1954D1E51B0C5B44ADD6C5A28AF964A33A8E1D53A433D7ED566948AEA2D6DCA18EAB212B2210EBD1A327AF73BAEB6C65DED763079B16A3189D4295CDDB135E1704E0C69EB429DCE74D589009BDFF3EEC8A445EA7748F8536BE4FA813EA23084255DC7E23003DD80000EC2D1B5871C77809345631430EF364EE0E15C7AEF7D58C788B49EEE6C16FE89C2A7BD0B6885AD2880F5BEA2C8DBED5FC19E7C82EF236FCDB691C38D35D8D43CFEE6DF208BFAC13561BD7AE37DF0ADAF7E44AF89BD44147FA65606C83E1F1D4F1F601072AE2C0B87E10D2833B6173EDC5E32C05B422FCE3BED5B635B760B17399EDCB4E3CEA32F59D3C2BC93B7104C3C453399995747EAD2094140EB88552DE0380CB016D9B26E6A16C4D68DEC48BAB465ED83BF7588DE2C644DD52C242D1AC94E9BB5259581E9519AB654131A3768A4336935D89D2056BEE12F0531ECF1DF0AFA9974AA6DAE24C6156CFEF8674C70003BB4FD11510AB65931033A5BE21826643C7D6CD0BD1FBBF148BF20371A7A28EDD520DB1035AE2CEFA3D02170FC4DC4FEC555E590B7936507555E1E4E951B4EF661B4E9CAB6E16E181EC6581C4B61CBFB6C7C6A0DBF7DC7B0C7BF7DC76442F1B363B31B82866F276B0CF05AEDE56EA3E695C55176E8FDBBC2E618FE87F1FC515761E85B4EBC0A245EFDD4275BA51FEE5346B38336E18677F20263A0E80EB3D1A004783379A57A204BEC628A8D2B2B79F558A0D042B6284660C86E415866024A082B9CBD55E2FE268C099A8E03D6093187041C64C821545C160EB19C1D721BA5C4F5D4B4B918EFF9187CCD12EF306103364A426770B96F9711908FC34D4A938466D392C6D52BA2E206A99AF3A6EB6431EF82CBF5203AD9708F55E8657AE1D88B62D64BEC00CA592F121D0294EF146328A8C434D655863AC781B6E28A6AD16A408926CA8CFDEA98A793C9197FD2741660EA9DD0E58177551CDB0AE77C248A159EDAA40759E155898DB0C2AB22F9E65678E294D29D7FCE43756CEA59758D1DDE2EAA15D708BA5991C791A96662BC431F0A3D7020AAE772CD2AF10B95DC6E81CEF4821BA677055E4518F80AD3AA93B6B830480D79E1A8A982F04A540758285A03681A222200090BAA0571D9C3442D75A919D6002B1E97325CD9A1DA82DECC855F4B6F7AA870B025E512B1CB3138A586EA481D5EEBB5EE853967B99A09AB47EB1A57C291681ABF2B5619D7108AEAF54A148CCE2DA5CD3DA5C4583A1935026AB8532884943133B894649ADD2CB126B3B9ABE1DC4B9235F6710957BAE007176BB6E29B452933A0DB98D0BD44C699BB0AE5CB98195C4AE9D26F1692C4886B61C6F51251D5E41A680FCB5C7BB97590D7CDA649EC735A309B2A82A4677768B773C8B614349D9618AB24627AF1C3AA7D00B197604CAD5012479C539B8F44FD006D31570B4303A5374E10D225A2688D986373617B4233A92DA43855B321CBE68E3889D9F19AB5667FA71149758178152B49342353B41BE0D563B668FC4E24D10479778385B32317059257D685EF461E519BC6EADEC96353B97F522222CCA61CFD82E92BC84DB8A05427416B8AC4E531F874E53668F7295343A8049FDD20CAA257DD2AD4289997B68CA2F2DC8E36852A9BB1E3B4F1167FFB596B44D8CF5A2BC24DF949278A35A7422AE249CB4845A93E5211305A462A4AF591D288D0324C5AD412A31454288095EADA4B2B89FB94492CA9D147E4823BCB905C550B2ACB219C1522CB159DF0141295B7D01F410CDA2CA38BB5FAC892F0CD32B4A4BA03B68466BE4E1F5512E159069654B7DB37C473BA283D9A8D5E72D3DCCB619DB864FA9DD60A8CFDEDFCFD0FFB52AC5919A854DC122B8D2613C0D2F2A3D12BD95D7B30C56AF6416868960E8852B5969C6A09F16975BDF50D78E5D69585825536ACACB0E5812339618E489124DE88BD6C50890FB6DF06A5C0501F6B9538AAEAA9561BFC5533A3E5E0A8CABCD60587A9F1DA6D83FBD691AA57A5AA283AEECD6ED7152954CB0B0A7333F18B58DB8929CA596B579200CA36AAF81932831A846CE5AB60E773BA9646B0846D277E07BE0D59585D1E52D75A18BCDF4E5442C17DC737C99740EEC6E3DC75B3D475D6FCC307822F2D69621AD95A86ABCB6B48B137610D26AB5FDD85EB6066A8660DEE10713638A44954AA797E7A76CEFD62C2F1FC7AC1340C6D57E27A54FD844175E20E9011419E51603DA1400CF7EC91E15F800A0FC1B7C4C62F73F33F71AFCBD847CDFE8A8B4F40D53F13E7D7082A1E83081BBF8BA964C3643CD7BBCB8E343F5D5FAAB7FFFE92743D311E02583197C62927CB2E335CCD5A6F454DD2B507359D73D9BFDD05C5278567C07FF1D0CB5FCB685D12BF7B81F1C9DDBDC02A09DC52E171EBBE7BBEF6DAA183E46AF7E2579A8FDD6F6EC59CEBA1F00611A12AA7BA0B96329FDA864F1AE753B763569E5FDD8534656EB543DA83F199D5FABB6DD673981355A44C61729658D5380FA420D5E3A16E1A7BE4CD1EFC3C8845D29889D72B61676CC340C83DEDB5FD88F9A52DE0FAE49076518D5E299C7B510DD9AED1691EB8CCCCFE47CA3EA7B3C161F55D26270E66694A720F07B562C7DAA9F69E70782C398645F0F2B8A98587CC26AC0996F9AE92088F206B4312853E7EAAE0A1754DF5D67BE4E9422D1202556F0B3D12F18652EC815448EB8955C7CA6BA5455D1457FB956304956A97227964FB579A95327E22E4A1F72FD553F091EF5FADD21D8F4CD7C632C946D6346DAB6CF4E44531AE9F9F56790E5C3277C5E5427A0348DE35E7A6BDF64109924B4AF2A33CF2EC0AD56085B228072C9AA80755A775F0030B0B47185768513F6C3B5E531BB296D9B44DFDB08A1C337E6C995D230C2E0D96908CAE938D55C77C7A00D5329FB6A9675E91E33446FAA534CB48966BDBB0912AE293A459BBC79C6E59E1A4216DB8E91EA690893C57F89BC8AE542F475580638BECB736A23FEAACC94174A8B2D928E2FEBE9D24C9414432E44ED32229528C9E025BA7F43F97017B2B74B605048B0E23D8AA5839799B5BB2F133638BA3286BC23969EF304536984057017536C8A250CDDE32E35F818B5F62D88BFA1ADBB7E421A2BB8802CBD85BBB159F3733DAEAC68F333FAB34CF1E76EC2B1C820520D3616FC00FE47DE4B8764EF78DC42DAC8060D660FA10C3E692B20799ED6B8E742F8410AB8052F1E546EC23F6762E80850F64859E7117DA40FD3EE02DB25E8B47001548F34454C53E5B3A681B202F4C318AFEF0093A6C7B2F3FFE1F3879D6E663690000 , N'6.1.0-30225')
END

