From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/6] spi/imx: use soc name in spi device type naming scheme
Date: Mon, 11 Jul 2011 08:32:38 +0200
Message-ID: <20110711063238.GL6069@pengutronix.de>
References: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
	<1310113654-25887-3-git-send-email-shawn.guo@linaro.org>
	<20110708105851.GF6069@pengutronix.de>
	<20110709070001.GE13962@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110709070001.GE13962-+NayF8gZjK2ctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Jul 09, 2011 at 03:00:02PM +0800, Shawn Guo wrote:
> On Fri, Jul 08, 2011 at 12:58:51PM +0200, Sascha Hauer wrote:
> > On Fri, Jul 08, 2011 at 04:27:30PM +0800, Shawn Guo wrote:
> > > Software defined version number is not stable enough to be used
> > > in device type naming scheme.  The patch changes it to use implicit
> > > soc name for spi device type definition.  In this way, we can easily
> > > align the naming scheme with device tree binding, which comes later.
> > > =

> > > Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > Cc: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> > > ---
> > >  arch/arm/mach-imx/clock-imx25.c              |    7 +-
> > >  arch/arm/mach-mx5/clock-mx51-mx53.c          |   11 +-
> > >  arch/arm/plat-mxc/devices/platform-spi_imx.c |   12 +-
> > >  drivers/spi/Kconfig                          |   15 -
> > >  drivers/spi/spi-imx.c                        |  423 ++++++++++++----=
----------
> > >  5 files changed, 219 insertions(+), 249 deletions(-)
> > =

> > Generally this patch is too big for me to get the warm feeling that
> > everything will just work. Renaming from spi_ver_xy to imx_xy is fine,
> > but should be done in smaller steps and where possible not across
> > subsystems.
> > =

> Okay, I will split the patch into small pieces to win your warm
> feeling :)
> =

> > I increasingly see patches touching arch/ and drivers/ and I think
> > there's a high risk of merge conflicts upstream. This will not help
> > making Linus happy.
> > =

> Yes, I increasingly run into the situation touching arch/ and drivers/
> when working on dt migration because of the device renaming.  May I
> have to your suggestion on how to separate drivers/ patch from arch/
> one in orthogonal way, while keeping both trees working/bisectable?

You could for example keep the platform bindings for the old names and
just add new ones. Then, when all patches are in, remove the old
bindings. Of course this slows down things. You could also do all
necessary preparations and do the actual renaming of the devices during
-rc time.

Sascha

-- =

Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
