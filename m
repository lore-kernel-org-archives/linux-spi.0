From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] mtd: m25p80: consider max_transfer_size when reading
Date: Mon, 6 Jun 2016 11:28:03 -0700
Message-ID: <20160606182803.GA128439@google.com>
References: <56D22823.7090005@gmail.com>
 <20160405193952.GA5243@localhost>
 <57041B43.2000109@gmail.com>
 <20160405210727.GB5243@localhost>
 <5706B084.2070909@gmail.com>
 <20160505235700.GA99474@google.com>
 <20160506121431.GQ6292@sirena.org.uk>
 <77a22258-95ca-031a-825d-a9e98e30a162@gmail.com>
 <20160606174003.GE7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160606174003.GE7510-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jun 06, 2016 at 06:40:03PM +0100, Mark Brown wrote:
> On Sat, Jun 04, 2016 at 12:22:37AM +0200, Heiner Kallweit wrote:
> > Am 06.05.2016 um 14:14 schrieb Mark Brown:
> 
> > > Yes, it's called the maximum transfer size because it is the maximum
> > > size of a transfer, not because it's the maximum size of a message.
> 
> > I'd like to come back to this discussion. You said best would be to fix
> > the chip driver. To do this and calculate an appropriate value for
> > max_transfer_size the chip driver would have to know that the spi_device
> > is a spi-nor device.
> 
> That doesn't make any sense, the controller hardware doesn't magically
> change based on what is connected to it.

I believe Heiner has an (unstated here, but stated elsewhere?)
assumption that his driver has a maximum *message* size, not *transfer*
size. So he's explaining how to work around that by implicitly figuring
out what the message size would be based on a transfer size, I think.

What I don't understand yet is whether there's some HW limitation, or
just a SW limitation, for handling *transfers* as large as
SPCOM_TRANLEN_MAX in drivers/spi/spi-fsl-espi.c, with potentially
multiple of those transfers in a single message. I would think that each
SPI transfer can mostly be handled individually. But if not, then as
mentioned previously, we'd need a new API for that: ->max_msg_size().

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
