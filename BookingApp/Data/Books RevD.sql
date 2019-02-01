USE [master]
GO
/****** Object:  Database [Books]    Script Date: 18.01.2019 16:30:31 ******/
CREATE DATABASE [Books]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Books', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\BooksLocal.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Books_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\BooksLocal_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Books] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Books].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Books] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Books] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Books] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Books] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Books] SET ARITHABORT OFF 
GO
ALTER DATABASE [Books] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Books] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Books] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Books] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Books] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Books] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Books] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Books] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Books] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Books] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Books] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Books] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Books] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Books] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Books] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Books] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Books] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Books] SET RECOVERY FULL 
GO
ALTER DATABASE [Books] SET  MULTI_USER 
GO
ALTER DATABASE [Books] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Books] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Books] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Books] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Books] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Books] SET QUERY_STORE = OFF
GO
USE [Books]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Books]
GO
/****** Object:  User [sharik]    Script Date: 18.01.2019 16:30:31 ******/
CREATE USER [sharik] FOR LOGIN [sharik] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [sharik]
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 18.01.2019 16:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookings](
	[BookingID] [int] IDENTITY(1,1) NOT NULL,
	[ResourceID] [int] NOT NULL,
	[Description] [nvarchar](128) NULL,
	[StartTime] [datetime2](7) NOT NULL,
	[EndTime] [datetime2](7) NOT NULL,
	[IsCancelled] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Booking2] PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resources]    Script Date: 18.01.2019 16:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resources](
	[ResourceID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nchar](32) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[TreeGroupID] [int] NULL,
	[RuleID] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[ResourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rules]    Script Date: 18.01.2019 16:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rules](
	[RuleID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nchar](32) NOT NULL,
	[MinTime] [int] NOT NULL,
	[MaxTime] [int] NOT NULL,
	[StepTime] [int] NOT NULL,
	[ServiceTime] [int] NOT NULL,
	[ReuseTimeout] [int] NOT NULL,
	[PreOrderTimeLimit] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Rule] PRIMARY KEY CLUSTERED 
(
	[RuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TreeGroups]    Script Date: 18.01.2019 16:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TreeGroups](
	[TreeGroupID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nchar](32) NOT NULL,
	[ParentTreeGroupID] [int] NULL,
	[DefaultRuleID] [int] NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_TreeGroup] PRIMARY KEY CLUSTERED 
(
	[TreeGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsersTemp]    Script Date: 18.01.2019 16:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsersTemp](
	[UserID] [uniqueidentifier] NOT NULL,
	[Email] [nchar](128) NOT NULL,
	[IsAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_UsersTemp] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bookings] ON 

