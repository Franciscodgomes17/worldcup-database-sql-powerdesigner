/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     07/10/2023 12:26:03                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CARDS') and o.name = 'FK_CARDS_OCCURED_D_MATCHES')
alter table CARDS
   drop constraint FK_CARDS_OCCURED_D_MATCHES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CARDS') and o.name = 'FK_CARDS_PLAYER_EN_PLAYERS')
alter table CARDS
   drop constraint FK_CARDS_PLAYER_EN_PLAYERS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('GOALS') and o.name = 'FK_GOALS_OCCURED_D_MATCHES')
alter table GOALS
   drop constraint FK_GOALS_OCCURED_D_MATCHES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('GOALS') and o.name = 'FK_GOALS_PLAYER_EN_PLAYERS')
alter table GOALS
   drop constraint FK_GOALS_PLAYER_EN_PLAYERS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('HEAD_COACHES') and o.name = 'FK_HEAD_COA_COACHES_TEAMS')
alter table HEAD_COACHES
   drop constraint FK_HEAD_COA_COACHES_TEAMS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MATCHES') and o.name = 'FK_MATCHES_BELONGS_T_STAGE')
alter table MATCHES
   drop constraint FK_MATCHES_BELONGS_T_STAGE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MATCHES') and o.name = 'FK_MATCHES_IS_PLAYED_STADIUM')
alter table MATCHES
   drop constraint FK_MATCHES_IS_PLAYED_STADIUM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MATCHES') and o.name = 'FK_MATCHES_REFEREES_PRINCIPA')
alter table MATCHES
   drop constraint FK_MATCHES_REFEREES_PRINCIPA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MATCHES') and o.name = 'FK_MATCHES_TEAM_1_TEAMS')
alter table MATCHES
   drop constraint FK_MATCHES_TEAM_1_TEAMS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MATCHES') and o.name = 'FK_MATCHES_TEAM_2_TEAMS')
alter table MATCHES
   drop constraint FK_MATCHES_TEAM_2_TEAMS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PLAYERS') and o.name = 'FK_PLAYERS_PLAYS_FOR_TEAMS')
alter table PLAYERS
   drop constraint FK_PLAYERS_PLAYS_FOR_TEAMS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('REPLACEMENTS') and o.name = 'FK_REPLACEM_OCCURED_D_MATCHES')
alter table REPLACEMENTS
   drop constraint FK_REPLACEM_OCCURED_D_MATCHES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('REPLACEMENTS') and o.name = 'FK_REPLACEM_PLAYER_EN_PLAYERS')
alter table REPLACEMENTS
   drop constraint FK_REPLACEM_PLAYER_EN_PLAYERS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('REPLACEMENTS') and o.name = 'FK_REPLACEM_PLAYER_LE_PLAYERS')
alter table REPLACEMENTS
   drop constraint FK_REPLACEM_PLAYER_LE_PLAYERS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SUMMONED_PLAYERS') and o.name = 'FK_SUMMONED_IS_SUMMON_PLAYERS')
alter table SUMMONED_PLAYERS
   drop constraint FK_SUMMONED_IS_SUMMON_PLAYERS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SUMMONED_PLAYERS') and o.name = 'FK_SUMMONED_SUMMONED__MATCHES')
alter table SUMMONED_PLAYERS
   drop constraint FK_SUMMONED_SUMMONED__MATCHES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TEAMS') and o.name = 'FK_TEAMS_COACHES2_HEAD_COA')
