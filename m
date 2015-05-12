From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: spi: race in spi_finalize_current_message starting queue_kthread_work
 before the message is unmapped
Date: Tue, 12 May 2015 14:07:21 +0200
Message-ID: <5551ECF9.1050006@martin.sperl.org>
References: <8C375B28-1C09-4545-8A5B-78F6CD04102F@martin.sperl.org> <20150508221309.GK2761@sirena.org.uk> <352560EA-A323-449B-8F37-6066328D2081@martin.sperl.org> <20150511180016.GU3458@sirena.org.uk> <8F4019F0-7C56-4C9C-9193-A2A23B533165@martin.sperl.org> <20150512102034.GM2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	=?windows-1252?Q?Noralf_Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150512102034.GM2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2015-05-12 12:20, Mark Brown wrote:
> We can tell if it's a DMA transfer - if it's a DMA transfer then using
> anything except the SG list is a bit dodgy anyway since you're not
> really supposed to have the CPU look at anything that's mapped for the
> device (though it's generally fine if the device never actually DMAs).
>
>> So unless we have a separate flag to say we only need it for DMA,
>> then we have to keep the the current logic with allocation or we break
>> other drivers.
>
> We essentially have that; anything looking at a DMA mapped transfer had
> better cope.

I believe you miss my point:
a) with SPI_MASTER_MUST_ we will always allocate the buffer - we do not
    take the result of can_dma into account when calculating the size.
    This means we will allocate memory that is potentially too big for
    what we really need (and it can even fail because it is too big
    for the system to handle)
b) a driver in PIO mode can run without SPI_MASTER_MUST_XX
    but when can_dma returns true it needs a scatter-gather-list and
    in that case it needs SPI_MASTER_MUST_ to be set, but the allocation
    is not really needed - just a scatter/gather list that does the
    transfer - there is no means for the driver to state this
    requirement clearly.

That is why I was asking for an additional flag SPI_MASTER_MUST_DMAONLY
to state that requirement.

Then we can extend the if in spi_map_msg to:
     if ((master->flags & (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX)) &&
         (! (master->flags & SPI_MASTER_MUST_DMAONLY)) {

and we save on the allocation when not needed.

And inside __spi_map_msg we can just add some code to create the simple
scatter-gather mapping using a single preallocated page - so something
along the lines (assuming that either tx_buf or rx_buf must be set):
     if ((!xfer->tx_buf) && (master->flags & SPI_MASTER_MUST_TX)) {
         ret = spi_map_null(master, tx_dev,
                            &xfer->tx_sg, &xfer->rx_sg,
			   DMA_TO_DEVICE);
         if (ret != 0) {
              spi_unmap_buf(master, rx_dev,
                            &xfer->rx_sg, DMA_FROM_DEVICE);
              return ret;
         }
     }
     if ((!xfer->rx_buf) && (master->flags & SPI_MASTER_MUST_RX)) {
         ret = spi_map_null(master, rx_dev,
                            &xfer->rx_sg, &xfer->tx_sg,
			   DMA_FROM_DEVICE);
         if (ret != 0) {
              spi_unmap_buf(master, tx_dev,
                            &xfer->tx_sg, DMA_TO_DEVICE);
              return ret;
         }
     }

Similarly we could also define 2 flags: SPI_MASTER_MUST_RX_SG and
SPI_MASTER_MUST_TX_SG and be open for more different options for
drivers.

One potentially could merge the functionality of spi_map_msg and 
__spi_map_message into one to achive something similar without the
flag, but then this is a subtil change in the functionality which
may break existing drivers with different expectations about what
happens.

I see this last approach as the one with the highest risk of
breaking existing drivers.

So the extra flag seems to be to be a "safer" approach and it also
states more explicitly the needs of the driver.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
