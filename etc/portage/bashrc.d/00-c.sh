EPatchUser() {
if [ "$EAPI" == "5" ]; then
	if ! type epatch_user > /dev/null 2>&1; then
		local names="EPATCH_USER_SOURCE epatch_user epatch evar_push evar_push_set evar_pop estack_push estack_pop"
		source <(awk "/^# @(FUNCTION|VARIABLE): / { p = 0 } /^# @(FUNCTION|VARIABLE): (${names// /|})\$/ { p = 1 } p { print }" ${PORTDIR}/eclass/eutils.eclass)
		clog epatch_user sourced
	fi
	cd "$S"
	epatch_user
	for name in $names; do
		unset $name
	done
fi
}
BashrcdPhase compile EPatchUser
