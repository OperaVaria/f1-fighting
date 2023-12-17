#!/bin/bash

# F1 Fighting Championship - A Simple Terminal RPG Game
# Version 0.1 - Alpha
# Created by OperaVaria
#
# This is a simple, comedic, RPG meme game with text adventure elements, centred
# around F1 fan rivalries that got a bit out of hand lately. The project  was
# created as a Bash scripting exercise (and skill showcase). Nothing in this game is meant to be
# taken seriously.
#
# As of now, the game is highly unbalanced, much optimization is needed.
#
# Mainly made with nano, with some work in Sublime Text and Visual Studio Code.
#
# Tested on Lubuntu 22.04 LTS, GNU bash 5.1.16(1)-release and
#           Windows 11 Pro version 23H2, GNU bash 5.2.21(1)-release.
# Should work in any Linux distribution's default terminal, or with Git Bash on Windows.


# Licence:
# Copyright © 2023, OperaVaria

# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with this program. If not,
# see <https://www.gnu.org/licenses/>

# TODO:
# More testing
# Possible typos

# Set global text color variables
BOLDRED="\e[1;31m"
BOLDGREEN="\e[1;32m"
BOLDYELLOW="\e[1;33m"
# BOLDBLUE="\e[1;34m"
BOLDCYAN="\e[1;36m"
BOLDWHITE="\e[1;37m"
# ULINEBOLDYELLOW="\e[1;4;33m"
# ULINEBOLDBLUE="\e[1;4;34m"
ULINEBOLDWHITE="\e[1;4;37m"
COLORRESET="\e[0m"

# Unintentional or spam inputs are read into a discard variable throughout
# the script with: read -r -n 100 -t (seconds waiting) discard
declare discard


#####################
# INTRO AND OPTIONS #
#####################

# Display intro text
intro() {
  sleep 1
  stty -echo # Disable echo
  echo -e "${BOLDCYAN}Welcome to F1 Fighting Championship${COLORRESET}"
  # COLORRESET is needed every time to avoid cursor coloration.
  sleep 1
  echo -e "${BOLDCYAN}Version 0.1 Alpha${COLORRESET}"
  sleep 1
  echo -e "${BOLDWHITE}\n***${COLORRESET}"
  read -r -n 100 -t 1 discard
  player_name
}

# Enter player name
player_name() {
  stty echo # Re-enable echo to see input.
  echo -n -e "${BOLDWHITE}\nInput your player name and press enter: "
  read -r player_name
  stty -echo # Re-disable echo.
  read -r -n 100 -t 1 discard
  echo -e "Your player name is" \
          "\"${COLORRESET}${ULINEBOLDWHITE}${player_name}${COLORRESET}${BOLDWHITE}\"." \
          "Confirm? (Y/N)${COLORRESET}"
  while read -r -n 1 player_name_input; do
    case $player_name_input in
      Y|y)
        sleep 0.5
        echo -e "${BOLDWHITE}Name confirmed!${COLORRESET}"
        break
        ;;
      N|n)
        sleep 0.5
        echo -e "${BOLDWHITE}\nReturning...${COLORRESET}"
        sleep 1
        player_name
        ;;
      *)
        sleep 0.5
        echo -e "${BOLDRED}Invalid input.${COLORRESET}"
        read -r -n 100 -t 0.5 discard
        ;;
    esac
  done
  sleep 1
  echo -e "${BOLDWHITE}\n***${COLORRESET}"
  sleep 1
  class_select
}

