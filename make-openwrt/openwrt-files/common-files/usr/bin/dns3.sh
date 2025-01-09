#!/usr/bin/env bash


command -v bc > /dev/null || { echo "error: BY Sincan2 bc tidak di temukan kamu harus install bc."; exit 1; }
{ command -v drill > /dev/null && dig=drill; } || { command -v dig > /dev/null && dig=dig; } || { echo "error, by Sincan2 kamu harus install dnsutils/Kalau di openwrt Install opkg install bind-dig."; exit 1; }


NAMESERVERS=`cat /etc/resolv.conf | grep ^nameserver | cut -d " " -f 2 | sed 's/\(.*\)/&#&/'`

PROVIDERSV4="
223.5.5.5#AliDNS
103.87.68.23#BebasDNS-Malware
1.1.1.1#Cloudflare
1.1.1.2#CloudflareMalware
8.8.8.8#Google
9.9.9.9#Quad9
208.67.222.222#OpenDNS
176.103.130.132#Adguard
156.154.70.1#Neustar
4.2.2.1#Level3-1
209.244.0.3#Level3-2
80.80.80.80#Freenom
84.200.69.80#DNS.Watch
199.85.126.20#Norton
185.228.168.168#CleanBrowsing
77.88.8.7#Yandex
156.154.70.3#Meustar
8.26.56.26#Comodo
45.90.28.202#NextDNS
64.6.64.6#Verisign
195.46.39.39#SafeDNS
216.146.35.35#DynDNS
117.50.11.11#OneDNS
180.76.76.76#Baidu
74.82.42.42#HE.NET
194.187.251.67#CyberGhost
198.54.117.10#SafeServe
76.76.2.0#ControlD
172.104.162.222#OpenNIC
185.49.141.37#DNSPrivacy
185.222.222.222#DNS.SB
119.29.29.29#DNSPod
54.174.40.213#DNSWatchGO
193.110.81.0#dns0.eu
80.80.80.80#FreenomWorld
216.218.221.42#HurricaneElectric
194.242.2.2#Mullvad
12.159.2.159#Quadrant
104.155.237.225#SafeSurfer
101.226.4.6#360SecureDNS1
123.125.81.6#360SecureDNS2
64.6.64.6#VerisignPublicDNS
185.71.138.138#WikimediaDNS
146.255.56.98#AppliedPrivacyDNS
149.112.121.10#CIRACanadianShieldDNS
193.17.47.1#CZ.NICODVR
185.95.218.43#DigitaleGesellschaftDNS
158.64.1.29#FondationRestenaDNS
114.114.114.114#114DNS
155.248.232.226#JupitrDNS
88.198.92.222#LibreDNS
101.101.101.101#Quad101
193.58.251.251#SkyDNSRU
130.59.31.248#SWITCHDNS
116.121.57.111#XstlDNS
5.2.75.75#AhaDNS
139.59.48.222#CaptnemoDNS
176.9.93.198#DNSForge
185.121.177.177#fvzDNS
213.196.191.96#ibksturmDNS
204.12.237.197#MarbledFennec
51.38.83.141#OSZXDNS
174.138.21.128#Privacy-FirstDNS
45.76.113.31#SebyDNS
103.252.122.187#BlackMagiccDNS
95.85.95.85#G-CoreDNS
195.208.22.33#msk-ix.ru
195.140.195.21#TREXDNS
58.147.190.49#public-dns-Depok
103.166.158.10#public-dns-Jakarta
203.161.30.118#public-dns-Bogor
103.10.171.230#public-dns-Bandung
"

