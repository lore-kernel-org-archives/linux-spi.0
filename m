From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx-core: Move spi specific code into
 separate module.
Date: Thu, 19 Jan 2012 05:54:39 -0700
Message-ID: <20120119125439.GR4223@ponder.secretlab.ca>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
 <1326934894-29516-3-git-send-email-marc@cpdesign.com.au>
 <20120119080843.GC4066@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120119080843.GC4066-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jan 19, 2012 at 09:08:43AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Thu, Jan 19, 2012 at 12:01:33PM +1100, Marc Reilly wrote:
> > All spi specific code is moved into a new module. The mc13xxx
> > struct moves to the include file by necessity.
> >=20
> > A new config choice selects the bus type with SPI as the first item
> > (default selection) to remain compatible with existing configs.
> >=20
> > Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
> > ---
> > +choice
> > +	tristate "MC13XXX Bus interface type"
> > +	depends on MFD_MC13XXX
> > +	default MFD_MC13XXX_SPI
> > +	help
> > +	  The MC13XXX family can be connected over an SPI or I2C bus.
> > +	  Select the appropriate option for your hardware configuration.
> > +
> > +config MFD_MC13XXX_SPI
> > +	tristate "SPI interface"
> > +	depends on SPI_MASTER
> > +	help
> > +	  Select this if your MC13xxx is connected via an SPI bus.
> > +
> > +endchoice
> > +
> Hmm, you cannot have both, spi and i2c support?

+1 on Uwe's comment.  We're going multiplatform.  I2C and SPI support
should not be mutually exclusive.

g.
