using UnityEngine;
using System.Collections;

namespace  MysqlModel 
{
	/// <summary>
	/// map_config:实体类(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public partial class map_config
	{
		public map_config()
		{}
		#region Model
		private string _goods_des;
		private string _goods_des_i18n;
		private string _fresh_time_des;
		private string _fresh_time_des_i18n;
		private string _boss_des;
		private string _boss_des_i18n;
		private string _level_des;
		private string _level_des_i18n;
		private string _monster_des;
		private string _monster_des_i18n;
		private int _die_map_y;
		private int _die_map_x;
		private int _die_map_id;
		private int _map_pk_model;
		private int _map_protect_buff;
		private int _map_can_call_out_god_pet;
		private int _map_can_onblessing;
		private int _map_shift;
		private int _map_safe;
		private int _map_contest;
		private int _map_level_max;
		private int _map_level_min;
		private int _map_id;
		private string _map_name;
		private string _map_name_i18n;
		private int _map_show_order;
		private int _is_light;
		private string _map_music;
		private int _transport_x=0;
		private int _transport_y=0;
		/// <summary>
		/// 
		/// </summary>
		public string goods_des
		{
			set{ _goods_des=value;}
			get{return _goods_des;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string goods_des_i18n
		{
			set{ _goods_des_i18n=value;}
			get{return _goods_des_i18n;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string fresh_time_des
		{
			set{ _fresh_time_des=value;}
			get{return _fresh_time_des;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string fresh_time_des_i18n
		{
			set{ _fresh_time_des_i18n=value;}
			get{return _fresh_time_des_i18n;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string boss_des
		{
			set{ _boss_des=value;}
			get{return _boss_des;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string boss_des_i18n
		{
			set{ _boss_des_i18n=value;}
			get{return _boss_des_i18n;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string level_des
		{
			set{ _level_des=value;}
			get{return _level_des;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string level_des_i18n
		{
			set{ _level_des_i18n=value;}
			get{return _level_des_i18n;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string monster_des
		{
			set{ _monster_des=value;}
			get{return _monster_des;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string monster_des_i18n
		{
			set{ _monster_des_i18n=value;}
			get{return _monster_des_i18n;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int die_map_y
		{
			set{ _die_map_y=value;}
			get{return _die_map_y;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int die_map_x
		{
			set{ _die_map_x=value;}
			get{return _die_map_x;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int die_map_id
		{
			set{ _die_map_id=value;}
			get{return _die_map_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int map_pk_model
		{
			set{ _map_pk_model=value;}
			get{return _map_pk_model;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int map_protect_buff
		{
			set{ _map_protect_buff=value;}
			get{return _map_protect_buff;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int map_can_call_out_god_pet
		{
			set{ _map_can_call_out_god_pet=value;}
			get{return _map_can_call_out_god_pet;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int map_can_onBlessing
		{
			set{ _map_can_onblessing=value;}
			get{return _map_can_onblessing;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int map_shift
		{
			set{ _map_shift=value;}
			get{return _map_shift;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int map_safe
		{
			set{ _map_safe=value;}
			get{return _map_safe;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int map_contest
		{
			set{ _map_contest=value;}
			get{return _map_contest;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int map_level_max
		{
			set{ _map_level_max=value;}
			get{return _map_level_max;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int map_level_min
		{
			set{ _map_level_min=value;}
			get{return _map_level_min;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int map_id
		{
			set{ _map_id=value;}
			get{return _map_id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string map_name
		{
			set{ _map_name=value;}
			get{return _map_name;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string map_name_i18n
		{
			set{ _map_name_i18n=value;}
			get{return _map_name_i18n;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int map_show_order
		{
			set{ _map_show_order=value;}
			get{return _map_show_order;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int is_light
		{
			set{ _is_light=value;}
			get{return _is_light;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string map_music
		{
			set{ _map_music=value;}
			get{return _map_music;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int transport_x
		{
			set{ _transport_x=value;}
			get{return _transport_x;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int transport_y
		{
			set{ _transport_y=value;}
			get{return _transport_y;}
		}
		#endregion Model

	}
}
