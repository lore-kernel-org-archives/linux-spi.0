From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] spi/imx: set the inactive state of the clock according
	to the clock polarity
Date: Fri, 21 Sep 2012 09:54:31 +0200
Message-ID: <20120921075431.GS5525@pengutronix.de>
References: <1346403311-25080-1-git-send-email-dirk.behme@de.bosch.com>
	<20120831023518.GE7726@r65073-Latitude-D630>
	<505C1913.1090004@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Hui Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	"Wohlrab Knut \(CM-AI/PJ-CF31\)" <Knut.Wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <505C1913.1090004-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 21, 2012 at 09:36:51AM +0200, Dirk Behme wrote:
> On 31.08.2012 04:35, Shawn Guo wrote:
> >Copy Uwe ...
Copy our kernel mailing list ...

> Ping ;)
> =

> Any opinions on this?
Assuming it fixes access to a device I'm ok with your patch, but I don't
really feel responsible for the driver (i.e. me not acking shouldn't
have a negative influence on getting the patch in).

> >On Fri, Aug 31, 2012 at 10:55:11AM +0200, Dirk Behme wrote:
> >>From: Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
> >>
> >>There are SPI devices which need a SPI clock with active low polarity a=
nd
> >>high inactive state.
> >>
> >>Add the setting of the inactive state ECSPIx_CONFIGREG:SCLK CTL
> >>according to the clock polarity ECSPIx_CONFIGREG:SCLK POL:
> >>
> >>DT without "spi-cpol" =3D 0 =3D clock active high polarity =3D inactive=
 state low
> >>DT with    "spi-cpol" =3D 1 =3D clock active low  polarity =3D inactive=
 state high
> >>
> >>Signed-off-by: Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
If you forward a patch you must add your S-o-b.

> >>---
> >>
> >>Question: Are there real world examples for a need of an individual set=
ting of
> >>clock polarity/inactive state?
> >
> >I'm less concerned about that.  We can always patch the driver when
> >the real world example occurs?
yes.

Thanks
Uwe

> >> drivers/spi/spi-imx.c |    6 ++++--
> >> 1 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> >>index e834ff8..d64655b 100644
> >>--- a/drivers/spi/spi-imx.c
> >>+++ b/drivers/spi/spi-imx.c
> >>@@ -197,6 +197,7 @@ static unsigned int spi_imx_clkdiv_2(unsigned int f=
in,
> >> #define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
> >> #define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
> >> #define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
> >>+#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs) + 20))
> >> #define MX51_ECSPI_INT		0x10
> >> #define MX51_ECSPI_INT_TEEN		(1 <<  0)
> >>@@ -287,9 +288,10 @@ static int __maybe_unused mx51_ecspi_config(struct=
 spi_imx_data *spi_imx,
> >> 	if (config->mode & SPI_CPHA)
> >> 		cfg |=3D MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
> >>-	if (config->mode & SPI_CPOL)
> >>+	if (config->mode & SPI_CPOL) {
> >> 		cfg |=3D MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
> >>-
> >>+		cfg |=3D MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
> >>+	}
> >> 	if (config->mode & SPI_CS_HIGH)
> >> 		cfg |=3D MX51_ECSPI_CONFIG_SSBPOL(config->cs);
> >>-- =

> >>1.7.0.4
> =

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> =


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

---------------------------------------------------------------------------=
---
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
