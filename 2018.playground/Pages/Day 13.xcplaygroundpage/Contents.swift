//: [Previous](@previous)
import Foundation

let input = """
            /--------------------------------------------------------.                           /------------------------------------------------.
            |             /------------------------------------------+---------------------------+--------------------------.                     |
            |             |                             /------------+---------------------------+----------.    /--------. |                     |
            |             |   /-------------------------+---.        |                           |          |    |        | |                     |
            |             |   |                         |   |        |            /--------------+----------+----+--------+-+---------------------+-.
 /----------+-------.     |   |                         |   |        |     /------+--------------+----------+----+----.   | |                     | |
 |          |       |     |   |                         | /-+--------+-----+------+--------------+----------+----+----+---+-+----.                | |
 |  /-------+-------+-----+-. |                         | | |        |     |      |              |          |    |    |   | |    |                | |
 |  |      /+-------+-----+-+-+.     /------------------+-+-+--------+-----+-----.|              |          |    |    |   | |    |                | |
 | /+------++-.     |     | | ||     |                /-+-+-+--------+-----+-----++------.       |          |    |    |   | |    |                | |
 | ||      || |     |     |/+-++-----+----------------+-+-+-+--------+-----+-----++------+----.  .----------+----+----+---+-+----+----------------/ |
 | ||      || |     |    /+++-++-----+----------------+-+-+-+--------+-----+----.||      |    |             |    |    |   | |    |                  |
 | ||      || |     |    |||| ||   /-+----------------+-+-+-+--------+-----+----+++------+----+-------------+----+----+---+-+----+-------.          |
 | ||      || |     |    |||| ||/--+-+----------------+-+-+-+--------+-----+----+++------+->--+-------------+----+--. |   | |    |       |          |
 | ||      || |     |  /-++++-+++--+-+----------------+-+-+.|        |     .----+++------+----+-------------+----+--+-/   | |    |       |          |
 | ||     /++-+-----+--+-++++-+++--+-+----------------+-+-+++--------+----------+++------+----+-----.       |    |  |     | |    |       |          |
 | ||     ||| |     |  | |||| |||  | |                | | |||        |          |||    /-+----+-----+-------+----+--+-----+-+----+-----. |          |
 | ||     ||| |     |  | |||| |||/-+-+----------------+-+-+++--------+----------+++--. | |    |     |       |    .--+-----/ |    |     | |          |
 | ||     ||| |     |/-+-++++-++++-+-+----------------+-+-+++--------+----------+++--+-+-+----+-----+-------+-------+.      |    |     | |          |
 | ||     ||| |     || | |||| |||| | |               /+-+-+++--------+----------+++-.| | |    |     |       |       ||      |    |     | |          |
 | ||     ||| |/----++-+-++++-++++-+-+------.     /--++-+-+++------<-+----------+++-++-+-+----+-----+-------+-------++-----.|    |     | |          |
 | ||     |.+-++----++-+-++++-+/|| | |      |     |  || | |||/-------+-------.  ||| || | | /--+-----+-------+-------++-----++----+-----+-+---.      |
 | |.-----+-+-++----++-+-+++/ | || | |      |    /+--++-+-++++-------+-------+--+++-++-+-+-+--+-----+-------+-----. ||     ||    |     | |   |      |
 | |      | | ||    || | |||  | || | |    /-+----++--++-+-++++------.|       |  ||| || | |/+--+-----+---.   |     | ||     ||    |     | |   |      |
 | |      | | ||    || .-+++--+-++-+-+----+-+----++--++-+-+/||      ||       |  ||| || | |||  |     |   | /-+-----+-++---. ||    |     | |   |      |
 | |      | | ||  /-++---+++--+-++-+-+-.  | |    ||  || | | ||      ||/------+--+++-++-+-+++--+-----+---+-+-+-----+-++---+-++----+--.  | |   |      |
 | |      | | ||  | ||   |||  | || | | |  | |    || /++-+-+-++------+++------+--+++-++-+-+++--+-----+---+-+-+--.  | ||   | ||    |  |  | |   |      |
 | |      | |/++--+-++---+++. | || | | | /+-+----++-+++-+-+-++------+++------+--+++-++-+-+++--+-----+---+-+-+--+--+-++---+-++----+--+--+-+---+-----.|
 | |      | ||||  | ||   |||| | || | | | || |    ||/+++-+-+-++------+++------+--+++-++-+-+++--+-----+---+-+-+--+--+.||   | ||    |  |  | |   |     ||
 | |      | ||||  | ||   |||| | || | | | || |    |.++++-+-+-++------+++------+--+++-++-+-+++--+-----+---+-+-+--+--++++---+-/|    |  |  | |   |     ||
 | |      | ||||  | ||   |||| | || | | | || |    | |||| | | ||      |||    /-+--+++-++-+-+++--+-----+---+-+-+--+--++++--.|  |    |  |  | |   |     v|
 | |      | ||||  | ||   |||| | .+-+-+-+-++-+----+-++++-+-+-++------+++----+-+--+++-++-+-+++--+-----+---+-+-+--+--++/|  ||  |    |  | /+-+---+--.  ||
 | |      | ||||  | ||   |||| | /+-+-+-+-++-+----+-++++-+-+-++------+++----+-+--+++-++-+-+++--+-----+---+-+-+--+--++-+--++--+----+--+-++-+-. |  |  ||
 | |      | ||||  | ||   |||| | || | | | || |    |/++++-+-+-++------+++----+-+--+++-++-+-+++--+-----+---+-+-+--+--++-+. ||  |    |  | || | | |  |  ||
 | |      | ||||  | ||   |||| | || | | | || | /--++++++-+-+-++------+++----+.|  ||| || | |||  |  /--+---+-+-+--+--++-++-++--+----+--+-++.| | |  |  ||
 | |    /-+-++++--+-++---++++-+-++-+-+-+-++-+-+--++++++-+-+-++------+++----+++-.||| || | |||  |  |  |   | | |  |  || || ||  |    |  | |||| | |  |  ||
 | |    | | ||||  | ||   |||| | || | | | || | |  |||||| | | ||      |||    |||/++++-++-+-+++--+--+--+---+-+-+--+--++-++-++--+.   |  | |||| | |  |  ||
 | |    | | ||||  | ||   |||| | || | | ^ || | |  |||||| | | ||      |||/---++++++++-++-+-+++--+--+--+---+-+-+--+--++-++-++--++.  |  | |||| | |  |  ||
 | .----+-+-++/|  | ||   |||| | || | | | || | |  |||||| | | ||      ||||   |||||||| || | ||| /+--+--+-. | | |  |  || || ||  |||  |  | |||| | |  |  ||
 |      | | || |  |/++---++++-+-++-+-+-+-++-+-+--++++++-+-+-++------++++---++++++++-++-+-+++-++-.|  | | | | |  |  || || ||  |||  |  | |||| | |  |  ||
 |      | | || |  ||||   |||| | || | | |/++-+-+--++++++-+-+-++------++++---++++++++-++-+-+++-++-++--+-+-+-+-+-.|  || || ||  |||  |  | |||| | |  |  ||
 |      | | || |  ||||   |||| | .+-+-+-++++-+-+--++++++-+-+-++------++++---++++++++-++-+-+++-++-++--+-+-+-+-+-++--++-++-++--+++--+--+-++++-/ |  |  ||
 |      | | || |  ||||   |||| |  | | | |||| | |  |||||| | | ||/-----++++---++++++++-++-+-+++-++-++. | | | | | ||  || || ||  |||  |  | ||||   |  |  ||
 |      | | || |  |||.---++++-+--+-+-+-++++-+-+--++++++-+-+-+++-----++++---++++++++-++-+-+++-++-+++-+-+-+-+-+-++--++-/| ||  |||  |  | |^||   |  |  ||
 |      | | || |  |||  /-++++-+--+-+-+-++++-+-+--++++++-+-+-+++-----++++---++++++++-++.| ||| || ||| | | | | | ||  ||  | ||  ||| /+--+-++++---+--+. ||
 |      | | || |  |||  | |||| |  | |/+-++++-+-+--++++++-+-+-+++-----++++---++++++++-++++-+++.|| ||| | | | | | ||  ||  | ||  ||| ||  | ||||   |  || ||
 |      | | || |  |||  | |||| |  | ||| |||.-+-+--++++++-+-+-+++-----/|||   |||||||| |||| |||||| ||| | | | | | ||  ||  | ||  ||| ||  | ||||   |  || ||
 |      | | .+-+--+++--+-++++-+--+-+++-+++--+-+--++++++-+-+-+++------/||   |||||||| |||| |||||| ||| | | | | | ||  ||  | ||  ||| ||  | ||||   |  || ||
 |      | |  | |  |||  |/++++-+--+-+++-+++--+-+--++++++-+-+-+++-------++---++++++++-++++-++++++-+++-+-+-+-+.| ||  ||  | ||  ||| ||  | ||||   |  || ||
 |      | |  | |  .++--++++++-+--+-+++-/||  | |  |||||| | | |||  /----++---++++++++-++++-++++++-+++-+-+-+-+++-++--++--+-++--+++.||  | ||||   |  || ||
 |      | |  | |   ||  |||||| |  .-+++--++--+-+--++++++-+-+-+++--+----++---++++++++-+/|| |||||| ||| | | | .++-++--++--+-+/  ||||||  | ||||   |  || ||
 |      | |  | |   ||  |||||| |    |||  ||  | |  |||||| | | |||  |    ||   |||||||| | || |||||| ||| | | |  || ||  ||  | |   ||||||  | ||||   |  || ||
 |      | |  | |   ||  |||||| |    |||  ||  | |  ||||||/+-+-+++--+----++---++++++++-+-++-++++++-+++-+-+-+--++-++--++--+-+-. ||||||  | ||||   |  || ||
 |      | |  | |   ||  |||||| |    |||  ||  | |  |||||||| | |||  |    ||   |||.++++-+-++-++++++-+++-+-+-+--++-++--++--+-+-+-+/||||  | ||||   |  || ||
 |      | |  |/+---++--++++++-+----+++--++--+-+--++++++++-+-+++--+----++---+++-++++-+-++-++++++-+++-+.| |  || ||  ||  | | | | ||||  | ||||   |  || ||
 |      | .--+++---++--++++++-+----+++--++--+-+--++++++++-+-+++--+----++---+++-++++-+-++-++++++-+++-/|| |  || ||  ||  | | | | ||||  | ||||   |  || ||
 |      |    |||   ||  .+++++-+----+++--++--+-+--++++++++-+-+++--+----++---+++-++++-+-/| |||||| |||  || |  || ||  ||  | | | | ||||  | ||||   |  || ||
 .------+----+++---+/ /-+++++-+----+++--++--+-+--++++++++-+-+++--+----++---+++-++++-+--+-++++++-+++-.|| |  ||/++--++--+-+.| | ||||  | ||||   |  || ||
        |    |||   |  | ||||| |    |||  ||  | |  |||||||| | |||  | /--++---+++-++++-+--+-++++++-+++<+++-+--+++++--++. | ||| | ||||  | ||||   |  || ||
        |    |||   |  | ||||| |    |||  ||/-+-+--++++++++-+-+++--+-+--++---+++-++++-+--+-++++++-+++-+++-+--+++++--+++-+-+++-+-++++--+-++++---+. || ||
        |    |||   |/-+-+++++-+----+++--+++-+-+--++++++++-+-+++--+-+. ||   ||| |||| |  | |||||| ||| ||| |  |||||  ||| | ||| | ||||  | ||||   || || ||
        |    |||   || | ||||| |    |||  ||| | |  |||||||| | |||/-+-++-++---+++-++++-+--+-++++++-+++-+++-+--+++++--+++-+-+++-+-++++-.| ||||   || || ||
        |    |||   || | ||||| |    |||  ||| | |  |||||||| | |||| | || ||   ||| |||| |  | |||||| ||| ||| |  |||||  ||| | ||| | |||| || ||||   || || ||
 /------+----+++---++-+-+++++-+----+++--+++-+-+--++++++++-+-++++-+-++-++.  ||| |||| |  | |||||| ||| ||| |  |||||  ||| | ||| | |||| || ||||   || || ||
 |      |    |||   || | ||||| |    ||.--+++-+-+--++++++++-+-++++-+-++-+++--+++-++/| |  .-++++++-+++-+++-+--+++++--+++-+-+++-+-++++-++-+/||   || || ||
 |      |    .++---++-+-++++/ |    ||   ||| | |  |||||||| | |||| | || |||  ||| || | |    |||||| ||| ||| |  |||||  ||| | ||| | |||| || .-++---++-/| ||
 |      |     ||   || | ||||  |/---++---+++-+-+--++++++++-+-++++-+-++-+++--+++-++-+-+----++++++-+++-+++-+--+++++--+++-+-+++-+-++++-++--.||   ||  | ||
 |      |     ||   || | ||||  ||   ||   ||| | |  ||||||.+-+-++++-+-++-+++--+++-++-+-+----++++++-+++-+++-+--+++++--+++-+-++/ | |||| ||  |||   ||  | ||
 |      |     ||   || | ||||  ||   ||   ||| | |  |||.++-+-+-++++-+-++-+++--+++-++-+-+----++++++-+++-+++-+--++++/  ||| | ||  | |||| ||  |||   ||  | ||
 |      |  /--++---++-+-++++--++---++---+++-+-+--+++-++-+-+-++++-+-++-+++--+++-++-+-+---.|.++++-+++-+++-/  ||||   ||| | ||  | |||| ||  |||   ||  | ||
 |      |  |  ||   || | ||||  ||   ||   |.+-+-+--+++-++-+-+-++++-+-++-+++--+++-++-+-+---++-++++-+++-+++----++++---+++-+-++--+-++++-++--+++---++--+-/|
 |      |  |  ||   || | ||||  ||   ||   | |/+-+--+++-++-+-+-++++-+-++-+++--+++-++-+-+---++-++++-+++-+++----++++---+++-+-++-.| |||| ||  |||   ||  |  |
 |      |  |  ||   || | ||||  || /-++->-+-+++-+--+++-++-+.| |||| | || |||  ||| || | |   || |||| ||| |||    ||||   ||| | || || |||| ||  |||   ||  |  |
 |      |  |  ||   || | ||||  || | ||   | ||| |  ||| |.-+++-++++-+-++-+++--+++-++-+-+---+/ |||| ||| |||    ||||   ||| | || || |||| ||  |||   ||  |  |
 |      |  |  ||   || | |||| /++-+-++---+-+++-+. ||| |  ||| ||||/+-++-+++--+++-++-+-+---+--++++-+++-+++----++++---+++>+.|| || |||| ||  |||   ||  |  |
 |      |  |  ||   || | |||| ||| | ||   | ||| || ||| |  ||| |||||| || |||  ||| || | |  /+--++++-+++-+++----++++---+++-++++-++-++++-++--+++---++--+--+.
 |      |  |  ||   || | |||.-+++-+-++---+-+++-++-+++-+--+++-++++++-++-+++--+++-++-+-+--++--+++/ ||| |||    ||||   ||| |||| || |||| ||  |||   ||  |  ||
 | /----+--+--++---++-+-+++--+++-+-++---+-+++-++-+++-+--+++-++++++-++-+++--+++-++-+-+--++--+++--+++-+++--. ||.+---+++-+++/ || |||| ||  |||   ||  |  ||
 | |    |  |  ||   || | |||  ||| | ||   | ||| || ||| |  ||| |||.++-++-+++--+++-++-+-+--++--+++--+++-+++--+-++-+---+++-+++--++-++++-/|  |||   ||  |  ||
 | |    |  |  ||   || | |||  ||| | ||   | ||| || ||| |  ||| ||| || || |||  ||| || | |  ||  |||  ||| ||| /+-++-+---+++-+++--++-++++--+. |||   ||  |  ||
 | |  /-+--+--++---++-+-+++--+++-+.||   | ||| || ||| |  ||| ||.-++-++-+++--+++-++-+-+--++--+++--++/ ||| || || |   ||| |||  || |||| /++-+++---++--+. ||
 | |  | |  |  ||   || | |||  ||| ||||   | ||| || ||| |  ||| ||  || || |||  ||| || | |  ||  ||.--++--++/ || || |   ||| |||  || |||| ||| |||   ||  || ||
 | |  | |  |  ||   || | |||  ||| ||||   | ||| || ||| |  ||| ||  || || |||  ||| || | |  ||  ||   ||  ||  || || |   ||| |||  || |||| ||| |||   ||  || ||
 | |  | |/-+--++---++-+-+++--+++-++++---+-+++-++-+++-+--+++-++. || || |||  .++-++-+-+--++--++---++--++--++-++-+---+++-++/  || |||| ||| |||   ||  || ||
 | |  | || |  ||   || | |||  |.+-++++---+-+++-++-+++-+--+++-/|| || || |||   || || | |  ||  ||   ||  ||  || || |   ||| ||   || |||| ||| |||   ||  || ||
 | |  | || |  ||   || | |||  | | ||||   | ||| .+-+++-+--+++--++-++-++-+++---/| || | |  ||  ||   ||  ||  || || |   ||| ||   || |||| ||| |||   ||  || ||
 | |  | || |  ||   || | |||  | | ||||   | |||  | ||| |  |||  || || || |||    v || | |  ||  ||   ||  ||  || || |   ||| ||   || ||.+-+++-+++---++--/| ||
 | |  | || |  ||   || | |||  | | ||||   | |||  | ||| |  ||.--++-++-++-+++----+-++-+-+--++--++---++--++--++-++-+---+++-++---++-++-/ ||| |||   ||   | ||
 | |  | || |  ||   .+-+-+++--+-+-++++---+-+++--+-+++-+--++---++-++-++-+++----+-++-+-+--++--++---/|  ||  || || |   ||| ||   || ||   ||| |||   ||   | ||
 | |  | || |  ||    | | |||  | | ||||   | |.+--+-+++-+--++---++-++-++-+++----+-++-+-+--++--++----+--++--++-++-+---+++-++---/| ||   ||| |||   ||   | ||
/+-+--+-++-+--++---.| | |||  | | ||||   | | |  | ||| .--++---++-++-++-+++----+-++-+-/  ||  ||    |  ||  || || |   ||| ||    | ||   ||| |||   ||   | ||
|| |  | || |  .+---++-+-+++--+-+-++++---+-+-+--+-+++----++---++-++-++-+++----+-++-+----++--++----+--+/  || || |   ||| ||    | ||   ||| |||   ||   | ||
|| |  | || |   |   || | ||.--+-+-++++---+-+-+--+-+++----++---++-++-++-+++----+-++-+----++--++----+--+---++-++-+---+++-++----/ ||   ||| |||   ||   | ||
|| |  | || |   |   || | ||   | | ||||   | | |  | |||    ||   || || || |||    | || .----++--++----+--+---++-++-+---+++-++------++---+++-+++---++---+-/|
|| |  | || |   |   || | ||   | .-++++---+-+-+--+-+++----++---++-++-++-+++----+-++------++--++----+--+---++-++-+---+++-++------++---+++-/||   ||   |  |
|| |  | || |   |   || | ||   |   ||||   |/+-+--+-+++----++---++-++-++-+++----+-++------++--++----+--+---++-++-+---+++-++-<----++--.|||  ||   ||   |  |
|| |  | || |   |   || | ||   |   ||||   ||| |  | |||    ||   || || || |||    | ||      .+--++----+--+---++-++-+---+++-++------++--++++--++---++---+--/
|| |  | || |   |   || | ||   |   ||||  /+++-+--+-+++----++---++-++-++-+++----+-++-------+--++----+--+---++-++-+--<+++-++------++. ||||  ||   ||   |
|| |  | || |   |   || | ||   |   ||||  |||| |  | |||    ||   || || ||/+++----+-++-------+--++----+--+---++-++-+---+++-++----. ||| ||||  ||   ||   |
|| |  | || |   |   || | ||   |   |||| /++++-+--+.|||    .+---++-++-++++++----+-++-------+--++----+--+---++-+/ |   ||| ||    | ||| ||||  ||   ||   |
|| |  | || |   |   || | .+---+---++++-+++++-+--+++++-----+---++-++-++++++----+-++-------+--++----+--+---++-/  |   ||| ||    | ||| ||||  ||   ||   |
|| |  .-++-+---+---++-+--+---+---+/|| ||||| |  |||.+-----+---++-++-++++++----+-++-------+--++----+--+---++----+---+++-/|    | ||| ||||  ||   ||   |
|| |    || |  /+---++-+--+---+---+-++-+++++-+--+++-+----<+---++-++-++++++----+-++.   /--+--++----+--+---++----+---+++--+-.  | ||| ||||  ||   ||   |
|| |/---++-+--++---++.|  .---+---+-++-+++++-+--+++-+-----+---++-++-++++++----+-+/|   |  |  ||    |  |   .+----+---+++--+-+--+-+++-+++/  ||   ||   |
|| ||   || |  ||   ||||      |   | || ||||| |  ||| |     |   || || ||||||    | | |   |  |  ||    |  |    |    |   |||  | |  | ||| |||   ||   ||   |
|| ||   |.-+--++---++++------+---+-++-+++++-+--+++-+-----+---+/ || ||||||    | | |   |  |  ||    |  |    |   /+---+++-.| |  | ||| |||   ||   ||   |
|| ||   |/-+--++---++++------+---+-++-+++++-+--+++-+-----+---+--++-++++++----+-+-+---+--+--++----+--+-.  |   ||   ||| || |  |/+++-+++--.||   ||   |
|| ||   || |  ||   |||.------+---+-++-+++++-+--+++-+-----+---+--++-++++++----+-+-+---+--+--++----+--/ |  |   ||   ||| || |  ||||| |||  |||   ||   |
||/++---++-+--++---+++----.  |   | || ||||| |  ||| | /---+---+--++-++++++----+-+-+---+--+--++----+----+--+---++---+++-++-+--+++++-+++. |||   ||   |
|||||   || |  ||   |||    |  |   | .+-+++++-+--+++-+-+---+---+--++-++++++----+-+-+---+--+--++----+----+--+---++---+++-++-+--+++++-++++-++/   ||   |
|||||   || |  ||   |||    |  |   |  | ||.++-+--+++-+-+---+---+--++-++++++----+-+-+---+--+--++----+----+--+---+/   ||| || |  ||||| |||| ||    ||   |
||||| /-++-+--++---+++-.  |  |   .--+-++-++-+--+++-+-+---/   |  || |||||| /--+-+-+---+--+--++----+----+--+---+----+++-++-+--+++++-++++-++----++---+--.
.++++-+-++-+--++---/|| |  |  |      | || || |  ||| | |       |  || |||.++-+--+-+-+---+--+--++----+----+--+---+----+++-++-+--+++++-++/| ||    ||   |  |
 |||| | || |  ||    || |  |  |      | || || |  ||| .-+-------+--++-+++-++-+--+-+-+---+--+--++----+----+--+---+----+/| || |  ||||| || | ||    ||   |  |
 |||| | || |  ||    || |  |  |      | || || |  |||   |       |  || ||| || |  | | |   |  |  ||    |    |  |   .----+-+-/| |  ||||| || | ||    ||   |  |
 |||| | || |  ||    || |  |  |      | || || |  |||   |       |  || ||| .+-+--+-+-+---+--+--++----+----+--+--------+-+--+-+--++/|| || | ||    ||   |  |
 ||.+-+-++-+--++----++-+--+--+------+-++-++-+--+++---+-------+--++-+++--+-+--+-+-+---+--+--++----+----+--/        | |  | |  || || || | ||    ||   |  |
 || .-+-++-+--++----+/ |  |  |      | || || |  |||   |       |  || |||  | |  | | |   |  |  ||  /-+----+-----------+-+--+-+--++-++.|| | ||    ||   |  |
 ||   | .+-+--++----+--+--+--+------+-++-++-+--+++---+-------+--++-+++--+-+--+-/ |   |  |  .+--+-+----+<----------+-+--+-+--++-+++++-+-++----/|   |  |
 ||   |  | |  |.----+--+--+--+------+-++-++-/  |||   |       |/-++-+++--+.|  |   |   |  |   |  | |    |           | |  | |  || ||||| | ||     |   |  |
 ||   |  | |  |     |  |  |  |      | || ||    |||   |       .+-++-+++--+++--/   |   |  |   |  | |    |           | |  | |  || ||||| | ||     |   |  |
 v|   |  | |  .-----+--+--+--+------+-++-++----+++---+--------+-++-+++--+++------/   |  |   |  | |  /-+-----------+-+--+-+--++-+++++.| ||     |   |  |
 |.---+--+-+--------+--+--/  |      | || ||    |||   |        | || |||  |||          |  |   |  | .--+-+-----------+-+--+-+--++-+++++++-+/     |   |  |
 |    |  | |        |  |     |      | || ||    |||   |        | || |||  |||          |  |   |  |    | |   /-------+-+--+-+--++-+++++++-+------+-. |  |
 |    |  | |        |  |     |      | |.-++----+++---+--------+-++-+++--+++----------+--+---+--+----+-+---+-------+-+--+-+--++-+/||||| |      | | |  |
 |    .--+-+--------+--/     |      | .--++----+/|   |        | || ||.--+++------<---+--+---+--+----+-+-<-+-------+-+--+-+--/| | ||||| |      | | |  |
 |       | |   /----+-----.  |      |    .+----+-+---+--------+-++-++---+++----------+--+---+--+----+-+---+-------+-+--+-+---+-+-+/||| |      | | |  |
 |       | |   |    |     |  |      |     |    | |   |        | || .+---+++----------+--+---+--+----+-+---+-------+-/  | |   | | | ||| |      | | |  |
 |       | |   |    |     |  |      .-----+----+-+---+--------+-++--+---+++----------+--+---/  .----+-+---+-------+----+-+---+-+-/ ||| |      | | |  |
 |       | |   |    |     |  |            |    | |   |        | |.--+---+++----------+--+-----------+-+---+-------+----+-+---+-/   ||| |      | | |  |
 |       | |   |    |     |  |            |    | .---+--------+-+---+---+++----------+--+-----------+-+---+-------/    | |   |     ||| |      | | |  |
 |/------+-+---+----+-----+--+------------+----+-----+--------+-+---+---+++----------+--+------.    .-+---+------------+-+---+-----+/| |      | | |  |
 ||      | |   |    .-----+--+------------+----+-----+--------+-+---/   |||          | /+------+------+---+------------+-+---+-----+-+-+------+-+.|  |
 ||      | |   |    /-----+--+------------+----+-----+--------+-+-------+++----------+-++------+------+---+------.     | |   .-----+-+-/      | |||  |
 ||      | |   |    |     |  |            .----+-----+--------+-+-------+++----------+-++------+------+---+------+-----+-+---------+-+--------/ |||  |
 ||      | |   |    |     |  |                 |     |        | |       |||          .-++------+------+-->+------+-----+-/         | |          |||  |
 .+------+-+---+----+-----+--+-----------------+-----+--------+-+-------/||            ||      |      |   |      |     |           | |          |||  |
  |      .-+---+----+-----+--+-----------------+-----+--------+-+--------++------------++------+------/   |      |     |           | |          |||  |
  |        |   |    |     |  |                 |     |        | |        ||            ||      |          |      |     |           | |          |||  |
  |        |   .----+-----/  .-----------------/     |        | |        ||            ||      |          |      |     |           | |          |||  |
  |        |        |                                |        | |        ||            ||      |          |      |     |           | |          |||  |
  |        |        |                                .--------+-+--------++------------++------+----------+------+-----+-----------+-/          |||  |
  |        |        |                                         | |        |.------------++------+----------+------+-----+-----------+------------+++--/
  |        |        |                                         | |        |             ||      |          |      |     |           .------------++/
  |        |        |                                         | |        |             ||      |          |      |     |                        ||
  |        .--------+-----------------------------------------+-+--------+-------------+/      |          .------+-----+------------------------/|
  |                 |                                         | .--------+-------------+-------+-----------------+-----/                         |
  .-----------------+-----------------------------------------+----------+-------------+-------/                 |                               |
                    .-----------------------------------------+----------+-------------+-------------------------/                               |
                                                              .----------/             .---------------------------------------------------------/
"""

