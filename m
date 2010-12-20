From: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Subject: Re: [PATCHv3 4/4] mc13xxx: Add i2c and spi drivers to Kconfig and Makefile
Date: Mon, 20 Dec 2010 21:22:31 +1100
Message-ID: <201012202122.31582.marc@cpdesign.com.au>
References: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au> <1292817055-17715-5-git-send-email-marc@cpdesign.com.au> <20101220083839.GQ1940@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Uwe =?iso-8859-1?q?Kleine-K=F6nig?="
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101220083839.GQ1940-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Monday, December 20, 2010 07:38:39 pm Uwe Kleine-K=F6nig wrote:
> On Mon, Dec 20, 2010 at 02:50:55PM +1100, Marc Reilly wrote:
> > Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
> > ---
> >=20
> >  drivers/mfd/Kconfig  |   22 ++++++++++++++--------
> >  drivers/mfd/Makefile |    2 ++
> >  2 files changed, 16 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 3a1493b..6980cf2 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -424,20 +424,26 @@ config MFD_PCF50633
> >=20
> >  	  facilities, and registers devices for the various functions
> >  	  so that function-specific drivers can bind to them.
> >=20
> > -config MFD_MC13783
> > -	tristate
> > -
>=20
> this needs at least a note in the commit log.  And $(git grep
> MFD_MC13783 drivers) shows that you don't want to remove that yet.

I didn't get anything... which makes me think I'm doing it wrong.

>=20
> >  config MFD_MC13XXX
> >=20
> > -	tristate "Support Freescale MC13783 and MC13892"
> > -	depends on SPI_MASTER
> > +	tristate "Support Freescale MC13XXX"
>=20
> Hmm, I'd prefer to have the supported numbers.  Consider FSL releasin=
g
> an MC13991.  Then it's unclear if MFD_MC13XXX supports it.

I started with similar thinking, but then thought that if a new IC is r=
eleased=20
in the family and it's not compatible then it can be changed (the file =
names=20
themselves would also be misleading). Until then, all the family so far=
 come=20
under the mc13xxx umbrella.
The help file also explains which are supported.

>=20
> > +	depends on SPI_MASTER || I2C
> >=20
> >  	select MFD_CORE
> >=20
> > -	select MFD_MC13783
> >=20
> >  	help
> >  =09
> >  	  Support for the Freescale (Atlas) PMIC and audio CODECs
> >  	  MC13783 and MC13892.
> >=20
> > -	  This driver provides common support for accessing  the device,
> > +	  This driver provides common support for accessing the device,
> >=20
> >  	  additional drivers must be enabled in order to use the
> >=20
> > -	  functionality of the device.
> > +	  functionality of these devices.
> > +
> > +config MFD_MC13XXX_SPI
> > +	tristate "Support for MC13XXX via SPI"
> > +	depends on SPI_MASTER
> > +	select MFD_MC13XXX
> > +
> > +config MFD_MC13XXX_I2C
> > +	tristate "Support for MC13XXX via I2C"
>=20
> and only mc13892 can do i2c, so writing MC13XXX doesn't make sense he=
re.
>=20
> > +	depends on I2C
> > +	select MFD_MC13XXX
>=20
> Hmm, that means that MFD_MC13XXX alone doesn't do anything useful,
> right?  IMHO either do:
>=20
> 	config MFD_MC13XXX_SPI
> 		tristate
>=20
> 	config MFD_MC13XXX_I2C
> 		tristate
>=20
> 	config MFD_MC13XXX
> 		tristate "..."
> 		select MFD_MC13XXX_SPI if SPI_MASTER
> 		select MFD_MC13XXX_I2C if I2C
> 		...
>=20
> or
>=20
> 	config MFD_MC13XXX
> 		tristate
> 		...
>=20
> 	config MFD_MC13XXX_SPI
> 		tristate "..."
> 		select MFD_MC13XXX
> 		...
> 	config MFD_MC13XXX_I2C
> 		tristate "..."
> 		select MFD_MC13XXX
> 		...

It would need to be the second one, but OK.

>=20
> >  config PCF50633_ADC
> > =20
> >  	tristate "Support for NXP PCF50633 ADC"
> >=20
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index f54b365..b7d774f 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -42,6 +42,8 @@ obj-$(CONFIG_TWL4030_CODEC)	+=3D twl4030-codec.o
> >=20
> >  obj-$(CONFIG_TWL6030_PWM)	+=3D twl6030-pwm.o
> > =20
> >  obj-$(CONFIG_MFD_MC13XXX)	+=3D mc13xxx-core.o
> >=20
> > +obj-$(CONFIG_MFD_MC13XXX_SPI)	+=3D mc13xxx-spi.o
> > +obj-$(CONFIG_MFD_MC13XXX_I2C)	+=3D mc13xxx-i2c.o
> >=20
> >  obj-$(CONFIG_MFD_CORE)		+=3D mfd-core.o
>=20
> Best regards
> Uwe

Thanks again.

Cheers
Marc
