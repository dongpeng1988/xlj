using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace sw.util
{
    public class ConstantsRes
    {
        public const int UnitPixel = 256;
        public static int MapBlockPixel = 512;
        public static float MapBlockSize;// = (float)MapBlockPixel / UnitPixel;

        public static float ZScale =1f;// (float)Math.Sqrt(2f);
        public static float ZScale2 =  1f;
        public static float XRotation = 45f;
        public const int MapGridWidth = 10;
        public const int MapGridHeight = 10;
        //public const float GRID_SIZE = (float)MapGridWidth / UnitPixel;
        public const float GRID_SIZE =0.8f;
        public const int RQGameObject = 3000;
        public const int RQMap = 1;//地图render queue
        public const int RQBack = 0;

        public const float LAYER_GAP = 0.001f;//同一模型不同层之间的间隔
        //public const float DiagCost = Math.Sqrt;
		public const float SubMapMoveRatio = 0.1f;
		public const float SubMapSizeRatio = 0.25f;
		public const int MAX_PANEL_ITEM = 8;
		public static bool SHOW_DEBUG_INFO = true;
		public const float DYING_PERCENT = 0.25f;

        public const float TOP_PERCENT = 0.6f;

		public const int RANK_PAGE_NUM = 7;
		public const int ENHANCE_MIN_QUALITY=1;
		//洗炼最低品质 
		public const int WASH_QUALITY = 3;
		//升品最低品质
		public const int UPGRADE_QUALITY=1;
		//装备的最高品质
		public const int MAX_EQUIP_QUALITY = 5;
		//强化的最高等级
		public const int ENHANCE_LEVEL = 20;
		//可以镶嵌宝石的人物装备pos开始
		public const int EMBED_PLAYER_EQUIP_START=0;
		//可以镶嵌宝石的人物装备pos结束
		public const int EMBED_PLAYER_EQUIP_END=18;
		//镶嵌宝石的宠物装备的pos开始
		public const int EMBED_PET_EQUIP_START=14;
		//镶嵌宝石的宠物装备的pos结束
		public const int EMBED_PET_EQUIP_END=17;
		//宝石镶嵌槽
		public const int EMBED_GEM_NUM=3;
		public const int SLASH_MAX_TIME = 30*60*1000;
		
		public const int SHOP_NPC_TEMP_ID=0;
		
		public const int MAX_PET_SKILL_NUM=8;
		
		public const string LINK_EVENT_PLAYS="plays";//人物
		public const string LINK_EVENT_PETSS="pets";//宠物
		public const string LINK_EVENT_HORSE="horse";//坐骑
		public const string LINK_EVENT_ITEMS="items";//物品
		public const string LINK_EVENT_FABAO="fabao";//法宝
		public const string LINK_EVENT_STALL="stall";//看摊
		public const string LINK_EVENT_DUPNPC="dupnpc";//副本NPC
		public const string LINK_EVENT_OPENWIN="openwin";//打开窗口
		public const string LINK_EVENT_JUMP="jump";//传送
		public const string LINK_EVENT_JOIN_TEAM = "jointeam";//加入队伍
		public const string LINK_EVENT_INVITE_TEAM = "inviteteam";//邀请别人入队
		public const string LINK_EVENT_WALK_TO="walkto";//寻路 
		public const string LINK_EVENT_FAMILY_WELCOME="welcome";//家族欢迎成员
		public const string LINK_EVENT_SELECT_PLAYER="selectplayer";//选中玩家
		public const string LINK_EVENT_HUNYU = "hunyu";//魂玉
		
		/**翅膀*/
		public const string LINK_EVENT_SELECT_WING="wing";
		
		public const int QUESTION_TYPE_LINK=1;
		public const int QUESTION_TYPE_SCAN=2;
		
		public const int LIMIT_GOODS_NUM=3;
        //1-白2-绿3-蓝4-紫5-金
        public static string[] QualityColor = new string[] { "ffffff", "00ff00", "00beff", "ff00ff", "f0ee49", "FF0000" };
        public static string[] QualityName = new string[] { "白", "绿", "蓝", "紫", "金", "红" };
        public static string[] CuilianQualityName = new string[] { "凡铁", "黑铁", "白银", "黄金", "暗金", "红玉", "灵器", "宝器", "仙器", "神器", "远古", "洪荒" };
        public static uint[] Color = new uint[] { 0xffffff, 0x00ff00, 0x00beff, 0xff00ff, 0xf0ee49, 0xff0000 };
        public static string[] itemColor = new string[] {"[ffffff]", "[59fd43]", "[56b0fc]", "[d6b0fd]", "[ffca34]", "[fd6a63]" };

		//小地图最大宽高
		public const int SMALL_MAP_MAX_WIDTH = 610;
		public const int SMALL_MAP_MAX_HEIGHT = 415;
		
		//最大必杀点数
		public const int MAX_BISHA = 5;
		
		public const int EFFECT_QUALITY = 3;
		/**金装品质*/
		public const int GOLD_EQUIP_QUALITY = 4;
//		public const int PET_STAGE_STEP=10;
		
		public const int CHAT_CD = 3500;
		
		//用户消息区
		public const int USER_MSG_NORMAL = 1;
		public const int USER_MSG_ERROR = 3;
		public const int USER_MSG_WARNING = 2;
		
		
		public const string ERROR_SOCKET_CLOSED = "亲爱的仙友，因为网络原因，您暂时与服务器失去连接。我们已为您保存数据，请点击重新登录。";
		public const string ERROR_SERVER_MAINTAIN = "亲爱的仙友，因为服务器维护，您暂时与服务器失去连接。请等待维护完成后再点击重新登录。";
		
		
		public const string SRC_QQGAME = "qqgame";
		public const string SRC_QZONE = "qzone";
		public const string SRC_3366 = "3366";
		public const string SRC_IWAN="union";
		public const string SRC_WEBSITE="website";

        public static string[] ZHENYING_NAME = new string[] { "逆仙保护者", "弑神保护者" };
        public static string[] PETZHENYING_NAME = new string[] { "逆仙魔兽", "弑神魔兽" };
		public const int FENTIANDOUFA_DUP_ID = 16001;
		
		public const int CHECK_FPS_MIN_LEVEL = 13;
		public const int CHECK_FPS_MIN_USER = 30;

        public static string[] DayAry = new string[] { "日", "一", "二", "三", "四", "五", "六" };
		// 妖地争霸副本ID
		public const int YAODIZHENGBA_DUP_ID  = 22001;
		// 连服环id
		public const int LIANFU_CIRCLE_ID  = 4001;
		// 连服每日活动需要屏蔽的id
		public const int BLOCK_DAILY_ACTIVITY_ID  = 1801;
		// 仙王争霸一层的副本ID
		public const int XIANWANGZHENGBA_ONE_DUP_ID  = 24001;
		// 仙王争霸二层的副本ID
		public const int XIANWANGZHENGBA_TWO_DUP_ID  = 24002;
		// 仙王争霸三层的副本ID
		public const int XIANWANGZHENGBA_THREE_DUP_ID  = 24003;
		
		/**按年支付 开通黄钻蓝钻*/
		public const string OPEN_HZ_TIME_YEAR="year";
		
		/**按月支付 开通黄钻蓝钻*/
		public const string OPEN_HZ_TIME_MONTH="month";
		
	 
		public const string JINJIE_ACT="jinjieact";
		// 圣剑的id
		public static int[]  SHENGJIAN_ID_ARR    =new int[]{19017001, 19017002, 19017003, 19017004};
		
		public const int BASE_RALATION_TYPE=7;
		
		public const string WORLD_GRADE_TIPS="world_grade_tips";
		// 1v1王者赛副本id
		public const int WANGZHE_DUP_ID  = 27003;


        public static Color HurtColor = new Color(0.8f, 0.6f, 0.6f, 0f);
        public static Color NormalColor = new Color(0f, 0f, 0f, 0f);

    }
}