# Player class selection menus
class_select() {
  printf "%b\n" "${BOLDYELLOW}\n${player_name}, pick your class:" \
         "1.Tifosi" "2.TeamLH" "3.Orange Army" "4.Retro Schumacher Fan" \
         "5.Latin American Loco${COLORRESET}"
  sleep 1
  echo -e "${BOLDYELLOW}\nUse the number keys (1-5)" \
          "to make your selection.${COLORRESET}"
  read -r -n 100 -t 1 discard
  echo -e "${BOLDYELLOW}For more information on the different classes," \
          "press the \"I\" key.${COLORRESET}"
 # Setting player stats.
  while read -r -n 1 class_select_input; do
    case $class_select_input in
      1)
        player_class="Tifosi"
        player_hp=40
        base_player_hp=40
        max_player_hp=45
        player_attack=8
        player_agility=4
        break
        ;;
      2)
        player_class="TeamLH"
        player_hp=45
        base_player_hp=45
        max_player_hp=50
        player_attack=7
        player_agility=3
        break
        ;;
      3)
        player_class="Orange Army"
        player_hp=35
        base_player_hp=35
        max_player_hp=40
        player_attack=9
        player_agility=5
        break
        ;;
      4)
        player_class="Retro Schumacher Fan"
        player_hp=50
        base_player_hp=50
        max_player_hp=55
        player_attack=6
        player_agility=2
        break
        ;;
      5)
        player_class="Latin American Loco"
        player_hp=30
        base_player_hp=30
        max_player_hp=35
        player_attack=10
        player_agility=6
        break
        ;;
      I|i)
        sleep 1
        printf "%b\n" "${ULINEBOLDWHITE}\nTifosi:${COLORRESET}" \
        "${BOLDWHITE}The Tifosi are the fanatical supporters of Scuderia Ferrari. They say" \
        "that catch fencing was invented not to collect flying debris, but to keep" \
        "the Tifosi from committing ritual suicide by running in front of their" \
        "beloved scarlet cars.\n${COLORRESET}"
        sleep 0.3
        printf "%b\n" "${ULINEBOLDWHITE}TeamLH:${COLORRESET}" \
        "${BOLDWHITE}TeamLH blends the bluntness of traditional British Steel with that of" \
        "critical race theory. Referred to once as \"the most insufferable people" \
        "in the world\", TeamLH has currently the highest death threats/day rate" \
        "on Twitter.\n${COLORRESET}"
        sleep 0.3
        printf "%b\n" "${ULINEBOLDWHITE}Orange Army:${COLORRESET}" \
        "${BOLDWHITE}Dutch Verstappen fans are relative newcomers to the scene, however," \
        "they already made their mark as the leading cause of grandstand" \
        "disturbances at grand prix venues around the continent. Beware:" \
        "no one is safe in the clouds of the Orange Mist.\n${COLORRESET}"
        sleep 0.3
        printf "%b\n" "${ULINEBOLDWHITE}Retro Schumacher Fan:${COLORRESET}" \
        "${BOLDWHITE}With their legendary world champions retired, and no home grand prix," \
        "German fans have not much to look forward to these days. But" \
        "caution is advised, as their severe beer intoxication and decades" \
        "of experience makes them a formidable opponent.\n${COLORRESET}"
        sleep 0.3
        printf "%b\n" "${ULINEBOLDWHITE}Latin American Loco:${COLORRESET}" \
        "${BOLDWHITE}Mexican and Brazilian fans are known to drown out even the loudest" \
        "engines. They create an atmosphere unrivaled by anything on the" \
        "calendar, and defend their local favorites at all cost, no matter" \
        "how useless these \"heroes\" they may be!\n${COLORRESET}"
        read -r -n 100 -t 1 discard
        echo -e "${BOLDYELLOW}Pick your class (1-5):${COLORRESET}"
        ;;
      *)
       sleep 0.5
        echo -e "${BOLDRED}Invalid input, please try again.${COLORRESET}"
        read -r -n 100 -t 0.5 discard
        ;;
    esac
  done
  sleep 1
  echo -e "${BOLDGREEN}\nYou've selected the \"${player_class}\" class." \
          "Your HP is ${player_hp}," \
          "your attack value is ${player_attack}.${COLORRESET}"
  sleep 1
  echo -e "${BOLDGREEN}If you're satisfied with your pick," \
          "press \"C\" to continue.${COLORRESET}"
  read -r -n 100 -t 1 discard
  echo -e "${BOLDGREEN}Otherwise, press \"R\"" \
          "to repeat the selection process.${COLORRESET}"
  while read -r -n 1 confirm_input; do
    case $confirm_input in
      C|c)
        sleep 1
        circuit_select
        ;;
      R|r)
        sleep 0.5
        echo -e "${BOLDWHITE}\nReturning...${COLORRESET}"
        sleep 1
        class_select
        ;;
      *)
        sleep 0.5
        echo -e "${BOLDRED}Invalid input.${COLORRESET}"
        read -r -n 100 -t 0.5 discard
        ;;
    esac
  done
}

