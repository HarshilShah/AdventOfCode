import Foundation

let input = """
dark orange bags contain 3 dark chartreuse bags.
striped fuchsia bags contain 5 striped lavender bags.
dull gray bags contain 4 muted cyan bags, 3 light maroon bags.
dull chartreuse bags contain 3 light tan bags, 3 dotted bronze bags, 4 dark crimson bags, 4 dull gold bags.
shiny teal bags contain 3 muted maroon bags, 1 bright salmon bag, 2 dark chartreuse bags.
dull crimson bags contain 1 clear cyan bag, 1 dark chartreuse bag, 1 drab gold bag, 1 dim black bag.
plaid silver bags contain 2 muted bronze bags.
mirrored lime bags contain 5 pale brown bags, 4 dark white bags, 1 wavy yellow bag.
dark olive bags contain 5 light lavender bags, 5 vibrant tomato bags, 2 light purple bags.
wavy fuchsia bags contain 3 striped gold bags, 4 vibrant brown bags, 3 pale blue bags, 2 shiny brown bags.
mirrored tomato bags contain 3 light yellow bags, 4 dim indigo bags, 5 light beige bags, 3 posh indigo bags.
striped red bags contain 2 muted crimson bags, 2 dim olive bags.
dark crimson bags contain 1 striped chartreuse bag, 4 dark tan bags, 2 faded fuchsia bags, 5 mirrored black bags.
mirrored green bags contain 3 mirrored violet bags, 2 faded beige bags.
bright beige bags contain 4 faded magenta bags, 1 dotted purple bag, 2 mirrored cyan bags, 1 drab white bag.
light orange bags contain 4 mirrored fuchsia bags, 5 clear maroon bags.
faded magenta bags contain 3 drab beige bags.
muted plum bags contain 5 faded turquoise bags, 2 pale silver bags, 4 dotted coral bags, 3 dim violet bags.
wavy magenta bags contain 2 wavy brown bags, 5 clear turquoise bags, 3 plaid silver bags.
bright white bags contain 1 plaid blue bag, 5 posh black bags, 1 shiny plum bag.
mirrored maroon bags contain 4 drab gray bags, 1 muted fuchsia bag.
posh lime bags contain 1 vibrant yellow bag.
striped purple bags contain 3 light cyan bags, 4 mirrored gray bags.
vibrant aqua bags contain 3 posh bronze bags.
wavy maroon bags contain 3 posh fuchsia bags, 2 vibrant beige bags, 4 striped blue bags.
plaid gold bags contain 5 dotted coral bags, 2 dim plum bags.
dark beige bags contain 2 striped blue bags, 5 plaid lime bags.
dim orange bags contain 2 faded salmon bags.
dim olive bags contain 1 dim salmon bag.
posh blue bags contain 5 muted chartreuse bags, 4 striped bronze bags, 1 wavy bronze bag.
drab tan bags contain 2 faded beige bags, 1 dark tomato bag, 1 posh gold bag.
wavy orange bags contain 4 dull aqua bags.
bright chartreuse bags contain 1 clear gray bag, 1 clear magenta bag, 2 dark blue bags, 4 mirrored cyan bags.
plaid orange bags contain 4 dotted aqua bags.
dotted tomato bags contain 5 shiny white bags, 4 muted cyan bags, 5 wavy gray bags, 5 dull crimson bags.
clear tomato bags contain 5 bright bronze bags, 5 posh blue bags.
striped aqua bags contain 3 faded olive bags, 4 plaid maroon bags.
dull indigo bags contain 1 light red bag, 4 pale indigo bags.
pale plum bags contain 2 faded olive bags.
bright aqua bags contain 5 drab fuchsia bags, 4 shiny orange bags, 1 dim lavender bag, 4 posh brown bags.
mirrored salmon bags contain 3 clear cyan bags.
wavy bronze bags contain 4 pale blue bags.
mirrored gold bags contain 1 shiny turquoise bag, 4 clear magenta bags.
faded maroon bags contain no other bags.
striped olive bags contain 4 wavy tomato bags, 3 mirrored maroon bags.
muted tan bags contain 5 dull fuchsia bags.
pale turquoise bags contain 3 plaid chartreuse bags, 5 dim salmon bags, 3 faded maroon bags, 3 clear black bags.
drab brown bags contain 3 shiny maroon bags, 3 plaid magenta bags.
shiny salmon bags contain 2 light indigo bags.
striped green bags contain 2 dotted gold bags, 4 plaid violet bags.
dark cyan bags contain 5 posh beige bags, 2 posh turquoise bags, 4 clear brown bags.
pale green bags contain 3 faded orange bags, 1 dotted purple bag, 5 vibrant silver bags, 3 posh purple bags.
muted white bags contain 4 faded turquoise bags.
dotted gray bags contain 1 dark coral bag, 3 light cyan bags, 4 pale white bags.
pale fuchsia bags contain 4 shiny teal bags, 5 vibrant blue bags.
wavy coral bags contain 3 muted aqua bags.
vibrant turquoise bags contain 1 plaid red bag, 1 clear brown bag, 1 clear beige bag, 1 wavy brown bag.
faded orange bags contain 4 bright coral bags, 1 mirrored cyan bag.
dim tomato bags contain 2 wavy indigo bags, 3 dotted teal bags.
wavy indigo bags contain 5 dotted yellow bags, 5 wavy aqua bags, 5 dotted lime bags, 4 clear brown bags.
bright teal bags contain 4 muted magenta bags, 5 bright plum bags, 1 vibrant aqua bag.
shiny coral bags contain 1 shiny black bag, 5 striped fuchsia bags, 4 shiny beige bags, 1 wavy bronze bag.
dull beige bags contain 2 wavy cyan bags, 1 shiny lime bag, 3 dark purple bags.
pale salmon bags contain 5 muted maroon bags, 3 striped bronze bags, 2 muted tan bags.
light green bags contain 3 wavy tan bags, 5 muted purple bags, 3 drab violet bags, 4 posh maroon bags.
dull red bags contain 2 drab yellow bags, 3 striped orange bags, 2 plaid teal bags.
vibrant violet bags contain 2 clear plum bags, 1 dim tan bag, 5 wavy yellow bags.
drab crimson bags contain 3 clear teal bags, 3 mirrored cyan bags.
drab coral bags contain 4 posh aqua bags, 3 plaid salmon bags.
vibrant cyan bags contain 4 drab chartreuse bags, 1 light yellow bag, 2 clear gold bags, 1 wavy olive bag.
striped chartreuse bags contain 1 posh aqua bag, 5 posh salmon bags.
pale yellow bags contain 3 vibrant brown bags, 3 faded maroon bags, 3 wavy bronze bags.
mirrored red bags contain 1 plaid lavender bag, 5 clear green bags, 5 dark blue bags, 4 pale tan bags.
dark yellow bags contain 3 mirrored aqua bags, 3 shiny plum bags, 1 mirrored silver bag, 1 faded tomato bag.
plaid olive bags contain 3 mirrored red bags, 5 muted salmon bags, 3 bright bronze bags.
vibrant olive bags contain 2 mirrored fuchsia bags.
mirrored fuchsia bags contain 1 posh lime bag.
mirrored tan bags contain 4 light teal bags, 4 dark bronze bags, 3 muted maroon bags.
striped brown bags contain 5 posh lavender bags, 3 pale yellow bags, 1 light orange bag, 3 muted beige bags.
clear yellow bags contain 3 dull black bags, 3 plaid violet bags, 5 wavy bronze bags.
clear aqua bags contain 5 clear cyan bags, 2 pale crimson bags, 1 drab coral bag.
dull cyan bags contain 5 dim tan bags, 1 striped black bag.
muted turquoise bags contain 2 light olive bags, 5 light black bags.
light fuchsia bags contain 1 drab coral bag, 4 muted plum bags, 4 dim lime bags.
faded black bags contain 1 drab blue bag, 4 dark yellow bags.
plaid green bags contain 3 dotted fuchsia bags, 4 light green bags, 1 dim lavender bag, 2 dotted black bags.
dark tomato bags contain 5 plaid silver bags, 4 mirrored olive bags.
shiny gray bags contain 2 posh brown bags, 1 posh cyan bag.
muted orange bags contain 1 posh bronze bag, 2 bright blue bags.
dotted green bags contain 4 pale gray bags, 4 wavy gray bags, 3 plaid gray bags.
dotted salmon bags contain 1 pale violet bag, 1 bright bronze bag, 5 striped purple bags, 5 mirrored crimson bags.
dim gold bags contain 1 light crimson bag, 4 dull crimson bags.
clear bronze bags contain 2 striped maroon bags, 3 posh lavender bags.
muted yellow bags contain 5 dull crimson bags, 2 clear lime bags.
pale red bags contain 4 dim green bags.
faded beige bags contain 2 light red bags, 2 wavy orange bags, 2 dim chartreuse bags, 2 dotted bronze bags.
pale white bags contain 4 drab salmon bags, 4 clear silver bags, 1 muted cyan bag, 1 wavy plum bag.
plaid coral bags contain 1 muted tan bag, 1 posh aqua bag, 3 plaid orange bags, 4 vibrant brown bags.
light crimson bags contain 3 dotted coral bags, 4 clear beige bags, 4 shiny beige bags.
dim beige bags contain 1 bright gray bag, 1 striped yellow bag.
dull green bags contain 1 dim gold bag, 4 plaid lime bags.
wavy black bags contain 2 faded teal bags, 5 dull lime bags, 4 dotted gold bags.
mirrored teal bags contain 2 drab violet bags.
mirrored violet bags contain 4 dotted crimson bags, 5 plaid beige bags.
dim chartreuse bags contain 5 faded white bags, 2 posh chartreuse bags.
dim bronze bags contain 4 wavy bronze bags, 4 clear maroon bags, 2 light gold bags.
light silver bags contain 4 plaid coral bags, 4 muted chartreuse bags, 4 wavy white bags.
faded tan bags contain 1 dark olive bag, 3 faded salmon bags, 2 dark gold bags.
vibrant tan bags contain 3 light salmon bags, 2 shiny green bags, 5 pale white bags, 2 dark fuchsia bags.
dim tan bags contain 1 mirrored magenta bag, 4 dull crimson bags, 5 faded lavender bags.
shiny lime bags contain 5 dull yellow bags, 1 pale blue bag, 4 striped chartreuse bags, 3 drab magenta bags.
dark red bags contain 3 drab yellow bags.
pale lavender bags contain 1 posh cyan bag, 2 dim salmon bags, 4 bright lavender bags, 3 shiny lime bags.
dim brown bags contain 3 dull white bags, 4 dim salmon bags, 1 plaid coral bag.
clear blue bags contain 4 wavy turquoise bags, 3 mirrored fuchsia bags.
dotted beige bags contain 1 pale indigo bag, 2 vibrant coral bags.
dim crimson bags contain 1 light gold bag, 1 drab plum bag, 5 drab turquoise bags.
clear coral bags contain 3 dull yellow bags, 4 mirrored turquoise bags, 3 dotted salmon bags, 3 faded lavender bags.
mirrored purple bags contain 3 light cyan bags, 1 plaid salmon bag, 5 posh red bags.
clear purple bags contain 2 plaid crimson bags.
plaid beige bags contain 1 posh purple bag, 3 dark maroon bags, 1 clear cyan bag, 5 striped chartreuse bags.
faded coral bags contain 3 pale silver bags.
posh cyan bags contain 3 pale white bags, 2 posh tan bags, 2 bright silver bags.
pale teal bags contain 4 shiny maroon bags, 1 clear tomato bag, 3 drab beige bags.
posh turquoise bags contain 1 bright gray bag, 2 light crimson bags, 1 dotted aqua bag.
striped gray bags contain 1 bright magenta bag, 2 striped coral bags, 1 bright orange bag, 5 bright lavender bags.
vibrant fuchsia bags contain 2 dim black bags, 3 dark magenta bags, 3 dark violet bags.
dotted turquoise bags contain 2 dull black bags.
wavy gold bags contain 5 light purple bags, 1 wavy fuchsia bag.
dotted coral bags contain no other bags.
pale brown bags contain 3 mirrored blue bags, 2 drab coral bags.
pale black bags contain 1 clear teal bag, 5 clear salmon bags.
dull silver bags contain 1 plaid lime bag, 5 bright fuchsia bags, 4 pale silver bags.
posh maroon bags contain 4 dotted orange bags, 1 mirrored blue bag.
bright maroon bags contain 3 shiny tan bags, 3 striped purple bags, 5 posh blue bags, 2 dotted blue bags.
striped crimson bags contain 1 clear cyan bag, 3 dark chartreuse bags, 3 plaid coral bags, 5 shiny plum bags.
drab black bags contain 2 plaid fuchsia bags, 3 shiny cyan bags, 1 dotted coral bag, 3 bright fuchsia bags.
mirrored yellow bags contain 3 dark indigo bags, 4 mirrored chartreuse bags, 4 pale purple bags.
drab bronze bags contain 1 muted aqua bag.
pale magenta bags contain 1 shiny red bag, 5 shiny beige bags, 3 dotted aqua bags.
muted magenta bags contain 3 dotted purple bags, 4 dark bronze bags, 4 dim silver bags.
bright olive bags contain 3 mirrored olive bags.
pale lime bags contain 5 pale blue bags.
dull turquoise bags contain 4 shiny red bags, 3 dotted coral bags, 2 dark maroon bags.
shiny olive bags contain 2 posh beige bags, 1 posh aqua bag, 2 dark lavender bags, 2 pale yellow bags.
dark bronze bags contain 5 faded turquoise bags, 2 striped turquoise bags, 3 mirrored gray bags, 1 dark cyan bag.
clear turquoise bags contain 2 striped crimson bags, 3 dotted red bags, 5 striped yellow bags.
dotted brown bags contain 3 bright gold bags, 4 posh lime bags.
posh beige bags contain 3 drab beige bags, 2 dark chartreuse bags, 1 shiny plum bag, 5 dark maroon bags.
dull blue bags contain 4 faded gray bags, 4 pale yellow bags, 3 dim salmon bags, 5 mirrored gray bags.
muted brown bags contain 1 dull aqua bag.
dull tan bags contain 3 shiny beige bags, 5 clear black bags, 5 clear cyan bags.
shiny fuchsia bags contain 1 dark coral bag.
plaid bronze bags contain 4 dim white bags, 2 posh plum bags.
dull tomato bags contain 1 muted yellow bag, 4 dim indigo bags.
shiny red bags contain 1 muted chartreuse bag, 1 light cyan bag, 5 bright blue bags, 3 vibrant maroon bags.
faded fuchsia bags contain 4 dim gray bags, 1 drab gold bag.
drab plum bags contain 1 plaid coral bag.
drab salmon bags contain 1 dotted aqua bag, 1 striped purple bag, 4 posh blue bags.
dim purple bags contain 5 dull violet bags.
light red bags contain 2 plaid coral bags, 1 clear silver bag, 3 dull tan bags, 5 pale cyan bags.
clear cyan bags contain 4 dotted coral bags.
faded indigo bags contain 3 bright gray bags, 4 faded tomato bags, 1 drab coral bag, 1 dark brown bag.
dotted magenta bags contain 3 muted yellow bags, 3 plaid salmon bags, 2 dark violet bags, 5 mirrored silver bags.
bright tomato bags contain 3 clear cyan bags, 4 dotted aqua bags, 4 faded maroon bags.
wavy olive bags contain 2 faded salmon bags, 4 posh silver bags, 2 drab white bags.
striped turquoise bags contain 1 shiny plum bag.
drab silver bags contain 5 pale white bags, 2 shiny white bags, 1 striped chartreuse bag, 5 dull turquoise bags.
dim teal bags contain 1 plaid purple bag, 2 wavy lavender bags, 3 muted yellow bags.
dull teal bags contain 3 dotted red bags.
shiny silver bags contain 3 wavy yellow bags, 4 clear bronze bags.
faded salmon bags contain 2 bright coral bags, 4 muted chartreuse bags.
bright green bags contain 1 shiny crimson bag, 3 wavy tan bags.
muted cyan bags contain 4 plaid red bags, 2 shiny teal bags.
light salmon bags contain 3 muted turquoise bags, 5 posh orange bags, 1 dark lime bag, 5 pale orange bags.
light gold bags contain 1 faded maroon bag, 2 dark white bags.
faded gray bags contain 1 mirrored salmon bag, 2 posh magenta bags.
mirrored magenta bags contain 5 pale blue bags.
light gray bags contain 4 vibrant silver bags.
posh indigo bags contain 2 dark plum bags, 1 dotted orange bag, 5 faded white bags.
pale tan bags contain 5 wavy bronze bags, 1 muted indigo bag, 1 bright fuchsia bag, 2 light fuchsia bags.
posh silver bags contain 2 faded plum bags, 5 striped lavender bags, 3 striped bronze bags.
plaid black bags contain 3 bright crimson bags, 1 faded indigo bag.
bright red bags contain 5 drab coral bags.
wavy lavender bags contain 1 pale gold bag, 1 light tomato bag, 5 dull black bags.
dark silver bags contain 1 dark white bag, 4 plaid magenta bags, 3 dull salmon bags.
clear plum bags contain 3 faded maroon bags.
vibrant silver bags contain 3 bright blue bags, 1 dark maroon bag, 5 light cyan bags, 3 dull crimson bags.
light olive bags contain 4 light purple bags, 1 dark tomato bag, 4 drab chartreuse bags.
mirrored olive bags contain 5 faded olive bags, 3 dull fuchsia bags, 3 plaid salmon bags, 3 light yellow bags.
clear gold bags contain 1 drab teal bag.
dark salmon bags contain 5 mirrored purple bags, 1 posh lavender bag, 5 light lavender bags, 1 muted white bag.
posh aqua bags contain 5 faded maroon bags.
plaid plum bags contain 2 dim gray bags, 3 dim tomato bags, 2 muted brown bags, 1 drab olive bag.
muted red bags contain 3 dark black bags, 5 plaid fuchsia bags, 5 bright fuchsia bags, 5 wavy lavender bags.
mirrored crimson bags contain 2 mirrored aqua bags.
dotted black bags contain 1 drab coral bag.
dark violet bags contain 2 posh chartreuse bags, 2 muted cyan bags, 2 striped bronze bags, 5 dim plum bags.
plaid salmon bags contain 3 muted tan bags, 3 clear plum bags, 4 bright gold bags.
mirrored chartreuse bags contain 1 dull tan bag, 2 posh plum bags.
shiny orange bags contain 1 striped yellow bag, 3 dark chartreuse bags.
shiny purple bags contain 1 mirrored beige bag.
wavy blue bags contain 3 faded black bags, 2 striped turquoise bags, 4 muted yellow bags, 2 clear lime bags.
striped indigo bags contain 1 posh silver bag, 3 plaid aqua bags, 5 plaid maroon bags.
mirrored gray bags contain 3 bright blue bags.
muted tomato bags contain 1 dotted tomato bag.
wavy tan bags contain 2 faded salmon bags, 2 dark brown bags, 3 wavy violet bags, 1 vibrant coral bag.
striped cyan bags contain 2 dotted tomato bags, 1 mirrored tomato bag, 1 wavy plum bag, 2 clear olive bags.
faded chartreuse bags contain 2 light blue bags, 5 bright bronze bags, 5 muted silver bags.
drab maroon bags contain 1 clear olive bag, 3 mirrored cyan bags.
posh yellow bags contain 2 shiny lavender bags, 4 bright tomato bags, 3 dim tan bags, 2 dotted silver bags.
muted gray bags contain 5 striped lavender bags, 3 shiny red bags, 3 dark chartreuse bags, 3 faded olive bags.
striped violet bags contain 4 striped white bags.
bright blue bags contain 5 plaid orange bags, 4 dark chartreuse bags, 2 dotted coral bags, 1 wavy teal bag.
dull magenta bags contain 4 bright tomato bags, 5 plaid aqua bags.
muted black bags contain 5 vibrant blue bags.
mirrored coral bags contain 2 shiny coral bags, 4 light tan bags.
mirrored plum bags contain 1 posh bronze bag, 2 dotted olive bags, 5 drab bronze bags, 2 striped tomato bags.
dull olive bags contain 1 posh beige bag.
clear olive bags contain 4 shiny olive bags, 5 muted tan bags.
light magenta bags contain 3 dark white bags.
dotted lime bags contain 4 vibrant brown bags, 1 light yellow bag, 5 dim violet bags, 2 dim olive bags.
light bronze bags contain 1 shiny olive bag, 1 drab silver bag, 3 vibrant silver bags, 1 muted tan bag.
clear violet bags contain 4 wavy lavender bags.
dull purple bags contain 1 bright purple bag, 2 shiny lime bags, 2 drab salmon bags, 3 dull aqua bags.
light brown bags contain 4 shiny lime bags, 3 wavy salmon bags.
posh green bags contain 4 drab green bags.
striped salmon bags contain 2 pale brown bags.
dotted maroon bags contain 4 pale bronze bags, 3 mirrored silver bags, 3 muted purple bags, 5 dull lime bags.
mirrored beige bags contain 3 clear tan bags, 4 light beige bags.
bright gold bags contain 1 light cyan bag, 1 dotted coral bag.
drab gray bags contain 4 posh lime bags.
clear brown bags contain 4 muted gray bags, 5 shiny gold bags.
dotted plum bags contain 2 drab maroon bags, 3 dotted olive bags, 3 plaid maroon bags, 5 striped magenta bags.
dim magenta bags contain 3 bright crimson bags, 3 dark aqua bags.
faded crimson bags contain 5 dull brown bags, 4 dark violet bags, 3 striped gray bags.
pale purple bags contain 1 light black bag, 3 dark salmon bags, 4 drab blue bags, 1 posh indigo bag.
drab aqua bags contain 3 pale tomato bags, 4 drab gray bags, 2 wavy yellow bags.
plaid fuchsia bags contain 5 faded indigo bags, 3 clear plum bags, 2 shiny tan bags.
posh salmon bags contain 1 mirrored gray bag, 3 vibrant maroon bags, 1 dotted coral bag, 3 clear maroon bags.
faded teal bags contain 3 bright indigo bags, 5 striped red bags, 3 dark turquoise bags, 5 dark tan bags.
shiny cyan bags contain 3 bright gray bags, 3 posh beige bags, 2 dark blue bags.
dim aqua bags contain 3 muted magenta bags.
dim coral bags contain 1 pale cyan bag, 4 wavy green bags, 2 posh salmon bags.
drab blue bags contain 1 dotted crimson bag, 1 posh silver bag.
bright silver bags contain 1 shiny red bag, 2 bright bronze bags, 1 wavy white bag.
pale cyan bags contain 3 clear black bags.
dull white bags contain 2 dark white bags.
wavy plum bags contain 5 bright purple bags.
striped yellow bags contain 3 muted gray bags, 3 posh red bags, 4 faded olive bags.
dim fuchsia bags contain 5 dim lime bags, 3 dull olive bags.
dotted olive bags contain 5 muted cyan bags, 4 vibrant violet bags.
dim white bags contain 2 light tomato bags.
mirrored indigo bags contain 4 dim tan bags, 4 dim tomato bags, 2 shiny cyan bags, 2 shiny tomato bags.
dotted teal bags contain 5 posh white bags, 5 muted bronze bags, 3 pale cyan bags.
striped gold bags contain 4 dark coral bags, 4 striped aqua bags, 1 bright plum bag.
dull black bags contain 1 dull aqua bag, 4 wavy tan bags, 1 dotted red bag, 5 mirrored aqua bags.
dim maroon bags contain 3 plaid gold bags, 4 shiny beige bags, 5 dull yellow bags, 2 dark white bags.
vibrant yellow bags contain 4 plaid coral bags, 5 muted silver bags, 3 posh red bags.
pale indigo bags contain 1 shiny blue bag, 2 muted aqua bags, 1 drab beige bag, 2 muted maroon bags.
dull yellow bags contain 4 posh aqua bags, 2 shiny red bags, 1 shiny coral bag, 3 pale magenta bags.
plaid tan bags contain 4 faded plum bags, 2 plaid aqua bags.
clear crimson bags contain 4 light cyan bags, 5 faded purple bags.
pale maroon bags contain 5 plaid orange bags.
light purple bags contain 2 faded cyan bags, 5 shiny red bags.
pale crimson bags contain 4 dark chartreuse bags, 1 mirrored gray bag, 3 dim salmon bags, 2 mirrored purple bags.
mirrored cyan bags contain 1 drab salmon bag, 4 mirrored magenta bags, 2 mirrored lime bags.
shiny bronze bags contain 3 muted yellow bags.
faded purple bags contain 5 drab black bags.
dotted red bags contain 3 light gold bags, 4 light yellow bags, 3 shiny coral bags.
plaid aqua bags contain 5 plaid orange bags, 1 dotted coral bag, 5 light cyan bags, 5 clear cyan bags.
shiny tomato bags contain 2 dark tomato bags, 1 dull olive bag, 5 striped tomato bags, 5 muted gold bags.
light turquoise bags contain 1 dull tan bag.
vibrant blue bags contain 1 clear bronze bag, 4 posh purple bags.
pale violet bags contain 4 dotted red bags, 3 clear beige bags.
dotted orange bags contain 3 bright crimson bags, 2 wavy aqua bags.
vibrant plum bags contain 3 mirrored beige bags, 3 mirrored salmon bags.
wavy cyan bags contain 3 plaid magenta bags, 2 light gold bags.
dark lavender bags contain 3 posh chartreuse bags, 3 dotted red bags, 3 bright fuchsia bags.
bright lime bags contain 3 muted aqua bags, 1 plaid salmon bag, 2 mirrored purple bags, 3 pale silver bags.
pale chartreuse bags contain 1 dotted white bag, 3 clear purple bags.
striped silver bags contain 2 faded maroon bags, 2 mirrored gray bags, 1 muted chartreuse bag.
vibrant bronze bags contain 2 striped crimson bags, 4 mirrored white bags, 4 plaid gray bags.
wavy tomato bags contain 4 clear lime bags, 3 posh indigo bags, 1 vibrant brown bag, 4 dotted chartreuse bags.
striped tan bags contain 4 dark black bags, 5 plaid yellow bags.
bright bronze bags contain 1 clear lime bag.
dotted gold bags contain 4 muted green bags.
dotted indigo bags contain 5 mirrored olive bags, 5 posh violet bags.
vibrant purple bags contain 4 posh aqua bags, 3 mirrored magenta bags, 2 wavy yellow bags, 1 dotted teal bag.
wavy purple bags contain 5 light red bags, 4 faded white bags.
faded violet bags contain 4 wavy silver bags, 5 faded orange bags.
clear red bags contain 4 posh olive bags, 5 shiny cyan bags.
bright tan bags contain 3 mirrored chartreuse bags.
muted bronze bags contain 2 dark chartreuse bags, 5 dotted aqua bags.
wavy chartreuse bags contain 3 mirrored turquoise bags, 3 drab black bags, 3 wavy salmon bags.
light cyan bags contain no other bags.
muted indigo bags contain 2 plaid orange bags, 3 dim olive bags, 4 dim lime bags.
vibrant brown bags contain 3 dull white bags.
plaid magenta bags contain 4 dark white bags, 1 wavy gray bag, 3 pale blue bags, 1 faded lavender bag.
dim blue bags contain 1 bright red bag, 2 clear plum bags, 3 pale blue bags.
pale tomato bags contain 5 striped orange bags, 2 dark crimson bags, 2 mirrored silver bags.
pale orange bags contain 4 bright coral bags, 3 dark violet bags.
plaid tomato bags contain 3 bright lime bags.
bright coral bags contain 3 light cyan bags.
plaid indigo bags contain 5 posh brown bags, 3 striped fuchsia bags.
drab white bags contain 1 mirrored purple bag, 2 light tomato bags.
drab indigo bags contain 2 clear lime bags, 2 vibrant white bags, 4 clear gold bags.
dim silver bags contain 1 mirrored blue bag, 2 pale tomato bags, 2 dark tan bags, 4 dotted indigo bags.
vibrant indigo bags contain 5 pale white bags, 3 posh fuchsia bags, 4 drab lavender bags, 3 striped red bags.
faded aqua bags contain 4 pale tan bags, 2 shiny indigo bags, 1 plaid magenta bag, 5 plaid orange bags.
wavy green bags contain 5 dim brown bags, 1 dark turquoise bag.
mirrored white bags contain 3 vibrant violet bags, 4 wavy yellow bags.
drab orange bags contain 5 dark maroon bags, 1 bright cyan bag, 2 shiny salmon bags.
shiny green bags contain 2 dim olive bags, 5 light brown bags, 2 dotted violet bags.
drab lime bags contain 5 light tan bags, 1 clear black bag, 5 plaid aqua bags, 2 wavy teal bags.
faded plum bags contain 4 bright tomato bags, 3 dark maroon bags, 1 dotted coral bag.
clear white bags contain 5 mirrored purple bags.
shiny violet bags contain 3 striped green bags, 5 vibrant blue bags, 3 vibrant lime bags, 5 clear green bags.
dotted cyan bags contain 5 wavy tan bags, 4 shiny coral bags.
striped lavender bags contain 5 dotted chartreuse bags, 1 plaid aqua bag, 2 dotted coral bags, 1 dark maroon bag.
pale silver bags contain 3 dull fuchsia bags, 2 plaid orange bags, 1 wavy bronze bag, 5 shiny black bags.
clear beige bags contain 3 striped chartreuse bags, 3 dotted red bags.
dim plum bags contain 1 bright purple bag, 2 posh red bags.
bright crimson bags contain 5 vibrant maroon bags, 5 bright purple bags, 3 clear cyan bags.
pale coral bags contain 3 mirrored silver bags.
bright violet bags contain 4 light brown bags, 5 vibrant cyan bags, 3 wavy beige bags, 1 dim violet bag.
dark maroon bags contain no other bags.
shiny blue bags contain 3 dark white bags.
vibrant salmon bags contain 4 clear red bags, 1 dark aqua bag, 5 vibrant purple bags.
muted gold bags contain 3 light turquoise bags, 2 faded cyan bags, 4 clear cyan bags, 1 wavy plum bag.
shiny lavender bags contain 1 dim salmon bag.
dull aqua bags contain 3 drab blue bags, 2 mirrored gray bags.
clear teal bags contain 2 faded cyan bags, 1 dotted beige bag.
clear maroon bags contain 4 wavy teal bags.
wavy crimson bags contain 5 vibrant brown bags.
light chartreuse bags contain 2 clear plum bags, 3 dull orange bags, 3 plaid fuchsia bags, 1 light tomato bag.
shiny white bags contain 5 plaid lavender bags, 3 bright indigo bags, 2 posh violet bags, 4 dull crimson bags.
faded bronze bags contain 4 light turquoise bags.
vibrant chartreuse bags contain 1 clear black bag.
dull maroon bags contain 1 shiny orange bag.
shiny black bags contain no other bags.
shiny magenta bags contain 1 shiny teal bag, 3 faded gray bags, 4 shiny white bags.
posh orange bags contain 4 plaid gold bags.
light aqua bags contain 2 plaid violet bags, 5 dim tan bags.
faded lavender bags contain 2 plaid salmon bags.
dotted tan bags contain 4 wavy green bags, 5 bright gray bags.
posh teal bags contain 1 muted white bag, 3 plaid beige bags, 2 plaid magenta bags, 2 light tomato bags.
drab chartreuse bags contain 5 posh purple bags, 1 light tomato bag.
mirrored lavender bags contain 4 striped salmon bags, 3 striped lavender bags, 5 dull indigo bags, 5 shiny fuchsia bags.
plaid violet bags contain 2 dotted chartreuse bags, 4 muted white bags, 4 dark tan bags, 2 dark brown bags.
dotted crimson bags contain 4 mirrored magenta bags, 2 wavy white bags, 1 wavy teal bag.
clear lavender bags contain 4 striped tomato bags, 1 light maroon bag, 3 light bronze bags, 4 striped coral bags.
vibrant gray bags contain 1 dark tan bag, 1 posh chartreuse bag.
wavy violet bags contain 1 clear black bag, 5 shiny plum bags, 1 shiny black bag, 1 faded lavender bag.
faded red bags contain 4 drab coral bags, 1 clear aqua bag.
clear black bags contain 3 bright blue bags, 2 striped silver bags, 1 wavy teal bag, 2 light yellow bags.
dim gray bags contain 4 faded turquoise bags, 4 striped bronze bags, 4 drab gold bags.
faded blue bags contain 4 bright orange bags, 4 dotted aqua bags, 1 muted plum bag.
dotted violet bags contain 3 light white bags.
mirrored bronze bags contain 2 shiny lime bags, 1 mirrored chartreuse bag, 5 dim gold bags, 5 dim aqua bags.
faded turquoise bags contain 1 dark white bag, 4 muted chartreuse bags, 2 light cyan bags, 4 posh aqua bags.
clear tan bags contain 4 vibrant aqua bags, 1 dull gold bag, 5 bright fuchsia bags.
posh lavender bags contain 5 wavy plum bags, 2 striped bronze bags, 5 wavy white bags.
vibrant crimson bags contain 1 vibrant silver bag, 3 dotted crimson bags.
dark coral bags contain 3 plaid tan bags.
plaid white bags contain 3 dim cyan bags, 4 drab lime bags.
striped blue bags contain 5 striped lavender bags, 1 bright salmon bag.
drab turquoise bags contain 4 striped lime bags.
dim turquoise bags contain 1 bright gold bag.
bright yellow bags contain 2 plaid black bags, 5 faded lime bags, 2 plaid coral bags, 2 posh crimson bags.
pale gray bags contain 3 dark maroon bags, 2 dark yellow bags, 1 dim violet bag.
wavy brown bags contain 2 shiny fuchsia bags, 1 muted bronze bag, 5 pale white bags, 4 wavy silver bags.
posh tomato bags contain 1 shiny beige bag, 3 wavy maroon bags, 4 shiny plum bags.
dull lime bags contain 4 vibrant maroon bags.
dull salmon bags contain 5 dim brown bags, 1 mirrored white bag, 1 dotted gold bag, 1 vibrant gold bag.
vibrant teal bags contain 1 pale brown bag, 3 shiny crimson bags, 2 striped tomato bags.
shiny plum bags contain 4 dotted aqua bags.
wavy white bags contain 1 bright crimson bag, 1 clear cyan bag, 4 dark white bags, 3 vibrant maroon bags.
dim red bags contain 5 shiny lavender bags, 1 wavy yellow bag.
clear salmon bags contain 5 dim indigo bags, 2 dark black bags.
muted lime bags contain 2 shiny white bags.
dim cyan bags contain 1 shiny blue bag, 5 light cyan bags, 1 bright tomato bag, 4 vibrant yellow bags.
dark brown bags contain 3 posh aqua bags.
faded white bags contain 1 mirrored purple bag.
drab olive bags contain 4 dotted salmon bags.
dull gold bags contain 3 wavy salmon bags, 3 dotted crimson bags, 4 drab violet bags.
dotted fuchsia bags contain 5 pale gold bags, 4 faded olive bags, 5 posh black bags.
clear green bags contain 3 faded tomato bags, 5 faded maroon bags, 4 dotted red bags, 2 bright crimson bags.
muted maroon bags contain 5 dark white bags, 2 dotted chartreuse bags, 2 shiny black bags, 3 light gold bags.
vibrant beige bags contain 5 light tan bags.
dark indigo bags contain 2 faded fuchsia bags, 2 dotted beige bags, 1 mirrored green bag, 1 wavy yellow bag.
shiny aqua bags contain 3 vibrant lavender bags, 5 posh bronze bags, 5 clear purple bags.
plaid gray bags contain 3 dim brown bags, 4 dull aqua bags.
plaid crimson bags contain 2 dark bronze bags, 3 dim beige bags, 5 drab salmon bags, 3 bright coral bags.
posh fuchsia bags contain 5 muted yellow bags.
vibrant magenta bags contain 1 dotted cyan bag, 1 striped green bag, 5 plaid gray bags, 3 pale olive bags.
vibrant tomato bags contain 5 plaid beige bags, 5 clear silver bags, 1 light cyan bag, 4 posh silver bags.
drab purple bags contain 5 wavy olive bags, 1 drab blue bag.
dark purple bags contain 4 pale teal bags.
mirrored orange bags contain 2 mirrored blue bags, 2 drab gold bags, 2 light blue bags, 2 dotted cyan bags.
muted aqua bags contain 2 pale blue bags, 4 striped purple bags.
wavy beige bags contain 1 dim aqua bag.
muted fuchsia bags contain 3 clear chartreuse bags, 3 drab white bags, 4 plaid magenta bags.
clear magenta bags contain 4 pale brown bags.
posh bronze bags contain 5 mirrored magenta bags.
dotted yellow bags contain 5 clear green bags, 3 muted aqua bags, 5 clear beige bags.
wavy salmon bags contain 5 light crimson bags, 5 muted gray bags, 5 clear plum bags, 1 striped purple bag.
dim violet bags contain 2 shiny blue bags, 4 dark brown bags.
clear fuchsia bags contain 1 mirrored coral bag, 2 dim gray bags, 3 pale orange bags.
dark green bags contain 3 clear bronze bags, 4 mirrored cyan bags, 3 dark brown bags, 5 dotted gray bags.
muted purple bags contain 5 muted orange bags, 3 plaid aqua bags, 4 clear chartreuse bags, 4 vibrant indigo bags.
pale blue bags contain no other bags.
dull fuchsia bags contain 3 bright blue bags.
light indigo bags contain 4 dull fuchsia bags, 1 striped silver bag, 5 wavy aqua bags.
muted teal bags contain 3 vibrant black bags, 1 dark maroon bag, 5 dark white bags, 5 dark plum bags.
mirrored brown bags contain 4 shiny lavender bags, 2 light lime bags.
striped teal bags contain 1 striped lime bag.
posh magenta bags contain 4 muted crimson bags, 5 shiny blue bags, 2 plaid orange bags.
dark turquoise bags contain 1 bright tomato bag, 1 dim violet bag.
muted olive bags contain 2 pale lavender bags, 5 plaid plum bags, 1 faded gold bag.
plaid yellow bags contain 1 muted gold bag.
light plum bags contain 2 dull aqua bags.
shiny yellow bags contain 3 mirrored magenta bags, 1 dark violet bag.
vibrant green bags contain 3 striped fuchsia bags, 1 dull gold bag, 5 muted lavender bags.
wavy lime bags contain 5 wavy purple bags, 4 muted coral bags, 2 vibrant indigo bags.
bright lavender bags contain 5 dotted lime bags.
striped orange bags contain 1 wavy tan bag.
dim indigo bags contain 3 striped tan bags, 5 dotted red bags.
vibrant coral bags contain 4 drab bronze bags, 3 dark brown bags, 3 plaid orange bags, 4 pale crimson bags.
dull plum bags contain 1 muted maroon bag.
bright plum bags contain 5 dull tan bags, 4 mirrored blue bags, 3 dull fuchsia bags, 3 wavy violet bags.
faded silver bags contain 4 wavy orange bags, 2 dim salmon bags.
wavy silver bags contain 3 light red bags, 4 faded gray bags, 1 dim tan bag.
drab teal bags contain 4 posh chartreuse bags, 1 posh salmon bag.
light blue bags contain 2 bright lime bags.
mirrored turquoise bags contain 1 drab lime bag, 5 mirrored gray bags.
pale beige bags contain 5 bright tomato bags, 2 mirrored magenta bags, 2 faded gray bags, 1 shiny yellow bag.
muted violet bags contain 3 muted indigo bags, 1 wavy aqua bag, 1 posh lime bag.
dull violet bags contain 4 dark red bags.
bright cyan bags contain 1 dull aqua bag.
muted chartreuse bags contain no other bags.
vibrant red bags contain 5 posh fuchsia bags, 5 shiny brown bags, 5 vibrant plum bags.
posh gold bags contain 2 dull magenta bags, 4 posh plum bags, 1 muted violet bag.
vibrant white bags contain 1 dull magenta bag, 2 dull crimson bags, 1 vibrant tomato bag.
shiny beige bags contain 3 bright blue bags, 1 bright purple bag.
light lime bags contain 1 shiny gold bag, 3 posh salmon bags.
light maroon bags contain 1 dark maroon bag.
dark magenta bags contain 2 dotted crimson bags, 2 dim lavender bags.
shiny indigo bags contain 3 dim lavender bags.
bright salmon bags contain 2 posh beige bags.
posh red bags contain 2 muted chartreuse bags, 3 shiny plum bags, 5 mirrored gray bags, 2 bright tomato bags.
striped plum bags contain 2 posh purple bags, 2 plaid purple bags, 1 posh bronze bag, 2 bright tomato bags.
clear gray bags contain 3 dark violet bags, 1 bright silver bag, 4 striped chartreuse bags, 3 muted gray bags.
posh gray bags contain 5 light maroon bags, 4 dull black bags.
striped beige bags contain 2 dark yellow bags.
muted blue bags contain 2 pale indigo bags, 5 bright gold bags.
dim black bags contain 3 bright purple bags, 1 shiny black bag, 4 vibrant lime bags.
dark blue bags contain 1 pale bronze bag, 5 posh turquoise bags.
dark black bags contain 4 striped fuchsia bags.
light teal bags contain 4 drab tomato bags, 5 bright lavender bags.
light black bags contain 2 wavy olive bags, 4 wavy plum bags, 5 posh indigo bags.
dull bronze bags contain 3 posh fuchsia bags, 2 plaid orange bags.
plaid purple bags contain 2 light tomato bags, 1 drab bronze bag.
striped black bags contain 4 clear silver bags.
muted salmon bags contain 5 dim red bags, 1 mirrored tomato bag, 2 bright coral bags, 1 pale coral bag.
faded yellow bags contain 5 pale orange bags, 4 dim maroon bags, 5 posh lavender bags.
clear indigo bags contain 1 dim aqua bag.
drab green bags contain 3 plaid black bags.
striped tomato bags contain 1 dim orange bag, 5 light indigo bags, 3 pale bronze bags.
posh black bags contain 1 mirrored magenta bag, 5 drab plum bags, 2 pale crimson bags.
dull lavender bags contain 5 dull black bags, 4 dim black bags.
light lavender bags contain 3 posh blue bags, 5 mirrored blue bags, 1 dotted yellow bag.
dotted bronze bags contain 3 bright tomato bags, 4 bright purple bags, 1 dotted red bag.
bright indigo bags contain 3 posh tan bags, 2 posh silver bags.
mirrored black bags contain 5 shiny teal bags, 4 vibrant maroon bags.
bright gray bags contain 3 posh chartreuse bags, 1 wavy bronze bag.
bright magenta bags contain 2 shiny tan bags.
shiny gold bags contain 2 pale blue bags, 1 clear black bag, 2 wavy teal bags, 3 dotted red bags.
dark tan bags contain 1 shiny coral bag, 4 posh chartreuse bags, 3 dark chartreuse bags.
dim lime bags contain 1 dull yellow bag, 1 dim gray bag.
dotted white bags contain 2 vibrant coral bags, 1 striped red bag.
faded cyan bags contain 1 pale silver bag.
vibrant lime bags contain 5 bright tomato bags, 3 dull white bags, 3 plaid orange bags, 2 pale blue bags.
pale aqua bags contain 1 dull red bag, 2 bright aqua bags, 1 light lime bag, 3 clear indigo bags.
vibrant black bags contain 4 posh salmon bags, 2 shiny salmon bags, 2 mirrored crimson bags, 5 shiny orange bags.
wavy red bags contain 3 shiny lavender bags, 4 dotted yellow bags.
faded brown bags contain 5 shiny chartreuse bags.
dark teal bags contain 4 dotted aqua bags, 2 posh lavender bags, 1 dull indigo bag, 5 posh lime bags.
shiny tan bags contain 4 mirrored lime bags, 4 shiny bronze bags, 4 striped crimson bags.
pale bronze bags contain 2 clear chartreuse bags, 1 plaid coral bag.
light tan bags contain 1 dark coral bag, 3 posh chartreuse bags.
drab beige bags contain 4 clear cyan bags, 4 dotted aqua bags.
plaid blue bags contain 1 light cyan bag, 1 mirrored salmon bag.
bright orange bags contain 3 muted cyan bags, 4 bright olive bags, 5 dark yellow bags, 2 wavy gray bags.
dark plum bags contain 4 pale orange bags, 4 mirrored salmon bags.
clear orange bags contain 5 dark teal bags, 1 muted crimson bag, 5 dotted tan bags.
light white bags contain 2 dull black bags, 1 muted crimson bag, 5 pale plum bags.
dark fuchsia bags contain 2 light yellow bags, 4 vibrant tomato bags.
clear lime bags contain 4 pale silver bags, 2 plaid salmon bags.
drab fuchsia bags contain 2 shiny coral bags, 3 drab white bags, 2 dull lime bags.
drab tomato bags contain 3 striped aqua bags, 1 mirrored black bag.
plaid turquoise bags contain 1 light purple bag, 3 mirrored black bags, 2 bright tan bags.
plaid lime bags contain 1 dull tan bag, 2 muted silver bags.
posh white bags contain 4 dotted red bags.
drab magenta bags contain 1 posh aqua bag, 2 plaid salmon bags.
bright black bags contain 2 posh white bags, 4 drab gray bags, 5 dotted indigo bags, 3 faded blue bags.
shiny brown bags contain 1 vibrant violet bag, 4 vibrant lime bags.
dim lavender bags contain 2 wavy green bags, 5 bright fuchsia bags, 5 clear lime bags.
clear chartreuse bags contain 5 faded salmon bags, 3 drab bronze bags, 4 dull magenta bags.
light violet bags contain 5 mirrored orange bags, 3 muted gray bags, 5 striped gray bags, 2 pale lavender bags.
posh brown bags contain 3 light maroon bags, 1 muted lavender bag, 3 faded gray bags, 2 posh chartreuse bags.
dim salmon bags contain 1 faded turquoise bag, 5 vibrant maroon bags, 3 drab cyan bags, 4 dim black bags.
muted beige bags contain 2 vibrant white bags, 1 posh salmon bag.
faded gold bags contain 1 drab brown bag, 1 light blue bag.
light yellow bags contain 4 dark chartreuse bags, 2 dull fuchsia bags.
wavy turquoise bags contain 3 posh brown bags, 2 dotted salmon bags.
dark gold bags contain 4 muted maroon bags.
vibrant orange bags contain 1 dull maroon bag, 3 light tan bags, 4 shiny maroon bags.
plaid teal bags contain 5 faded maroon bags.
plaid brown bags contain 4 clear tomato bags, 1 striped silver bag, 2 plaid coral bags, 5 dull blue bags.
bright purple bags contain no other bags.
drab red bags contain 1 striped white bag, 4 light red bags, 1 bright purple bag.
striped coral bags contain 4 pale tan bags, 1 dim fuchsia bag, 1 dim white bag, 3 bright crimson bags.
posh tan bags contain 4 striped fuchsia bags.
drab cyan bags contain 4 shiny gold bags, 5 light cyan bags, 3 posh blue bags.
dull brown bags contain 3 clear silver bags, 2 dotted crimson bags.
drab violet bags contain 4 muted cyan bags, 4 clear maroon bags, 5 plaid beige bags, 3 dull aqua bags.
bright turquoise bags contain 3 pale turquoise bags.
posh crimson bags contain 3 muted tan bags, 4 vibrant gray bags, 3 mirrored aqua bags, 4 striped indigo bags.
dotted aqua bags contain no other bags.
bright brown bags contain 1 dark chartreuse bag.
posh purple bags contain 5 clear maroon bags, 2 clear lime bags, 1 faded salmon bag.
drab lavender bags contain 4 drab magenta bags.
clear silver bags contain 2 dull white bags, 5 dotted aqua bags, 1 vibrant maroon bag.
dotted silver bags contain 4 faded cyan bags, 4 plaid lavender bags, 4 drab magenta bags.
vibrant lavender bags contain 4 posh aqua bags, 2 pale lime bags, 4 dotted purple bags.
posh violet bags contain 4 dark chartreuse bags, 2 plaid tan bags, 2 bright gray bags, 4 faded salmon bags.
shiny chartreuse bags contain 5 drab coral bags, 2 light yellow bags.
plaid red bags contain 1 drab cyan bag, 5 pale brown bags, 4 dark brown bags.
dotted lavender bags contain 1 bright fuchsia bag, 2 pale maroon bags, 5 vibrant violet bags.
light beige bags contain 2 posh purple bags, 1 dull crimson bag.
dark aqua bags contain 4 drab silver bags, 1 drab beige bag, 2 clear teal bags, 3 dull tan bags.
dotted purple bags contain 3 drab cyan bags, 1 striped turquoise bag, 2 drab plum bags.
wavy gray bags contain 3 dark chartreuse bags, 4 mirrored purple bags, 4 bright blue bags.
faded olive bags contain 3 faded plum bags, 4 dull tan bags.
shiny turquoise bags contain 1 shiny beige bag, 3 vibrant maroon bags.
light tomato bags contain 3 wavy gray bags.
striped maroon bags contain 2 dark white bags, 1 vibrant coral bag.
dull coral bags contain 4 drab olive bags.
muted silver bags contain 5 striped bronze bags, 5 wavy violet bags, 4 muted tan bags.
dotted chartreuse bags contain 3 clear plum bags.
faded lime bags contain 5 dull brown bags, 4 dim brown bags.
posh coral bags contain 5 vibrant violet bags, 1 drab chartreuse bag, 2 faded yellow bags, 5 pale coral bags.
dim green bags contain 1 dark teal bag.
mirrored blue bags contain 1 mirrored gray bag, 4 dotted chartreuse bags, 3 striped silver bags, 2 shiny beige bags.
mirrored aqua bags contain 4 dotted coral bags, 3 posh salmon bags, 5 drab bronze bags.
light coral bags contain 5 shiny cyan bags, 2 faded turquoise bags, 5 plaid lime bags, 5 plaid bronze bags.
vibrant maroon bags contain 3 dark chartreuse bags, 1 dark maroon bag, 2 shiny coral bags, 4 clear cyan bags.
pale olive bags contain 4 dull lime bags, 5 wavy aqua bags.
striped magenta bags contain 5 bright purple bags, 2 muted white bags.
vibrant gold bags contain 1 plaid maroon bag, 3 pale tomato bags, 1 clear tomato bag.
posh plum bags contain 5 mirrored salmon bags, 1 posh magenta bag, 2 posh bronze bags, 1 plaid gold bag.
plaid maroon bags contain 3 striped crimson bags, 3 posh magenta bags, 2 mirrored olive bags, 2 dim gray bags.
drab gold bags contain 2 dark chartreuse bags.
plaid lavender bags contain 3 wavy bronze bags, 1 shiny blue bag, 5 mirrored purple bags, 4 muted aqua bags.
faded green bags contain 3 vibrant yellow bags, 5 clear brown bags, 2 posh bronze bags.
muted green bags contain 3 shiny red bags, 5 pale orange bags.
posh chartreuse bags contain 5 pale indigo bags, 2 striped bronze bags, 3 mirrored blue bags, 1 light cyan bag.
dark lime bags contain 4 bright gray bags, 2 drab purple bags, 5 vibrant indigo bags.
plaid cyan bags contain 2 shiny cyan bags, 2 mirrored magenta bags, 2 dotted indigo bags.
drab yellow bags contain 5 shiny gold bags.
shiny crimson bags contain 2 dim black bags.
posh olive bags contain 4 drab beige bags.
muted crimson bags contain 4 bright bronze bags.
shiny maroon bags contain 5 faded indigo bags, 2 drab plum bags, 2 striped yellow bags.
muted coral bags contain 3 wavy olive bags, 1 posh olive bag.
wavy yellow bags contain 5 drab beige bags, 2 wavy gray bags.
dotted blue bags contain 4 clear magenta bags, 1 shiny bronze bag, 5 posh tan bags.
mirrored silver bags contain 5 shiny lavender bags, 5 dark violet bags.
dark white bags contain 1 clear maroon bag.
faded tomato bags contain 5 shiny coral bags.
dull orange bags contain 1 dim red bag, 4 posh plum bags, 5 posh orange bags, 3 bright cyan bags.
plaid chartreuse bags contain 4 shiny bronze bags, 2 plaid salmon bags, 5 striped purple bags, 4 bright gold bags.
striped white bags contain 2 dull indigo bags, 2 pale plum bags, 4 dim orange bags.
wavy aqua bags contain 2 dull turquoise bags, 4 muted maroon bags.
dim yellow bags contain 2 plaid tan bags.
dark gray bags contain 2 wavy salmon bags, 2 plaid gold bags, 4 dim gold bags.
muted lavender bags contain 4 drab coral bags, 1 vibrant yellow bag, 4 vibrant gray bags, 3 dull crimson bags.
striped lime bags contain 5 dull yellow bags.
striped bronze bags contain 4 wavy bronze bags, 1 striped silver bag.
dark chartreuse bags contain no other bags.
pale gold bags contain 2 mirrored olive bags, 2 drab violet bags.
wavy teal bags contain 1 dark maroon bag, 5 muted chartreuse bags, 1 shiny black bag, 3 dotted aqua bags.
bright fuchsia bags contain 1 muted cyan bag.
"""

