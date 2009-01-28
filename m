From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Move eeprom drivers to drivers/misc/eeprom
Date: Wed, 28 Jan 2009 13:42:45 +0100
Message-ID: <20090128134245.3839d386@hyperion.delvare>
References: <1232446982-7842-1-git-send-email-w.sang@pengutronix.de>
	<200901262355.27913.david-b@pacbell.net>
	<20090127090442.35190667@hyperion.delvare>
	<20090127095326.GA8385@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	rt2400-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090127095326.GA8385-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Wolfram,

On Tue, 27 Jan 2009 10:53:26 +0100, Wolfram Sang wrote:
> On Tue, Jan 27, 2009 at 09:04:42AM +0100, Jean Delvare wrote:
> 
> > > 
> > > Now that thhis is in mainline ... I suggest two more changes:
> > > 
> > >  - at24 (i2c eeprom) doesn't need to be EXPERIMENTAL
> > > 
> > >  - we still need interfaces whereby kernel code can be
> > >    given handles to the EEPROM devices, and then use
> > >    them to read board config data out during boot.
> > > 
> > > Obviously, the first one is easy.  ;)
> > 
> > Indeed, but where's the patch?
> 
> I may be missing some irony here, but just in case I don't, here is a
> patch :)

Don't know if this qualifies as irony. I was simply wondering why David
was telling us that a change could be done instead of just doing it
himself if he cared.

> From 622e104ea7c0ee99c631701919289792c8a890a4 Mon Sep 17 00:00:00 2001
> From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Date: Tue, 27 Jan 2009 10:46:11 +0100
> Subject: [PATCH] at24: remove EXPERIMENTAL
> 
> This driver has been widely used since inclusion and no problems have
> been reported.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/misc/eeprom/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> index c76df8c..89fec05 100644
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -2,7 +2,7 @@ menu "EEPROM support"
>  
>  config EEPROM_AT24
>  	tristate "I2C EEPROMs from most vendors"
> -	depends on I2C && SYSFS && EXPERIMENTAL
> +	depends on I2C && SYSFS
>  	help
>  	  Enable this driver to get read/write support to most I2C EEPROMs,
>  	  after you configure the driver to know about each EEPROM on
> 

Thanks, patch applied.

-- 
Jean Delvare
