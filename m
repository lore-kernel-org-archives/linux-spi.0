From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: mpc512x-psc: fix compiler warning about uninitialized variable
Date: Tue, 21 Jul 2015 10:30:42 +0200
Message-ID: <1437467442-7011-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>,
	Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>,
	linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This fixes several warnings like:

	drivers/spi/spi-mpc512x-psc.c: In function 'mpc512x_psc_spi_prep_xfer_=
hw':
	arch/powerpc/include/asm/io.h:163:2: warning: '__ret' may be used unin=
itialized in this function [-Wmaybe-uninitialized]

introduced in commit 8bf960985dfc for some build configurations.

=46ixes: 8bf960985dfc ("spi: mpc512x-psc: add support for Freescale MPC=
5125")
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Hello,

didn't check why "my" config doesn't throw this warning, but I could re=
produce
and fix it with the .config and toolchain as suggested by the build bot=
's
report.

An alternatives is to introduce a default case that BUG()s, but I think
there is not much benefit over the NULL pointer exception that I
introduced with my commit.

I expected that giving the enum I introduced a name and using this to
type the variable should do the trick, but this didn't made the compile=
r
happy.

Best regards
Uwe

 drivers/spi/spi-mpc512x-psc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-ps=
c.c
index 280794dd248a..1e75341689a6 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -40,8 +40,8 @@ enum {
  * MPC5121 (which uses a struct mpc52xx_psc) and MPC5125 (using mpc512=
5_psc).
  */
 #define psc_addr(mps, regname) ({					\
-	void *__ret;							\
-	switch(mps->type) {						\
+	void *__ret =3D NULL;						\
+	switch (mps->type) {						\
 	case TYPE_MPC5121: {						\
 			struct mpc52xx_psc __iomem *psc =3D mps->psc;	\
 			__ret =3D &psc->regname;				\
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
