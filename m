From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v1 1/4] spi/xilinx: Remove CONFIG_OF from the driver
Date: Mon,  8 Jul 2013 15:29:14 +0200
Message-ID: <ff70173bee5f9223ffea2b92b903b4e46ef8b323.1373290150.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-25808-1373290157-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Michal Simek <monstr@monstr.eu>,
	Michal Simek <michal.simek@xilinx.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	spi-devel-general@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-25808-1373290157-0001

dev.of_node is in struct device all the time.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/spi/spi-xilinx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 35503b4..f3de5e5 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -375,7 +375,6 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		bits_per_word = pdata->bits_per_word;
 	}

-#ifdef CONFIG_OF
 	if (pdev->dev.of_node) {
 		const __be32 *prop;
 		int len;
@@ -386,7 +385,6 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		if (prop && len >= sizeof(*prop))
 			num_cs = __be32_to_cpup(prop);
 	}
-#endif

 	if (!num_cs) {
 		dev_err(&pdev->dev,
--
1.8.2.3


--=_mimegpg-monstr-desktop-25808-1373290157-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHavq0ACgkQykllyylKDCE5sACglQAYrddQ8oLj9Kd0MT6ROq8s
AeYAoIR14RsU9s3bjSUT5TF6KyEMsxl6
=grs1
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-25808-1373290157-0001--