alter table TEAMS
   drop constraint FK_TEAMS_COACHES2_HEAD_COA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CARDS')
            and   name  = 'PLAYER_ENTERED2_FK'
            and   indid > 0
            and   indid < 255)
   drop index CARDS.PLAYER_ENTERED2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CARDS')
            and   name  = 'OCCURED_DURING2_FK'
            and   indid > 0
            and   indid < 255)
   drop index CARDS.OCCURED_DURING2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CARDS')
            and   type = 'U')
   drop table CARDS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GOALS')
            and   name  = 'PLAYER_ENTERED3_FK'
            and   indid > 0
            and   indid < 255)
   drop index GOALS.PLAYER_ENTERED3_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GOALS')
            and   name  = 'OCCURED_DURING3_FK'
            and   indid > 0
            and   indid < 255)
   drop index GOALS.OCCURED_DURING3_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GOALS')
            and   type = 'U')
   drop table GOALS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('HEAD_COACHES')
            and   name  = 'COACHES_FK'
            and   indid > 0
            and   indid < 255)
   drop index HEAD_COACHES.COACHES_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('HEAD_COACHES')
            and   type = 'U')
   drop table HEAD_COACHES
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MATCHES')
            and   name  = 'IS_PLAYED_IN_FK'
            and   indid > 0
            and   indid < 255)
   drop index MATCHES.IS_PLAYED_IN_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MATCHES')
            and   name  = 'BELONGS_TO_FK'
            and   indid > 0
            and   indid < 255)
   drop index MATCHES.BELONGS_TO_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MATCHES')
            and   name  = 'REFEREES_FK'
            and   indid > 0
            and   indid < 255)
   drop index MATCHES.REFEREES_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MATCHES')
            and   name  = 'TEAM_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index MATCHES.TEAM_2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MATCHES')
            and   name  = 'TEAM_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index MATCHES.TEAM_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MATCHES')
            and   type = 'U')
   drop table MATCHES
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PLAYERS')
            and   name  = 'PLAYS_IN_FK'
            and   indid > 0
            and   indid < 255)
   drop index PLAYERS.PLAYS_IN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PLAYERS')
            and   type = 'U')
   drop table PLAYERS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PRINCIPAL_REFEREES')
            and   type = 'U')
   drop table PRINCIPAL_REFEREES
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('REPLACEMENTS')
            and   name  = 'PLAYER_ENTERED_FK'
            and   indid > 0
            and   indid < 255)
   drop index REPLACEMENTS.PLAYER_ENTERED_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('REPLACEMENTS')
            and   name  = 'OCCURED_DURING_FK'
            and   indid > 0
            and   indid < 255)
   drop index REPLACEMENTS.OCCURED_DURING_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('REPLACEMENTS')
            and   name  = 'PLAYER_LEFT_FK'
            and   indid > 0
            and   indid < 255)
   drop index REPLACEMENTS.PLAYER_LEFT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('REPLACEMENTS')
            and   type = 'U')
   drop table REPLACEMENTS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('STADIUM')
            and   type = 'U')
   drop table STADIUM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('STAGE')
            and   type = 'U')
   drop table STAGE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SUMMONED_PLAYERS')
            and   name  = 'SUMMONED__STARTING_IN_FK'
            and   indid > 0
            and   indid < 255)
   drop index SUMMONED_PLAYERS.SUMMONED__STARTING_IN_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SUMMONED_PLAYERS')
            and   name  = 'IS_SUMMONED__STARTING_FK'
            and   indid > 0
            and   indid < 255)
   drop index SUMMONED_PLAYERS.IS_SUMMONED__STARTING_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SUMMONED_PLAYERS')
            and   type = 'U')
   drop table SUMMONED_PLAYERS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TEAMS')
            and   name  = 'COACHES2_FK'
            and   indid > 0
            and   indid < 255)
   drop index TEAMS.COACHES2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TEAMS')
            and   type = 'U')
   drop table TEAMS
go

/*==============================================================*/
/* Table: CARDS                                                 */
/*==============================================================*/
create table CARDS (
   IDMATCH              numeric              not null,
   IDPEOPLE             numeric              not null,
   IDSTATS              numeric              identity,
   PHASEOFGAME          smallint             not null
      constraint CKC_PHASEOFGAME_CARDS check (PHASEOFGAME in (1,2)),
   MINUTE               smallint             not null,
   COLOUR               varchar(10)          null
      constraint CKC_COLOUR_CARDS check (COLOUR is null or (COLOUR in ('Yellow','Red'))),
   constraint PK_CARDS primary key (IDMATCH, IDPEOPLE, IDSTATS)
)
go

