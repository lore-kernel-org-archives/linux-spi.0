From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v5 6/8] mtd: spi-nor: add a helper to find the spi_device_id
Date: Mon, 24 Feb 2014 18:37:40 +0800
Message-ID: <1393238262-8622-7-git-send-email-b32955@freescale.com>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <angus.clark-qxv4g6HH51o@public.gmane.org>,
	<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <pekon-l0cyMroinI0@public.gmane.org>, <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	<broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	<b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393238262-8622-1-git-send-email-b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add the spi_nor_match_id() to find the proper spi_device_id with the
NOR flash's name in the spi_nor_ids table.

Signed-off-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/mtd/spi-nor/spi-nor.c |   12 ++++++++++++
 include/linux/mtd/spi-nor.h   |   12 ++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index a840e88..6c8fd01 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1081,6 +1081,18 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 	return 0;
 }
 
+const struct spi_device_id *spi_nor_match_id(char *name)
+{
+	const struct spi_device_id *id = spi_nor_ids;
+
+	while (id->name[0]) {
+		if (!strcmp(name, id->name))
+			return id;
+		id++;
+	}
+	return NULL;
+}
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
 MODULE_AUTHOR("Mike Lavender");
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 16d8409..41dae78 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -182,4 +182,16 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 			enum read_mode mode);
 extern const struct spi_device_id spi_nor_ids[];
 
+/**
+ * spi_nor_match_id() - find the spi_device_id by the name
+ * @name:	the name of the spi_device_id
+ *
+ * The drivers use this function to find the spi_device_id
+ * specified by the @name.
+ *
+ * Return: returns the right spi_device_id pointer on success,
+ *         and returns NULL on failure.
+ */
+const struct spi_device_id *spi_nor_match_id(char *name);
+
 #endif
-- 
1.7.2.rc3


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
