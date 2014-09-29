From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] mtd: spi-nor: make spi_nor_scan() take a chip type name, not spi_device_id
Date: Mon, 29 Sep 2014 11:47:54 +0200
Message-ID: <1411984074-3850-2-git-send-email-zajec5@gmail.com>
References: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Artem Bityutskiy <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411984074-3850-1-git-send-email-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=46rom: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>

Drivers currently call spi_nor_match_id() and then spi_nor_scan().
This adds a dependency on struct spi_device_id which we want to
avoid.  Make spi_nor_scan() do it for them.

Signed-off-by: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c      |  4 +---
 drivers/mtd/spi-nor/fsl-quadspi.c |  7 +------
 drivers/mtd/spi-nor/spi-nor.c     | 13 +++++++++----
 include/linux/mtd/spi-nor.h       | 20 +++-----------------
 4 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.=
c
index 822209d..bd5e4c6 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -193,7 +193,6 @@ static int m25p_probe(struct spi_device *spi)
 {
 	struct mtd_part_parser_data	ppdata;
 	struct flash_platform_data	*data;
-	const struct spi_device_id *id =3D NULL;
 	struct m25p *flash;
 	struct spi_nor *nor;
 	enum read_mode mode =3D SPI_NOR_NORMAL;
@@ -241,8 +240,7 @@ static int m25p_probe(struct spi_device *spi)
 	else
 		flash_name =3D spi->modalias;
=20
-	id =3D spi_nor_match_id(flash_name);
-	ret =3D spi_nor_scan(nor, id, mode);
+	ret =3D spi_nor_scan(nor, flash_name, mode);
 	if (ret)
 		return ret;
=20
diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fs=
l-quadspi.c
index 8d659a2..d5269a2 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -881,7 +881,6 @@ static int fsl_qspi_probe(struct platform_device *p=
dev)
=20
 	/* iterate the subnodes. */
 	for_each_available_child_of_node(dev->of_node, np) {
-		const struct spi_device_id *id;
 		char modalias[40];
=20
 		/* skip the holes */
@@ -909,10 +908,6 @@ static int fsl_qspi_probe(struct platform_device *=
pdev)
 		if (of_modalias_node(np, modalias, sizeof(modalias)) < 0)
 			goto map_failed;
=20
-		id =3D spi_nor_match_id(modalias);
-		if (!id)
-			goto map_failed;
-
 		ret =3D of_property_read_u32(np, "spi-max-frequency",
 				&q->clk_rate);
 		if (ret < 0)
@@ -921,7 +916,7 @@ static int fsl_qspi_probe(struct platform_device *p=
dev)
 		/* set the chip address for READID */
 		fsl_qspi_set_base_addr(q, nor);
=20
-		ret =3D spi_nor_scan(nor, id, SPI_NOR_QUAD);
+		ret =3D spi_nor_scan(nor, modalias, SPI_NOR_QUAD);
 		if (ret)
 			goto map_failed;
=20
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-no=
r.c
index ae16aa2..5c8e399 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -28,6 +28,8 @@
=20
 #define JEDEC_MFR(_jedec_id)	((_jedec_id) >> 16)
=20
+static const struct spi_device_id *spi_nor_match_id(const char *name);
+
 /*
  * Read the status register, returning its value in the location
  * Return the status register value.
@@ -911,9 +913,9 @@ static int spi_nor_check(struct spi_nor *nor)
 	return 0;
 }
=20
-int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
-			enum read_mode mode)
+int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode=
 mode)
 {
+	const struct spi_device_id	*id =3D NULL;
 	struct flash_info		*info;
 	struct device *dev =3D nor->dev;
 	struct mtd_info *mtd =3D nor->mtd;
@@ -925,6 +927,10 @@ int spi_nor_scan(struct spi_nor *nor, const struct=
 spi_device_id *id,
 	if (ret)
 		return ret;
=20
+	id =3D spi_nor_match_id(name);
+	if (!id)
+		return -ENOENT;
+
 	info =3D (void *)id->driver_data;
=20
 	if (info->jedec_id) {
@@ -1113,7 +1119,7 @@ int spi_nor_scan(struct spi_nor *nor, const struc=
t spi_device_id *id,
 }
 EXPORT_SYMBOL_GPL(spi_nor_scan);
=20
-const struct spi_device_id *spi_nor_match_id(char *name)
+static const struct spi_device_id *spi_nor_match_id(const char *name)
 {
 	const struct spi_device_id *id =3D spi_nor_ids;
=20
@@ -1124,7 +1130,6 @@ const struct spi_device_id *spi_nor_match_id(char=
 *name)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(spi_nor_match_id);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 9e6294f..a5a7a08 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -187,32 +187,18 @@ struct spi_nor {
 /**
  * spi_nor_scan() - scan the SPI NOR
  * @nor:	the spi_nor structure
- * @id:		the spi_device_id provided by the driver
+ * @name:	the chip type name
  * @mode:	the read mode supported by the driver
  *
  * The drivers can use this fuction to scan the SPI NOR.
  * In the scanning, it will try to get all the necessary information t=
o
  * fill the mtd_info{} and the spi_nor{}.
  *
- * The board may assigns a spi_device_id with @id which be used to com=
pared with
- * the spi_device_id detected by the scanning.
+ * The chip type name can be provided through the @name parameter.
  *
  * Return: 0 for success, others for failure.
  */
-int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
-			enum read_mode mode);
+int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode=
 mode);
 extern const struct spi_device_id spi_nor_ids[];
=20
-/**
- * spi_nor_match_id() - find the spi_device_id by the name
- * @name:	the name of the spi_device_id
- *
- * The drivers use this function to find the spi_device_id
- * specified by the @name.
- *
- * Return: returns the right spi_device_id pointer on success,
- *         and returns NULL on failure.
- */
-const struct spi_device_id *spi_nor_match_id(char *name);
-
 #endif
--=20
1.8.4.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
