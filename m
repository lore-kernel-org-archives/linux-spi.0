From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Applied "spi: omap2-mcspi: Undo broken fix for dma transfer of
 vmalloced buffer" to the spi tree
Date: Thu, 12 May 2016 22:49:15 +0900
Message-ID: <CAC5umyjoKfMBbO1JPyTjqsz4zuiZMQDZcKHxonZuEwqGpJxb_g@mail.gmail.com>
References: <1460140995-4062-1-git-send-email-akinobu.mita@gmail.com>
 <E1apndq-0002S5-8J@debutante> <CAC5umyg2fJxYKOB4J96+3igkNx+eJs5MET8S8NnafZ3hcPPEag@mail.gmail.com>
 <20160511162030.GN6261@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160511162030.GN6261-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2016-05-12 1:20 GMT+09:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Thu, May 12, 2016 at 12:39:35AM +0900, Akinobu Mita wrote:
>
>> I realized that this undo patch has not been merged to Linus' tree yet.
>> I have a fix for this issue (attached patch).  But the change is not
>> small and also v4.6 release is soon.  So I think this undo patch
>> should go into 4.6 release.
>
> I actually just sent that a few minutes ago anyway.
>
>> The actual DMA transfer length by dmaengine can be smaller than SPI
>> transfer length in the specific condition.  In that case, the last
>> word needs to be filled after DMA transfer completion.
>
>> This fixes it by detecting that case and remap the scatterlist with
>> correct DMA transfer length.
>
> This feels like it should be in the framework, I imagine other devices
> will have similar limiations.  Especially if the limitation comes from
> the DMA engine I'd hope we can arrange to query it somehow...  can you
> provide a bit more detail on what the restriction is please?

According to the source code (I couldn't find out the reason from TRM
yet), the last word (or two words if TURBO mode is used) of RX data
needs to be transferred by PIO transfer instead of DMA transfer.

But if FIFO buffer support[*] is used, the whole RX data can be
transferred by DMA transfer.  The use of FIFO buffer is determined by
omap2_mcspi_set_fifo() with the total transfer length, bits per words,
TX/RX only or both, and etc.

[*] commit d33f473dcd8e ("spi: omap2-mcspi: Add FIFO buffer support")

If we have an optional callback to get the actual DMA transfer length
instead of using spi_transfer->len for each spi_transfer in the
framework, we can use it to determine the correct map size used by
spi_map_buf() in spi.c.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