/*==============================================================*/
/* Index: OCCURED_DURING2_FK                                    */
/*==============================================================*/
create index OCCURED_DURING2_FK on CARDS (
IDMATCH ASC
)
go

/*==============================================================*/
/* Index: PLAYER_ENTERED2_FK                                    */
/*==============================================================*/
create index PLAYER_ENTERED2_FK on CARDS (
IDPEOPLE ASC
)
go

/*==============================================================*/
/* Table: GOALS                                                 */
/*==============================================================*/
create table GOALS (
   IDMATCH              numeric              not null,
   IDPEOPLE             numeric              not null,
   IDSTATS              numeric              identity,
   PHASEOFGAME          smallint             not null
      constraint CKC_PHASEOFGAME_GOALS check (PHASEOFGAME in (1,2)),
   MINUTE               smallint             not null,
   PENALTY              bit                  null,
   OWNGOAL              bit                  null,
   constraint PK_GOALS primary key (IDMATCH, IDPEOPLE, IDSTATS)
)
go

/*==============================================================*/
/* Index: OCCURED_DURING3_FK                                    */
/*==============================================================*/
create index OCCURED_DURING3_FK on GOALS (
IDMATCH ASC
)
go

/*==============================================================*/
/* Index: PLAYER_ENTERED3_FK                                    */
/*==============================================================*/
create index PLAYER_ENTERED3_FK on GOALS (
IDPEOPLE ASC
)
go

/*==============================================================*/
/* Table: HEAD_COACHES                                          */
/*==============================================================*/
create table HEAD_COACHES (
   IDPEOPLE             numeric              identity,
   IDTEAM               numeric              not null,
   NAME                 varchar(50)          not null,
   BIRTHDATE            datetime             not null,
   GENDER               varchar(30)          not null,
   constraint PK_HEAD_COACHES primary key (IDPEOPLE)
)
go

/*==============================================================*/
/* Index: COACHES_FK                                            */
/*==============================================================*/
create index COACHES_FK on HEAD_COACHES (
IDTEAM ASC
)
go

/*==============================================================*/
/* Table: MATCHES                                               */
/*==============================================================*/
create table MATCHES (
   IDMATCH              numeric              identity,
   IDSTAGE              numeric              not null,
   TEAM_1               numeric              not null,
   IDSTADIUM            numeric              not null,
   TEAM_2               numeric              not null,
   IDPEOPLE             numeric              not null,
   STARTINGDATEANDTIME  datetime             not null,
   FIRSTPARTADDEDTIME   smallint             null,
   SECONDPARTADDEDTIME  smallint             null,
   TIEREGULARTIME       bit                  not null,
   EXTRAFIRSTPARTADDEDTIME smallint             null,
   EXTRASECONDPARTADDEDTIME smallint             null,
   TIEEXTRATIME         bit                  not null,
   constraint PK_MATCHES primary key nonclustered (IDMATCH)
)
go

/*==============================================================*/
/* Index: TEAM_1_FK                                             */
/*==============================================================*/
create index TEAM_1_FK on MATCHES (
TEAM_1 ASC
)
go

/*==============================================================*/
/* Index: TEAM_2_FK                                             */
/*==============================================================*/
create index TEAM_2_FK on MATCHES (
TEAM_2 ASC
)
go

/*==============================================================*/
/* Index: REFEREES_FK                                           */
/*==============================================================*/
create index REFEREES_FK on MATCHES (
IDPEOPLE ASC
)
go

/*==============================================================*/
/* Index: BELONGS_TO_FK                                         */
/*==============================================================*/
create index BELONGS_TO_FK on MATCHES (
IDSTAGE ASC
)
go

/*==============================================================*/
/* Index: IS_PLAYED_IN_FK                                       */
/*==============================================================*/
create index IS_PLAYED_IN_FK on MATCHES (
IDSTADIUM ASC
)
go

