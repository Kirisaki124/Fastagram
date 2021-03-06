USE [master]
GO
/****** Object:  Database [Fastagram]    Script Date: 7/16/2019 9:24:56 AM ******/
CREATE DATABASE [Fastagram]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Fastagram', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Fastagram.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Fastagram_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Fastagram_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Fastagram] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Fastagram].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Fastagram] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Fastagram] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Fastagram] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Fastagram] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Fastagram] SET ARITHABORT OFF 
GO
ALTER DATABASE [Fastagram] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Fastagram] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Fastagram] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Fastagram] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Fastagram] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Fastagram] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Fastagram] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Fastagram] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Fastagram] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Fastagram] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Fastagram] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Fastagram] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Fastagram] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Fastagram] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Fastagram] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Fastagram] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Fastagram] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Fastagram] SET RECOVERY FULL 
GO
ALTER DATABASE [Fastagram] SET  MULTI_USER 
GO
ALTER DATABASE [Fastagram] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Fastagram] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Fastagram] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Fastagram] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Fastagram] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Fastagram', N'ON'
GO
ALTER DATABASE [Fastagram] SET QUERY_STORE = OFF
GO
USE [Fastagram]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 7/16/2019 9:24:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [int] NOT NULL,
	[PostID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Like]    Script Date: 7/16/2019 9:24:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Like](
	[PostID] [int] NOT NULL,
	[UserID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Post]    Script Date: 7/16/2019 9:24:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[PostID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 7/16/2019 9:24:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Avatar] [nvarchar](max) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([PostID], [UserID], [Image], [Content], [DateCreated]) VALUES (1, 1, N'1', N'1', CAST(N'2019-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Post] ([PostID], [UserID], [Image], [Content], [DateCreated]) VALUES (2, 1, N'1', N'1', CAST(N'2019-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Post] ([PostID], [UserID], [Image], [Content], [DateCreated]) VALUES (3, 1, N'1', N'1', CAST(N'2019-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Post] ([PostID], [UserID], [Image], [Content], [DateCreated]) VALUES (4, 1, N'1', N'1', CAST(N'2019-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Post] ([PostID], [UserID], [Image], [Content], [DateCreated]) VALUES (5, 1, N'1', N'1', CAST(N'2019-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Post] ([PostID], [UserID], [Image], [Content], [DateCreated]) VALUES (6, 1, N'07_16_2019_09_15_47_AM.jpg', N'testing content', CAST(N'2019-07-16T09:15:47.447' AS DateTime))
SET IDENTITY_INSERT [dbo].[Post] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [UserName], [Password], [Avatar]) VALUES (1, N'admin', N'123', NULL)
SET IDENTITY_INSERT [dbo].[User] OFF
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_comment_PostID] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_comment_PostID]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_UserID]
GO
ALTER TABLE [dbo].[Like]  WITH CHECK ADD  CONSTRAINT [FK_Like_PostID] FOREIGN KEY([PostID])
REFERENCES [dbo].[Post] ([PostID])
GO
ALTER TABLE [dbo].[Like] CHECK CONSTRAINT [FK_Like_PostID]
GO
ALTER TABLE [dbo].[Like]  WITH CHECK ADD  CONSTRAINT [FK_Like_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Like] CHECK CONSTRAINT [FK_Like_UserID]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_UserID]
GO
USE [master]
GO
ALTER DATABASE [Fastagram] SET  READ_WRITE 
GO
