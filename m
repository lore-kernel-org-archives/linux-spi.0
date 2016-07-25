From: Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 5/6] spi: octeon: Split driver into Octeon specific and
 common parts
Date: Mon, 25 Jul 2016 13:32:41 +0200
Message-ID: <20160725113241.GA2849@hardcore>
References: <cover.1469174814.git.jglauber@cavium.com>
 <edfc55f3653fedd5e13a8bd1282e089b269a4e61.1469174814.git.jglauber@cavium.com>
 <CAP=VYLrQDwCfYFCkxd0N4PfgP-2U+pcw_Gm0Yo_8m0=0o3pBrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Steven J. Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	"David Daney" <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAP=VYLrQDwCfYFCkxd0N4PfgP-2U+pcw_Gm0Yo_8m0=0o3pBrA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Jul 24, 2016 at 02:38:11PM -0400, Paul Gortmaker wrote:
> On Sat, Jul 23, 2016 at 6:42 AM, Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org> wrote:
> > Separate driver probing from SPI transfer functions.
> >
> > Signed-off-by: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> > Tested-by: Steven J. Hill <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/spi/Makefile                       |   1 +
> >  drivers/spi/spi-cavium-octeon.c            | 104 +++++++++++++++++++++++++
> >  drivers/spi/{spi-octeon.c => spi-cavium.c} | 120 +----------------------------
> >  drivers/spi/spi-cavium.h                   |  31 ++++++++
> >  4 files changed, 138 insertions(+), 118 deletions(-)
> >  create mode 100644 drivers/spi/spi-cavium-octeon.c
> >  rename drivers/spi/{spi-octeon.c => spi-cavium.c} (55%)
> >
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> > index 3c74d00..185367e 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_SPI_MT65XX)                += spi-mt65xx.o
> >  obj-$(CONFIG_SPI_MXS)                  += spi-mxs.o
> >  obj-$(CONFIG_SPI_NUC900)               += spi-nuc900.o
> >  obj-$(CONFIG_SPI_OC_TINY)              += spi-oc-tiny.o
> > +spi-octeon-objs                                := spi-cavium.o spi-cavium-octeon.o
> >  obj-$(CONFIG_SPI_OCTEON)               += spi-octeon.o
> >  obj-$(CONFIG_SPI_OMAP_UWIRE)           += spi-omap-uwire.o
> >  obj-$(CONFIG_SPI_OMAP_100K)            += spi-omap-100k.o
> > diff --git a/drivers/spi/spi-cavium-octeon.c b/drivers/spi/spi-cavium-octeon.c
> > new file mode 100644
> > index 0000000..ee4703e
> > --- /dev/null
> > +++ b/drivers/spi/spi-cavium-octeon.c
> > @@ -0,0 +1,104 @@
> > +/*
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + *
> > + * Copyright (C) 2011, 2012 Cavium, Inc.
> > + */
> > +
> > +#include <linux/platform_device.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/module.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> 
> [...]
> 
> > +MODULE_DEVICE_TABLE(of, octeon_spi_match);
> > +
> > +static struct platform_driver octeon_spi_driver = {
> > +       .driver = {
> > +               .name           = "spi-octeon",
> > +               .of_match_table = octeon_spi_match,
> > +       },
> > +       .probe          = octeon
> _spi_probe,
> > +       .remove         = octeon_spi_remove,
> > +};
> > +
> > +module_platform_driver(octeon_spi_driver);
> > +
> > +MODULE_DESCRIPTION("Cavium, Inc. OCTEON SPI bus driver");
> > +MODULE_AUTHOR("David Daney");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-cavium.c
> > similarity index 55%
> > rename from drivers/spi/spi-octeon.c
> > rename to drivers/spi/spi-cavium.c
> > index 2180176..5aaf215 100644
> > --- a/drivers/spi/spi-octeon.c
> > +++ b/drivers/spi/spi-cavium.c
> > @@ -6,42 +6,13 @@
> >   * Copyright (C) 2011, 2012 Cavium, Inc.
> >   */
> >
> > -#include <linux/platform_device.h>
> > -#include <linux/interrupt.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/module.h>
> 
> It almost looks like all the modular stuff got moved to the new file and
> maybe the above module.h isn't needed in the original file anymore?
> 
> Paul.
> --

Yes, that can be removed. Also io.h isn't needed there.

thanks,
Jan

> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> > -#include <linux/of.h>
> > -
> > -#include <asm/octeon/octeon.h>
> >
> >  #include "spi-cavium.h"
> 
> [...]
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
