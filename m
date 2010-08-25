From: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: add spi_tegra driver
Date: Wed, 25 Aug 2010 14:22:53 -0700
Message-ID: <AANLkTincgapUK5ncs_t3ax=1Kt_56GdR_RVwRqdCm5ge@mail.gmail.com>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
	<1281574023-25160-1-git-send-email-konkers@android.com>
	<AANLkTim4nL+Re=qc55CGS+ksq+ACtGe=vqOeGQ3HbQWM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTim4nL+Re=qc55CGS+ksq+ACtGe=vqOeGQ3HbQWM-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 12, 2010 at 12:54 PM, Grant Likely
<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> Missing patch description. =A0Give reviewers and future readers some
> more details about what hardware this patch adds support for.

I'll add one

>> +#undef DEBUG
>
> Still need to trim this #undef

Done.

> It's a good idea to prefix all these register #defines with something
> driver specific to avoid the possibility of collisions with the global
> namespace.

I'll add SLINK_ to all the bit definitions.

>> +static inline unsigned bytes_per_word(u8 bits)
>> +{
>> + =A0 =A0 =A0 WARN_ON((bits < 1) || bits > 32);
>> + =A0 =A0 =A0 if (bits <=3D 8)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 else if (bits <=3D 16)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 2;
>> + =A0 =A0 =A0 else if (bits <=3D 24)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 3;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 4;
>> +}
>
> No longer used, can be removed.

done

>> +static unsigned long spi_tegra_readl(struct spi_tegra_data *tspi,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0unsigned long reg)
>> +{
>> + =A0 =A0 =A0 return readl(tspi->base + reg);
>> +}
>
> static inline

done

>> +
>> +static void spi_tegra_writel(struct spi_tegra_data *tspi, unsigned long=
 val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long reg)
>> +{
>> + =A0 =A0 =A0 writel(val, tspi->base + reg);
>> +}
>
> ditto

done

