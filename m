From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: [PATCH 3/5] spi-nor: Make spi_nor_scan() take a chip type name, not
 an spi_device_id
Date: Sun, 14 Sep 2014 18:11:28 +0100
Message-ID: <1410714688.3040.41.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-64kxttVzhJztzfDUPSLE"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410714624.3040.38.camel-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--=-64kxttVzhJztzfDUPSLE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Drivers currently call spi_nor_match_id() and then spi_nor_scan().
This adds a dependency on struct spi_device_id which we want to
avoid.  Make spi_nor_scan() do it for them.

Signed-off-by: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c      |  6 +-----
 drivers/mtd/spi-nor/fsl-quadspi.c |  7 +------
 drivers/mtd/spi-nor/spi-nor.c     | 29 +++++++++++++----------------
 include/linux/mtd/spi-nor.h       | 21 ++++-----------------
 4 files changed, 19 insertions(+), 44 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 3f0fe86..b547c39 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -196,7 +196,6 @@ static int m25p_probe(struct spi_device *spi)
 	struct m25p *flash;
 	struct spi_nor *nor;
 	enum read_mode mode =3D SPI_NOR_NORMAL;
-	const struct spi_device_id *id;
 	int ret;
=20
 	flash =3D devm_kzalloc(&spi->dev, sizeof(*flash), GFP_KERNEL);
@@ -224,10 +223,7 @@ static int m25p_probe(struct spi_device *spi)
 		mode =3D SPI_NOR_QUAD;
 	else if (spi->mode & SPI_RX_DUAL)
 		mode =3D SPI_NOR_DUAL;
-	id =3D spi_nor_match_id(spi_get_device_id(spi)->name);
-	if (WARN_ON(!id))
-		return -ENODEV;
-	ret =3D spi_nor_scan(nor, id, mode);
+	ret =3D spi_nor_scan(nor, spi_get_device_id(spi)->name, mode);
 	if (ret)
 		return ret;
=20
diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-qu=
adspi.c
index 8d659a2..d5269a2 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -881,7 +881,6 @@ static int fsl_qspi_probe(struct platform_device *pdev)
=20
 	/* iterate the subnodes. */
 	for_each_available_child_of_node(dev->of_node, np) {
-		const struct spi_device_id *id;
 		char modalias[40];
=20
 		/* skip the holes */
@@ -909,10 +908,6 @@ static int fsl_qspi_probe(struct platform_device *pdev=
)
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
@@ -921,7 +916,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 		/* set the chip address for READID */
 		fsl_qspi_set_base_addr(q, nor);
=20
-		ret =3D spi_nor_scan(nor, id, SPI_NOR_QUAD);
+		ret =3D spi_nor_scan(nor, modalias, SPI_NOR_QUAD);
 		if (ret)
 			goto map_failed;
=20
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6f699c5..40d6f70 100644
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
@@ -908,9 +910,9 @@ static int spi_nor_check(struct spi_nor *nor)
 	return 0;
 }
