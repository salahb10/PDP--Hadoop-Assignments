/* load orders.csv */
orders = LOAD '/user/maria_dev/diplomacy/orders.csv'  USING PigStorage(',')AS
	(game_id:chararray,
    unit_id:chararray,
    unit_order:chararray,
    location:chararray,
    target:chararray,
    target_dest:chararray,
    success:chararray,
    reason:chararray,
    turn_num:chararray);

/*Part 2: Group by ýýýlocationýýý with target ýýýHollandýýý. */
/*filter and group by Lists */
filterByHolland = Filter orders BY target == '"Holland"';
groupByLocation = GROUP filterByHolland BY (location, target);

/*Part 3: Count how many times Holland was the target from that location. */
counter = FOREACH groupByLocation GENERATE group, COUNT(filterByHolland);                      

/*Part 1: a alphabetic list from all locations from the orders.csv. */
ordered = ORDER counter BY $0 ASC;

DUMP ordered;


