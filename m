From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH 4/9] spi: sun4i: add DMA support
Date: Tue, 17 May 2016 07:44:36 +0200
Message-ID: <CAOMqctQPUDm3XDf_YAVubzq2op=j6Qs6R4hjjCaa=ELoeHzjhQ@mail.gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com> <ccf776869b0d7fe2c78bcc41d6cd1896bf732296.1440080122.git.hramrach@gmail.com>
 <20150820185850.GQ12027@sirena.org.uk>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBB3G75K4QKGQES6H5VMY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20150820185850.GQ12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

On 20 August 2015 at 16:56, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

>> +             /* Enable Dedicated DMA requests */
>> +             reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
>> +             reg |=3D SUN4I_CTL_DMAMC_DEDICATED;
>> +             sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
>> +             sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, trigger);
>> +     } else {
>> +             dev_dbg(&sspi->master->dev, "Using PIO mode for transfer\n=
");
>> +
>> +             /* Disable DMA requests */
>> +             reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
>> +             sun4i_spi_write(sspi, SUN4I_CTL_REG,
>> +                             reg & ~SUN4I_CTL_DMAMC_DEDICATED);
>> +             sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, 0);
>> +
>> +             /* Fill the TX FIFO */
>> +             /* Filling the fifo fully causes timeout for some reason
>> +              * at least on spi2 on a10s */
>> +             sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
>> +     }
>> +
>>       /* Start the transfer */
>>       reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
>>       sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
>> @@ -303,7 +363,12 @@ static int sun4i_spi_transfer_one(struct spi_master=
 *master,
>>               goto out;
>>       }
>>
>> -     sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
>> +     if (sun4i_spi_can_dma(master, spi, tfr) && desc_rx) {
>> +             /* The receive transfer should be the last one to finish *=
/
>> +             dma_wait_for_async_tx(desc_rx);
>
> Nope, this is only meant for async_tx. You should register a callback
> in your transfer that will mark the completion structure as completed,
> and then drain the FIFO only if not using DMA.

What exactly is wrong with this?

I did not observe data corruption. Passing desc_rx to
dma_wait_for_async_tx looks odd on closer inspection, though. Will
look through some other spi driver code.

>> -     init_completion(&sspi->done);
>> +     master->dma_tx =3D dma_request_slave_channel_reason(&pdev->dev, "t=
x");
>> +     if (IS_ERR(master->dma_tx)) {
>> +             dev_err(&pdev->dev, "Unable to acquire DMA channel TX\n");
>> +             ret =3D PTR_ERR(master->dma_tx);
>> +             goto err_free_master;
>> +     }
>> +
>> +     dma_sconfig.direction =3D DMA_MEM_TO_DEV;
>> +     dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +     dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +     dma_sconfig.dst_addr =3D res->start + SUN4I_TXDATA_REG;
>> +     dma_sconfig.src_maxburst =3D 1;
>> +     dma_sconfig.dst_maxburst =3D 1;
>> +
>> +     ret =3D dmaengine_slave_config(master->dma_tx, &dma_sconfig);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "Unable to configure TX DMA slave\n");
>> +             goto err_tx_dma_release;
>> +     }
>> +
>> +     master->dma_rx =3D dma_request_slave_channel_reason(&pdev->dev, "r=
x");
>> +     if (IS_ERR(master->dma_rx)) {
>> +             dev_err(&pdev->dev, "Unable to acquire DMA channel RX\n");
>> +             ret =3D PTR_ERR(master->dma_rx);
>> +             goto err_tx_dma_release;
>> +     }
>> +
>> +     dma_sconfig.direction =3D DMA_DEV_TO_MEM;
>> +     dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +     dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +     dma_sconfig.src_addr =3D res->start + SUN4I_RXDATA_REG;
>> +     dma_sconfig.src_maxburst =3D 1;
>> +     dma_sconfig.dst_maxburst =3D 1;
>
> We can't use a higher bust size?

Who actually does?

It accomplishes the transfer with burst size of 1 so that's good enough.

Researching alignment requirements and other oddities of Chinese
controllers when larger burst size is used can be topic for another
patch.


On 20 August 2015 at 20:58, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Aug 20, 2015 at 02:19:46PM -0000, Emilio L=C3=B3pez wrote:
>
>> -     sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
>> +     if (sun4i_spi_can_dma(master, spi, tfr) && desc_rx) {
>> +             /* The receive transfer should be the last one to finish *=
/
>> +             dma_wait_for_async_tx(desc_rx);
>
> What if it's a transmit only transfer?  We'll fall over to this...
>
>> +     } else {
>> +             sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
>> +     }
>
> ...which manually reads data from the FIFO which doesn't seem like what
... which should be empty since RX is not enabled.
> we want, won't it conflict with the DMA?
It does not seem to conflict in practice.


Thanks

Michal

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