=20
-int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
-			enum read_mode mode)
+int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mod=
e)
 {
+	const struct spi_device_id	*id =3D NULL;
 	struct flash_info		*info;
 	struct flash_platform_data	*data;
 	struct device *dev =3D nor->dev;
@@ -930,21 +932,17 @@ int spi_nor_scan(struct spi_nor *nor, const struct sp=
i_device_id *id,
 	 */
 	data =3D dev_get_platdata(dev);
 	if (data && data->type) {
-		const struct spi_device_id *plat_id;
-
-		for (i =3D 0; i < ARRAY_SIZE(spi_nor_ids) - 1; i++) {
-			plat_id =3D &spi_nor_ids[i];
-			if (strcmp(data->type, plat_id->name))
-				continue;
-			break;
-		}
-
-		if (i < ARRAY_SIZE(spi_nor_ids) - 1)
-			id =3D plat_id;
-		else
+		id =3D spi_nor_match_id(data->type);
+		if (!id)
 			dev_warn(dev, "unrecognized id %s\n", data->type);
 	}
=20
+	if (!id && name)
+		id =3D spi_nor_match_id(name);
+
+	if (!id)
+		return -ENODEV;
+
 	info =3D (void *)id->driver_data;
=20
 	if (info->jedec_id) {
@@ -1133,7 +1131,7 @@ int spi_nor_scan(struct spi_nor *nor, const struct sp=
i_device_id *id,
 }
 EXPORT_SYMBOL_GPL(spi_nor_scan);
=20
-const struct spi_device_id *spi_nor_match_id(const char *name)
+static const struct spi_device_id *spi_nor_match_id(const char *name)
 {
 	const struct spi_device_id *id =3D spi_nor_ids;
=20
@@ -1144,7 +1142,6 @@ const struct spi_device_id *spi_nor_match_id(const ch=
ar *name)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(spi_nor_match_id);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 66af67a..6f92b4b 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -184,31 +184,18 @@ struct spi_nor {
 /**
  * spi_nor_scan() - scan the SPI NOR
  * @nor:	the spi_nor structure
- * @id:		the spi_device_id provided by the driver
+ * @name:	the chip type name
  * @mode:	the read mode supported by the driver
  *
  * The drivers can use this fuction to scan the SPI NOR.
  * In the scanning, it will try to get all the necessary information to
  * fill the mtd_info{} and the spi_nor{}.
  *
- * The board may assigns a spi_device_id with @id which be used to compare=
d with
- * the spi_device_id detected by the scanning.
+ * The chip type name can be provided either through platform data or
+ * through the @name parameter.  Platform data takes precedence.
  *
  * Return: 0 for success, others for failure.
  */
-int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
-			enum read_mode mode);
-
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
-const struct spi_device_id *spi_nor_match_id(const char *name);
+int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mod=
e);
=20
 #endif


--=20
Ben Hutchings
The world is coming to an end.	Please log off.

--=-64kxttVzhJztzfDUPSLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVBXMQee/yOyVhhEJAQqnfg/+N1IMKnkjUvMcSfbFtbMNwPXkZapOXpjs
FAD3liJvedDQFvQuhieoSQqi2iNMIrFLs0c7bGY4s3ZXgUObQp0ou1bICD4eNEte
3XH/GPD2pSfw/t/pjx7l7xoJph60cjGVMtCfJRraPScQUylZMI2a2EOBYNmH01hR
z/1dbzT4QLvazbxua/KHPvU04+OvJYfqu/W7OkYJqmGKSmb2FeVkcT55S2JCgVtH
JNy96DOP5xihyZGMtpz7VKhe9OnviWHoOeRIm1qyyF84KKs54bnMHPgVk6WdUkkE
ed0xEw/wN2R7wNbR7V23w21IQYPZnmTGjicCT5K4Ph26MkjmPFf+tTR+5xR1YTXr
qr4+3DH6lO+Zm1OWJ0pliimQt1VfO5BKvdQGIpw7quwZlF1Xk4J9BbdfMO3UK7sw
7RlMNaIsuX+ys7yzupb+GEfKcQwsUH2BOK+Xcwn5Etke89d7RGqupXl+G8r/G9tc
jX5oAct/+KnGSPeiYrNubUgE4GMFaFKipUqRJvZb4s63UzGPK0iJj/rByt273i+x
pxDFirT62bV4BNCLRcUZc10aWJ5XljyMPcnq6kSoNeoQsfHUeNUXIg16vpNjevRp
MJJ1O0OqCIa7ZkPVO8actKX6EPjNzc7svmZ4oY7vJHv7F88wFmUbuIODe5SmNSK0
fSuaobZ0xe0=
=MR11
-----END PGP SIGNATURE-----

--=-64kxttVzhJztzfDUPSLE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
