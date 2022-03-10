#include scripts\core_common\struct;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\hud_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\rank_shared;
#include scripts\zm_common\zm_utility.gsc;
#include script_47fb62300ac0bd60.gsc;
#include scripts\zm_common\zm_bgb.gsc;
#include scripts\zm_common\zm_perks.gsc;
#include scripts\zm_common\zm_powerups.gsc;
#include scripts\zm_common\zm_magicbox.gsc;
#include scripts\zm_common\zm_blockers.gsc;
#include scripts\zm_common\zm_pack_a_punch_util.gsc;
#include scripts\zm_common\zm_pack_a_punch.gsc;
#include scripts\zm_common\zm_weapons.gsc;
#include scripts\core_common\aat_shared.gsc;
#include scripts\zm_common\gametypes\globallogic_score.gsc;
#include scripts\zm_common\gametypes\globallogic.gsc;
#include scripts\core_common\contracts_shared.gsc;
#include scripts\zm_common\zm_laststand.gsc;
#include scripts\core_common\laststand_shared.gsc;
#include scripts\core_common\exploder_shared.gsc;
#include scripts\core_common\challenges_shared.gsc;
#include scripts\zm_common\zm_laststand.gsc;
#include scripts\core_common\laststand_shared.gsc;
#include scripts\core_common\match_record.gsc;
#include scripts\zm_common\zm_stats.gsc;


#namespace clientids_shared;

//required
autoexec __init__sytem__()
{
	system::register("clientids_shared", &__init__, undefined, undefined);
}

//required
__init__()
{
    callback::on_start_gametype(&init);
    callback::on_spawned(&onPlayerSpawned);
}
