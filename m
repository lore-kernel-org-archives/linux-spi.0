From: Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [RESEND v6  06/13] spi: imx: fix ERR009165
Date: Tue, 10 Mar 2020 08:27:41 +0000
Message-ID: <VE1PR04MB66384DA6732A840FE1D80C1989FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-7-git-send-email-yibin.gong@nxp.com>
 <20200310073920.GR3335@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
        "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>,
        "l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "martin.fuzzey-X8SyT9posyX3d/wEbhiU/g@public.gmane.org" <martin.fuzzey-X8SyT9posyX3d/wEbhiU/g@public.gmane.org>,
        "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XcXa4x6EXUF0@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200310073920.GR3335-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 2020/03/10 Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Tue, Mar 10, 2020 at 07:31:55PM +0800, Robin Gong wrote:
> > Change to XCH  mode even in dma mode, please refer to the below
> > errata:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.
> >
> nxp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D02%7C01%7C
> yibin.g
> >
> ong%40nxp.com%7Ccbabce268dfd4b0a0e2a08d7c4c62ff6%7C686ea1d3bc2b4c
> 6fa92
> >
> cd99c5c301635%7C0%7C1%7C637194227793913712&amp;sdata=3DQ5N49T4jgX
> TcdTzsB
> > 3D0saK2%2Fzj0R4gnJcGR%2Bd70Fm4%3D&amp;reserved=3D0
> >
> > Signed-off-by: Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>
> > Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/spi/spi-imx.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > f4f28a4..842a86e 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -585,8 +585,9 @@ static int mx51_ecspi_prepare_transfer(struct
> spi_imx_data *spi_imx,
> >  	ctrl |=3D mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
> >  	spi_imx->spi_bus_clk =3D clk;
> >
> > +	/* ERR009165: work in XHC mode as PIO */
> >  	if (spi_imx->usedma)
> > -		ctrl |=3D MX51_ECSPI_CTRL_SMC;
> > +		ctrl &=3D ~MX51_ECSPI_CTRL_SMC;
>=20
> 'ctrl' was read from the hardware. In the dma case it was set explicitly,=
 but it
> was never cleared for a PIO transfer. This looked wrong before this patch=
. Now
> with this patch it looks even more wrong:
> We clear a bit that has never been set and we only do this for DMA, when =
for
> the PIO case it definitly must be cleared. Drop the if clause.
Good point, ACK.
>=20
> >
> >  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
> >
> > @@ -612,12 +613,14 @@ static int mx51_ecspi_prepare_transfer(struct
> > spi_imx_data *spi_imx,
> >
> >  static void mx51_setup_wml(struct spi_imx_data *spi_imx)  {
> > +	u32 tx_wml =3D 0;
> > +
> >  	/*
> >  	 * Configure the DMA register: setup the watermark
> >  	 * and enable DMA request.
> >  	 */
> >  	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
> > -		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
> > +		MX51_ECSPI_DMA_TX_WML(tx_wml) |
>=20
> tx_wml is never assigned any other value than 0. Drop the variable.
That's prepared for 07/13 patch which may assign spi_imx->wml to tx_wml.
>=20
> >  		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
> >  		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
> >  		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
> @@ -1171,7
> > +1174,11 @@ static int spi_imx_dma_configure(struct spi_master *master)
> >  	tx.direction =3D DMA_MEM_TO_DEV;
> >  	tx.dst_addr =3D spi_imx->base_phys + MXC_CSPITXDATA;
> >  	tx.dst_addr_width =3D buswidth;
> > -	tx.dst_maxburst =3D spi_imx->wml;
> > +	/*
> > +	 * For ERR009165 with tx_wml =3D 0 could enlarge burst size to fifo s=
ize
> > +	 * to speed up fifo filling as possible.
> > +	 */
> > +	tx.dst_maxburst =3D spi_imx->devtype_data->fifo_size;
> >  	ret =3D dmaengine_slave_config(master->dma_tx, &tx);
> >  	if (ret) {
> >  		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n",
> > ret); @@ -1265,10 +1272,6 @@ static int spi_imx_sdma_init(struct
> > device *dev, struct spi_imx_data *spi_imx,  {
> >  	int ret;
> >
> > -	/* use pio mode for i.mx6dl chip TKT238285 */
> > -	if (of_machine_is_compatible("fsl,imx6dl"))
> > -		return 0;
>=20
> So with this patch it becomes possible to do DMA on i.MX6dl, but it is
> mentioned nowhere.
That's a common IP issue but caught on i.mx6dl at that time, so this time I=
 didn't mention
i.mx6dl.
>=20
> Sascha
>=20
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe
> ngutronix.de%2F&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7Ccbabce2
> 68dfd4b0a0e2a08d7c4c62ff6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C1%7C637194227793913712&amp;sdata=3DTL%2BheiNsYVPld3qyzWjF6yQZgH2
> HLdVFxzFeK3MupTc%3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