/*==============================================================*/
/* Table: PLAYERS                                               */
/*==============================================================*/
create table PLAYERS (
   IDPEOPLE             numeric              identity,
   IDTEAM               numeric              not null,
   NAME                 varchar(50)          not null,
   BIRTHDATE            datetime             not null,
   GENDER               varchar(30)          not null,
   POSITION             varchar(30)          not null
      constraint CKC_POSITION_PLAYERS check (POSITION in ('Goalkeeper','Defender','Midfielder','Attacker')),
   constraint PK_PLAYERS primary key (IDPEOPLE)
)
go

/*==============================================================*/
/* Index: PLAYS_IN_FK                                           */
/*==============================================================*/
create index PLAYS_IN_FK on PLAYERS (
IDTEAM ASC
)
go

/*==============================================================*/
/* Table: PRINCIPAL_REFEREES                                    */
/*==============================================================*/
create table PRINCIPAL_REFEREES (
   IDPEOPLE             numeric              identity,
   COUNTRY              varchar(50)          not null,
   NAME                 varchar(50)          not null,
   BIRTHDATE            datetime             not null,
   GENDER               varchar(30)          not null,
   constraint PK_PRINCIPAL_REFEREES primary key (IDPEOPLE)
)
go

/*==============================================================*/
/* Table: REPLACEMENTS                                          */
/*==============================================================*/
create table REPLACEMENTS (
   PLAYERLEFT           numeric              not null,
   IDMATCH              numeric              not null,
   PLAYERENTERED        numeric              not null,
   IDSTATS              numeric              identity,
   PHASEOFGAME          smallint             not null
      constraint CKC_PHASEOFGAME_REPLACEM check (PHASEOFGAME in (1,2)),
   MINUTE               smallint             not null,
   constraint PK_REPLACEMENTS primary key (PLAYERLEFT, IDMATCH, PLAYERENTERED, IDSTATS)
)
go

/*==============================================================*/
/* Index: PLAYER_LEFT_FK                                        */
/*==============================================================*/
create index PLAYER_LEFT_FK on REPLACEMENTS (
PLAYERLEFT ASC
)
go

/*==============================================================*/
/* Index: OCCURED_DURING_FK                                     */
/*==============================================================*/
create index OCCURED_DURING_FK on REPLACEMENTS (
IDMATCH ASC
)
go

/*==============================================================*/
/* Index: PLAYER_ENTERED_FK                                     */
/*==============================================================*/
create index PLAYER_ENTERED_FK on REPLACEMENTS (
PLAYERENTERED ASC
)
go

/*==============================================================*/
/* Table: STADIUM                                               */
/*==============================================================*/
create table STADIUM (
   IDSTADIUM            numeric              identity,
   STADIUMNAME          varchar(50)          not null,
   STADIUMCOUNTRY       varchar(50)          not null,
   CITY                 varchar(50)          not null,
   constraint PK_STADIUM primary key nonclustered (IDSTADIUM)
)
go

/*==============================================================*/
/* Table: STAGE                                                 */
/*==============================================================*/
create table STAGE (
   IDSTAGE              numeric              identity,
   STAGE                varchar(80)          not null
      constraint CKC_STAGE_STAGE check (STAGE in ('Group Stage','Round of 16','Quarterfinals','Semifinals','Third-place play-off','Final')),
   STAGESTARTDATE       datetime             not null,
   STAGEENDDATE         datetime             not null,
   constraint PK_STAGE primary key nonclustered (IDSTAGE)
)
go

/*==============================================================*/
/* Table: SUMMONED_PLAYERS                                      */
/*==============================================================*/
create table SUMMONED_PLAYERS (
   IDPEOPLE             numeric              not null,
   IDMATCH              numeric              not null,
   ISSTARTING           bit                  not null,
   constraint PK_SUMMONED_PLAYERS primary key (IDPEOPLE, IDMATCH)
)
go

/*==============================================================*/
/* Index: IS_SUMMONED__STARTING_FK                              */
/*==============================================================*/
create index IS_SUMMONED__STARTING_FK on SUMMONED_PLAYERS (
IDPEOPLE ASC
)
go

/*==============================================================*/
/* Index: SUMMONED__STARTING_IN_FK                              */
/*==============================================================*/
create index SUMMONED__STARTING_IN_FK on SUMMONED_PLAYERS (
IDMATCH ASC
)
go

