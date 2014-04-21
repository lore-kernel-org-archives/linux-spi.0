From: Jorge Ventura <jorge.araujo.ventura-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi-omap2-mcspi hangs when DMA and PIO are used simultaneously
Date: Mon, 21 Apr 2014 08:20:44 -0500
Message-ID: <20140421132043.GA6640@gmail.com>
References: <20140412031902.GA28289@myventura.us>
 <FEB1293C1A07484EA4E9721B32981131EAEF80@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <FEB1293C1A07484EA4E9721B32981131EAEF80-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This message is just to give a conclusion on my original post. This is a
description of some tests that I did to verify the drive
spi_omap2_mcspi related with the problem I reported. The conclusion is
that there is no problem with the driver.

I connected one beaglebone as the spi master to an Arduino uno as slave;
doing that I can have serial terminals at both sides so that I can see
everything. In the middle I have a logic analyzer to confirm that what I
am reading at the terminals is exactly what I can see in the display of
logic analyzer for both directions. I didn't find anything wrong!

Another check that I did was a stress test making transitions from PIO
to DMA and from DMA to PIO sending blocks of two different sizes and
again, everything works perfectly. This eliminates completely the drive
spi_opmp2_mcspi as the originator of the problem I am having with the
network card enc28j60. The problem has to be in the enc28j60 driver
itself.

Ventura

On Sat, Apr 12, 2014 at 04:33:38AM +0000, Poddar, Sourav wrote:
> Hi,
> [Sorry fot top posting]
> 
> Can you try this patch?
> https://patchwork.kernel.org/patch/3511311/
> 
> ________________________________________
> From: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] on behalf of Jorge Ventura [jorge.araujo.ventura-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Saturday, April 12, 2014 8:49 AM
> To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: jorge.araujo.ventura-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> Subject: spi-omap2-mcspi hangs when DMA and PIO are used simultaneously
> 
> I am struggling with this problem for several weeks with no success.
> 
> I am using spi-omap2-mcspi to drive a network card based on enc28j60 and everything works perfect if I define
> DMA_MIN_BYTES = 0 (force to use DMA only) or DMA_MIN_BYTES = 99999 (force to use PIO only).
> But if I use the original value of 160, the board can send out 10 to 20 pings approximately
> and if for any reason the drive switch from PIO to DMA what will be decided by the size of data,
> some workqueue tasks hung and the card stops.
> 
> I am running with "lockdep" and "detect hung tasks" and I can see that four tasks are stopped,
> three from enc28j60 and one from spi-omap2-mcspi.
> 
> The mcspi is stopped in spi-omap2.mcspi.c:480 to wait the completion of omap2_mcspi_rx_callback
> that it never happens.
> 
>    468                 if (tx) {
>    469                         tx->callback = omap2_mcspi_rx_callback;
>    470                         tx->callback_param = spi;
>    471                         dmaengine_submit(tx);
>    472                 } else {
>    473                                 /* FIXME: fall back to PIO? */
>    474                 }
>    475         }
>    476
>    477         dma_async_issue_pending(mcspi_dma->dma_rx);
>    478         omap2_mcspi_set_dma_req(spi, 1, 1);
>    479
>    480         wait_for_completion(&mcspi_dma->dma_rx_completion);
>    481         dma_unmap_single(mcspi->dev, xfer->rx_dma, count,
>    482                          DMA_FROM_DEVICE);
> 
> Any help/suggestion is welcome. Need more information, please let me know, I have much
> more details.
> 
> Thank you.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
