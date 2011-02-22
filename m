From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] spi/spi_oc_tiny and spi_altera.c: fix build errors
Date: Tue, 22 Feb 2011 13:35:29 -0800
Message-ID: <20110222133529.56b02ebb.randy.dunlap@oracle.com>
References: <20110222132438.02d310e0@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
To: Andres Salomon <dilinger@queued.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110222132438.02d310e0@queued.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 22 Feb 2011 13:24:38 -0800 Andres Salomon wrote:

> Fix the following build error due to a missing semicolon:
>=20
>  CC [M]  drivers/spi/spi_oc_tiny.o
> drivers/spi/spi_oc_tiny.c:394: error: expected =E2=80=98,=E2=80=99 or=
 =E2=80=98;=E2=80=99 before =E2=80=98extern=E2=80=99
> make[2]: *** [drivers/spi/spi_oc_tiny.o] Error 1
>=20
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

Same fix is needed for drivers/spi/spi_altera.c.
I already had this patch ready to send.  Grant, can you extract
the spi_altera.c patch...?


---
=46rom: Randy Dunlap <randy.dunlap@oracle.com>

=46ix build error due to missing semi-colon:

drivers/spi/spi_altera.c:308: error: expected ',' or ';' before 'extern=
'
drivers/spi/spi_oc_tiny.c:394: error: expected ',' or ';' before 'exter=
n'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/spi/spi_altera.c  |    2 +-
 drivers/spi/spi_oc_tiny.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20110222.orig/drivers/spi/spi_oc_tiny.c
+++ linux-next-20110222/drivers/spi/spi_oc_tiny.c
@@ -390,7 +390,7 @@ static int __devexit tiny_spi_remove(str
 static const struct of_device_id tiny_spi_match[] =3D {
 	{ .compatible =3D "opencores,tiny-spi-rtlsvn2", },
 	{},
-}
+};
 MODULE_DEVICE_TABLE(of, tiny_spi_match);
 #else /* CONFIG_OF */
 #define tiny_spi_match NULL
--- linux-next-20110222.orig/drivers/spi/spi_altera.c
+++ linux-next-20110222/drivers/spi/spi_altera.c
@@ -304,7 +304,7 @@ static int __devexit altera_spi_remove(s
 static const struct of_device_id altera_spi_match[] =3D {
 	{ .compatible =3D "ALTR,spi-1.0", },
 	{},
-}
+};
 MODULE_DEVICE_TABLE(of, altera_spi_match);
 #else /* CONFIG_OF */
 #define altera_spi_match NULL
