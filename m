From: Robin Gong <yibin.gong@nxp.com>
Subject: RE: [RESEND v6  06/13] spi: imx: fix ERR009165
Date: Tue, 10 Mar 2020 09:02:08 +0000
Message-ID: <VE1PR04MB6638B911F4767D238B16279289FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-7-git-send-email-yibin.gong@nxp.com>
 <20200310073920.GR3335@pengutronix.de>
 <VE1PR04MB66384DA6732A840FE1D80C1989FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200310083725.sb6cufp5wznvxcji@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vg
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310083725.sb6cufp5wznvxcji@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2020/03/10 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> Hello,
>=20
> On Tue, Mar 10, 2020 at 08:27:41AM +0000, Robin Gong wrote:
> > On 2020/03/10 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > On Tue, Mar 10, 2020 at 07:31:55PM +0800, Robin Gong wrote:
> > > >  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
> > > >
> > > > @@ -612,12 +613,14 @@ static int mx51_ecspi_prepare_transfer(struct
> > > > spi_imx_data *spi_imx,
> > > >
> > > >  static void mx51_setup_wml(struct spi_imx_data *spi_imx)  {
> > > > +	u32 tx_wml =3D 0;
> > > > +
> > > >  	/*
> > > >  	 * Configure the DMA register: setup the watermark
> > > >  	 * and enable DMA request.
> > > >  	 */
> > > >  	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
> > > > -		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
> > > > +		MX51_ECSPI_DMA_TX_WML(tx_wml) |
> > >
> > > tx_wml is never assigned any other value than 0. Drop the variable.
> > That's prepared for 07/13 patch which may assign spi_imx->wml to tx_wml=
.
>=20
> Then this belongs into patch 7, right?
Okay, understood your concern. Then I'll drop tx_wml to make it clear.
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.p
> engutronix.de%2F&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7Cca6f14
> 28f4224fa79f1d08d7c4ce4a41%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C637194262606339591&amp;sdata=3DkI9HAyC%2FG3qmrIrLmfUDJ7dac
> %2FOEDBtDm4oeRyak1xE%3D&amp;reserved=3D0 |
