From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spi: Provide core support for full duplex devices
Date: Wed, 19 Feb 2014 14:32:28 +0100
Message-ID: <CAMuHMdWRd075tEDfvtWfkQ-7dECT0y14qxQpbyKMs5v3GDYRAA@mail.gmail.com>
References: <CAMuHMdUY+XEqKYh7mMOYUV18PpR+7SFw+BEUFh-9yL=H6reQkA@mail.gmail.com>
	<CAMuHMdWkPxp2U=Xz=wWu70RPxj+4GGCyifdPv=xL=47cz_upBw@mail.gmail.com>
	<20140219130407.GR2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140219130407.GR2669-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Feb 19, 2014 at 2:04 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Feb 18, 2014 at 10:59:09AM +0100, Geert Uytterhoeven wrote:
>
>> For Dual/Quad transfers, which are half-duplex, the buffer pointer for the
>> unused direction must be NULL, so the driver knows in which direction to
>> transfer. Hence SPI_MASTER_MUST_TX cannot be set for Dual/Quad
>> capable SPI master.
>
> This is a particularly thoughtless hardware design it has to be said.

Do you mean the fact that you need to transmit dummy data on this particular
hardware, or that you need to know the direction for Dual/Quad transfers,
and don't need dummy data for the latter?

It actually makes sense from a hardware point of view:
  - Single SPI transfers are full-duplex. For every bit of output, there's a bit
    of input. As this is SPI master, not slave, the master controls everything
    based on the availability of data in the output FIFO.
  - Dual/Quad SPI transfers are half duplex:
      Transmission is controlled by the master, based on the availability of
      data in the output FIFO.
      Reception is also controlled by the master, but as there's no data to
      output, this is handled based on the amount of space in the RX FIFO.

>> I'm also worried about the buffer allocation. With m25p80 and mtchar, the
>> transfer buffer can be quite large (up to 4 MiB in my case), and this can be
>> triggered from userspace.
>
> That's readily fixable for DMA capable drivers, we can just repeatedly
> transfer the same page (or whatever).  PIO drivers have big problems

So let's hope all DMA-capable hardware has scatter/gather support, or an
IOMMU ;-)

>> Concluding, for PIO mode, I'm still in favor of using
>
>>     data = tx_buf ? *tx_buf++ : DUMMY_DATA;
>
>> in the SPI master driver itself.
>
> With the ternery operator for legibility of course.

You forgot the smiley ;-)

While in general I care a lot about readability (code is read more than it's
written), using a ternary operator for chosing between valid data and a
dummy zero is fine, IMHO.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
