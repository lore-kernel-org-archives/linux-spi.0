From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message length
Date: Fri, 20 Nov 2015 13:56:21 +0100
Message-ID: <CAOMqctQo58yCfzU3u=u3N0zNfhQph2Pw2vnrxsVvAEXi5n2HRw@mail.gmail.com>
References: <564CEB61.2000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <564CEB61.2000601-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

On 18 November 2015 at 22:19, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> There have been few discussions in the past about how to handle SPI controller
> limitations like max message length. However they don't seem to have resulted
> in accepted patches yet.
> I also stumbled across this topic because I own a device using Freescale's
> ESPI which has a 64K message size limitation.
>
> At least one agreed fact is that silently assembling chunks in protocol
> drivers is not the preferred approach.
>
> Maybe a better approach would be to introduce a new member of spi_master
> dealing with controller limitations.
> My issue is just the message size limitation but most likely there are more
> and different limitations in other controllers.
>

There are multiple sides to this problem.

The first is the nature of the limitation of the driver. I was dealing
with a driver that can transfer up to 63 bytes because it has 64byte
fifo and the hardware locks up when it's full. The limitation is only
due to the driver cutting way too many corners. There is dmaengine
support available for the platform which has been merged recently so
the driver can use DMA for arbitrarily long transfers. Even without
DMA there is possibility to to drive CS manually and compose multiple
transfers into single logical message or whatever.

Either way, the limit of 63 bytes is very low and would actually cause
problems with many device drivers so it was agreed that fixing the
master one way or another is desirable.

64k limit on the other hand is something more usable from driver
writer standpoint and some banked mmap access to flash memories would
have similar granularity.

I would also like to point out that the limit depends on the transfer
settings. For example, a SPI controller can have no limit on transfer
size but when accessing a flash memory through mmap interface the mmap
window limits the amount of data you can transfer at once. This
particular case may be fixable by moving the mmap window transparently
inside the driver.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
