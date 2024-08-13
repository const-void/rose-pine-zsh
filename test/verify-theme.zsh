#!/bin/zsh
# verify-theme.zsh [theme]
#
# (C) 2024 const void*, free + open
CUR_PATH=$(dirname ${0:a})
THEME="rose-pine"
# opt param chk
if [[ "${#}" -ne 0 ]]; then
  local theme_input=$1

  if [[ -f "${CUR_PATH}/../dist/themes/${theme_input}.zsh" ]]; then
    THEME="${theme_input}"
  else
    echo "Usage: verify-theme.zsh <theme>"
    echo ""
    echo "Theme [${theme_input}] not found"
    exit 1
  fi
fi
source ${CUR_PATH}/../dist/themes/${THEME}.zsh

## true-color ansi token helpers
term16m_bgn='\033['
term16m_end='m'
term16m_bg='48;2;'
term16m_fg='38;2;'
term16m_black='0;0;0'
term16m_reset="${term16m_bgn}0${term16m_end}"

function term16m_set_color() {
  echo "${term16m_bgn}${term16m_bg}$1;${term16m_fg}$2${term16m_end}"
}

TERM16M_BLACK=$(term16m_set_color ${term16m_black} ${term16m_black})


function test_bg() {
  local bg=$1
  local fg=$2
  local txt=$3

  echo -en "$(term16m_set_color $bg $fg)${txt}"
}

function test_fg() {
  local fg=$1
  local txt=$2

  echo -en "${TERM16M_BLACK}  " 
  test_bg "${TERM16M_BASE}"    "${fg}" "${txt}"
  test_bg "${TERM16M_SURFACE}" "${fg}" "${txt}"
  test_bg "${TERM16M_OVERLAY}" "${fg}" "${txt}"
  echo -e "${TERM16M_BLACK}  ${term16m_reset}"
}

function test_fg_sel() {
  local fg=$1
  local txt=$2

  echo -en "${TERM16M_BLACK}  " 
  test_bg "${TERM16M_SEL_L}" "${fg}" "${txt}"
  test_bg "${TERM16M_SEL_M}" "${fg}" "${txt}"
  test_bg "${TERM16M_SEL_H}" "${fg}" "${txt}"
  echo -e "${TERM16M_BLACK}  ${term16m_reset}"
}

## print theme ##############

# hdr
echo        ""
echo -e     "$(term16m_set_color $TERM16M_SURFACE $TERM16M_ROSE)${THEME}${term16m_reset}"
echo        ""
echo -e     "${TERM16M_BLACK}                                  ${term16m_reset}"

# normal
test_fg     "${TERM16M_MUTED}"  "   MUTED  "
test_fg     "${TERM16M_SUBTLE}" "  SUBTLE  "
test_fg     "${TERM16M_TEXT}"   "   TEXT   "
test_fg     "${TERM16M_LOVE}"   "   LOVE   "
test_fg     "${TERM16M_GOLD}"   "   GOLD   "
test_fg     "${TERM16M_ROSE}"   "   ROSE   "
test_fg     "${TERM16M_PINE}"   "   PINE   "
test_fg     "${TERM16M_FOAM}"   "   FOAM   "
test_fg     "${TERM16M_IRIS}"   "   IRIS   "

# selected
test_fg_sel "${TERM16M_MUTED}"  "   MUTED  "
test_fg_sel "${TERM16M_SUBTLE}" "  SUBTLE  "
test_fg_sel "${TERM16M_TEXT}"   "   TEXT   "
test_fg_sel "${TERM16M_LOVE}"   "   LOVE   "
test_fg_sel "${TERM16M_GOLD}"   "   GOLD   "
test_fg_sel "${TERM16M_ROSE}"   "   ROSE   "
test_fg_sel "${TERM16M_PINE}"   "   PINE   "
test_fg_sel "${TERM16M_FOAM}"   "   FOAM   "
test_fg_sel "${TERM16M_IRIS}"   "   IRIS   "

# footer
echo -e "${TERM16M_BLACK}                                  ${term16m_reset}"
echo        ""