From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v1 4/4] spi/xilinx: Use of_property_read_u32 for reading value from node
Date: Mon,  8 Jul 2013 15:29:17 +0200
Message-ID: <95fea2ecead16435fc526b1d7f36a0a1ec1635ff.1373290150.git.michal.simek@xilinx.com>
References: <ff70173bee5f9223ffea2b92b903b4e46ef8b323.1373290150.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-25853-1373290166-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Michal Simek <monstr@monstr.eu>,
	Michal Simek <michal.simek@xilinx.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ff70173bee5f9223ffea2b92b903b4e46ef8b323.1373290150.git.michal.simek@xilinx.com>
In-Reply-To: <ff70173bee5f9223ffea2b92b903b4e46ef8b323.1373290150.git.michal.simek@xilinx.com>
References: <ff70173bee5f9223ffea2b92b903b4e46ef8b323.1373290150.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-25853-1373290166-0001

It simplifies driver probing.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/spi/spi-xilinx.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index a6bb5b0..07a7bca 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -372,17 +372,9 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	if (pdata) {
 		num_cs = pdata->num_chipselect;
 		bits_per_word = pdata->bits_per_word;
-	}
-
-	if (pdev->dev.of_node) {
-		const __be32 *prop;
-		int len;
-
-		/* number of slave select bits is required */
-		prop = of_get_property(pdev->dev.of_node, "xlnx,num-ss-bits",
-				       &len);
-		if (prop && len >= sizeof(*prop))
-			num_cs = __be32_to_cpup(prop);
+	} else {
+		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
+					  &num_cs);
 	}

 	if (!num_cs) {
--
1.8.2.3


--=_mimegpg-monstr-desktop-25853-1373290166-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHavrYACgkQykllyylKDCGxigCfRH6KQw7Tc2/ASYsJ7FGEqP7H
2BIAnjQIk6ka6XazUEvirggFiFTswbPh
=cxyu
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-25853-1373290166-0001--