INSERT [dbo].[Bookings] ([BookingID], [ResourceID], [Description], [StartTime], [EndTime], [IsCancelled], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (1, 4, N'Music for my bro', CAST(N'2019-01-18T16:11:16.0700000' AS DateTime2), CAST(N'2019-01-18T16:11:16.0700000' AS DateTime2), 0, CAST(N'2019-01-18T16:25:29.9333333' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96404', CAST(N'2019-01-18T16:25:29.9333333' AS DateTime2), NULL)
INSERT [dbo].[Bookings] ([BookingID], [ResourceID], [Description], [StartTime], [EndTime], [IsCancelled], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (3, 4, N'Twinkle twinke little star', CAST(N'2019-01-13T19:00:00.0700000' AS DateTime2), CAST(N'2019-01-13T20:59:00.0700000' AS DateTime2), 0, CAST(N'2019-01-18T16:27:19.6000000' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96405', CAST(N'2019-01-18T16:27:19.6000000' AS DateTime2), NULL)
INSERT [dbo].[Bookings] ([BookingID], [ResourceID], [Description], [StartTime], [EndTime], [IsCancelled], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (4, 4, N'Admins Party at Egg Monument', CAST(N'2019-01-14T18:00:00.0700000' AS DateTime2), CAST(N'2019-01-15T14:59:00.0700000' AS DateTime2), 0, CAST(N'2019-01-18T16:28:31.4233333' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:28:31.4233333' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[Bookings] OFF
SET IDENTITY_INSERT [dbo].[Resources] ON 

INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (1, N'Nothern View                    ', NULL, 2, 2, CAST(N'2019-01-18T16:16:38.2166667' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:16:38.2166667' AS DateTime2), NULL)
INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (2, N'Southern View                   ', NULL, 2, 2, CAST(N'2019-01-18T16:17:01.7366667' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:17:01.7366667' AS DateTime2), NULL)
INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (3, N'Flag                            ', NULL, 2, 2, CAST(N'2019-01-18T16:17:10.0733333' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:17:10.0733333' AS DateTime2), NULL)
INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (4, N'Trumpet Ensemble                ', NULL, 3, 1, CAST(N'2019-01-18T16:17:36.3633333' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:17:36.3633333' AS DateTime2), NULL)
INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (5, N'First Floor hallway             ', NULL, 1, 2, CAST(N'2019-01-18T16:17:50.7000000' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:17:50.7000000' AS DateTime2), NULL)
INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (6, N'Natural Museum                  ', NULL, 4, 2, CAST(N'2019-01-18T16:18:17.3500000' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:18:17.3500000' AS DateTime2), NULL)
INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (7, N'Art Museum                      ', NULL, 4, 2, CAST(N'2019-01-18T16:18:26.4900000' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:18:26.4900000' AS DateTime2), NULL)
INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (8, N'History Museum                  ', NULL, 4, 2, CAST(N'2019-01-18T16:18:35.2700000' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:18:35.2700000' AS DateTime2), NULL)
INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (9, N'Civil Defence Alarm             ', NULL, NULL, 4, CAST(N'2019-01-18T16:19:08.7833333' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:19:08.7833333' AS DateTime2), NULL)
INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (10, N'Cruiser Bicycle #2000           ', NULL, 5, 2, CAST(N'2019-01-18T16:19:37.0900000' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:19:37.0900000' AS DateTime2), NULL)
INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (11, N'Cruiser Bicycle #46             ', NULL, 5, 2, CAST(N'2019-01-18T16:19:51.9066667' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:19:51.9066667' AS DateTime2), NULL)
INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (12, N'Ukraine Tier0 Bicycle           ', NULL, 5, 2, CAST(N'2019-01-18T16:20:02.5833333' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:20:02.5833333' AS DateTime2), NULL)
INSERT [dbo].[Resources] ([ResourceID], [Title], [Description], [TreeGroupID], [RuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (13, N'Mountain Bike "Roger"           ', NULL, 5, 2, CAST(N'2019-01-18T16:20:14.0066667' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:20:14.0066667' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[Resources] OFF
SET IDENTITY_INSERT [dbo].[Rules] ON 

INSERT [dbo].[Rules] ([RuleID], [Title], [MinTime], [MaxTime], [StepTime], [ServiceTime], [ReuseTimeout], [PreOrderTimeLimit], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (1, N'Most Defaultest Rule            ', 15, 180, 15, 0, 0, 1440, CAST(N'2019-01-18T16:11:16.0700000' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:11:16.0700000' AS DateTime2), NULL)
INSERT [dbo].[Rules] ([RuleID], [Title], [MinTime], [MaxTime], [StepTime], [ServiceTime], [ReuseTimeout], [PreOrderTimeLimit], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (2, N'Rooms                           ', 60, 480, 30, 0, 0, 1440, CAST(N'2019-01-18T16:13:23.2633333' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:13:23.2633333' AS DateTime2), NULL)
INSERT [dbo].[Rules] ([RuleID], [Title], [MinTime], [MaxTime], [StepTime], [ServiceTime], [ReuseTimeout], [PreOrderTimeLimit], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (3, N'Teslas                          ', 60, 300, 30, 180, 0, 360, CAST(N'2019-01-18T16:14:10.2300000' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:14:10.2300000' AS DateTime2), NULL)
INSERT [dbo].[Rules] ([RuleID], [Title], [MinTime], [MaxTime], [StepTime], [ServiceTime], [ReuseTimeout], [PreOrderTimeLimit], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (4, N'Toilets                         ', 1, 15, 1, 0, 240, 120, CAST(N'2019-01-18T16:14:45.9200000' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:14:45.9200000' AS DateTime2), NULL)
INSERT [dbo].[Rules] ([RuleID], [Title], [MinTime], [MaxTime], [StepTime], [ServiceTime], [ReuseTimeout], [PreOrderTimeLimit], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (6, N'Strict Stuff                    ', 30, 80, 10, 40, 300, 1200, CAST(N'2019-01-18T16:15:24.5833333' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:15:24.5833333' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[Rules] OFF
SET IDENTITY_INSERT [dbo].[TreeGroups] ON 

INSERT [dbo].[TreeGroups] ([TreeGroupID], [Title], [ParentTreeGroupID], [DefaultRuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (1, N'Town Hall                       ', NULL, NULL, CAST(N'2019-01-18T00:00:00.0000000' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:06:08.2900000' AS DateTime2), NULL)
INSERT [dbo].[TreeGroups] ([TreeGroupID], [Title], [ParentTreeGroupID], [DefaultRuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (2, N'Spire Balcony                   ', 1, NULL, CAST(N'2019-01-18T16:06:42.6966667' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:06:42.6966667' AS DateTime2), NULL)
INSERT [dbo].[TreeGroups] ([TreeGroupID], [Title], [ParentTreeGroupID], [DefaultRuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (3, N'Gala Balcony                    ', 1, NULL, CAST(N'2019-01-18T16:07:02.0533333' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:07:02.0533333' AS DateTime2), NULL)
INSERT [dbo].[TreeGroups] ([TreeGroupID], [Title], [ParentTreeGroupID], [DefaultRuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (4, N'Museums                         ', 1, NULL, CAST(N'2019-01-18T16:07:18.9300000' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:07:18.9300000' AS DateTime2), NULL)
INSERT [dbo].[TreeGroups] ([TreeGroupID], [Title], [ParentTreeGroupID], [DefaultRuleID], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy]) VALUES (5, N'Bike Rental                     ', NULL, NULL, CAST(N'2019-01-18T16:07:39.2800000' AS DateTime2), N'6f9619ff-8b86-d011-b42d-00c04fc96401', CAST(N'2019-01-18T16:07:39.2800000' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[TreeGroups] OFF
INSERT [dbo].[UsersTemp] ([UserID], [Email], [IsAdmin]) VALUES (N'6f9619ff-8b86-d011-b42d-00c04fc96401', N'superadmin@mail.com                                                                                                             ', 1)
INSERT [dbo].[UsersTemp] ([UserID], [Email], [IsAdmin]) VALUES (N'6f9619ff-8b86-d011-b42d-00c04fc96402', N'tiger@admin.com                                                                                                                 ', 1)
INSERT [dbo].[UsersTemp] ([UserID], [Email], [IsAdmin]) VALUES (N'6f9619ff-8b86-d011-b42d-00c04fc96403', N'elephant@admin.com                                                                                                              ', 1)
INSERT [dbo].[UsersTemp] ([UserID], [Email], [IsAdmin]) VALUES (N'6f9619ff-8b86-d011-b42d-00c04fc96404', N'tiger@user.com                                                                                                                  ', 0)
INSERT [dbo].[UsersTemp] ([UserID], [Email], [IsAdmin]) VALUES (N'6f9619ff-8b86-d011-b42d-00c04fc96405', N'bear@user.com                                                                                                                   ', 0)
INSERT [dbo].[UsersTemp] ([UserID], [Email], [IsAdmin]) VALUES (N'6f9619ff-8b86-d011-b42d-00c04fc96406', N'cheetah@user.com                                                                                                                ', 0)
INSERT [dbo].[UsersTemp] ([UserID], [Email], [IsAdmin]) VALUES (N'6f9619ff-8b86-d011-b42d-00c04fc96407', N'wolf@user.com                                                                                                                   ', 0)
INSERT [dbo].[UsersTemp] ([UserID], [Email], [IsAdmin]) VALUES (N'6f9619ff-8b86-d011-b42d-00c04fc96408', N'camel@user.com                                                                                                                  ', 0)
INSERT [dbo].[UsersTemp] ([UserID], [Email], [IsAdmin]) VALUES (N'6f9619ff-8b86-d011-b42d-00c04fc96409', N'eagle@user.com                                                                                                                  ', 0)
INSERT [dbo].[UsersTemp] ([UserID], [Email], [IsAdmin]) VALUES (N'6f9619ff-8b86-d011-b42d-00c04fc96410', N'mantis@user.com                                                                                                                 ', 0)
ALTER TABLE [dbo].[Bookings] ADD  CONSTRAINT [DF_Bookings_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Bookings] ADD  CONSTRAINT [DF_Bookings_UpdatedAt]  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Resources] ADD  CONSTRAINT [DF_Booking_Title]  DEFAULT (N'Unnamed Resource') FOR [Title]
GO
ALTER TABLE [dbo].[Resources] ADD  CONSTRAINT [DF_Resources_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Resources] ADD  CONSTRAINT [DF_Resources_UpdatedAt]  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Rules] ADD  CONSTRAINT [DF_Rule_Title]  DEFAULT (N'Unnamed Rule') FOR [Title]
GO
ALTER TABLE [dbo].[Rules] ADD  CONSTRAINT [DF_Rule_Min]  DEFAULT ((1)) FOR [MinTime]
GO
ALTER TABLE [dbo].[Rules] ADD  CONSTRAINT [DF_Rule_Max]  DEFAULT ((10)) FOR [MaxTime]
GO
ALTER TABLE [dbo].[Rules] ADD  CONSTRAINT [DF_Rule_Step]  DEFAULT ((1)) FOR [StepTime]
GO
ALTER TABLE [dbo].[Rules] ADD  CONSTRAINT [DF_Rule_Advance]  DEFAULT ((60)) FOR [PreOrderTimeLimit]
GO
ALTER TABLE [dbo].[Rules] ADD  CONSTRAINT [DF_Rules_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Rules] ADD  CONSTRAINT [DF_Rules_UpdatedAt]  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[TreeGroups] ADD  CONSTRAINT [DF_TreeGroup_Title]  DEFAULT (N'Unnamed Tree Group') FOR [Title]
GO
ALTER TABLE [dbo].[TreeGroups] ADD  CONSTRAINT [DF_TreeGroups_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[TreeGroups] ADD  CONSTRAINT [DF_TreeGroups_UpdatedAt]  DEFAULT (getdate()) FOR [UpdatedAt]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Resource] FOREIGN KEY([ResourceID])
REFERENCES [dbo].[Resources] ([ResourceID])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_Booking_Resource]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_Bookings_UsersTemp] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UsersTemp] ([UserID])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_Bookings_UsersTemp]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_Bookings_UsersTemp1] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[UsersTemp] ([UserID])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_Bookings_UsersTemp1]
GO
ALTER TABLE [dbo].[Resources]  WITH CHECK ADD  CONSTRAINT [FK_Resource_Rule] FOREIGN KEY([RuleID])
REFERENCES [dbo].[Rules] ([RuleID])
GO
ALTER TABLE [dbo].[Resources] CHECK CONSTRAINT [FK_Resource_Rule]
GO
ALTER TABLE [dbo].[Resources]  WITH CHECK ADD  CONSTRAINT [FK_Resource_TreeGroup] FOREIGN KEY([TreeGroupID])
REFERENCES [dbo].[TreeGroups] ([TreeGroupID])
GO
ALTER TABLE [dbo].[Resources] CHECK CONSTRAINT [FK_Resource_TreeGroup]
GO
ALTER TABLE [dbo].[Resources]  WITH CHECK ADD  CONSTRAINT [FK_Resources_UsersTemp] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UsersTemp] ([UserID])
GO
ALTER TABLE [dbo].[Resources] CHECK CONSTRAINT [FK_Resources_UsersTemp]
GO
ALTER TABLE [dbo].[Resources]  WITH CHECK ADD  CONSTRAINT [FK_Resources_UsersTemp1] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[UsersTemp] ([UserID])
GO
ALTER TABLE [dbo].[Resources] CHECK CONSTRAINT [FK_Resources_UsersTemp1]
GO
ALTER TABLE [dbo].[Rules]  WITH CHECK ADD  CONSTRAINT [FK_Rules_UsersTemp] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UsersTemp] ([UserID])
GO
ALTER TABLE [dbo].[Rules] CHECK CONSTRAINT [FK_Rules_UsersTemp]
GO
ALTER TABLE [dbo].[Rules]  WITH CHECK ADD  CONSTRAINT [FK_Rules_UsersTemp1] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[UsersTemp] ([UserID])
GO
ALTER TABLE [dbo].[Rules] CHECK CONSTRAINT [FK_Rules_UsersTemp1]
GO
ALTER TABLE [dbo].[TreeGroups]  WITH CHECK ADD  CONSTRAINT [FK_TreeGroup_Rule] FOREIGN KEY([DefaultRuleID])
REFERENCES [dbo].[Rules] ([RuleID])
GO
ALTER TABLE [dbo].[TreeGroups] CHECK CONSTRAINT [FK_TreeGroup_Rule]
GO
ALTER TABLE [dbo].[TreeGroups]  WITH CHECK ADD  CONSTRAINT [FK_TreeGroup_TreeGroup] FOREIGN KEY([ParentTreeGroupID])
REFERENCES [dbo].[TreeGroups] ([TreeGroupID])
GO
ALTER TABLE [dbo].[TreeGroups] CHECK CONSTRAINT [FK_TreeGroup_TreeGroup]
GO
ALTER TABLE [dbo].[TreeGroups]  WITH CHECK ADD  CONSTRAINT [FK_TreeGroups_UsersTemp] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[UsersTemp] ([UserID])
GO
ALTER TABLE [dbo].[TreeGroups] CHECK CONSTRAINT [FK_TreeGroups_UsersTemp]
GO
ALTER TABLE [dbo].[TreeGroups]  WITH CHECK ADD  CONSTRAINT [FK_TreeGroups_UsersTemp1] FOREIGN KEY([UpdatedBy])
REFERENCES [dbo].[UsersTemp] ([UserID])
GO
ALTER TABLE [dbo].[TreeGroups] CHECK CONSTRAINT [FK_TreeGroups_UsersTemp1]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'minutes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Rules', @level2type=N'COLUMN',@level2name=N'MinTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'minutes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Rules', @level2type=N'COLUMN',@level2name=N'MaxTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'minutes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Rules', @level2type=N'COLUMN',@level2name=N'StepTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'minutes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Rules', @level2type=N'COLUMN',@level2name=N'PreOrderTimeLimit'
GO
USE [master]
GO
ALTER DATABASE [Books] SET  READ_WRITE 
GO
