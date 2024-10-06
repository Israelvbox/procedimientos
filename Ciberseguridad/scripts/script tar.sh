#!/bin/bash

fecha=$(date +\%Y-\%m-\%d)

tar -czvf $fecha.tgz /ruta_del_archivo /ruta_destino

mv $fecha.tgz /ruta_destino


-------------------------------------

#!/bin/bash

fecha=$(date +\%Y-\%m-\%d)

tar -czvf $fecha.tgz /ruta_del_archivo /ruta_del_archivo

mv $fecha.tgz /ruta_destino