
 USE [StackOverflow_MimicUse]
 GO

/* Initial table creation. Drop all first. */
DROP TABLE IF EXISTS dbo.Votes
DROP TABLE IF EXISTS dbo.Comments
DROP TABLE IF EXISTS dbo.PostLinks
DROP TABLE IF EXISTS dbo.Posts
DROP TABLE IF EXISTS dbo.Badges
DROP TABLE IF EXISTS dbo.Users
DROP TABLE IF EXISTS dbo.VoteTypes
DROP TABLE IF EXISTS dbo.PostTypes
DROP TABLE IF EXISTS dbo.LinkTypes


DROP TABLE IF EXISTS demosetup.Votes
DROP TABLE IF EXISTS demosetup.Comments
DROP TABLE IF EXISTS demosetup.Posts
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'demosetup')
EXEC('CREATE SCHEMA demosetup')
GO

/****** Object:  Table [dbo].[LinkTypes]    Script Date: 7/2/2024 7:30:21 PM ******/

CREATE TABLE [dbo].[LinkTypes](
	[Id] [INT] IDENTITY(1,1) NOT NULL,
	[Type] [VARCHAR](50) NOT NULL,
	CONSTRAINT [PK_LinkTypes_Id] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT UQ_LinkTypes_Type UNIQUE ([Type])
	) 
GO

/****** Object:  Table [dbo].[PostTypes]    Script Date: 7/2/2024 7:30:21 PM ******/

CREATE TABLE [dbo].[PostTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	CONSTRAINT [PK_PostTypes_Id] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT UQ_PostTypes_Type UNIQUE ([Type])
	) 
GO

/****** Object:  Table [dbo].[VoteTypes]    Script Date: 7/2/2024 7:30:21 PM ******/

CREATE TABLE [dbo].[VoteTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	CONSTRAINT [PK_VoteType_Id] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT UQ_VotesType_Name UNIQUE ([Name])
	) 
GO

/****** Object:  Table [dbo].[Users]    Script Date: 7/2/2024 7:30:21 PM ******/

CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AboutMe] [nvarchar](max) NULL,
	[Age] [int] NULL,
	[CreationDate] [datetime] NOT NULL,
	[DisplayName] [nvarchar](40) NOT NULL,
	[DownVotes] [int] NOT NULL,
	[EmailHash] [nvarchar](40) NULL,
	[LastAccessDate] [datetime] NOT NULL,
	[Location] [nvarchar](100) NULL,
	[Reputation] [int] NOT NULL,
	[UpVotes] [int] NOT NULL,
	[Views] [int] NOT NULL,
	[WebsiteUrl] [nvarchar](200) NULL,
	[AccountId] [int] NULL,
	CONSTRAINT [PK_Users_Id] PRIMARY KEY CLUSTERED ([Id]),
	INDEX IDX_Users_DisplayName (DisplayName)
	)  
GO


/****** Object:  Table [dbo].[Badges]    Script Date: 7/2/2024 7:30:21 PM ******/

CREATE TABLE [dbo].[Badges](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[UserId] [int] NOT NULL
		CONSTRAINT FK_Badges_Users FOREIGN KEY REFERENCES dbo.Users (Id),
	[Date] [datetime] NOT NULL,
	CONSTRAINT [PK_Badges_Id] PRIMARY KEY CLUSTERED ([Id]),
	INDEX IDX_BadgesUserId (UserId)
	) 
GO



/****** Object:  Table [dbo].[Posts]    Script Date: 7/2/2024 7:30:21 PM ******/

CREATE TABLE [dbo].[Posts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AcceptedAnswerId] [int] NULL
		CONSTRAINT FK_Posts_AcceptedAnswerPosts FOREIGN KEY REFERENCES dbo.Posts (Id),
	[AnswerCount] [int] NULL,
	[Body] [nvarchar](max) NOT NULL,
	[ClosedDate] [datetime] NULL,
	[CommentCount] [int] NULL,
	[CommunityOwnedDate] [datetime] NULL,
	[CreationDate] [datetime] NOT NULL,
	[FavoriteCount] [int] NULL,
	[LastActivityDate] [datetime] NOT NULL,
	[LastEditDate] [datetime] NULL,
	[LastEditorDisplayName] [nvarchar](40) NULL,
	[LastEditorUserId] [int] NULL
		CONSTRAINT FK_Posts_LastEditorUsers FOREIGN KEY REFERENCES dbo.Users (Id),
	[OwnerUserId] [int] NULL
		CONSTRAINT FK_Posts_OwnerUsers FOREIGN KEY REFERENCES dbo.Users (Id),
	[ParentId] [int] NULL
		CONSTRAINT FK_Posts_ParentPosts FOREIGN KEY REFERENCES dbo.Posts (Id),
	[PostTypeId] [INT] NOT NULL
		CONSTRAINT FK_Posts_PostTypes FOREIGN KEY REFERENCES dbo.PostTypes (Id),
	[Score] [INT] NOT NULL,
	[Tags] [NVARCHAR](150) NULL,
	[Title] [NVARCHAR](250) NULL,
	[ViewCount] [INT] NOT NULL,
	CONSTRAINT [PK_Posts_Id] PRIMARY KEY CLUSTERED ([Id]),
	INDEX IDX_Posts_AcceptedAnswerId (AcceptedAnswerId),
	INDEX IDX_Posts_LastEditorUserId (LastEditorUserId),
	INDEX IDX_Posts_OwnerUserId (OwnerUserId),
	INDEX IDX_Posts_ParentId (ParentId),
	INDEX IDX_Posts_PostTypeId (PostTypeId),
	INDEX IDX_Posts_CreationDate (CreationDate)
	)  
