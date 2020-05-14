#!/bin/bash
#SBATCH --time=5:00:00
#SBATCH --account=def-emilios
#SBATCH --job-name=huggingFace
#SBATCH --gres=gpu:2
#SBATCH --cpus-per-task=6
#SBATCH --mem=32G
#SBATCH --output=%N-%j.out
#SBATCH --error=error_%j.e

module load python/3.6

# rm -rf env
python3 -m venv env
source ../env/bin/activate

ln -s $SLURM_TMPDIR/env `whoami` #useful when you want to use VSCODE
echo $SLURM_TMPDIR
module load scipy-stack

python3 -m pip install --user  numPy
python3 -m pip install --user  pandas
python3 -m pip install --user tensorflow_gpu
python3 -m pip install --user torch torchvision
python3 -m pip install --user torchtext
python3 -m pip install --user --index="http://pypi.org/simple/" scikit-learn
python3 -m pip install --user matplotlib
python3 -m pip install --user tqdm
python3 -m pip install transformers

unset XDG_RUNTIME_DIR
python3 -u -m jupyter notebook --ip $(hostname -f) --no-browser