extension Sequence {
    func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self {
            if try predicate(element) {
                count += 1
            }
        }
        return count
    }
}

enum Direction {
    case up, down, left, right
}

enum NextDirection {
    case left, straight, right
    
    mutating func advance() {
        switch self {
        case .left:     self = .straight
        case .straight: self = .right
        case .right:    self = .left
        }
    }
}

struct Cart {
    var x: Int
    var y: Int
    var direction: Direction
    var turn: NextDirection = .left
    
    init(x: Int, y: Int, direction: Direction) {
        self.x = x
        self.y = y
        self.direction = direction
    }
    
    mutating func changeDirection() {
        switch turn {
        case .left:
            switch direction {
            case .up:    direction = .left
            case .down:  direction = .right
            case .left:  direction = .down
            case .right: direction = .up
            }
            
        case .straight:
            break
            
        case .right:
            switch direction {
            case .up:    direction = .right
            case .down:  direction = .left
            case .left:  direction = .up
            case .right: direction = .down
            }
        }
        
        turn.advance()
    }
    
    mutating func move() {
        switch direction {
        case .up: y -= 1
        case .down: y += 1
        case .left: x -= 1
        case .right: x += 1
        }
    }
}

extension Cart: Comparable {
    static func < (lhs: Cart, rhs: Cart) -> Bool {
        return (lhs.y < rhs.y) || (lhs.y == rhs.y && lhs.x < rhs.x)
    }
}

