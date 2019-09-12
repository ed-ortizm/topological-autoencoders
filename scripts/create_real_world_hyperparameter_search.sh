#!/bin/bash

ae_models=(Vanilla TopoRegEdgeSymmetric)
competitor_methods=(PCA TSNE Isomap UMAP)
output_pattern='experiments/hyperparameter_search/real_world/{dataset}/{model}.json'
input_dims='[3,32,32]'

python scripts/configs_from_product.py exp.hyperparameter_search \
  --name model \
  --set ${ae_models[*]} \
  --name dataset --set MNIST FashionMNIST \
  --name dummy --set overrides.model__parameters__autoencoder_model=DeepAE \
  --output-pattern ${output_pattern}

python scripts/configs_from_product.py exp.hyperparameter_search \
    --name model \
    --set ${ae_models[*]} \
    --name dataset --set CIFAR \
    --name dummy --set overrides.model__parameters__autoencoder_model=DeepAE \
    --name dummy --set overrides.model__parameters__ae_kwargs__input_dims=${input_dims} \
    --output-pattern ${output_pattern}

#python scripts/configs_from_product.py exp.hyperparameter_search \
#  --name model \
#  --set ${ae_models[*]} \
#  --name dataset --set  COIL \
#  --name dummy --set overrides.model__parameters__autoencoder_model=DeepAE_COIL \
#  --output-pattern ${output_pattern}

python scripts/configs_from_product.py exp.hyperparameter_search \
  --name model \
  --set ${competitor_methods[*]} \
  --name dataset --set MNIST FashionMNIST CIFAR \
  --output-pattern ${output_pattern}
