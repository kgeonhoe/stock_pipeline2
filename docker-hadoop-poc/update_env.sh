#!/bin/bash

# resourcemanager 컨테이너의 IP 주소 가져오기
RESOURCEMANAGER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' resourcemanager)

# hadoop.env 파일에서 관련 설정 업데이트
sed -i "s/YARN_CONF_yarn_resourcemanager_hostname=.*/YARN_CONF_yarn_resourcemanager_hostname=${RESOURCEMANAGER_IP}/" hadoop.env
sed -i "s/YARN_CONF_yarn_resourcemanager_address=.*/YARN_CONF_yarn_resourcemanager_address=${RESOURCEMANAGER_IP}:8032/" hadoop.env
sed -i "s/YARN_CONF_yarn_resourcemanager_scheduler_address=.*/YARN_CONF_yarn_resourcemanager_scheduler_address=${RESOURCEMANAGER_IP}:8030/" hadoop.env
sed -i "s/YARN_CONF_yarn_resourcemanager_resource__tracker_address=.*/YARN_CONF_yarn_resourcemanager_resource__tracker_address=${RESOURCEMANAGER_IP}:8031/" hadoop.env

echo "hadoop.env 파일이 성공적으로 업데이트되었습니다."
