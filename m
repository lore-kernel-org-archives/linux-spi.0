From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH] spi/spi_oc_tiny: fix build error
Date: Tue, 22 Feb 2011 13:24:38 -0800
Message-ID: <20110222132438.02d310e0@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
To: David Brownell <dbrownell@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


=46ix the following build error due to a missing semicolon:

 CC [M]  drivers/spi/spi_oc_tiny.o
drivers/spi/spi_oc_tiny.c:394: error: expected =E2=80=98,=E2=80=99 or =E2=
=80=98;=E2=80=99 before =E2=80=98extern=E2=80=99
make[2]: *** [drivers/spi/spi_oc_tiny.o] Error 1

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/spi/spi_oc_tiny.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_oc_tiny.c b/drivers/spi/spi_oc_tiny.c
index e99e545..f1bde66 100644
--- a/drivers/spi/spi_oc_tiny.c
+++ b/drivers/spi/spi_oc_tiny.c
@@ -390,7 +390,7 @@ static int __devexit tiny_spi_remove(struct platfor=
m_device *pdev)
 static const struct of_device_id tiny_spi_match[] =3D {
 	{ .compatible =3D "opencores,tiny-spi-rtlsvn2", },
 	{},
-}
+};
 MODULE_DEVICE_TABLE(of, tiny_spi_match);
 #else /* CONFIG_OF */
 #define tiny_spi_match NULL
--=20
1.7.2.3
