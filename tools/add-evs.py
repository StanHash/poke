import os
import glob
import requests

filenames = glob.glob('data/pokemon/base_stats/*.asm')

REMAP = {
    'nidoran_m': 'nidoran-m',
    'nidoran_f': 'nidoran-f',
    'farfetch_d': 'farfetchd',
    'mr__mime': 'mr-mime',
    'ho_oh': 'ho-oh' }

for filename in filenames:
    mon_name = os.path.splitext(os.path.split(filename)[1])[0]

    if mon_name in REMAP:
        mon_name = REMAP[mon_name]

    print(f'Update {mon_name}')

    r = requests.get(f'https://pokeapi.co/api/v2/pokemon/{mon_name}/')
    j = r.json()

    with open(filename, 'r', encoding='utf8') as file:
        lines = file.readlines()

    with open(filename, 'w', encoding='utf8') as file:
        for line in lines:
            if line in ['\tdb 100 ; unknown 1\n', '\tdb 5 ; unknown 2\n']:
                continue
            if line == '\t;   hp  atk  def  spd  sat  sdf\n':
                file.write(f'\tevs  {j["stats"][0]["effort"]},   {j["stats"][1]["effort"]},   {j["stats"][2]["effort"]},   {j["stats"][5]["effort"]},   {j["stats"][3]["effort"]},   {j["stats"][4]["effort"]}\n')
            file.write(line)
