From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v2 1/1] spi: dw: Make debugfs name unique between instances
Date: Tue,  3 Jan 2017 12:54:09 +0800
Message-ID: <1483419249-88956-1-git-send-email-preid@electromag.com.au>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Some system have multiple dw devices. Currently the driver uses a
fixed name for the debugfs dir. Append bus_num to the debugfs dir
name to make it unique.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
---

Notes:
    Changes from v1:
    - Reduce buffer size to 32.
    - Use bus_num instead of device name.

 drivers/spi/spi-dw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 27960e4..77439ac 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -107,7 +107,10 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
 
 static int dw_spi_debugfs_init(struct dw_spi *dws)
 {
-	dws->debugfs = debugfs_create_dir("dw_spi", NULL);
+	char name[32];
+
+	snprintf(name, 32, "dw_spi%d", dws->master->bus_num);
+	dws->debugfs = debugfs_create_dir(name, NULL);
 	if (!dws->debugfs)
 		return -ENOMEM;
 
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
