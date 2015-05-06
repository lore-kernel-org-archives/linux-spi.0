From: =?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v2] dmaengine: bcm2835: Add slave dma support
Date: Wed, 06 May 2015 21:21:57 +0200
Message-ID: <554A69D5.90301@tronnes.org>
References: <1429355160-13657-1-git-send-email-noralf@tronnes.org> <DC1D0474-515B-4863-85FB-9E60FFA34829@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	jonathan-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DC1D0474-515B-4863-85FB-9E60FFA34829-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Den 01.05.2015 23:07, skrev Martin Sperl:
> Tests with the initial (and incomplete) version of the spi-bcm2835 dr=
iver
> with DMA transfer support show that the dma-engine works as expected =
with
> this patch.
>
> There is one one observation:
>
>> On 18.04.2015, at 13:06, Noralf Tr=C3=B8nnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org> wr=
ote:
>> +static struct dma_async_tx_descriptor *
>> +bcm2835_dma_prep_slave_sg(struct dma_chan *chan,
>> +			  struct scatterlist *sgl,
>> +			  unsigned int sg_len,
>> +			  enum dma_transfer_direction direction,
>> +			  unsigned long flags, void *context)
>> +{
> ...
>> +			/* Enable */
>> +			if (i =3D=3D sg_len - 1 && len - j <=3D max_size)
>> +				control_block->info |=3D BCM2835_DMA_INT_EN;
> The observation is that an interrupt is always triggered - even in th=
e case
> where flags does NOT have DMA_PREP_INTERRUPT set.
> This may not be necessary and avoid interrupts.
>
> So maybe the above if clause should get extended by:
>     && (flags & DMA_PREP_INTERRUPT)
> to only trigger an interrupt when really requested.
>
> I am not sure if there are any side-effects because of this besides h=
aving the
> requirement on the client to run dmaengine_terminate_all() on that sp=
ecific dma
> channel without interrupts when the transfer is finished.
>
> In the case of SPI we have TX feed the fifo - which finishes early - =
, but we
> only need to the interrupt when RX finishes reading the fifo, which i=
ndicates
> that the SPI-transfer is fully finished.
> So having an interrupt on TX is not necessary for the process.
>
> The same observations may also apply to bcm2835_dma_prep_dma_cyclic (=
which is
> outside of this patch provided by Noralf).

Jonathan, can you comment on this?


Noralf.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
