#!/bin/bash
#SBATCH --job-name=scaling_crl            # Job name
#SBATCH --nodes=1                        # Number of nodes
#SBATCH --ntasks=1                       # Number of tasks
#SBATCH --cpus-per-task=1                # Number of CPU cores per task
#SBATCH --mem-per-cpu=128G                 # Memory per CPU core
#SBATCH --gres=gpu:1                     # Number of GPUs per node
#SBATCH --constraint=gpu80                # GPU type
#SBATCH --time 56:00:00                 # Time limit (hh:mm:ss)
#SBATCH --output=slurm_logs/slurm-%j.out       # Output file (%j = job ID)

module purge
module load anaconda3/2024.2
conda activate scaling-crl

python train_sg.py --env_id "ant_big_maze_sg" --eval_env_id "ant_big_maze_sg" --num_epochs 100 --total_env_steps 100000000 --critic_depth 256 --actor_depth 256 --actor_skip_connections 4 --critic_skip_connections 4 --batch_size 512 --vis_length 1000 --save_buffer 0 --goal_location '{"x":1, "y":6}'
