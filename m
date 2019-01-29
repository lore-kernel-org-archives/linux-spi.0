From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2] spi: spi-mem: spi-nxp-fspi: add module license info
Date: Tue, 29 Jan 2019 09:49:22 +0000
Message-ID: <1548755240-27319-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add MODULE_LICENSE info to fix below warning:
WARNING: modpost: missing MODULE_LICENSE() in drivers/spi/spi-nxp-fspi.o

Typo fix in Boris Brezillon last name.

Fixes: a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
- Added Reported-by and Fixes tag.
- Typo fix in Boris Brezillon last name.

 drivers/spi/spi-nxp-fspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 0327216ef7aa..8894f98cc99c 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -26,7 +26,7 @@
  *
  * Author:
  *     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
- *     Boris Brezillion <bbrezillon@kernel.org>
+ *     Boris Brezillon <bbrezillon@kernel.org>
  *     Frieder Schrempf <frieder.schrempf@kontron.de>
  */
=20
@@ -1101,5 +1101,6 @@ module_platform_driver(nxp_fspi_driver);
 MODULE_DESCRIPTION("NXP FSPI Controller Driver");
 MODULE_AUTHOR("NXP Semiconductor");
 MODULE_AUTHOR("Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>");
-MODULE_AUTHOR("Boris Brezillion <bbrezillon@kernel.org>");
+MODULE_AUTHOR("Boris Brezillon <bbrezillon@kernel.org>");
 MODULE_AUTHOR("Frieder Schrempf <frieder.schrempf@kontron.de>");
+MODULE_LICENSE("GPL v2");
--=20
2.17.1
