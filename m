From: Kyle Roeschley <kyle.roeschley-acOepvfBmUk@public.gmane.org>
Subject: Re: [PATCH] spi: Add a sysfs interface to instantiate devices
Date: Fri, 22 Dec 2017 11:11:08 -0600
Message-ID: <20171222171108.GA31574@senary>
References: <20171221200309.17967-1-kyle.roeschley@ni.com>
 <1513890342.26695.4.camel@impinj.com>
 <20171222155603.GM1827@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org" <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171222155603.GM1827@finisterre>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Dec 22, 2017 at 03:56:03PM +0000, Mark Brown wrote:
> On Thu, Dec 21, 2017 at 09:05:43PM +0000, Trent Piepho wrote:
> > On Thu, 2017-12-21 at 14:03 -0600, Kyle Roeschley wrote:
> > > Add a sysfs interface to instantiate and delete SPI devices using the
> > > spidev driver. This can be used when developing a driver on a
> > > self-soldered board which doesn't yet have proper SPI device declaration
> > > at the platform level, and presumably for various debugging situations.
> 
> > > Inspired by 99cd8e25875a ("i2c: Add a sysfs interface to instantiate
> > > devices").
> 
> > The i2c interface allows one to specify the type of device to create.
> > Why must this interface be linked to spidev and only capable of
> > creating spidev devices?
> 
> Right, that doesn't seem good.  I also can't see anything in the actual
> code which suggests that this is tied to spidev except the log messages.
> 

Quoting Geert's email [1] on the subject:

> To me, the above sounds a bit contradictive: either you have
>   1. a simple (trivial) description, which can be handled by spidev and
>      userspace, and thus by just writing "<unit-addr> spidev" to a new_device
>      sysfs node, or
>   2. a complex description, for which you need a specialized in-kernel driver,
>      so you're gonna need a real DT node (and overlays?) to describe it.
> 
> I don't think writing a complex description to a new_device sysfs node makes
> sense.

And regarding not being linked to spidev, see modalias in new_device_store:

> > > +	struct spi_board_info bi = {
> > > +		.modalias = "spidev",
> > > +		.max_speed_hz = ctlr->max_speed_hz,
> > > +	};

[1] https://marc.info/?l=linux-spi&m=151199390921251&w=2

Happy holidays,

-- 
Kyle Roeschley
Software Engineer
National Instruments
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
