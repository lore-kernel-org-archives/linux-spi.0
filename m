From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: xilinx: Use standard num-cs binding
Date: Fri, 16 Jan 2015 13:55:14 +0100
Message-ID: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-28521-1421412914-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-28521-1421412914-0001

Use standard num-cs binding property and setup
"xlnx,num-ss-bits" as deprecated.

Signed-off-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---

 drivers/spi/spi-xilinx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 79bd84f43430..30e5180195bb 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -338,8 +338,15 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		num_cs = pdata->num_chipselect;
 		bits_per_word = pdata->bits_per_word;
 	} else {
-		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
-					  &num_cs);
+		if (of_property_read_u32(pdev->dev.of_node, "num-cs",
+					 &num_cs)) {
+			if (!of_property_read_u32(pdev->dev.of_node,
+						  "xlnx,num-ss-bits",
+						  &num_cs)) {
+				dev_err(&pdev->dev,
+					"property name 'xlnx,num-ss-bits' is deprecated.\n");
+			}
+		}
 	}

 	if (!num_cs) {
--
1.8.2.3


--=_mimegpg-monstr-desktop-28521-1421412914-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlS5CjIACgkQykllyylKDCHv/wCfadPigO5FEf+BRTEyCVCvcZx7
9BYAnRlqeZk/yQcoF84u0e/a+yRo3QEe
=UaPi
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-28521-1421412914-0001--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
