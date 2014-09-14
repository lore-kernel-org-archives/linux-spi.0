From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: [PATCH 2/5] spi-nor: Remove spi_nor::read_id operation
Date: Sun, 14 Sep 2014 18:11:16 +0100
Message-ID: <1410714676.3040.40.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-GPJrzHr2c+Xu0KQ1pmPe"
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


--=-GPJrzHr2c+Xu0KQ1pmPe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is currently no useful way to override the default
implementation of this operation.  The returned struct spi_device_id
must have a pointer to struct flash_info in its private data, but this
structure is defined inside spi-nor.

Signed-off-by: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 +---
 include/linux/mtd/spi-nor.h   | 3 ---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6b1bda2..6f699c5 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -902,8 +902,6 @@ static int spi_nor_check(struct spi_nor *nor)
 		return -EINVAL;
 	}
=20
-	if (!nor->read_id)
-		nor->read_id =3D spi_nor_read_id;
 	if (!nor->wait_till_ready)
 		nor->wait_till_ready =3D spi_nor_wait_till_ready;
=20
@@ -952,7 +950,7 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_=
device_id *id,
 	if (info->jedec_id) {
 		const struct spi_device_id *jid;
=20
-		jid =3D nor->read_id(nor);
+		jid =3D spi_nor_read_id(nor);
 		if (IS_ERR(jid)) {
 			return PTR_ERR(jid);
 		} else if (jid !=3D id) {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 5ec84cc..66af67a 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -139,8 +139,6 @@ enum spi_nor_ops {
  * @write_xfer:		[OPTIONAL] the writefundamental primitive
  * @read_reg:		[DRIVER-SPECIFIC] read out the register
  * @write_reg:		[DRIVER-SPECIFIC] write data to the register
- * @read_id:		[REPLACEABLE] read out the ID data, and find
- *			the proper spi_device_id
  * @wait_till_ready:	[REPLACEABLE] wait till the NOR becomes ready
  * @read:		[DRIVER-SPECIFIC] read data from the SPI NOR
  * @write:		[DRIVER-SPECIFIC] write data to the SPI NOR
@@ -172,7 +170,6 @@ struct spi_nor {
 	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
 	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len,
 			int write_enable);
-	const struct spi_device_id *(*read_id)(struct spi_nor *nor);
 	int (*wait_till_ready)(struct spi_nor *nor);
=20
 	int (*read)(struct spi_nor *nor, loff_t from,


--=20
Ben Hutchings
The world is coming to an end.	Please log off.

--=-GPJrzHr2c+Xu0KQ1pmPe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVBXMNOe/yOyVhhEJAQo2EQ/+Pk/l3/uHWeP9wHRXlhU9FjkxGX5s0EmJ
X7oklM8IWu+UY5fPp5MVoalokorYujQQ+2Q56Jh+IykACs/zvTuqz61trxS2+9FE
PRmeXnxfRYfdZKk0DAOAPuw3MdTxuG+v4uMRZR9ST18CO7x0eAtn1Ixj4AnT4/cD
lrofX26zf/dswpDV7MZW6Slsu58nkVsmgQz3D0h1EUMmpTlYQcNKJPzbxs9JtR3n
VvJU9iykFSEJe7/APhepHqrlO9ao3jXYs+8JsiULHAHM4nbwkGfciJXFVy7gu9Zu
PFebPj3ZIe8c6uRSOgLgGbBWj5ZQ2Jb7hbshKfu91P6eAYTGdlGMX5lsr71IBs1P
mJqkLcUOJC9HThA0pE+uUqBM8qjVPLfuZRK1LnTfLmBiftBsrkG2zrnIFh9qmuAy
QuKBe+rtFNh8e0Dk57wEtAvKDLwMN9kZFtMMbe+glJTxVzY1zXC5uB9nWHwBxWy4
jWaYKBxJ5JalHD+JTYZdVxgsfSCUqNWIScCk12mzDyXh2wKB3UMDFbM0a7iofgov
2GgnNO+T5wkIyZa0tWHtzo0FiV42PzuqJU/ta75pmsIaZgjn0kld4AO+/xGogxam
U7GzGxig+GBnVj3uduH/5jaVuRfjrSpnOJB2eegWBR6gPRy8GSO3axb3iilWVUbu
EgXx2QGR99I=
=aK6y
-----END PGP SIGNATURE-----

--=-GPJrzHr2c+Xu0KQ1pmPe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
