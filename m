From: Robin Gong <yibin.gong@nxp.com>
Subject: RE: [RESEND v6  09/13] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Date: Tue, 10 Mar 2020 09:35:40 +0000
Message-ID: <VE1PR04MB66388CC09E1D3AD956AF94CC89FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-10-git-send-email-yibin.gong@nxp.com>
 <20200310081925.GT3335@pengutronix.de>
 <VE1PR04MB6638029458AFDE3005C6E4A489FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200310092803.GW3335@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.or
To: Sascha Hauer <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310092803.GW3335@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2020/03/10 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Mar 10, 2020 at 08:59:03AM +0000, Robin Gong wrote:
> > On 2020/03/10 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > On Tue, Mar 10, 2020 at 07:31:58PM +0800, Robin Gong wrote:
> > > > ECSPI issue fixed from i.mx6ul at hardware level, no need
> > > > ERR009165 anymore on those chips such as i.mx8mq. Add i.mx6sx from
> > > > where i.mx6ul source.
> > > >
> > > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > > Acked-by: Vinod Koul <vkoul@kernel.org>
> > > > ---
> > > >  drivers/dma/imx-sdma.c | 51
> > > > +++++++++++++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 50 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> > > > 56288d8..5ae7237 100644
> > > > --- a/drivers/dma/imx-sdma.c
> > > > +++ b/drivers/dma/imx-sdma.c
> > > > @@ -419,6 +419,13 @@ struct sdma_driver_data {
> > > >  	int num_events;
> > > >  	struct sdma_script_start_addrs	*script_addrs;
> > > >  	bool check_ratio;
> > > > +	/*
> > > > +	 * ecspi ERR009165 fixed should be done in sdma script
> > > > +	 * and it has been fixed in soc from i.mx6ul.
> > > > +	 * please get more information from the below link:
> > > > +	 *
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw=
w
> > > w.nx
> p.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D02%7C01%7Cyi
> > >
> bin.gong%40nxp.com%7C91d42046e6894501d48508d7c4cbcae2%7C686ea1d3
> > >
> bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637194251876090170&amp;sdata=3D
> > > T6LA4xz9CUFlNpnyjHSThEQb8i1rhbY9e1nUyxIGD5Q%3D&amp;reserved=3D0
> > > > +	 */
> > > > +	bool ecspi_fixed;
> > > >  };
> > > >
> > > >  struct sdma_engine {
> > > > @@ -539,6 +546,31 @@ static struct sdma_driver_data sdma_imx6q =3D =
{
> > > >  	.script_addrs =3D &sdma_script_imx6q,  };
> > > >
> > > > +static struct sdma_script_start_addrs sdma_script_imx6sx =3D {
> > > > +	.ap_2_ap_addr =3D 642,
> > > > +	.uart_2_mcu_addr =3D 817,
> > > > +	.mcu_2_app_addr =3D 747,
> > > > +	.uartsh_2_mcu_addr =3D 1032,
> > > > +	.mcu_2_shp_addr =3D 960,
> > > > +	.app_2_mcu_addr =3D 683,
> > > > +	.shp_2_mcu_addr =3D 891,
> > > > +	.spdif_2_mcu_addr =3D 1100,
> > > > +	.mcu_2_spdif_addr =3D 1134,
> > > > +};
> > > > +
> > > > +static struct sdma_driver_data sdma_imx6sx =3D {
> > > > +	.chnenbl0 =3D SDMA_CHNENBL0_IMX35,
> > > > +	.num_events =3D 48,
> > > > +	.script_addrs =3D &sdma_script_imx6sx, };
> > > > +
> > > > +static struct sdma_driver_data sdma_imx6ul =3D {
> > > > +	.chnenbl0 =3D SDMA_CHNENBL0_IMX35,
> > > > +	.num_events =3D 48,
> > > > +	.script_addrs =3D &sdma_script_imx6sx,
> > > > +	.ecspi_fixed =3D true,
> > > > +};
> > > > +
> > > >  static struct sdma_script_start_addrs sdma_script_imx7d =3D {
> > > >  	.ap_2_ap_addr =3D 644,
> > > >  	.uart_2_mcu_addr =3D 819,
> > > > @@ -584,9 +616,15 @@ static const struct platform_device_id
> > > sdma_devtypes[] =3D {
> > > >  		.name =3D "imx6q-sdma",
> > > >  		.driver_data =3D (unsigned long)&sdma_imx6q,
> > > >  	}, {
> > > > +		.name =3D "imx6sx-sdma",
> > > > +		.driver_data =3D (unsigned long)&sdma_imx6sx,
> > > > +	}, {
> > >
> > > Now the i.MX6sx uses a new sdma_script_start_addrs entry which is
> > > the same as the i.MX6q one we used before with one exception: it
> > > lacks the per_2_per_addr =3D 6331 entry. This is only used for
> > > IMX_DMATYPE_ASRC and
> > Totally same script for i.mx6 chips whatever i.MX6sx, i.MX6q or i.MX6ul=
.
>=20
> When it's the same then use it.
>=20
> > > IMX_DMATYPE_ASRC_SP, both are entirely unused in the mainline
> > > kernel. So why must the i.MX6sx changed here and what has this to do =
with
> ECSPI?
> > i.MX6ul is based on i.MX6sx, so adding i.MX6sx could keep good shape on=
 our
> i.MX family evolution.
>=20
> My point is that there is no difference between i.MX6q and i.MX6sx here, =
so do
> not artificially introduce i.MX6sx support when all you do is copying the=
 i.MX6q
> support.
Okay, will remove i.MX6sx now.
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe
> ngutronix.de%2F&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7C02af95d
> 81bf745b7b2cc08d7c4d55ed2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C637194293001547060&amp;sdata=3DcN13LuC6Bgs1m9W6oKc2q03j5rf
> KvsMbonpd1JALA%2Fk%3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
