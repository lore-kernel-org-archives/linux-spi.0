From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH] spi/spi_altera: fix build error
Date: Tue, 22 Feb 2011 13:23:03 -0800
Message-ID: <20110222132303.6a78b8e0@queued.net>
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

I ran into a build error while attempting to build the Feb 22nd
linux-next tree.



=46rom: Andres Salomon <dilinger@queued.net>

=46ix the following build error due to a missing semicolon:

 CC [M]  drivers/spi/spi_altera.o
drivers/spi/spi_altera.c:308: error: expected =E2=80=98,=E2=80=99 or =E2=
=80=98;=E2=80=99 before =E2=80=98extern=E2=80=99
make[2]: *** [drivers/spi/spi_altera.o] Error 1

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/spi/spi_altera.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_altera.c b/drivers/spi/spi_altera.c
index 5e001f3..4813a63 100644
--- a/drivers/spi/spi_altera.c
+++ b/drivers/spi/spi_altera.c
@@ -304,7 +304,7 @@ static int __devexit altera_spi_remove(struct platf=
orm_device *dev)
 static const struct of_device_id altera_spi_match[] =3D {
 	{ .compatible =3D "ALTR,spi-1.0", },
 	{},
-}
+};
 MODULE_DEVICE_TABLE(of, altera_spi_match);
 #else /* CONFIG_OF */
 #define altera_spi_match NULL
--=20
1.7.2.3
