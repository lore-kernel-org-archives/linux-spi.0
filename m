From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [PATCH] SPI: drain MXC SPI transfer buffer
	when probing device
Date: Thu, 19 Nov 2009 20:01:42 +0100
Message-ID: <20091119190142.GO14091@buzzloop.caiaq.de>
References: <1258627487-7408-1-git-send-email-daniel@caiaq.de>
	<20091119184951.GA26816@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091119184951.GA26816-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Uwe,

On Thu, Nov 19, 2009 at 07:49:51PM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Nov 19, 2009 at 11:44:47AM +0100, Daniel Mack wrote:
> > On the MX31litekit, the bootloader seems to communicate with the MC13783
> > PMIC chip before booting Linux. However, it does not flush all the
> > buffers properly after that, which makes the imx-spi driver read
> > bogus data when probing the MC13783.
> > =

> > Fix that by draining the SPI buffer on startup.
> > =

> > Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> > Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> > Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> > Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > ---
> >  drivers/spi/spi_imx.c |    7 +++++++
> >  1 files changed, 7 insertions(+), 0 deletions(-)
> > =

> > diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> > index 89c22ef..a3894fd 100644
> > --- a/drivers/spi/spi_imx.c
> > +++ b/drivers/spi/spi_imx.c
> > @@ -42,8 +42,11 @@
> >  #define MXC_CSPITXDATA		0x04
> >  #define MXC_CSPICTRL		0x08
> >  #define MXC_CSPIINT		0x0c
> > +#define MXC_CSPISTAT		0x14
> On imx27 the register at offset 0x14 is called PERIODREG ...
> =

> >  #define MXC_RESET		0x1c
> >  =

> > +#define MXC_CSPISTAT_RR		(1 << 3)
> ... and bits 0..14 are called WAIT.
> =

> =

> > +
> >  /* generic defines to abstract from the different register layouts */
> >  #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
> >  #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
> > @@ -593,6 +596,10 @@ static int __init spi_imx_probe(struct platform_de=
vice *pdev)
> >  	if (!cpu_is_mx31() || !cpu_is_mx35())
> >  		writel(1, spi_imx->base + MXC_RESET);
> >  =

> > +	/* drain the buffer */
> > +	while (readl(spi_imx->base + MXC_CSPISTAT) & MXC_CSPISTAT_RR)
> > +		readl(spi_imx->base + MXC_CSPIRXDATA);
> > +
> So this needs protection by
> =

> 	if (cpu_is_mx31() || cpu_is_mx35())

Oh, I wasn't aware of such differences, thanks for checking!

> (note, I didn't check the mx35 reference!).

But I did now, and mx35 seems to be compatible. I also changed the
register define names to avoid confusion.

New patch below.

Thanks,
Daniel


>From 965180664e33f972409fb8ae00372902406c1c22 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Date: Thu, 19 Nov 2009 11:39:45 +0100
Subject: [PATCH] SPI: drain MXC SPI transfer buffer when probing device
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

On the MX31litekit, the bootloader seems to communicate with the MC13783
PMIC chip before booting Linux. However, it does not flush all the
buffers properly after that, which makes the imx-spi driver read
bogus data when probing the MC13783.

Fix that by draining the SPI receive buffer on startup.

Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
---
 drivers/spi/spi_imx.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
index 89c22ef..1b17f44 100644
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -44,6 +44,9 @@
 #define MXC_CSPIINT		0x0c
 #define MXC_RESET		0x1c
 =

+#define MX3_CSPISTAT		0x14
+#define MX3_CSPISTAT_RR		(1 << 3)
+
 /* generic defines to abstract from the different register layouts */
 #define MXC_INT_RR	(1 << 0) /* Receive data ready interrupt */
 #define MXC_INT_TE	(1 << 1) /* Transmit FIFO empty interrupt */
@@ -593,6 +596,11 @@ static int __init spi_imx_probe(struct platform_device=
 *pdev)
 	if (!cpu_is_mx31() || !cpu_is_mx35())
 		writel(1, spi_imx->base + MXC_RESET);
 =

+	/* drain receive buffer */
+	if (cpu_is_mx31() || cpu_is_mx35())
+		while (readl(spi_imx->base + MX3_CSPISTAT) & MX3_CSPISTAT_RR)
+			readl(spi_imx->base + MXC_CSPIRXDATA);
+
 	spi_imx->intctrl(spi_imx, 0);
 =

 	ret =3D spi_bitbang_start(&spi_imx->bitbang);
-- =

1.6.5.2


---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
