From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 1/5] mtd: spi-nor: Added way to rescan spi-nor device
Date: Fri,  3 Feb 2017 18:31:12 -0500
Message-ID: <1486164676-12912-2-git-send-email-kdasu.kdev@gmail.com>
References: <1486164676-12912-1-git-send-email-kdasu.kdev@gmail.com>
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
        marex-ynQEQJNshbs@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486164676-12912-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On pm resume op spi-nor flash may need to be reconfigured on a power
reset, however there is no need to go through a full spi_nor_scan().
The driver might need to disable protection, program the address width and
transfer mode where applicable. The spi-nor framework has all the generic
code to do this. Refactored a few pieces and added a spi_nor_pm_rescan()
to be called by the mtd device driver's pm resume() op.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/spi-nor/spi-nor.c | 93 +++++++++++++++++++++++++++++++++++++------
 include/linux/mtd/spi-nor.h   | 17 ++++++++
 2 files changed, 98 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index da7cd69..e72233b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1312,26 +1312,28 @@ static int spi_nor_check(struct spi_nor *nor)
 	return 0;
 }
 
-int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
+static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
+						       const char *name,
+						       int *retval)
+
 {
 	const struct flash_info *info = NULL;
 	struct device *dev = nor->dev;
-	struct mtd_info *mtd = &nor->mtd;
-	struct device_node *np = spi_nor_get_flash_node(nor);
-	int ret;
-	int i;
+	int ret = 0;
 
 	ret = spi_nor_check(nor);
 	if (ret)
-		return ret;
+		goto info_out;
 
 	if (name)
 		info = spi_nor_match_id(name);
 	/* Try to auto-detect if chip name wasn't specified or not found */
 	if (!info)
 		info = spi_nor_read_id(nor);
-	if (IS_ERR_OR_NULL(info))
-		return -ENOENT;
+	if (IS_ERR_OR_NULL(info)) {
+		ret = -ENOENT;
+		goto info_out;
+	}
 
 	/*
 	 * If caller has specified name of flash model that can normally be
@@ -1342,7 +1344,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 
 		jinfo = spi_nor_read_id(nor);
 		if (IS_ERR(jinfo)) {
-			return PTR_ERR(jinfo);
+			ret = PTR_ERR(jinfo);
+			goto info_out;
 		} else if (jinfo != info) {
 			/*
 			 * JEDEC knows better, so overwrite platform ID. We
@@ -1357,8 +1360,15 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 		}
 	}
 
-	mutex_init(&nor->lock);
+info_out:
+
+	*retval = ret;
+	return info;
+}
 
+static void spi_nor_unprotect(struct spi_nor *nor,
+			      const struct flash_info *info)
+{
 	/*
 	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
 	 * with the software protection bits set
@@ -1372,6 +1382,35 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 		write_sr(nor, 0);
 		spi_nor_wait_till_ready(nor);
 	}
+}
+
+static inline void spi_nor_print_flash_info(struct spi_nor *nor,
+					    const struct flash_info *info)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	struct device *dev = nor->dev;
+
+	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
+			(long long)mtd->size >> 10);
+
+}
+
+int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
+{
+	const struct flash_info *info;
+	struct device *dev = nor->dev;
+	struct mtd_info *mtd = &nor->mtd;
+	struct device_node *np = spi_nor_get_flash_node(nor);
+	int ret;
+	int i;
+
+	info = spi_nor_get_flash_info(nor, name, &ret);
+	if (ret)
+		return ret;
+
+	mutex_init(&nor->lock);
+
+	spi_nor_unprotect(nor, info);
 
 	if (!mtd->name)
 		mtd->name = dev_name(dev);
@@ -1517,8 +1556,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 
 	nor->read_dummy = spi_nor_read_dummy_cycles(nor);
 
-	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
-			(long long)mtd->size >> 10);
+	spi_nor_print_flash_info(nor, info);
 
 	dev_dbg(dev,
 		"mtd .name = %s, .size = 0x%llx (%lldMiB), "
@@ -1540,6 +1578,37 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 }
 EXPORT_SYMBOL_GPL(spi_nor_scan);
 
+int spi_nor_pm_rescan(struct spi_nor *nor, const char *name)
+{
+	int ret = 0;
+	const struct flash_info *info;
+	struct device *dev = nor->dev;
+
+	info = spi_nor_get_flash_info(nor, name, &ret);
+	if (ret)
+		return ret;
+
+	spi_nor_unprotect(nor, info);
+
+	if (nor->flash_read == SPI_NOR_QUAD) {
+		ret = set_quad_mode(nor, info);
+		if (ret) {
+			dev_err(dev, "quad mode not supported\n");
+			return ret;
+		}
+	}
+
+	if (nor->addr_width == 4 && JEDEC_MFR(info) != CFI_MFR_AMD)
+		set_4byte(nor, info, 1);
+
+	spi_nor_print_flash_info(nor, info);
+	dev_dbg(dev, "addr width %d read mode %d",
+		nor->addr_width, nor->flash_read);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_nor_pm_rescan);
+
 static const struct flash_info *spi_nor_match_id(const char *name)
 {
 	const struct flash_info *id = spi_nor_ids;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index c425c7b..487b473 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -213,4 +213,21 @@ static inline struct device_node *spi_nor_get_flash_node(struct spi_nor *nor)
  */
 int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode);
 
+/**
+ * spi_nor_pm_rescan() - rescan the SPI NOR
+ * @nor:	the spi_nor structure
+ * @name:	the chip type name
+ *
+ * The drivers can use this function to set the SPI NOR flash device to
+ * its initial scanned state, it shall use all nor information set on poweron
+ * for the read mode, address width and enabling write mode for certain
+ * manufacturers. This would be needed to be called for flash devices that are
+ * reset during power management.
+ *
+ * The chip type name can be provided through the @name parameter.
+ *
+ * Return: 0 for success, others for failure.
+ */
+int spi_nor_pm_rescan(struct spi_nor *nor, const char *name);
+
 #endif
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
