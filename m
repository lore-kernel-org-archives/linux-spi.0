From: DongCV <cv-dong-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: [PATCH] spi: rspi: fix the bug related to mount/remount jffs2
Date: Fri, 27 Jan 2017 17:12:13 +0900
Message-ID: <74ea1835-3ce3-612c-ece5-52c8dba0ca87@jinso.co.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------CA1D405169DC987F84F67A20"
Cc: kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
        ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, inux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org, h-inayoshi-HEF513clHfp3+QwDJ9on6Q@public.gmane.org, cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a multi-part message in MIME format.
--------------CA1D405169DC987F84F67A20
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Mark,
cc:Geert

This patch fixes the output warning logs and data loss when performing 
mount/umount then remount the device with jffs2 format.
This patch is tested on Lager board at Linux uptream v4.10-rc5.
Please consider the patch for Renesas-soc Gen2

Best regards,
Dong.

------


--------------CA1D405169DC987F84F67A20
Content-Type: text/x-patch;
 name="0001-spi-rspi-fix-the-bug-related-to-mount-remount-jffs2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-spi-rspi-fix-the-bug-related-to-mount-remount-jffs2.pat";
 filename*1="ch"

>From 5513c6a02c911fcf9f99d5188fa46256aa1e41b4 Mon Sep 17 00:00:00 2001
From: Dong <cv-dong-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Date: Fri, 27 Jan 2017 16:29:18 +0900
Subject: [PATCH] spi: rspi: fix the bug related to mount/remount jffs2

This patch fixes the output warning logs and data loss when
performing mount/umount then remount the device with jffs2 format.

This is the warning logs when performing mount/umount then remount the device with jffs2 format:
"root@linaro-naro:~# mount -t jffs2 /dev/mtdblock2 /mnt/media
[ 3839.928013] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40000: 0x1900 instead
[ 3839.956515] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40004: 0x000c instead
[ 3839.985009] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40008: 0xb0b1 instead
[ 3840.013591] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b4000c: 0x1900 instead
[ 3840.042087] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40010: 0x0044 instead
[ 3840.070566] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40014: 0xfb1d instead
[ 3840.099159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40018: 0x0002 instead
[ 3840.127604] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b4001c: 0x0001 instead
[ 3840.156043] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40020: 0x81a4 instead
[ 3840.184472] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b4002c: 0x6529 instead
[ 3840.212900] jffs2: Further such events for this erase block will not be printed
[ 3840.322915] jffs2: notice: (2008) read_dnode: node CRC failed on dnode at 0x3b40080: read 0xc40b5dfc, calculated 0x264be003
root@linaro-naro[ 3840.356857] jffs2: warning: (2008) jffs2_do_read_inode_internal: no data nodes found for ino #2
:~# [ 3840.386659] jffs2: Returned error for crccheck of ino #2. Expect badness...

Signed-off-by: Dong <cv-dong-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 9daf500..2ee1301 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -848,7 +848,6 @@ static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
 			ret = rspi_pio_transfer(rspi, NULL, rx, n);
 			if (ret < 0)
 				return ret;
-			*rx++ = ret;
 		}
 		n -= len;
 	}
-- 
1.9.1


--------------CA1D405169DC987F84F67A20--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
