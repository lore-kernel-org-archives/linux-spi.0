From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dw_spi: add DMA support
Date: Tue, 23 Nov 2010 07:48:39 +0100
Message-ID: <AANLkTik8v=H=exeOO93Q_oOxVU=snck_SGWDXuy+-db7@mail.gmail.com>
References: <20101118200935.26334.53708.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101118200935.26334.53708.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is much better than last time but I still have questions...

2010/11/18 Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>:

> + =A0 =A0 =A0 /* 1. Init rx channel */
> + =A0 =A0 =A0 rxs =3D &dw_dma->dmas_rx;
> + =A0 =A0 =A0 ds =3D &rxs->dma_slave;
> + =A0 =A0 =A0 ds->direction =3D DMA_FROM_DEVICE;
> + =A0 =A0 =A0 rxs->hs_mode =3D LNW_DMA_HW_HS;
> + =A0 =A0 =A0 rxs->cfg_mode =3D LNW_DMA_PER_TO_MEM;
> + =A0 =A0 =A0 ds->src_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> + =A0 =A0 =A0 ds->dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> + =A0 =A0 =A0 ds->src_maxburst =3D 16;
> + =A0 =A0 =A0 ds->dst_maxburst =3D 16;

This is great stuff! That is exactly how ds is to be set up.
I would prefer that you don't dereference the this rxs thing here
but whatever.

> + =A0 =A0 =A0 dma_cap_zero(mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_MEMCPY, mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_SLAVE, mask);

This is not elegant. Are you going to do memcpy() or slave
transfers? What you want to do is fix your DMA engine so that
just asking for DMA_SLAVE works.

> + =A0 =A0 =A0 dma_cap_set(DMA_SLAVE, mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_MEMCPY, mask);

Here again...

> +static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
> +{
(...)
> + =A0 =A0 =A0 flag =3D DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
> + =A0 =A0 =A0 if (dws->tx_dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdesc =3D txchan->device->device_prep_=
dma_memcpy(txchan,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->dm=
a_addr, dws->tx_dma,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->le=
n, flag);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdesc->callback =3D dw_spi_dma_done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdesc->callback_param =3D &dws->tx_par=
am;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* 3. start the RX dma transfer */
> + =A0 =A0 =A0 if (dws->rx_dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdesc =3D rxchan->device->device_prep_=
dma_memcpy(rxchan,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->rx=
_dma, dws->dma_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->le=
n, flag);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdesc->callback =3D dw_spi_dma_done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdesc->callback_param =3D &dws->rx_par=
am;
> + =A0 =A0 =A0 }

Using device_prep_dma_memcpy() for this is still nonsense, it should be
device_prep_slave_sg().

I know the DMA driver needs fixing in order for this to work properly,
so why not fix it?

These are the most important concerns I raised last iteration, so
I challenge you to fix drivers/dma/dw_dmac.c or wherever the real
problem sits.

Can you describe where the problem with fixing this to use real
slave sglists is?

Yours,
Linus Walleij
