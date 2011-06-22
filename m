From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: omap2-mcspi: fix omap2_mcspi_probe error handling
Date: Wed, 22 Jun 2011 09:29:05 -0600
Message-ID: <BANLkTimQ55xBwzoxnSAKznG-GTHZ+LtShw@mail.gmail.com>
References: <1308751077.4846.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	Juha Yrjola <juha.yrjola@nokia.com>,
	spi-devel-general@lists.sourceforge.net
To: Axel Lin <axel.lin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308751077.4846.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 22, 2011 at 7:57 AM, Axel Lin <axel.lin@gmail.com> wrote:
> This patch includes below fixes for error handling:
> 1. return proper error if kcalloc for mcspi->dma_channels fails
> 2. return proper error if omap2_mcspi_master_setup fails
> 3. properly release allocated resources in error paths and
> =A0 improve the naming of goto labels.

Is this to be applied immediately, or queued up in linux-next for v3.1?

g.

>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =A0drivers/spi/spi-omap2-mcspi.c | =A0 39 +++++++++++++++++++++------=
------------
> =A01 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mc=
spi.c
> index fde3a2d..74f444d 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1087,7 +1087,7 @@ static int __init omap2_mcspi_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0struct omap2_mcspi_platform_config *pdata =3D pdev->de=
v.platform_data;
> =A0 =A0 =A0 =A0struct omap2_mcspi =A0 =A0 =A0*mcspi;
> =A0 =A0 =A0 =A0struct resource =A0 =A0 =A0 =A0 *r;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D =
0, i;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status, i;
>
> =A0 =A0 =A0 =A0master =3D spi_alloc_master(&pdev->dev, sizeof *mcspi)=
;
> =A0 =A0 =A0 =A0if (master =3D=3D NULL) {
> @@ -1114,12 +1114,12 @@ static int __init omap2_mcspi_probe(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> =A0 =A0 =A0 =A0if (r =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_put_master;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (!request_mem_region(r->start, resource_size(r),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_na=
me(&pdev->dev))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -EBUSY;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_put_master;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0r->start +=3D pdata->regs_offset;
> @@ -1129,7 +1129,7 @@ static int __init omap2_mcspi_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0if (!mcspi->base) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&pdev->dev, "can't ioremap MCS=
PI\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_mem_region;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0mcspi->dev =3D &pdev->dev;
> @@ -1143,8 +1143,10 @@ static int __init omap2_mcspi_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(struct omap2_mc=
spi_dma),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
>
> - =A0 =A0 =A0 if (mcspi->dma_channels =3D=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> + =A0 =A0 =A0 if (mcspi->dma_channels =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_iounmap;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < master->num_chipselect; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0char dma_ch_name[14];
> @@ -1156,7 +1158,7 @@ static int __init omap2_mcspi_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!dma_res) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&pdev->dev, "c=
annot get DMA RX channel\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_dma_chann=
els;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcspi->dma_channels[i].dma_rx_channel =
=3D -1;
> @@ -1167,7 +1169,7 @@ static int __init omap2_mcspi_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!dma_res) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&pdev->dev, "c=
annot get DMA TX channel\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_dma_chann=
els;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcspi->dma_channels[i].dma_tx_channel =
=3D -1;
> @@ -1176,23 +1178,24 @@ static int __init omap2_mcspi_probe(struct pl=
atform_device *pdev)
>
> =A0 =A0 =A0 =A0pm_runtime_enable(&pdev->dev);
>
> - =A0 =A0 =A0 if (status || omap2_mcspi_master_setup(mcspi) < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> + =A0 =A0 =A0 status =3D omap2_mcspi_master_setup(mcspi);
> + =A0 =A0 =A0 if (status)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_dma_channels;
>
> =A0 =A0 =A0 =A0status =3D spi_register_master(master);
> =A0 =A0 =A0 =A0if (status < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_dma_channels;
>
> - =A0 =A0 =A0 return status;
> + =A0 =A0 =A0 return 0;
>
> -err4:
> - =A0 =A0 =A0 spi_master_put(master);
> -err3:
> +err_free_dma_channels:
> =A0 =A0 =A0 =A0kfree(mcspi->dma_channels);
> -err2:
> - =A0 =A0 =A0 release_mem_region(r->start, resource_size(r));
> +err_iounmap:
> =A0 =A0 =A0 =A0iounmap(mcspi->base);
> -err1:
> +err_release_mem_region:
> + =A0 =A0 =A0 release_mem_region(r->start, resource_size(r));
> +err_put_master:
> + =A0 =A0 =A0 spi_master_put(master);
> =A0 =A0 =A0 =A0return status;
> =A0}
>
> --
> 1.7.4.1
>
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
