#!/system/bin/sh

ufs() {
    local ufs_life_value="$1"
    local status_msg
    case $ufs_life_value in
    "0x01"|"0x1")
        status_msg="UFS健康状况：100% - 90% 已使用寿命 0% - 10%"
    ;;
    "0x02"|"0x2")
        status_msg="UFS健康状况：90% - 80% 已使用寿命 10% - 20%"
    ;;
    "0x03"|"0x3")
        status_msg="UFS健康状况：80% - 70% 已使用寿命 20% - 30%"
    ;;
    "0x04"|"0x4")
        status_msg="UFS健康状况：70% - 60% 已使用寿命 30% - 40%"
    ;;
    "0x05"|"0x5")
        status_msg="UFS健康状况：60% - 50% 已使用寿命 40% - 50%"
    ;;
    "0x06"|"0x6")
        status_msg="UFS健康状况：50% - 40% 已使用寿命 50% - 60%"
    ;;
    "0x07"|"0x7")
        status_msg="UFS健康状况：40% - 30% 已使用寿命 60% - 70%"
    ;;
    "0x08"|"0x8")
        status_msg="UFS健康状况：30% - 20% 已使用寿命 70% - 80%"
    ;;
    "0x09"|"0x9")
        status_msg="UFS健康状况：20% - 10% 已使用寿命 80% - 90%"
    ;;
    "0x0A"|"0xA")
        status_msg="UFS健康状况：10% - 0% 已使用寿命 90% - 100%"
    ;;
    "0x0B"|"0xB")
        status_msg="UFS健康状况：<10% 已超过预估寿命"
    ;;
    *)
        status_msg='已使用寿命 未知'
    ;;
    esac

    echo "$status_msg"
}

name=$(su -c "cat /sys/devices/platform/soc/1d84000.ufshc/string_descriptors/product_name")
echo "UFS设备品牌 - $name"

if [[ -f /sys/devices/platform/soc/1d84000.ufshc/health_descriptor/life_time_estimation_a ]]; then
    ufs_a=$(su -c "cat /sys/devices/platform/soc/1d84000.ufshc/health_descriptor/life_time_estimation_a" | cut -f1 -d ' ')
    echo "A - $(ufs $ufs_a)"
else
    echo "无法获取 a 的值，请检查权限或文件是否存在。"
fi

if [[ -f /sys/devices/platform/soc/1d84000.ufshc/health_descriptor/life_time_estimation_b ]]; then
    ufs_b=$(su -c "cat /sys/devices/platform/soc/1d84000.ufshc/health_descriptor/life_time_estimation_b" | cut -f1 -d ' ')
    echo "B - $(ufs $ufs_b)"
else
    echo "无法获取 b 的值，请检查权限或文件是否存在。"
fi