# Circuit selection menus
circuit_select() {
  printf "%b\n" "${BOLDYELLOW}\nPick the venue:" \
         "1.Monza" "2.Silverstone" "3.Zandvoort" \
         "4.Hungaroring" "5.Mexico City${COLORRESET}"
  sleep 1
  echo -e "${BOLDYELLOW}\nAs before, use the number keys (1-5)" \
          "to make your selection.${COLORRESET}"
  read -r -n 100 -t 1 discard
  echo -e "${BOLDYELLOW}For more information on the circuits," \
          "press the \"I\" key.${COLORRESET}"
  # The circuit selection determines the boss.
  # The boss names are punny and really bad.
  while read -r -n 1 circuit_select_input; do
    case $circuit_select_input in
      1)
        circuit="Monza"
        boss_name="Mario Testarossa"
        boss_class="Tifosi"
        boss_hp=45
        boss_attack=10
        boss_agility=5
        break
        ;;
      2)
        circuit="Silverstone"
        boss_name="Nigel Fencebender"
        boss_class="TeamLH"
        boss_hp=50
        boss_attack=9
        boss_agility=4
        break
        ;;
      3)
        circuit="Zandvoort"
        boss_name="Ruud van Goulingan"
        boss_class="Orange Army"
        boss_hp=40
        boss_attack=11
        boss_agility=6
        break
        ;;
      4)
        circuit="Hungaroring"
        boss_name="Hans Benzinkopf"
        boss_class="Retro Schumacher Fan"
        boss_hp=55
        boss_attack=8
        boss_agility=3
        break
        ;;
      5)
        circuit="Mexico City"
        boss_name="Pedro Peraltada"
        boss_class="Latin American Loco"
        boss_hp=35
        boss_attack=12
        boss_agility=7
        break
        ;;
      I|i)
        sleep 1
        printf "%b\n" "${ULINEBOLDWHITE}\nMonza:${COLORRESET}" \
        "${BOLDWHITE}The historic Monza circuit is the spiritual home of the Tifosi. Red mist," \
        "makeshift stands, and Italian profanities are the decades old traditions" \
        "of the Ferrari home track. Only the bravest of souls dare to venture here" \
        "not wearing the local scarlet red." \
        "The venue boss is Mario Testarossa, a Super Mario looking gentleman," \
        "sporting a large asset of historical Ferrari paraphernalia, and eager" \
        "to punish does who don't.\n${COLORRESET}"
        sleep 0.3
        printf "%b\n" "${ULINEBOLDWHITE}Silverstone:${COLORRESET}" \
        "${BOLDWHITE}Silverstone, the oldest and muddiest Formula 1 circuit, home of track" \
        "invasions and TeamLH. The motorsport loving British crowd is only" \
        "slightly more docile than their footballing counterpart, but don't let" \
        "this fool you, complacency is a dangerous mistake to make by anyone" \
        "venturing into the heart of the HamiltonLand." \
        "The venue boss is Nigel Fencebender, and old-school British motorsport" \
        "fan, currently standing half-naked atop the stand.\n${COLORRESET}"
        sleep 0.3
        printf "%b\n" "${ULINEBOLDWHITE}Zandvoort:${COLORRESET}" \
        "${BOLDWHITE}Zandvoort only recently returned to the Grad Prix calendar, but everyone" \
        "feared what would happen,if all the mischievous Dutch fans concentrated" \
        "in a single location. The crowd delivered richly, as expected, committing" \
        "every misdemeanor in the book in a span of three days.Be ready, be careful," \
        "and be afraid." \
        "The venue boss is Ruud van Gouligan, and orange clad Verstappen fan" \
        "currently on a balanced diet of MDMA and beer.\n${COLORRESET}"
        sleep 0.3
        printf "%b\n" "${ULINEBOLDWHITE}Hungaroring:${COLORRESET}" \
        "${BOLDWHITE}With no German Grand Prix, the foster home for the Retro Schumacher" \
        "fans is the Hungaroring, the cheapest option within reasonable distance" \
        "from home. Though the glory days are long past, the excessive beer" \
        "consumption in the summer heat awakens even the most haggard old warriors" \
        "from their long slumber." \
        "The venue boss is Hans Benzinkopf, sizable on both axes, sporting long" \
        "unkempt hair and a respectable beer belly.\n${COLORRESET}"
        sleep 0.3
        printf "%b\n" "${ULINEBOLDWHITE}Mexico City:${COLORRESET}" \
        "${BOLDWHITE}One of the bastions for the Latin American Locos, the Hermanos Rodríguez" \
        "track is no place for the faint hearted. Mexican fans are prepared do" \
        "anything for their home favourites, and if you stand in the way," \
        "they would do anything to you as well." \
        "The venue boss is Pedro Peraltada, who wares a Luchador outfit, but" \
        "is determined to do actual harm this time.\n${COLORRESET}"
        read -r -n 100 -t 1 discard
        echo -e "${BOLDYELLOW}Pick a venue (1-5):${COLORRESET}"
        ;;
      *)
        sleep 0.5
        echo -e "${BOLDRED}Invalid input, please try again.${COLORRESET}"
        read -r -n 100 -t 0.5 discard
        ;;
    esac
  done
  sleep 1
  echo -e "${BOLDGREEN}\nYou've selected \"${circuit}\" circuit!${COLORRESET}"
  sleep 1
  echo -e "${BOLDGREEN}If you're satisfied with your pick," \
          "press \"C\" to continue.${COLORRESET}"
  read -r -n 100 -t 1 discard
  echo -e "${BOLDGREEN}Otherwise, press \"R\"" \
          "to repeat the selection process.${COLORRESET}"
  while read -r -n 1 confirm_input; do
    case $confirm_input in
      C|c)
        sleep 1
        intro_battle_setup
        ;;
      R|r)
        sleep 0.5
        echo -e "${BOLDWHITE}\nReturning...${COLORRESET}"
        sleep 1
        circuit_select
        ;;
      *)
        sleep 0.5
        echo -e "${BOLDRED}Invalid input.${COLORRESET}"
        read -r -n 100 -t 0.5 discard
        ;;
    esac
  done
}

################
# BATTLE SETUP #
################

# Introductory battle text and setup
intro_battle_setup() {
  echo -e "${BOLDWHITE}\n***${COLORRESET}"
  sleep 1
  echo -e "${BOLDYELLOW}\n${player_name}, your goal is to reach your" \
          "allocated seat at the venue.${COLORRESET}"
  sleep 1
  echo -e "${BOLDYELLOW}But life is never simple: you have to battle both" \
          "security and hostile fans to achieve your goal.${COLORRESET}"
  read -r -n 100 -t 1 discard
  echo -e "${BOLDYELLOW}Press any key to advance the story${COLORRESET}"
  read -r -n 1 discard
  echo -e "${BOLDWHITE}\n***${COLORRESET}"
  read -r -n 100 -t 1 discard
  echo -e "${BOLDWHITE}\nYou’re approaching the gates of" \
          "\"$circuit\" circuit.${COLORRESET}"
  read -r -n 1 discard
  echo -e "${BOLDWHITE}The traffic was horrible, the line is long," \
          "and the track's infrastructure is as poor as expected.${COLORRESET}"
  read -r -n 1 discard
  echo -e "${BOLDWHITE}Tensions are high.${COLORRESET}"
  read -r -n 1 discard
  echo -e "${BOLDWHITE}The security guard is \"giving you the shit\" for" \
          "the huge stash of alcoholic beverages" \
          "you're dragging with you.${COLORRESET}"
  read -r -n 1 discard
  echo -e "${BOLDWHITE}You must get in with your booze," \
          "no matter the cost.${COLORRESET}"
  read -r -n 1 discard
  echo -e "${BOLDRED}A fight ensues!${COLORRESET}"
  # Set security guard stats
    opponent_class="Security guard"
    opponent_hp=25
    opponent_attack=5
    opponent_agility=1 # Only Security guard has agility=1.
  battle_number=0 # Intro battle is 0, random battles 1-3, boss battle is 4.
  red_bull=5 # Red Bull is the healing item, 5 given at the beginning.
  sleep 1
  battle_sequence_setup
}

# Random battle intro text
random_battle_intro() {
  echo -e "${BOLDWHITE}\nYou've managed to enter the venue.${COLORRESET}"
  read -r -n 1 discard
  echo -e "${BOLDWHITE}You now need to make your way to your seat" \
          "on the discount stand.${COLORRESET}"
  read -r -n 1 discard
  echo -e "${BOLDWHITE}But be careful," \
          "the general admission area is full of dangers!${COLORRESET}"
  read -r -n 1 discard
  movement
}

# Faux movement in GA area
movement() {
  echo -e "${BOLDGREEN}\nPress \"W\",\"A\",\"S\", or \"D\"" \
          "to advance in any direction${COLORRESET}"
  while read -r -n 1 direction_input; do
    case $direction_input in
      W|w)
        sleep 0.5
        echo -e "${BOLDWHITE}You moved north.${COLORRESET}"
        break
        ;;
      A|a)
        sleep 0.5
        echo -e "${BOLDWHITE}You moved west.${COLORRESET}"
        break
        ;;
      S|s)
        sleep 0.5
        echo -e "${BOLDWHITE}You moved south.${COLORRESET}"
        break
        ;;
      D|d)
        sleep 0.5
        echo -e "${BOLDWHITE}You moved east.${COLORRESET}"
        break
        ;;
      *)
        sleep 0.5
        echo -e "${BOLDRED}Invalid input.${COLORRESET}"
        read -r -n 100 -t 0.5 discard
        ;;
    esac
  done
  read -r -n 100 -t 1 discard
  # 50% chance of a random encounter after every move
  local -i encounter_chance=$((RANDOM % 2))
  # 25% chance of finding a can of Red Bull every move if there is no fight
  local -i item_chance=$((RANDOM % 4))
  if [[ $encounter_chance -eq 1 ]]; then
    random_battle_setup
  elif [[ $item_chance -eq 3 ]]; then
    red_bull=$((red_bull + 1))
    echo -e "${BOLDYELLOW}You've found a can of Red Bull!.${COLORRESET}"
    sleep 1
    movement
  else
    movement
  fi
}

# Random encounter setup
random_battle_setup() {
  echo -e "${BOLDRED}Random encounter!${COLORRESET}"
  sleep 1
  echo -e "${BOLDYELLOW}An opponent approaches.${COLORRESET}"
  sleep 1
  # Randomly selects a class from the pool every time.
  opponents=("Tifosi" "TeamLH" "Orange Army" "Retro Schumacher Fan" "Latin American Loco")
  opponent_class=${opponents[ $RANDOM % ${#opponents[@]} ]}
  # Setting opponent stats.
  case $opponent_class in
    "Tifosi")
      opponent_hp=40
      opponent_attack=8
      opponent_agility=4
      ;;
    "TeamLH")
      opponent_hp=45
      opponent_attack=7
      opponent_agility=3
      ;;
    "Orange Army")
      opponent_hp=35
      opponent_attack=9
      opponent_agility=5
      ;;
    "Retro Schumacher Fan")
      opponent_hp=50
      opponent_attack=6
      opponent_agility=2
      ;;
    "Latin American Loco")
      opponent_hp=30
      opponent_attack=10
      opponent_agility=6
      ;;
  esac
  echo -e "${BOLDYELLOW}He's from the \"${opponent_class}\" camp.${COLORRESET}"
  sleep 1
  # Same class text setup
  if [[ "$player_class" == "$opponent_class" ]]; then
    echo -e "${BOLDRED}Oh no, it's a civil war!${COLORRESET}"
    sleep 1
    echo -e "${BOLDRED}You're too drunk to realize" \
            "you're on the same team!${COLORRESET}"
    sleep 1
  fi
  battle_sequence_setup
}

# Boss battle setup
boss_battle_intro() {
  echo -e "${BOLDWHITE}\nYou've finally managed to reach your stand.${COLORRESET}"
  read -r -n 1 discard
  echo -e "${BOLDWHITE}But here awaits the final boss of the track.${COLORRESET}"
  read -r -n 1 discard
  echo -e "${BOLDWHITE}The leader of the ${boss_class} faction:" \
          "${boss_name}.${COLORRESET}"
  read -r -n 1 discard
  echo -e "${BOLDWHITE}This is your final battle!${COLORRESET}"
  sleep 1
  # Easter egg: if the boss is from your faction then the fight is canceled.
  if [[ "$player_class" == "$boss_class" ]]; then
    echo -e "${BOLDRED}But the boss realizes you are on the same team!${COLORRESET}"
    sleep 1
    echo -e "${BOLDWHITE}Differences are ironed out," \
            "you can take your seat peacefully!${COLORRESET}"
    victory
  else
    # Red Bull refill for the boss-fight
    echo -e "${BOLDYELLOW}A teammate tosses you a pack of Red Bulls" \
            "for the fight.${COLORRESET}"
    sleep 1
    red_bull=$((red_bull + 3))
    # Setting boss stats for opponent variables.
    opponent_class=$boss_class
    opponent_hp=$boss_hp
    opponent_attack=$boss_attack
    opponent_agility=$boss_agility
    battle_sequence_setup
  fi
}

###################
# BATTLE SEQUENCE #
###################

# Battle sequence initial setup
battle_sequence_setup() {
  # Declare player_defend variable (0=inactive)
  player_defend=0
  echo -e "${BOLDRED}Get read -ry!${COLORRESET}"
  sleep 1
  if [[ $opponent_agility -gt $player_agility ]]; then
    echo -e "${BOLDYELLOW}Your nimble opponent strikes first.${COLORRESET}"
    sleep 1
    opponent_round
  # If agility is equal than 50% chance to have the first strike.
  elif [[ $opponent_agility -eq $player_agility ]]; then
    local -i start_chance=$((RANDOM % 2))
    if [[ $start_chance -eq 0 ]]; then
      echo -e "${BOLDYELLOW}Your opponent was faster this time," \
              "he strikes first.${COLORRESET}"
      sleep 1
      opponent_round
    elif [[ $start_chance -eq 1 ]]; then
      echo -e "${BOLDYELLOW}You get the first strike this time.${COLORRESET}"
      read -r -n 100 -t 1 discard
      player_round
    fi
  else
    echo -e "${BOLDYELLOW}You get the first strike.${COLORRESET}"
    read -r -n 100 -t 1 discard
    player_round
  fi
}

# Player attack round
player_round() {
  #Player input
  echo -e "${BOLDGREEN}\nPress \"A\" to attack, \"D\" to defend," \
          "or \"R\" to heal with Red Bull (${red_bull} left)."
  echo -e "Current health: ${player_hp}HP.${COLORRESET}"
  while read -r -n 1 attack_input ; do
    case $attack_input in
      A|a) #Attack
        local -i player_chance=$((RANDOM % 4)) #RPG hit chance: 25% miss.
        # Miss
        if [[ $player_chance -eq 0 ]]; then
          sleep 0.5
          echo -e "${BOLDYELLOW}You missed!${COLORRESET}"
        # Charged attack
        elif [[ $player_chance -gt 0 && player_defend -eq 1 ]]; then
          sleep 0.5
          local -i player_hit=$((player_attack + 4))
          opponent_hp=$((opponent_hp - player_hit))
          echo -e "${BOLDYELLOW}Charged hit." \
                  "Damage: ${player_hit}HP${COLORRESET}"
        # Normal attack
        else
          sleep 0.5
          # Attack randomness: 0-2 points added.
          local -i player_hit=$((RANDOM % 3 + player_attack))
          opponent_hp=$((opponent_hp - player_hit))
          echo -e "${BOLDYELLOW}Opponent hit. Damage: ${player_hit}HP${COLORRESET}"
        fi
        player_defend=0 # Resetting player_defend value.
        break
        ;;
      D|d) # Defend
        sleep 0.5
        echo -e "${BOLDYELLOW}Defending and charging next attack.${COLORRESET}"
        player_defend=1 # Defence charging enabled.
        break
        ;;
      R|r) # Heal
        sleep 0.5
        if [[ $red_bull -le 0 ]]; then
          echo -e "${BOLDRED}You're out of Red Bull!${COLORRESET}"
        elif [[ $player_hp -ge $base_player_hp ]]; then
          echo -e "${BOLDYELLOW}Your HP is ${player_hp}, no healing needed.${COLORRESET}"
        else
          red_bull=$((red_bull - 1))
          old_player_hp=$player_hp
          player_hp=$((player_hp + 25))
          # Player HP can never be higher than class-dependent max HP.
          if [[ $player_hp -gt $max_player_hp ]]; then
            player_hp=$max_player_hp
          fi
          local -i hp_recovery=$((player_hp - old_player_hp))
          echo -e "${BOLDYELLOW}Red Bull gives you wings!" \
                  "You've recovered ${hp_recovery}HP.${COLORRESET}"
          # 5 points higher HP than base HP allowed.
          if [[ $player_hp -gt $base_player_hp ]]; then
            sleep 1
            echo -e "${BOLDRED}Health Supercharged!${COLORRESET}"
          fi
          player_defend=0
          break
        fi
        ;;
      *)
        sleep 0.5
        echo -e "${BOLDRED}Invalid selection!${COLORRESET}"
        ;;
    esac
  done
  sleep 1
  opponent_check
}

# Opponent status check
opponent_check() {
  if [[ $opponent_hp -le 0 ]]; then
    round_select
  elif [[ $opponent_hp -le 5 ]]; then
    echo -e "${BOLDYELLOW}Your opponent attacks." \
            "He's nearly knocked out!${COLORRESET}"
  else
    echo -e "${BOLDYELLOW}Your opponent attacks!${COLORRESET}"
  fi
  sleep 1
  opponent_round
}

# Opponent attack round
opponent_round() {
  # RPG hit chance: 25% miss, same as player
  local -i opponent_chance=$((RANDOM % 4))
  if [[ $opponent_chance -eq 0 ]]; then
     echo -e "${BOLDYELLOW}Opponent missed!${COLORRESET}"
   # Defending halves the hit.
   elif [[ $opponent_chance -gt 0 && $player_defend -eq 1 ]]; then
     local -i opponent_pre_hit=$((RANDOM % 3 + opponent_attack))
     local -i opponent_hit=$((opponent_pre_hit / 2))
     echo -e "${BOLDYELLOW}You've been hit, but it's deflected." \
             "Damage: ${opponent_hit}HP.${COLORRESET}"
   else
     # Attack randomness: 0-2 points added, same as player.
     local -i opponent_hit=$((RANDOM % 3 + opponent_attack))
     player_hp=$((player_hp - opponent_hit))
     echo -e "${BOLDYELLOW}You've been hit." \
             "Damage: ${opponent_hit}HP.${COLORRESET}"
  fi
  read -r -n 100 -t 1 discard
  # Player defeat if
  if [[ $player_hp -le 0 ]]; then
    defeat
  fi
  player_round
}

####################
# ENDINGS AND EXIT #
####################

# Battle victory and round select routine
round_select() {
  # Different flavour text for rounds
  case $battle_number in
    0)
      echo -e "${BOLDCYAN}\nYou've defeated the security guard!${COLORRESET}"
      ;;
    1|2|3)
      echo -e "${BOLDCYAN}\nYou've defeated your opponent!${COLORRESET}"
      ;;
    4)
      echo -e "${BOLDCYAN}\nFinal boss defeated!${COLORRESET}"
      ;;
  esac
  read -r -n 100 -t 1 discard
  # Round select and advance
  case $battle_number in
    0)
      battle_number=$((battle_number +1))
      random_battle_intro
      ;;
    1|2)
      battle_number=$((battle_number +1))
      movement
      ;;
    3)
      battle_number=$((battle_number +1))
      boss_battle_intro
      ;;
    4)
      victory
      ;;
  esac
}

# Victory and retry option
victory() {
  echo -e "${BOLDRED}You've won all fights and managed to avoid arrest!" \
          "Congratulations, ${player_name}!${COLORRESET}"
  read -r -n 100 -t 1 discard
  echo -e "${BOLDWHITE}Press \"Y\" to challenge again," \
          "otherwise press \"N\" to exit.${COLORRESET}"
  while read -r -n 1 victory_retry_input; do
    case $victory_retry_input in
      Y|y)
        sleep 0.5
        echo -e "${BOLDWHITE}\nReturning...${COLORRESET}"
        read -r -n 100 -t 1 discard
        class_select
        ;;
      N|n)
        read -r -n 100 -t 0.5 discard
        quit
        ;;
      *)
        sleep 0.5
        echo -e "${BOLDRED}Invalid input, press \"Y\" or \"N\".${COLORRESET}"
        read -r -n 100 -t 0.5 discard
        ;;
    esac
  done
}

# Defeat and retry option
defeat() {
  echo -e "${BOLDRED}${player_name}, you have been defeated!${COLORRESET}"
  sleep 1
  echo -e "${BOLDWHITE}\nTo retry with your current class and venue selection" \
          "(\"${player_class}\" and \"${circuit}\"), press \"C\".${COLORRESET}"
  sleep 1
  echo -e "${BOLDWHITE}To play again with a different setup, press \"D\"${COLORRESET}"
  read -r -n 100 -t 1 discard
  echo -e "${BOLDWHITE}To quit the game, press \"Q\"${COLORRESET}"
  while read -r -n 1 defeat_retry_input; do
    case $defeat_retry_input in
      C|c)
        sleep 0.5
        echo -e "${BOLDWHITE}\nRestoring HP...${COLORRESET}"
        case $player_class in
          "Tifosi")
            player_hp=40
            ;;
          "TeamLH")
            player_hp=45
            ;;
          "Orange Army")
            player_hp=35
            ;;
          "Retro Schumacher Fan")
            player_hp=50
            ;;
          "Latin American Loco")
            player_hp=30
            ;;
        esac
        sleep 1
        echo -e "${BOLDWHITE}Done!${COLORRESET}"
        sleep 1
        echo -e "${BOLDWHITE}New scenario loading...${COLORRESET}"
        read -r -n 100 -t 1 discard
        intro_battle_setup
        ;;
      D|d)
        sleep 0.5
        echo -e "${BOLDWHITE}\nReturning...${COLORRESET}"
        read -r -n 100 -t 1 discard
        class_select
        ;;
      Q|q)
        read -r -n 100 -t 1 discard
        quit
        ;;
      *)
        sleep 0.5
        echo -e "${BOLDRED}Invalid input.${COLORRESET}"
        read -r -n 100 -t 0.5 discard
        ;;
    esac
  done
}

# Exiting at the end and after CTRL+C
quit() {
  sleep 0.5
  echo -e "${BOLDCYAN}\nThank you for playing!${COLORRESET}"
  sleep 1
  echo -e -n "${BOLDCYAN}Returning to the Terminal...${COLORRESET}"
  sleep 1
  stty echo # Restore echoing before exiting (just in case).
  exit 0
}

# Graceful exiting
trap "quit" EXIT

# Launch game
intro

# End (Possibly the longest Bash script in existence.)