let tracks = input
    .components(separatedBy: .newlines)
    .map { line -> [Character] in
        let removingCars = line
            .replacingOccurrences(of: "^", with: "|")
            .replacingOccurrences(of: "v", with: "|")
            .replacingOccurrences(of: "<", with: "-")
            .replacingOccurrences(of: ">", with: "-")
        return Array(removingCars)
    }

let carts = input
    .components(separatedBy: .newlines)
    .enumerated()
    .flatMap { element -> [Cart] in
        let (y, line) = element
        return line
            .enumerated()
            .compactMap { element -> Cart? in
                let (x, character) = element
                
                switch character {
                case "^": return Cart(x: x, y: y, direction: .up)
                case "v": return Cart(x: x, y: y, direction: .down)
                case "<": return Cart(x: x, y: y, direction: .left)
                case ">": return Cart(x: x, y: y, direction: .right)
                default: return nil
                }
            }
    }

func partOne() -> String {
    var mutableCarts = carts
    
    var didCrash = false
    var x: Int!
    var y: Int!
    
    for _ in 0... {
        mutableCarts.sort()

        for index in 0 ..< mutableCarts.count {
            var cart: Cart {
                get { return mutableCarts[index] }
                set { mutableCarts[index] = newValue }
            }
            
            cart.move()
            
            if mutableCarts.count(where: { $0.x == cart.x && $0.y == cart.y }) > 1 {
                x = cart.x
                y = cart.y
                didCrash = true
                break
            }
            
            let trackCharacter = tracks[cart.y][cart.x]

            switch trackCharacter {
            
            case "+":
                cart.changeDirection()
            
            case "/":
                cart.direction = {
                    switch cart.direction {
                    case .up: return .right
                    case .down: return .left
                    case .right: return .up
                    case .left: return .down
                    }
                }()
                
            case ".":
                cart.direction = {
                    switch cart.direction {
                    case .up: return .left
                    case .down: return .right
                    case .right: return .down
                    case .left: return .up
                    }
                }()
                
            default:
                break
            }
        }

        if didCrash {
            break
        }

    }
    
    let result = "\(x!),\(y!)"
    return result
}

