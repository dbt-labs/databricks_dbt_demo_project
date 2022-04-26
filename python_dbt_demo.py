from fal import FalDbt
import os

cwd = os.getcwd()

faldbt = FalDbt(profiles_dir=cwd, project_dir=cwd)

print(faldbt.list_sources())

dim_listings_df = faldbt.ref('dim_neighborhoods')

print(dim_listings_df.tail())