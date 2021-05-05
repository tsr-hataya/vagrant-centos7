#!/bin/bash

echo ""
echo "==>>"
echo "==>> [SETUP2] Setup is complete."
echo "==>>"
echo ""

# ----- [Final TASK] -----
echo "==> [Final TASK] Setup is complete."
echo "Clearing the yum cache."
yum clean all
echo ""
echo "The setup process is complete."
echo ""
echo "Reboot the server. Please wait for a little while."
echo ""
shutdown -r now


