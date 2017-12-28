From: Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Subject: Re: [PATCH 0/3] mtd: spi-nor: fix DMA-unsafe buffer issue between MTD
 and SPI
Date: Thu, 28 Dec 2017 10:36:28 +0100
Message-ID: <1dfd0843-32a5-9c58-24c7-d598dee64f4b@wedev4u.fr>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <1514313927.26695.19.camel@impinj.com> <20171227103609.GQ1827@finisterre>
 <1514405711.26695.67.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        "computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "vigneshr-l0cyMroinI0@public.gmane.org" <vigneshr-l0cyMroinI0@public.gmane.org>,
        "boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org"
        <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        "richard-/L3Ra7n9ekc@public.gmane.org" <richard-/L3Ra7n9ekc@public.gmane.org>,
        "marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1514405711.26695.67.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Trent,

Le 27/12/2017 à 21:15, Trent Piepho a écrit :
> On Wed, 2017-12-27 at 10:36 +0000, Mark Brown wrote:
>> On Tue, Dec 26, 2017 at 06:45:28PM +0000, Trent Piepho wrote:
>>
>>> Or, since this only fixes instances of DMA-unsafe buffers used in
>>> access to SPI NOR flash chips, and since there are other SPI master
>>> interface users, those chip specific fixes in some/all spi master
>>> drivers are still needed to fix transfers not originated via spi-nor? 
>>
>> SPI client drivers are *supposed* to use DMA safe memory already.  How
>> often that happens in cases where it matters is a separate question, we
>> definitely have users with smaller transfers that don't do the right
>> thing but they're normally done using PIO anyway.
> 
> I wonder what the end goal is here?
> 
> A random collection of spi master drivers will accept DMA-unsafe
> buffers in some way.  In some cases a framework like spi-nor provides
> the fixup to spi-nor master drivers (none so far) and in other cases
> (atmel-quadspi), the spi-nor master driver has its own fixes.
>

At the spi-nor side, atmel-quadspi is also an example showing how the
bounce buffer feature should be used by other spi-flash drivers.
Actually, the m25p80 driver taken aside, no spi-flash driver is currently
able to perform DMA safe transfers.

Some patches were proposed but all rejected because they were doing wrong
things: calling dma_map_single() even if the buffer is not guaranteed to be
contiguous in physical memory or not being aware of the data cache aliasing
issue on some architectures.

So this series offers a common helper solution for all drivers in spi-nor.
I don't want each spi-flash driver to implement its own custom solution.
 
> Generic spi masters like spi-atmel, spi-ti-qspi, and spi-davinci will
> have their fixes for certain cases.
>

If UBIFS was the only reason for those drivers to implement their own fixes
then those fixes would no longer be needed with this series. However if
other spi-clients also provide the SPI sub-system with DMA-unsafe buffers
then maybe those fixes are still needed. I think Mark knows better than
anyone else about the SPI sub-system.

Besides, another reason to allocate the bounce buffer from spi-nor is that
we can choose a suited size as a trade-off between performance and memory
footprint.

> Perhaps spi flash drivers like m25p80 will have fixes too?
>

patch 1 of the series enables the bounce buffer for both read and write
operations in the m25p80 driver, in order to be compliant with buffer
constraints expressed in the kernel-doc of 'struct spi_transfer'.

> Some spi clients, like spidev, will have internal bounce buffers,
> rather than userspace addresses or commands in stack variables, so that
> they follow the rules about DMA safe buffers.
> 
> What exactly is caught as DMA unsafe and what is not will of course
> vary greatly from driver to driver.  Some drivers will catch highmem
> memory while other drivers will only detect vmalloc memory.  Some will
> only catch an unsafe buffer if a specific SoC known to the driver to
> have an aliasing cache is enabled.  Some will check buffers that arrive
> via the spi_flash_read interface but not via generic spi transfers,
> while others will check all spi transfer buffers.
>

That's why I've asked for pieces of advice on how to implement a relevant
[spi_nor_]is_dma_safe() function and Vignesh has provided good suggestion!

> Obviously, I don't think this path will lead to a desirable end.  Maybe

Here you seem to only take the m25p80 and SPI sub-system cases into
account. However, at the spi-nor side, we currently have to other solution
to let spi-nor flash drivers implement DMA transfers safely.

Best regards,

Cyrille

> the basic assumption, that clients should provide DMA safe buffers,
> should be revisited.  Experience has shown that it's too much to ask
> for and spi clients will never get it right.  It would be better to try
> to fix this at some common point between the clients and masters so it
> can be done once and for all.
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
