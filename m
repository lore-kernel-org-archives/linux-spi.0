From: Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: [PATCH] spi: lpspi: Add cs-gpio support
Date: Wed, 12 Dec 2018 02:12:10 +0000
Message-ID: <AM6PR04MB50167EFBFCF970403B4EF90DF3A70@AM6PR04MB5016.eurprd04.prod.outlook.com>
References: <20181204062313.28942-1-xiaoning.wang@nxp.com>
 <20181211142611.GF6686@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211142611.GF6686@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, December 11, 2018 22:26
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] spi: lpspi: Add cs-gpio support
>=20
> On Tue, Dec 04, 2018 at 06:24:59AM +0000, Clark Wang wrote:
>=20
> > Add cs-gpio feature for LPSPI. Use fsl_lpspi_prepare_message() and
> > fsl_lpspi_unprepare_message() to enable and control cs line.
> > These two functions will be only called at the beginning and the
> > ending of a message transfer.
>=20
> > Still support using the mode without cs-gpio. It depends on if
> > attribute cs-gpio has been configured in dts file.
>=20
> Why is this not using the core support for GPIO chip selects?  Note that =
you
> can't just implement chip select in the prepare and unprepare, drivers ca=
n
> toggle chip select within a message so the code should be looking at the
> individual transfers to see if cs_change is set and acting accordingly.

Ok, I will try to use the core support for GPIO chip selects.

Regards,
Clark Wang
