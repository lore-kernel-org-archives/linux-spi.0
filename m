From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH] spi: Add builtin_spi_driver() to avoid registration
 boilerplate
Date: Wed, 16 Dec 2015 09:21:17 -0500
Message-ID: <20151216142117.GL2772@windriver.com>
References: <1450040037-28334-1-git-send-email-paul.gortmaker@windriver.com>
 <20151216132357.GK5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151216132357.GK5727-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

[Re: [PATCH] spi: Add builtin_spi_driver() to avoid registration boilerplate] On 16/12/2015 (Wed 13:23) Mark Brown wrote:

> On Sun, Dec 13, 2015 at 03:53:57PM -0500, Paul Gortmaker wrote:
> 
> > Here we use that support and extend it to SPI driver registration, so where
> > a driver is clearly non-modular and builtin-only, we can register it in a
> > similar fashion.  Existing code that is clearly non-modular can be updated
> > with the simple mapping of
> 
> >   module_spi_driver(...)  ---> builtin_spi_driver(...)
> 
> > We've essentially cloned the former to make the latter, and taken out the
> > remove/module_exit parts since those never get used in a non-modular build
> > of the code.
> 
> Why would it be sensible to have a SPI driver that can't be built as a
> module?

Looking at the existing use case - in:

  drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c

it would appear that the SPI driver is embedded within another driver
that the author decided to make non-modular.  Others that don't actually
use the module_spi_driver macro but are also non modular are drivers/mfd
wm831x-spi.c and stmpe-spi.c -- I'm guessing based on the above that you
will suggest we convert those to tristate.

At a more general level, if we have provided infrastructural helpers
like module_xyz() then it seems sensible IMHO to have the parallel
equivalent of builtin_xyz() so that we don't force non-modular code to
require an include of <module.h> to build.

Paul.
--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
