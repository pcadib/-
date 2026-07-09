#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "لطفاً این اسکریپت را با sudo یا به عنوان root اجرا کن."
  exit 1
fi

PCADIB_VERSION="1.0"
PCADIB_CODENAME="Nova"

echo "=== [1/6] نصب پیش‌نیازهای ساخت ==="
apt update
apt install -y live-build live-config live-boot debootstrap syslinux-utils \
               squashfs-tools xorriso isolinux git rsync

echo "=== [2/6] پاکسازی build قبلی (در صورت وجود) ==="
lb clean --purge || true

echo "=== [3/6] تنظیم پیکربندی live-build ==="
lb config \
  --distribution bookworm \
  --archive-areas "main contrib non-free non-free-firmware" \
  --debian-installer false \
  --binary-images iso-hybrid \
  --iso-application "PCADIB OS" \
  --iso-preparer "PCADIB Project" \
  --iso-publisher "PCADIB Project - https://example.com" \
  --iso-volume "PCADIB_OS_${PCADIB_VERSION}" \
  --linux-flavours amd64 \
  --bootappend-live "boot=live components username=pcadib hostname=pcadib-os locales=fa_IR.UTF-8 keyboard-layouts=us quiet splash" \
  --memtest none \
  --win32-loader false

echo "=== [4/6] کپی فایل‌های سفارشی (پکیج‌ها، برندینگ، هوک‌ها) ==="
chmod +x config/hooks/live/*.hook.chroot

echo "=== [5/6] ساخت ایمیج (ممکن است ۳۰ تا ۹۰ دقیقه طول بکشد) ==="
lb build

echo "=== [6/6] پایان ==="
ISO_FILE=$(ls live-image-*.hybrid.iso 2>/dev/null | head -n1)
if [ -n "$ISO_FILE" ]; then
  mv "$ISO_FILE" "pcadib-os-${PCADIB_VERSION}-${PCADIB_CODENAME}.iso"
  echo "ISO ساخته شد: pcadib-os-${PCADIB_VERSION}-${PCADIB_CODENAME}.iso"
else
  echo "ساخت ISO با خطا مواجه شد یا نامی متفاوت دارد؛ داخل پوشه‌ی جاری را بررسی کن."
fi