>> + =A0 =A0 =A0 val =3D spi_tegra_readl(tspi, SLINK_COMMAND2);
>> + =A0 =A0 =A0 if (t->rx_buf)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D RXEN;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~RXEN;
>> +
>> + =A0 =A0 =A0 if (t->tx_buf)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D TXEN;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~TXEN;
>> +
>> + =A0 =A0 =A0 val &=3D ~SS_EN_CS(~0);
>> + =A0 =A0 =A0 val |=3D SS_EN_CS(spi->chip_select);
>> + =A0 =A0 =A0 val |=3D SPIE;
>
> Nit: This would be more concise:
>
> + =A0 =A0 =A0 val &=3D ~(SS_EN_CS(~0) | RXEN | TXEN);
> + =A0 =A0 =A0 if (t->rx_buf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D RXEN;
> + =A0 =A0 =A0 if (t->tx_buf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D TXEN;
> + =A0 =A0 =A0 val |=3D SS_EN_CS(spi->chip_select);
> + =A0 =A0 =A0 val |=3D SPIE;

done

>> + =A0 =A0 =A0 if (spi->mode & SPI_CPOL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D IDLE_SCLK_DRIVE_HIGH;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D IDLE_SCLK_DRIVE_LOW;
>
> nit: IDLE_SCLK_DRIVE_LOW =3D=3D 0. =A0The driver will be more concise if =
the
> above 2 lines are dropped.

I did it this way because it's not obvious from this code which sets
the bit and which does not without decoding the #defines.  I expect
the complier optimizes this out.

>> +
>> + =A0 =A0 =A0 val |=3D M_S;
>> +
>> + =A0 =A0 =A0 spi_tegra_writel(tspi, val, SLINK_COMMAND);
>
> The read/modify/write register blocks are quite common. =A0Would it be
> clearer and more concise to have a spi_tegra_clrsetbits() static
> inline?

More concise, yes.  Clearer?  I don't think so.  It seems that
clrsetbits is mostly used in ppc code.

>> + =A0 =A0 =A0 /* the SPI controller may come back with both the BSY and =
RDY bits
>> + =A0 =A0 =A0 =A0* set. =A0In this case we need to wait for the BSY bit =
to clear so
>> + =A0 =A0 =A0 =A0* that we are sure the DMA is finished. =A01000 reads w=
as empirically
>> + =A0 =A0 =A0 =A0* determined to be long enough.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 while (timeout++ < 1000) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(spi_tegra_readl(tspi, SLINK_STATUS) =
& BSY))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>
> What happens if the BSY bit is still set when the loop exits?

Given how I've seen the hardware act, I don't think it's possible for
BSY to still be set after 1000 reads.  I forget the average number of
loops but 1000 was very conservative.  Worst case some of the data
might be corrupt.  I'll put an error message in and set status to
-EIO.

>> +
>> + =A0 =A0 =A0 val =3D spi_tegra_readl(tspi, SLINK_STATUS);
>> + =A0 =A0 =A0 val |=3D RDY;
>> + =A0 =A0 =A0 spi_tegra_writel(tspi, val, SLINK_STATUS);
>
> The spin lock isn't held at this point. =A0Will that make this
> read-modify-write operation risky?

move spinlock up.

>> +
>> + =A0 =A0 =A0 spin_lock_irqsave(&tspi->lock, flags);
>
> Is there any condition/event which could cause the spi controller to
> go busy before obtaining the spinlock?

No.  The controller only goes busy when a transaction is started by
calling spi_tegra_go().

>> +
>> + =A0 =A0 =A0 m =3D list_first_entry(&tspi->queue, struct spi_message, q=
ueue);
>> + =A0 =A0 =A0 spi =3D m->state;
>> +
>> + =A0 =A0 =A0 tspi->cur_pos +=3D spi_tegra_drain_rx_fifo(tspi, tspi->cur=
);
>> + =A0 =A0 =A0 m->actual_length +=3D tspi->cur_pos;
>> +
>> + =A0 =A0 =A0 if (tspi->cur_pos < tspi->cur->len) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tspi->cur_len =3D spi_tegra_fill_tx_fifo(t=
spi, tspi->cur);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_tegra_go(tspi);
>> + =A0 =A0 =A0 } else if (!list_is_last(&tspi->cur->transfer_list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&m->tra=
nsfers)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tspi->cur =3D =A0list_first_entry(&tspi->c=
ur->transfer_list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct spi_transfer,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 transfer_list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_tegra_start_transfer(spi, tspi->cur);
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete =3D 1;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (complete) {
>
> Looks like the above else clause is the only thing that can set
> complete. =A0You could delete the above three lines to get the same
> behaviour.

deleted

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&m->queue);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 m->status =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 m->complete(m->context);


>> + =A0 =A0 =A0 switch (spi->chip_select) {
>> + =A0 =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_bit =3D CS_POLARITY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 case 1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_bit =3D CS_POLARITY1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 case 2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_bit =3D CS_POLARITY2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 case 4:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_bit =3D CS_POLARITY3;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> CS_POLARITY is named a little oddly as it seems to indicate the bit,
> not the polarity of the bit. =A0Would this better be named
> CS_BIT0..CS_BIT3?

That's how Nvidia named them in the TRM.


>> + =A0 =A0 =A0 tspi->rx_dma =3D tegra_dma_allocate_channel(TEGRA_DMA_MODE=
_ONESHOT);
>> + =A0 =A0 =A0 if (IS_ERR(tspi->rx_dma)) {
>
> As an aside, and commenting on the tegra DMA api... Is the IS_ERR()
> pattern in the tegra_dma_allocate_channel() return really a good idea
> here? =A0Personally I find that pattern isn't very useful, especially
> when the results is either "yes, allocated" or "no, not-alocated", and
> it is very easy to write code that tests the wrong thing on the return
> value because the compiler cannot catch it. =A0In other words, if it
> isn't vital to return a specific error code, the using the PTR_ERR()
> pattern adds unnecessary risk to the code because developers are used
> to seeing and writing this pattern:
>
> tspi->rx_dma =3D tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT);
> if (!tspi->rx_dma)
> =A0 =A0 =A0 =A0return -ENOMEM;
>
> The compiler won't catch it if the return value is an PTR_ERR.
>
> (I know that some subsystems make heavy use of it, particularly
> filesystems and the block layer which do need to return specific error
> codes to userspace. =A0My argument is that the specific error code is
> probably irrelevant when allocating DMA channels)

I don't have a strong opinion either way but that's the way Colin's
code is written.  I'll let him speak to that.

>> +static int __init spi_tegra_init(void)
>> +{
>> + =A0 =A0 =A0 return platform_driver_probe(&spi_tegra_driver, spi_tegra_=
probe);
>> +}
>> +subsys_initcall(spi_tegra_init);
>
> Unless there is a specific reason that this driver needs to be
> initialized earlier, it should use the module_init() call. =A0In which
> case the reason it is initialized early should be documented with a
> comment. =A0(for reference: 4 of the mainlined spi bus drivers use
> subsys_initcall() whereas 30 of them use module_init().. =A01 uses
> device_initcall() which is the same as module_init. =A0None of the ones
> using subsys_initcall() give a reason why.)

heh.. I missed the module_inits because i grepped for initcall.
changed to module_init.

patch incoming.

-Erik

---------------------------------------------------------------------------=
---
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users =

worldwide. Take advantage of special opportunities to increase revenue and =

speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
