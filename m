From: Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: [PATCH] spi: lpspi: Fix CLK pin becomes low before one transfer
Date: Wed, 12 Dec 2018 02:10:46 +0000
Message-ID: <AM6PR04MB5016E6D2220CDD266B2C6C01F3A70@AM6PR04MB5016.eurprd04.prod.outlook.com>
References: <20181204062224.28844-1-xiaoning.wang@nxp.com>
 <20181211143005.GJ6686@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211143005.GJ6686@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

These five patches are based on patch series spi: lpspi: Add Slave Mode sup=
port for LPSPI. For the patch series make a big change, should I hold these=
 five patches until the patch series are applied in your git branch?

Thanks for your patience.

Regards,
Clark Wang

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, December 11, 2018 22:30
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] spi: lpspi: Fix CLK pin becomes low before one trans=
fer
>=20
> On Tue, Dec 04, 2018 at 06:23:19AM +0000, Clark Wang wrote:
> > Remove Reset operation in fsl_lpspi_config(). This RST may cause both
> > CLK and CS pins go from high to low level under cs-gpio mode.
> > Add fsl_lpspi_reset() function after one message transfer to clear all
> > flags in use.
>=20
> This doesn't apply against current code, please check and resend.
