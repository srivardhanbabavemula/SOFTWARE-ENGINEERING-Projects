#!/bin/bash

echo "🚀 Running Layer 1 (FastLoad)..."
/home/wahab/Project/fastload/fastload.sh
if [ $? -ne 0 ]; then
    echo "❌ Layer 1 (FastLoad) failed. Aborting..."
    exit 1
fi

echo "🚀 Running Layer 2 (BTEQ DDL + DML)..."
/home/wahab/Project/layer2/run_layer2.sh
if [ $? -ne 0 ]; then
    echo "❌ Layer 2 failed. Aborting..."
    exit 1
fi

echo "🚀 Running Layer 3 (BTEQ DDL (Select from Layer 2 with Data))..."
/home/wahab/Project/layer3/run_layer3.shif 
[ $? -ne 0 ]; then
    echo "❌ Layer 3 failed. Aborting..."
    exit 1
fi

echo "🚀 Running Layer 4 (DP_SDM Dimensional Model (DDL + DML))..."
/home/wahab/Project/layer4/run_layer4.shif
 [ $? -ne 0 ]; then
    echo "❌ Layer 4 failed. Aborting..."
    exit 1
fi

echo "✅ All Layers Completed Successfully"

