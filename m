From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] mtd: m25p80: get rid of spi_get_device_id
Date: Mon, 29 Sep 2014 11:47:53 +0200
Message-ID: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
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
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This simplifies the way we use spi_nor framework and will allow us to
drop spi_nor_match_id.

Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.=
c
index dcda628..822209d 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -197,6 +197,7 @@ static int m25p_probe(struct spi_device *spi)
 	struct m25p *flash;
 	struct spi_nor *nor;
 	enum read_mode mode =3D SPI_NOR_NORMAL;
+	char *flash_name =3D NULL;
 	int ret;
=20
 	data =3D dev_get_platdata(&spi->dev);
@@ -236,12 +237,11 @@ static int m25p_probe(struct spi_device *spi)
 	 * If that's the case, respect "type" and ignore a "name".
 	 */
 	if (data && data->type)
-		id =3D spi_nor_match_id(data->type);
-
-	/* If we didn't get name from platform, simply use "modalias". */
-	if (!id)
-		id =3D spi_get_device_id(spi);
+		flash_name =3D data->type;
+	else
+		flash_name =3D spi->modalias;
=20
+	id =3D spi_nor_match_id(flash_name);
 	ret =3D spi_nor_scan(nor, id, mode);
 	if (ret)
 		return ret;
--=20
1.8.4.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