GO

/****** Object:  Table [dbo].[PostLinks]    Script Date: 7/2/2024 7:30:21 PM ******/

CREATE TABLE [dbo].[PostLinks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[PostId] [int] NOT NULL,
	[RelatedPostId] [int] NOT NULL,
	[LinkTypeId] [int] NOT NULL,
	CONSTRAINT [PK_PostLinks_Id] PRIMARY KEY CLUSTERED ([Id])
	) 
GO


/****** Object:  Table [dbo].[Comments]    Script Date: 7/2/2024 7:30:21 PM ******/
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[PostId] [int] NOT NULL
		CONSTRAINT FK_Comments_Posts FOREIGN KEY REFERENCES dbo.Posts (Id),
	[Score] [int] NULL,
	[Text] [nvarchar](700) NOT NULL,
	[UserId] [int] NULL
		CONSTRAINT FK_Comments_Users FOREIGN KEY REFERENCES dbo.Users (Id),
	CONSTRAINT [PK_Comments_Id] PRIMARY KEY CLUSTERED ([Id]),
	INDEX IDX_Comments_PostId (PostId),
	INDEX IDX_Comments_UserId (UserId),
	INDEX IDX_Comments_CreationDatePostUser (CreationDate, PostID, UserID)
	) 
GO


/****** Object:  Table [dbo].[Votes]    Script Date: 7/2/2024 7:30:21 PM ******/
CREATE TABLE [dbo].[Votes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PostId] [int] NOT NULL
		CONSTRAINT FK_Votes_Posts FOREIGN KEY REFERENCES dbo.Posts (Id),
	[UserId] [int] NULL
		CONSTRAINT FK_Votes_Users FOREIGN KEY REFERENCES dbo.Users (Id),
	[BountyAmount] [int] NULL,
	[VoteTypeId] [int] NOT NULL
		CONSTRAINT FK_Votes_VotesTypes FOREIGN KEY REFERENCES dbo.VoteTypes (Id),
	[CreationDate] [datetime] NOT NULL,
	CONSTRAINT [PK_Votes_Id] PRIMARY KEY CLUSTERED ([Id]),
	INDEX IDX_Votes_PostId (PostId),
	INDEX IDX_Votes_UserId (UserId),
	INDEX IDX_Votes_VoteTypeId (VoteTypeId)
	) 
GO


/**************************************************************************************************/


CREATE TABLE demosetup.[Posts](
	[OldPostId] [int] NOT NULL,
	[AcceptedAnswerId] [int] NULL,
	[AnswerCount] [int] NULL,
	[Body] [nvarchar](max) NOT NULL,
	[ClosedDate] [datetime] NULL,
	[CommentCount] [int] NULL,
	[CommunityOwnedDate] [datetime] NULL,
	[CreationDate] [datetime] NOT NULL,
	[FavoriteCount] [int] NULL,
	[LastActivityDate] [datetime] NOT NULL,
	[LastEditDate] [datetime] NULL,
	[LastEditorDisplayName] [nvarchar](40) NULL,
	[LastEditorUserId] [int] NULL,
	[OwnerUserId] [int] NULL,
	[ParentId] [int] NULL,
	[PostTypeId] [INT] NOT NULL,
	[Score] [INT] NOT NULL,
	[Tags] [NVARCHAR](150) NULL,
	[Title] [NVARCHAR](250) NULL,
	[ViewCount] [INT] NOT NULL,
	CONSTRAINT [PK_demosetupPosts_Id] PRIMARY KEY CLUSTERED ([OldPostId])
	)  
GO



/****** Object:  Table [dbo].[Comments]    Script Date: 7/2/2024 7:30:21 PM ******/
CREATE TABLE demosetup.[Comments](
	[OldCommentId] [int]NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[PostId] [int] NOT NULL,
	[Score] [int] NULL,
	[Text] [nvarchar](700) NOT NULL,
	[UserId] [int] NULL,
	CONSTRAINT [PK_demosetupComments_Id] PRIMARY KEY CLUSTERED ([OldCommentId])
	) 
GO





/****** Object:  Table [dbo].[Votes]    Script Date: 7/2/2024 7:30:21 PM ******/
CREATE TABLE demosetup.[Votes](
	[OldVoteId] [int] NOT NULL,
	[PostId] [int] NOT NULL,
	[UserId] [int] NULL,
	[BountyAmount] [int] NULL,
	[VoteTypeId] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	CONSTRAINT [PK_demosetupVotes_Id] PRIMARY KEY CLUSTERED ([OldVoteId])
	) 
GO
