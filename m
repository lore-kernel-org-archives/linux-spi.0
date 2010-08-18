From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] SPI: remove superfluous DMA buffer
	syncs on PL022
Date: Tue, 17 Aug 2010 22:15:29 -0600
Message-ID: <AANLkTi=T89ZZo0m2hYaW9dJ7MKd9GLEDVZpcqZ-3RcNq@mail.gmail.com>
References: <1282082924-25809-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yuanyabin1978-k+cT0dCbe1g@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1282082924-25809-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 17, 2010 at 4:08 PM, Linus Walleij
<linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
> This removes the superfluous DMA buffer syncs identified by Russell
> in the DMA support for PL022.
>
> Cc: yuanyabin1978-k+cT0dCbe1g@public.gmane.org
> Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

I haven't actually pushed out the spi-test branch yet.  Shall I squash
this patch into the previous one?

g.

> ---
> =A0drivers/spi/amba-pl022.c | =A0 16 +++++-----------
> =A01 files changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 59b3948..521d3d9 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -794,12 +794,7 @@ static void dma_callback(void *data)
> =A0 =A0 =A0 =A0struct pl022 *pl022 =3D data;
> =A0 =A0 =A0 =A0struct spi_message *msg =3D pl022->cur_msg;
>
> - =A0 =A0 =A0 /* Sync in RX buffer to CPU */
> =A0 =A0 =A0 =A0BUG_ON(!pl022->sgt_rx.sgl);
> - =A0 =A0 =A0 dma_sync_sg_for_cpu(&pl022->adev->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl022->sgt_rx.sgl,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl022->sgt_rx.nents,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_FROM_DEVICE);
>
> =A0#ifdef VERBOSE_DEBUG
> =A0 =A0 =A0 =A0/*
> @@ -812,6 +807,11 @@ static void dma_callback(void *data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct scatterlist *sg;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int i;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_sync_sg_for_cpu(&pl022->adev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl0=
22->sgt_rx.sgl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl0=
22->sgt_rx.nents,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA=
_FROM_DEVICE);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for_each_sg(pl022->sgt_rx.sgl, sg, pl022->=
sgt_rx.nents, i) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&pl022->adev->dev,=
 "SPI RX SG ENTRY: %d", i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print_hex_dump(KERN_ERR, "=
SPI RX: ",
> @@ -1001,12 +1001,6 @@ static int configure_dma(struct pl022 *pl022)
> =A0 =A0 =A0 =A0if (sglen !=3D pages)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_tx_sgmap;
>
> - =A0 =A0 =A0 /* Synchronize the TX scatterlist, invalidate buffers, cach=
es etc */
> - =A0 =A0 =A0 dma_sync_sg_for_device(&pl022->adev->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pl022->sgt_t=
x.sgl,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pl022->sgt_t=
x.nents,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_TO_DEVIC=
E);
> -
> =A0 =A0 =A0 =A0/* Send both scatterlists */
> =A0 =A0 =A0 =A0rxdesc =3D rxchan->device->device_prep_slave_sg(rxchan,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0pl022->sgt_rx.sgl,
> --
> 1.6.3.3
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =
