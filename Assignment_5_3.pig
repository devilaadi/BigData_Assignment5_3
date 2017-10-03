
--Loading the data

Load_Data = LOAD '/home/cloudera/Desktop/Acadgild/5_3/Pokemon.csv' USING PigStorage(',') AS(Sno:int,Name:chararray,Type1:chararray,Type2:chararray,Total:int,HP:int,Attack:int,Defense:int,SpAtk:int,SpDef:int,Speed:int);

--Ques 1: Find the list of players that have been selected in the qualifying round (DEFENCE>55)

selected_list = Filter Load_Data BY Defense > 55 ;
Dump selected_list ;

--Ques 2: State the number of players taking part in the competition after getting selected in the qualifying round.

group_selected_list = GROUP selected_list ALL ;
count_selected_list = Foreach group_selected_list GENERATE COUNT(selected_list) ;
Dump count_selected_list ;

--Ques 3: Using random() generate random numbers for each Pokémon on the selected list.

random_include1 = FOREACH selected_list GENERATE RANDOM(),Name,Type1,Type2,Total,HP,Attack,Defense,SpAtk,SpDef,Speed;
Dump random_include1 ;

--Ques 4: Arrange the new list in a descending order according to a column randomly

random1_descending = ORDER random_include1 BY $0 desc;
Dump random1_descending ;

--Ques 5: Now on a new relation again associate random numbers for each Pokémon and arrange in descending order according to column random.

random_include2 = foreach selected_list GENERATE RANDOM(),Name,Type1,Type2,Total,HP,Attack,Defense,SpAtk,SpDef,Speed;
random2_desending = ORDER random_include2 BY $0 DESC;
Dump random2_desending ;

--Ques: From the two different descending lists of random Pokémons, select the top 5 Pokémons for 2 different players.

limit_data_random1_descending = LIMIT random1_descending 5 ;
Dump limit_data_random1_descending;

limit_data_random2_desending = LIMIT random2_desending 5 ;
Dump limit_data_random2_desending ;

--Ques: Store the data on a local drive to announce for the final match. By the name player1 and player2 (only show the NAME and HP).

filter_only_name1 = foreach limit_data_random1_descending Generate ($1,HP);
DUMP filter_only_name1;

STORE filter_only_name1 INTO '/home/cloudera/Desktop/Acadgild/5_3/Player1.txt';

--2nd file

filter_only_name2 = foreach limit_data_random2_desending Generate ($1,HP);
DUMP filter_only_name2;

STORE filter_only_name2 INTO '/home/cloudera/Desktop/Acadgild/5_3/Player2.txt';













