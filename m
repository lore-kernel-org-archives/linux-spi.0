From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH] spi: make Open Firmware device id constant
Date: Sun, 10 Jan 2010 13:14:14 +0100
Message-ID: <4B49C496.2090507@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	LKML <linux-kernel@vger.kernel.org>, cocci@diku.dk
To: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <cocci-bounces@diku.dk>
List-Unsubscribe: <http://lists.diku.dk/mailman/listinfo/cocci>,
	<mailto:cocci-request@diku.dk?subject=unsubscribe>
List-Archive: <http://lists.diku.dk/pipermail/cocci>
List-Post: <mailto:cocci@diku.dk>
List-Help: <mailto:cocci-request@diku.dk?subject=help>
List-Subscribe: <http://lists.diku.dk/mailman/listinfo/cocci>,
	<mailto:cocci-request@diku.dk?subject=subscribe>
Sender: cocci-bounces@diku.dk
Errors-To: cocci-bounces@diku.dk
List-Id: linux-spi.vger.kernel.org

From: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

The match_table field of the struct of_device_id is constant in <linux/of=
_platform.h>
so it is worth to make the initialization data constant.

The semantic match that finds this kind of pattern is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
disable decl_init,const_decl_init;
identifier I1, I2, x;
@@
	struct I1 {
	  ...
	  const struct I2 *x;
	  ...
	};
@s@
identifier r.I1, y;
identifier r.x, E;
@@
	struct I1 y =3D {
	  .x =3D E,
	};
@c@
identifier r.I2;
identifier s.E;
@@
	const struct I2 E[] =3D ... ;
@depends on !c@
identifier r.I2;
identifier s.E;
@@
+	const
	struct I2 E[] =3D ...;
// </smpl>

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
Cc: Julia Lawall <julia@diku.dk>
Cc: cocci@diku.dk
---
diff -u -p a/drivers/spi/xilinx_spi_of.c b/drivers/spi/xilinx_spi_of.c
--- a/drivers/spi/xilinx_spi_of.c 2010-01-07 19:08:45.000000000 +0100
+++ b/drivers/spi/xilinx_spi_of.c 2010-01-08 09:11:27.000000000 +0100
@@ -99,7 +99,7 @@ static int __exit xilinx_spi_of_remove(s
 	return xilinx_spi_remove(op);
 }

-static struct of_device_id xilinx_spi_of_match[] =3D {
+static const struct of_device_id xilinx_spi_of_match[] =3D {
 	{ .compatible =3D "xlnx,xps-spi-2.00.a", },
 	{ .compatible =3D "xlnx,xps-spi-2.00.b", },
 	{}
diff -u -p a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
--- a/drivers/spi/mpc52xx_spi.c 2010-01-07 19:08:45.000000000 +0100
+++ b/drivers/spi/mpc52xx_spi.c 2010-01-08 09:11:55.000000000 +0100
@@ -550,7 +550,7 @@ static int __devexit mpc52xx_spi_remove(
 	return 0;
 }

-static struct of_device_id mpc52xx_spi_match[] __devinitdata =3D {
+static const struct of_device_id mpc52xx_spi_match[] __devinitconst =3D =
{
 	{ .compatible =3D "fsl,mpc5200-spi", },
 	{}
 };
diff -u -p a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.=
c
--- a/drivers/spi/mpc52xx_psc_spi.c 2010-01-07 19:08:45.000000000 +0100
+++ b/drivers/spi/mpc52xx_psc_spi.c 2010-01-08 09:13:23.000000000 +0100
@@ -503,7 +503,7 @@ static int __exit mpc52xx_psc_spi_of_rem
 	return mpc52xx_psc_spi_do_remove(&op->dev);
 }

-static struct of_device_id mpc52xx_psc_spi_of_match[] =3D {
+static const struct of_device_id mpc52xx_psc_spi_of_match[] =3D {
 	{ .compatible =3D "fsl,mpc5200-psc-spi", },
 	{ .compatible =3D "mpc5200-psc-spi", }, /* old */
 	{}
diff -u -p a/drivers/spi/spi_ppc4xx.c b/drivers/spi/spi_ppc4xx.c
--- a/drivers/spi/spi_ppc4xx.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/spi/spi_ppc4xx.c 2010-01-08 09:13:36.000000000 +0100
@@ -578,7 +578,7 @@ static int __exit spi_ppc4xx_of_remove(s
 	return 0;
 }

-static struct of_device_id spi_ppc4xx_of_match[] =3D {
+static const struct of_device_id spi_ppc4xx_of_match[] =3D {
 	{ .compatible =3D "ibm,ppc4xx-spi", },
 	{},
 };
_______________________________________________
Cocci mailing list
Cocci@diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
