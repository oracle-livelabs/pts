# -----------------------------------------------------------------------------
# Copyright (c) 2023, Oracle and/or its affiliates.
#
# This software is dual-licensed to you under the Universal Permissive License
# (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
# 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
# either license.
#
# If you elect to accept the software under the Apache License, Version 2.0,
# the following applies:
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# -----------------------------------------------------------------------------
#
# Create the schema for the demostrations


import os
import sys

import oracledb

un = os.getenv("PYTHON_USERNAME")
pw = os.getenv("PYTHON_PASSWORD")
cs = os.getenv("PYTHON_CONNECTSTRING")

# Connect to Oracle Database 23.4
with oracledb.connect(user=un, password=pw, dsn=cs) as connection:
    db_version = tuple(int(s) for s in connection.version.split("."))[:2]
    if db_version < (23, 4):
        sys.exit("This example requires Oracle Database 23.4 or later")
    print("Connected to Oracle Database")

    print("Creating schema objects")
    with connection.cursor() as cursor:
        sql = [
            """drop table if exists my_data purge""",
            """create table if not exists my_data (
                 id   number primary key,
                 info varchar2(128),
                 v    vector)""",
        ]
        for s in sql:
            try:
                cursor.execute(s)
            except oracledb.DatabaseError as e:
                if e.args[0].code != 942:  # ignore ORA-942: table does not exist
                    raise

        data_to_insert = [
            (1, "San Francisco is in California.", None),
            (2, "San Jose is in California.", None),
            (3, "Los Angeles is in California.", None),
            (4, "Buffalo is in New York.", None),
            (5, "Brooklyn is in New York.", None),
            (6, "Queens is in New York.", None),
            (7, "Harlem is in New York.", None),
            (8, "The Bronx is in New York.", None),
            (9, "Manhattan is in New York.", None),
            (10, "Staten Island is in New York.", None),
            (11, "Miami is in Florida.", None),
            (12, "Tampa is in Florida.", None),
            (13, "Orlando is in Florida.", None),
            (14, "Dallas is in Texas.", None),
            (15, "Houston is in Texas.", None),
            (16, "Austin is in Texas.", None),
            (17, "Phoenix is in Arizona.", None),
            (18, "Las Vegas is in Nevada.", None),
            (19, "Portland is in Oregon.", None),
            (20, "New Orleans is in Louisiana.", None),
            (21, "Atlanta is in Georgia.", None),
            (22, "Chicago is in Illinois.", None),
            (23, "Cleveland is in Ohio.", None),
            (24, "Boston is in Massachusetts.", None),
            (25, "Baltimore is in Maryland.", None),
            (26, "Charlotte is in North Carolina.", None),
            (27, "Raleigh is in North Carolina.", None),

            (100, "Ferraris are often red.", None),
            (101, "Teslas are electric.", None),
            (102, "Mini Coopers are small.", None),
            (103, "Fiat 500 are small.", None),
            (104, "Dodge Vipers are wide.", None),
            (105, "Ford 150 are popular.", None),
            (106, "Alfa Romeos are fun.", None),
            (107, "Volvos are safe.", None),
            (108, "Toyotas are reliable.", None),
            (109, "Hondas are reliable.", None),
            (110, "Porsches are fast and reliable.", None),
            (111, "Nissan GTR are great", None),
            (112, "NISMO is awesome", None),
            (113, "Tesla Cybertrucks are awesome", None),
            (114, "Jeep Wranglers are fun.", None),

            (200, "Bananas are yellow.", None),
            (201, "Kiwis are green inside.", None),
            (202, "Kiwis are brown on the outside.", None),
            (203, "Kiwis are birds.", None),
            (204, "Kiwis taste good.", None),
            (205, "Ripe strawberries are red.", None),
            (206, "Apples can be green, yellow or red.", None),
            (207, "Ripe cherries are red.", None),
            (208, "Pears can be green, yellow or brown.", None),
            (209, "Oranges are orange.", None),
            (210, "Peaches can be yellow, orange or red.", None),
            (211, "Peaches can be fuzzy.", None),
            (212, "Grapes can be green, red or purple.", None),
            (213, "Watermelons are green on the outside.", None),
            (214, "Watermelons are red on the outside.", None),
            (215, "Blueberries are blue.", None),
            (216, "Limes are green.", None),
            (217, "Lemons are yellow.", None),
            (218, "Ripe tomatoes are red.", None),
            (219, "Unripe tomatoes are green.", None),
            (220, "Ripe raspberries are red.", None),
            (221, "Mangoes can be yellow, gold, green or orange.", None),

            (300, "Tigers have stripes.", None),
            (301, "Lions are big.", None),
            (302, "Mice are small.", None),
            (303, "Cats do not care.", None),
            (304, "Dogs are loyal.", None),
            (305, "Bears are hairy.", None),
            (306, "Pandas are black and white.", None),
            (307, "Zebras are black and white.", None),
            (308, "Penguins can be black and white.", None),
            (309, "Puffins can be black and white.", None),
            (310, "Giraffes have long necks.", None),
            (311, "Elephants have trunks.", None),
            (312, "Horses have four legs.", None),
            (313, "Birds can fly.", None),
            (314, "Birds lay eggs.", None),
            (315, "Fish can swim.", None),
            (316, "Sharks have lots of teeth.", None),
            (317, "Flies can fly.", None),
            (318, "Snakes have fangs.", None),
            (319, "Hyenas laugh.", None),
            (320, "Crocodiles lurk.", None),
            (321, "Spiders have eight legs.", None),
            (322, "Wolves are hairy.", None),
            (323, "Mountain Lions eat deer.", None),
            (324, "Kangaroos can hop.", None),
            (325, "Turtles have shells.", None),

            (400, "Ibaraki is in Kanto.", None),
            (401, "Tochigi is in Kanto.", None),
            (402, "Gunma is in Kanto.", None),
            (403, "Saitama is in Kanto.", None),
            (404, "Chiba is in Kanto.", None),
            (405, "Tokyo is in Kanto.", None),
            (406, "Kanagawa is in Kanto.", None),

            (500, "Eggs are egg shaped.", None),
            (501, "Tokyo is in Japan.", None),
            (502, "To be, or not to be, that is the question.", None),
            (503, "640K ought to be enough for anybody.", None),
            (504, "Man overboard.", None),
            (505, "The world is your oyster.", None),
            (506, "One small step for Mankind.", None),
            (507, "Bitcoin is a cryptocurrency.", None),
            (508, "Saturn has rings.", None),

            (600, "Catamarans have two hulls.", None),
            (601, "Monohulls have a single hull.", None),
            (602, "Foiling sailboats are fast.", None),
            (603, "Cutters have two headsails.", None),
            (604, "Yawls have two masts.", None),
            (605, "Sloops have one mast.", None),

            (900, 'Oracle CloudWorld Las Vegas was on September 18–21, 2023', None),
            (901, 'Oracle CloudWorld Las Vegas was at The Venetian Convention and Expo Center', None),
            (902, 'Oracle CloudWorld Dubai is on 23 January 2024', None),
            (903, 'Oracle CloudWorld Dubai is at the Dubai World Trade Centre', None),
            (904, 'Oracle CloudWorld Mumbai is on 14 February 2024', None),
            (905, 'Oracle CloudWorld Mumbai is at the Jio World Convention Centre', None),
            (906, 'Oracle CloudWorld London is on 14 March 2024', None),
            (907, 'Oracle CloudWorld London is at the ExCeL London', None),
            (908, 'Oracle CloudWorld Milan is on 21 March 2024', None),
            (909, 'Oracle CloudWorld Milan is at the Milano Convention Centre', None),
            (910, 'Oracle CloudWorld Sao Paulo is on 4 April 2024', None),
            (911, 'Oracle CloudWorld Sao Paulo is at the World Trade Center São Paulo', None),
            (912, 'Oracle CloudWorld Singapore is on 16 April 2024', None),
            (913, 'Oracle CloudWorld Singapore is at the TBD', None),
            (914, 'Oracle CloudWorld Tokyo is on 18 April 2024', None),
            (915, 'Oracle CloudWorld Tokyo is at The Prince Park Tower Tokyo', None),
            (916, 'Oracle CloudWorld Mexico City is on 25 April 2024', None),
            (917, 'Oracle CloudWorld Mexico City is at the Centro Citibanamex', None),

            (1000, 'Dubai is in the United Arab Emirates.', None),
            (1001, 'The Burj Khalifa is in Dubai.', None),
            (1002, 'The Burj Khalifa is tallest building in the world.', None),
            (1003, 'Dubai is in the Persian Gulf.', None),
            (1004, 'The United Arab Emirates consists of seven emirates.', None),
            (1005, 'The Emirates are Abu Dhabi, Ajman, Dubai, Fujairah, Ras Al Khaimah, Sharjah and Umm Al Quwain.', None),
            (1006, 'The Emirates Mars Mission sent the Hope probe into orbit around Mars.', None),
            (1007, 'Sheikh Mohamed bin Zayed Al Nahyan is the third president of the United Arab Emirates.', None),
            (1008, 'Emirates is the largest airline in the Middle East.', None),
            (1009, 'Emirates operates to more than 150 cities in 80 countries.', None),
            (1010, 'Emirates operates a fleet of nearly 300 aircraft.', None),
            (1011, 'Emirates sponsors the Arsenal Football Club.', None),

            (1100, 'Mumbai is in India.', None),
            (1101, 'Mumbai is the capital city of the Indian state of Maharashtra.', None),
            (1102, 'Mumbai is the Indian state of Maharashtra.', None),
            (1103, 'Mumbai is on the west coast of India.', None),
            (1104, 'Mumbai is the de facto financial centre of India.', None),
            (1105, 'Mumbai has a population of about 12.5 million people.', None),
            (1106, 'Mumbai is hot with an average minimum temperature of 24 degrees celsius.', None),
            (1107, 'Common languages in Mumbai are Marathi, Hindi, Gujarati, Urdu, Bambaiya and English.', None),

        ]

        connection.autocommit = True

        cursor.executemany(
            """insert into my_data (id, info, v)
               values (:1, :2, :3)""",
            data_to_insert,
        )

print("Created tables and inserted data")