/*==============================================================*/
/* Table: TEAMS                                                 */
/*==============================================================*/
create table TEAMS (
   IDTEAM               numeric              identity,
   IDPEOPLE             numeric              null,
   COUNTRYNAME          varchar(50)          not null,
   GROUPNAME            varchar(1)           not null
      constraint CKC_GROUPNAME_TEAMS check (GROUPNAME in ('A','B','C','D','E','F','G','H')),
   COUNTRYCODE          varchar(3)           not null,
   constraint PK_TEAMS primary key nonclustered (IDTEAM),
   constraint AK_COUNTRYCODE_TEAMS unique (COUNTRYCODE)
)
go

/*==============================================================*/
/* Index: COACHES2_FK                                           */
/*==============================================================*/
create index COACHES2_FK on TEAMS (
IDPEOPLE ASC
)
go

alter table CARDS
   add constraint FK_CARDS_OCCURED_D_MATCHES foreign key (IDMATCH)
      references MATCHES (IDMATCH)
go

alter table CARDS
   add constraint FK_CARDS_PLAYER_EN_PLAYERS foreign key (IDPEOPLE)
      references PLAYERS (IDPEOPLE)
go

alter table GOALS
   add constraint FK_GOALS_OCCURED_D_MATCHES foreign key (IDMATCH)
      references MATCHES (IDMATCH)
go

alter table GOALS
   add constraint FK_GOALS_PLAYER_EN_PLAYERS foreign key (IDPEOPLE)
      references PLAYERS (IDPEOPLE)
go

alter table HEAD_COACHES
   add constraint FK_HEAD_COA_COACHES_TEAMS foreign key (IDTEAM)
      references TEAMS (IDTEAM)
go

alter table MATCHES
   add constraint FK_MATCHES_BELONGS_T_STAGE foreign key (IDSTAGE)
      references STAGE (IDSTAGE)
go

alter table MATCHES
   add constraint FK_MATCHES_IS_PLAYED_STADIUM foreign key (IDSTADIUM)
      references STADIUM (IDSTADIUM)
go

alter table MATCHES
   add constraint FK_MATCHES_REFEREES_PRINCIPA foreign key (IDPEOPLE)
      references PRINCIPAL_REFEREES (IDPEOPLE)
go

alter table MATCHES
   add constraint FK_MATCHES_TEAM_1_TEAMS foreign key (TEAM_1)
      references TEAMS (IDTEAM)
go

alter table MATCHES
   add constraint FK_MATCHES_TEAM_2_TEAMS foreign key (TEAM_2)
      references TEAMS (IDTEAM)
go

alter table PLAYERS
   add constraint FK_PLAYERS_PLAYS_FOR_TEAMS foreign key (IDTEAM)
      references TEAMS (IDTEAM)
go

alter table REPLACEMENTS
   add constraint FK_REPLACEM_OCCURED_D_MATCHES foreign key (IDMATCH)
      references MATCHES (IDMATCH)
go

alter table REPLACEMENTS
   add constraint FK_REPLACEM_PLAYER_EN_PLAYERS foreign key (PLAYERENTERED)
      references PLAYERS (IDPEOPLE)
go

alter table REPLACEMENTS
   add constraint FK_REPLACEM_PLAYER_LE_PLAYERS foreign key (PLAYERLEFT)
      references PLAYERS (IDPEOPLE)
go

alter table SUMMONED_PLAYERS
   add constraint FK_SUMMONED_IS_SUMMON_PLAYERS foreign key (IDPEOPLE)
      references PLAYERS (IDPEOPLE)
go

alter table SUMMONED_PLAYERS
   add constraint FK_SUMMONED_SUMMONED__MATCHES foreign key (IDMATCH)
      references MATCHES (IDMATCH)
go

alter table TEAMS
   add constraint FK_TEAMS_COACHES2_HEAD_COA foreign key (IDPEOPLE)
      references HEAD_COACHES (IDPEOPLE)
go

