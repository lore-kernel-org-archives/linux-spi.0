From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH v2] dmaengine: bcm2835: Add slave dma support
Date: Fri, 1 May 2015 23:07:33 +0200
Message-ID: <DC1D0474-515B-4863-85FB-9E60FFA34829@martin.sperl.org>
References: <1429355160-13657-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	jonathan-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429355160-13657-1-git-send-email-noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Tests with the initial (and incomplete) version of the spi-bcm2835 driv=
er=20
with DMA transfer support show that the dma-engine works as expected wi=
th=20
this patch.

There is one one observation:

> On 18.04.2015, at 13:06, Noralf Tr=C3=B8nnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org> wro=
te:
> +static struct dma_async_tx_descriptor *
> +bcm2835_dma_prep_slave_sg(struct dma_chan *chan,
> +			  struct scatterlist *sgl,
> +			  unsigned int sg_len,
> +			  enum dma_transfer_direction direction,
> +			  unsigned long flags, void *context)
> +{
=2E..
> +			/* Enable */
> +			if (i =3D=3D sg_len - 1 && len - j <=3D max_size)
> +				control_block->info |=3D BCM2835_DMA_INT_EN;

The observation is that an interrupt is always triggered - even in the =
case
where flags does NOT have DMA_PREP_INTERRUPT set.
This may not be necessary and avoid interrupts.

So maybe the above if clause should get extended by:
   && (flags & DMA_PREP_INTERRUPT)
to only trigger an interrupt when really requested.

I am not sure if there are any side-effects because of this besides hav=
ing the
requirement on the client to run dmaengine_terminate_all() on that spec=
ific dma
channel without interrupts when the transfer is finished.

In the case of SPI we have TX feed the fifo - which finishes early - , =
but we
only need to the interrupt when RX finishes reading the fifo, which ind=
icates
that the SPI-transfer is fully finished.=20
So having an interrupt on TX is not necessary for the process.

The same observations may also apply to bcm2835_dma_prep_dma_cyclic (wh=
ich is
outside of this patch provided by Noralf).

Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