func partTwo() -> String {
    var mutableCarts = carts
    
    var indicesToRemove: Set<Int> = []

    for _ in 0... {
        mutableCarts.sort()

        for index in 0 ..< mutableCarts.count {
            if indicesToRemove.contains(index) {
                continue
            }
            
            var cart: Cart {
                get { return mutableCarts[index] }
                set { mutableCarts[index] = newValue }
            }
            
            cart.move()

            let intersectingCarts = mutableCarts.enumerated().filter { $0.1.x == cart.x && $0.1.y == cart.y }
            if intersectingCarts.count > 1 {
                intersectingCarts.forEach {
                    indicesToRemove.insert($0.offset)
                }
            }
            
            let trackCharacter = tracks[cart.y][cart.x]
            
            switch trackCharacter {
            case "+":
                cart.changeDirection()
                
            case "/":
                cart.direction = {
                    switch cart.direction {
                    case .up: return .right
                    case .down: return .left
                    case .right: return .up
                    case .left: return .down
                    }
                }()
                
            case ".":
                cart.direction = {
                    switch cart.direction {
                    case .up: return .left
                    case .down: return .right
                    case .right: return .down
                    case .left: return .up
                    }
                }()
                
            default:
                break
            }
        }

        indicesToRemove.sorted().reversed().forEach {
            mutableCarts.remove(at: $0)
        }

        indicesToRemove.removeAll()

        if mutableCarts.count == 1 {
            break
        }

    }
    
    let cart = mutableCarts.first!
    let result = "\(cart.x),\(cart.y)"
    return result
}

print(partOne())
print(partTwo())
//: [Next](@next)