PROVIDERSV6="
2a04:b900:0:100::37#DNSPrivacy-v6
2a09::#DNS.SB-v6
2402:4e00::#DNSPod-v6
2a0f:fc80::#dns0.eu-v6
2001:470:0:17c::2#HurricaneElectric-v6
2a07:e340::2#Mullvad-v6
2001:1890:140c::159#Quadrant-v6
2620:74:1b::1:1#VerisignPublicDNS-v6
2001:67c:930::1#WikimediaDNS-v6
2a02:1b8:10:234::2#AppliedPrivacyDNS-v6
2620:10A:80BB::10#CIRACanadianShieldDNS-v6
2001:148f:ffff::1#CZ.NICODVR-v6
2a05:fc84::43#DigitaleGesellschaftDNS-v6
2001:a18:1::29#FondationRestenaDNS-v6
2001:de4::101#Quad101-v6
2001:620:0:ff::2#SWITCHDNS-v6
2a04:52c0:101:75::75#AhaDNS-v6
2a01:4f8:151:34aa::198#DNSForge-v6
2604:4300:f03:c1::2#MarbledFennec-v6
2001:41d0:801:2000::d64#OSZXDNS-v6
2400:6180:0:d0::5f6e:4001#Privacy-FirstDNS-v6
2401:4ae0::38#BlackMagiccDNS-v6
2a03:90c0:999d::1#G-CoreDNS-v6
2001:6d0:ffd9:337:195:208:22:33#msk-ix.ru-v6
2001:67c:2b0::1#TREXDNS-v6
2400:3200::1#AliDNS-v6
2606:4700:4700::1111#Cloudflare-v6
2606:4700:4700::1112#CloudflareMalware-v6
2001:4860:4860::8888#Google-v6
2620:fe::fe#Quad9-v6
2620:119:35::35#Opendns-v6
2a0d:2a00:1::1#CleanBrowsing-v6
2a02:6b8::feed:0ff#Yandex-v6
2a00:5a60::ad1:0ff#Adguard-v6
2610:a1:1018::3#Neustar-v6
2620:119:53::53#Comodo-v6
2606:1a40::#ControlD-v6
2400:8901::f03c:93ff:fe25:a89b#OpenNIC-v6
2001:470:20::2#HE.NET-v6
2620:74:1b::1:1#Verisign-v6
2001:df1:7340:c::beba:51d#BebasDNS-Malware-v6
"

# Testing for IPv6
if dig +short +tries=1 +time=2 +stats @2606:4700:4700::1111 alsyundawy.my.id | grep -q '172\.67\.134\.149\|104\.21\.6\.70'; then
    hasipv6="true"
fi

providerstotest=$PROVIDERSV4

if [ "x$1" = "xipv6" ]; then
    if [ "x$hasipv6" = "x" ]; then
        echo "error: IPv6 support not found. Unable to do the ipv6 test."; exit 1;
    fi
    providerstotest=$PROVIDERSV6

elif [ "x$1" = "xipv4" ]; then
    providerstotest=$PROVIDERSV4

elif [ "x$1" = "xall" ]; then
    if [ "x$hasipv6" = "x" ]; then
        providerstotest=$PROVIDERSV4
    else
        providerstotest="$PROVIDERSV4 $PROVIDERSV6"
    fi
else
    providerstotest=$PROVIDERSV4
fi



# Domains to test. Duplicated domains are ok
DOMAINS2TEST="google.com amazon.com facebook.com www.youtube.com www.detik.com wikipedia.org twitter.com www.tokopedia.com whatsapp.com tiktok.com"


totaldomains=0
printf "%-21s" ""
for d in $DOMAINS2TEST; do
    totaldomains=$((totaldomains + 1))
    printf "%-8s" "test$totaldomains"
done
printf "%-8s" "Average"
echo ""


for p in $NAMESERVERS $providerstotest; do
    pip=${p%%#*}
    pname=${p##*#}
    ftime=0

    printf "%-21s" "$pname"
    for d in $DOMAINS2TEST; do
        ttime=`$dig +tries=1 +time=2 +stats @$pip $d |grep "Query time:" | cut -d : -f 2- | cut -d " " -f 2`
        if [ -z "$ttime" ]; then
	        #let's have time out be 1s = 1000ms
	        ttime=1000
        elif [ "x$ttime" = "x0" ]; then
	        ttime=1
	    fi

        printf "%-8s" "$ttime ms"
        ftime=$((ftime + ttime))
    done
    avg=`bc -l <<< "scale=2; $ftime/$totaldomains"`

    echo "  $avg"
done


exit 0;
