From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dw_spi: add DMA support
Date: Sat, 23 Oct 2010 18:10:20 +0200
Message-ID: <AANLkTinSF1vdqc7nhRqY-Mo5dZnwvwd8oR=WJxVC6ne=@mail.gmail.com>
References: <20101022191049.8830.51496.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101022191049.8830.51496.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/10/22 Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>:

> (...)
> +static int mid_spi_dma_init(struct dw_spi *dws)
> +{
> + =A0 =A0 =A0 struct mid_dma *dw_dma =3D dws->dma_priv;
> + =A0 =A0 =A0 struct intel_mid_dma_slave *rxs, *txs;
> + =A0 =A0 =A0 dma_cap_mask_t mask;
> +
> + =A0 =A0 =A0 dws->txchan =3D NULL;
> + =A0 =A0 =A0 dws->rxchan =3D NULL;
> +
> + =A0 =A0 =A0 /*get pci device for DMA*/
> + =A0 =A0 =A0 dws->dmac =3D pci_get_device(PCI_VENDOR_ID_INTEL, 0x813, NU=
LL);
> +
> + =A0 =A0 =A0 /* 1. Init rx channel */
> + =A0 =A0 =A0 rxs =3D &dw_dma->dmas_rx;
> +
> + =A0 =A0 =A0 rxs->dirn =3D DMA_FROM_DEVICE;
> + =A0 =A0 =A0 rxs->hs_mode =3D LNW_DMA_HW_HS;
> + =A0 =A0 =A0 rxs->cfg_mode =3D LNW_DMA_PER_TO_MEM;
> + =A0 =A0 =A0 rxs->src_width =3D LNW_DMA_WIDTH_16BIT;
> + =A0 =A0 =A0 rxs->dst_width =3D LNW_DMA_WIDTH_32BIT;
> + =A0 =A0 =A0 rxs->src_msize =3D LNW_DMA_MSIZE_16;
> + =A0 =A0 =A0 rxs->dst_msize =3D LNW_DMA_MSIZE_16;

Hm, hm hm. You go configure these channel characteristics
by derferencing and writing private data.

There *is* a generic runtime channel control interface as of
kernel 2.6.36. Compare to this snippet from the PL022 DMA
support that was merged into becoming 2.6.37 a day ago or so
(behold the beauty in drivers/spi/amba-pl022.c):

        struct dma_slave_config rx_conf =3D {
                .src_addr =3D SSP_DR(pl022->phybase),
                .direction =3D DMA_FROM_DEVICE,
                .src_maxburst =3D pl022->vendor->fifodepth >> 1,
        };
       (...)
        struct dma_chan *rxchan =3D pl022->dma_rx_channel;

       (...)

        switch (pl022->read) {
        case READING_NULL:
                /* Use the same as for writing */
                rx_conf.src_addr_width =3D DMA_SLAVE_BUSWIDTH_UNDEFINED;
                break;
        case READING_U8:
                rx_conf.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
                break;
        case READING_U16:
                rx_conf.src_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
                break;
        case READING_U32:
                rx_conf.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
                break;
        }
        rxchan->device->device_control(rxchan, DMA_SLAVE_CONFIG,
                                       (unsigned long) &rx_conf);

I don't know if I'm particularly biased by being infatuated by my own
interface, but can't you just implement the DMA_SLAVE_CONFIG
command for the DW DMA controller instead of this
custom stuff?

> + =A0 =A0 =A0 dma_cap_zero(mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_MEMCPY, mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_SLAVE, mask);

What are you doing? Normally you want *either* a memcpy channel
(which wouldn't require the kind of setup you do above, hell memcpy
shan't be any different from the C library function memcpy()!) *or*
you want a slave channel.

Most probably you should drop dma_cap_set(DMA_MEMCPY, mask),
if it is needed your DMAengine driver is likely weird.

Then I think I get the answer later on:

> + =A0 =A0 =A0 dws->rxchan =3D dma_request_channel(mask, mid_spi_dma_chan_=
filter, dws);

Aha generic DMA engine, that's cool! :)

So then again, use the DMA-engine configuration mechanism, and
get the slave channel will ya?

> (...)
> +static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
> (...)
> + =A0 =A0 =A0 /* 3. start the RX dma transfer */
> + =A0 =A0 =A0 if (dws->rx_dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rxdesc =3D rxchan->device->device_prep_dma_=
memcpy(rxchan,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->rx_dma=
, dws->dma_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->len, f=
lag);

So you're still using the memcpy() prepare function in order to
be able to supply the endpoint address. Incidentally, that is an
additional argument that you can pass to the generic channel
control mechanism using .src_addr/.dst_addr respectively.

And the DW controller does *indeed* have a
device_prep_slave_sg hook.

My recommendation: put generic channel control into the
DMA driver you're using and inspect amba-pl022.c for an
idea on how to do this.

Since the .device_prep_slave_sg command only takes
SGlists you will have to wrap your buffers in SGlists but
I'm working on a simplifying wrapper for that.

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