extension Set {
	func intersects<S: Sequence>(with other: S) -> Bool where S.Element == Element {
		return isDisjoint(with: other) == false
	}
}

typealias BagContents = [String: Int]

func parseRule(_ raw: Substring) -> (color: String, contents: BagContents) {
	let color = raw.components(separatedBy: " bags").first!
	let rawContents = raw
		.components(separatedBy: "contain ")
		.last!
		.dropLast()
	let contents = rawContents == "no other bags"
		? [:]
		: rawContents.components(separatedBy: ", ")
			.reduce(into: [String: Int]()) { dict, line in
				let count = Int(line.prefix(while: \.isWholeNumber))!
				let color = count == 1
					? line.drop(while: \.isWholeNumber).dropFirst().dropLast(4)
					: line.drop(while: \.isWholeNumber).dropFirst().dropLast(5)
				dict[String(color)] = count
			}
	
	return (color, contents)
}

let rules = input
	.split(separator: "\n")
	.reduce(into: [String: BagContents]()) { dict, line in
		let (color, contents) = parseRule(line)
		dict[color] = contents
	}

func partOne() -> String {
	var validColors: Set<String> = []
	var currentColors: Set<String> = ["shiny gold"]
	
	while currentColors.isEmpty == false {
		let currentColorContainers = rules
			.filter { validColors.contains($0.key) == false }
			.filter { currentColors.intersects(with: $0.value.keys) }
			.keys
		
		currentColors.removeAll()
		currentColorContainers.forEach {
			validColors.insert($0)
			currentColors.insert($0)
		}
	}
	
	return validColors.count.description
}

func partTwo() -> String {
	var totalBagCount = 0
	var currentBags: [String: Int] = ["shiny gold": 1]

	while currentBags.isEmpty == false {
		let childBags = currentBags
			.map { color, quantity -> [String: Int] in
				rules[color]!.mapValues { value in
					value * quantity
				}
			}
			.reduce(into: [String: Int]()) { totalBag, newBag in
				totalBag.merge(newBag, uniquingKeysWith: +)
			}
		
		totalBagCount += childBags.values.reduce(0, +)
		currentBags = childBags
	}

	return totalBagCount.description
}

print(partOne())
print(partTwo())
