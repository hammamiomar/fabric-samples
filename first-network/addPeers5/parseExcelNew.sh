#!/bin/bash
docker logs orderer1.ord1.example.com 2>&1 | grep
orderer.consensus.etcd | grep -v byfn-sys-channel >> sample.txt
docker logs orderer2.deford1.example.com 2>&1 | grep
orderer.consensus.etcd | grep -v byfn-sys-channel >> sample.txt
docker logs orderer3.deford1.example.com 2>&1 | grep
orderer.consensus.etcd | grep -v byfn-sys-channel >> sample.txt
docker logs orderer4.deford1.example.com 2>&1 | grep
orderer.consensus.etcd | grep -v byfn-sys-channel >> sample.txt
docker logs orderer5.deford1.example.com 2>&1 | grep
orderer.consensus.etcd | grep -v byfn-sys-channel >> sample.txt

docker logs orderer1.deford2.example.com 2>&1 | grep
orderer.consensus.etcd | grep -v byfn-sys-channel >> sample.txt
docker logs orderer2.deford2.example.com 2>&1 | grep
orderer.consensus.etcd | grep -v byfn-sys-channel >> sample.txt
docker logs orderer3.deford2.example.com 2>&1 | grep
orderer.consensus.etcd | grep -v byfn-sys-channel >> sample.txt
docker logs orderer4.deford2.example.com 2>&1 | grep
orderer.consensus.etcd | grep -v byfn-sys-channel >> sample.txt
docker logs orderer5.deford2.example.com 2>&1 | grep
orderer.consensus.etcd | grep -v byfn-sys-channel >> sample.txt

docker logs peer0.deforg1.example.com >& peer01.txt
sed -e '1,9d' < peer01.txt >>temp_peer0.txt
docker logs peer1.deforg1.example.com >& peer11.txt
sed -e '1,9d' < peer11.txt >>temp_peer0.txt
docker logs peer2.deforg1.example.com >& peer21.txt
sed -e '1,9d' < peer21.txt >>temp_peer0.txt

docker logs peer0.deforg2.example.com >& peer02.txt
sed -e '1,9d' < peer02.txt >>temp_peer0.txt
docker logs peer1.deforg2.example.com >& peer12.txt
sed -e '1,9d' < peer12.txt >>temp_peer0.txt
docker logs peer2.deforg2.example.com >& peer22.txt
sed -e '1,9d' < peer22.txt >>temp_peer0.txt

cat temp_peer0.txt | awk '{print($2)}' >> peer_sample2.txt
cat temp_peer0.txt | awk '{print($5)}' >> peer_sample3.txt
cat temp_peer0.txt | awk '{print($4)}' >> peer_sample4.txt

gcut -d' ' -f1,2,3,4,5,6,7,8 --complement temp_peer0.txt | sed
's/node=.*//g' | sed 's/,//g'>> peer_sample5.txt

paste -d, peer_sample2.txt peer_sample3.txt peer_sample4.txt
peer_sample5.txt > peer_sample1.txt
sed  -i '1i Time, Operation, Operation_name, Description' peer_sample1.txt
cat peer_sample1.txt > peer_config10Orderer.csv

cat sample.txt | awk '{print($2)}' >> sample2.txt
cat sample.txt | awk '{print($5)}' >> sample3.txt
cat sample.txt | awk '{print substr($0,length,1)}' >> sample4.txt

gcut -d' ' -f1,2,3,4,5,6,7,8 --complement sample.txt | sed
's/node=.*//g' | sed 's/,//g'>> sample5.txt

paste -d, sample2.txt sample3.txt sample4.txt sample5.txt > sample1.txt
sed  -i '1i Time, Operation, Node, Description' sample1.txt
cat sample1.txt > config10Orderer.csv

rm *.txt

echo `wc -l config10Orderer.csv`
echo `wc -l peer_config10Orderer.csv`
