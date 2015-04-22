From: Fionn Cleary <clearyf-/Zw1syy4LHg@public.gmane.org>
Subject: [PATCH] spi/omap2-mcpsi: Always call spi_finalize_current_message()
Date: Wed, 22 Apr 2015 15:39:56 +0200
Message-ID: <87vbgo2ser.fsf@tcd.ie>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain

Hi,

While testing the omap2-mcspi driver I discovered that triggering the
error conditions in omap2_mcspi_transfer_one_message() will result in
the queue for the bus locking up while waiting for
spi_finalize_current_message().  This patch ensure that
spi_finalize_current_message() is always called for all error conditions
in omap2_mcspi_transfer_one_message().

Regards,
Fionn

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVN6SsAAoJEDmlvs+cFU0LiLkP/jTznyklmofioXoW+ziKEr4d
OKjpsiP6q1D6gRGDuX7dbc2bDzLBD4A7cbcCOKW2Yml5dkIrSWN5tdWi31eb8fgD
FMBzWx4kvYG3JswMyMQufq7Ch8kbwfnp0riPsKoeZR+aAB2hVEpbyBBrS6usufOt
4xoSGPKpLW1PJdXhWdeH+P71BtMdBmTbLHoAytrBI1hfe1J6vxJMATw7Ica0jJUV
xJnABwmCCakuxxgoUwTMKrfXIuRAn08HQXBZsh81JNI4vTnp+5a/Cre2Qjuh8YPp
Q6KFTM0KelMau5o5IV5/i1NcPqM1auih+co6OMp9p57+lrGmQHlxM5UEzDFufZH8
ENDr4vuHgBo2Gq9rN7qsWAAJ1pCt9TlCM/5/bsdwYVBLtdJW2p1ixfGCuwF7Ccwj
haDMWmtEA1nzfi2a+2Fje7hQRs8q0z55mj0cPNgKswIot43JtSBtSHlzaGPvy1SG
oMXWTL6wlV13pHh0+2FnxbvSUlZdKEnJZ72PDTU8TdzcQ1STkfCj/9axViwj9lS7
BU2HbuCOQrFIB8ZSL0/BwgQ0dn/n6zaYXOikROZhp7o+Yu4iu9e/WnytBLGRWzE0
OmEqrXWhcQCieoOfwygVJK//6Bwh9MY1RvLWu48Tk2Q9W1UwT1d45xjf1oIKYwUW
TijlUC1Nn4RUx3tOwjq2
=iOtE
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-spi-omap2-mcpsi-Always-call-spi_finalize_current_mess.patch

>From 2ec7ba94e9045a78de14192690134fc3d53c38f0 Mon Sep 17 00:00:00 2001
From: Fionn Cleary <fionn.cleary-6oiIBCxl0MMjD8S081q9vkEOCMrvLtNR@public.gmane.org>
Date: Wed, 22 Apr 2015 13:40:53 +0200
Subject: [PATCH] spi/omap2-mcpsi: Always call spi_finalize_current_message()

The spi queue waits forever for spi_finalize_current_message() to be
called, blocking the bus.  Ensure that all error paths from
omap2_mcspi_transfer_one_message() call spi_finalize_current_message().

Signed-off-by: Fionn Cleary <fionn.cleary-6oiIBCxl0MMjD8S081q9vkEOCMrvLtNR@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 3bc3cba..4acce76 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1234,7 +1234,8 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 					tx_buf ? "tx" : "",
 					rx_buf ? "rx" : "",
 					t->bits_per_word);
-			return -EINVAL;
+			m->status = -EINVAL;
+			goto out;
 		}
 
 		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
@@ -1246,7 +1247,8 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 			if (dma_mapping_error(mcspi->dev, t->tx_dma)) {
 				dev_dbg(mcspi->dev, "dma %cX %d bytes error\n",
 						'T', len);
-				return -EINVAL;
+				m->status = -EINVAL;
+				goto out;
 			}
 		}
 		if (mcspi_dma->dma_rx && rx_buf != NULL) {
@@ -1258,14 +1260,16 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 				if (tx_buf != NULL)
 					dma_unmap_single(mcspi->dev, t->tx_dma,
 							len, DMA_TO_DEVICE);
-				return -EINVAL;
+				m->status = -EINVAL;
+				goto out;
 			}
 		}
 	}
 
 	omap2_mcspi_work(mcspi, m);
+out:
 	spi_finalize_current_message(master);
-	return 0;
+	return m->status;
 }
 
 static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
-- 
1.9.1


--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
