From: Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: [PATCH] spi: lpspi: enable runtime pm for lpspi
Date: Wed, 12 Dec 2018 02:15:52 +0000
Message-ID: <AM6PR04MB5016DBDB10579AF52B4C6A0CF3A70@AM6PR04MB5016.eurprd04.prod.outlook.com>
References: <20181204061904.28567-1-xiaoning.wang@nxp.com>
 <20181211142817.GH6686@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211142817.GH6686@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, December 11, 2018 22:28
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] spi: lpspi: enable runtime pm for lpspi
>=20
> On Tue, Dec 04, 2018 at 06:19:48AM +0000, Clark Wang wrote:
> > 	From: Han Xu <han.xu@nxp.com>
> >
> > 	Enable the runtime power management for lpspi module.
> >
> > Signed-off-by: Han Xu <han.xu@nxp.com>
> > Reviewed-by: Frank Li <frank.li@nxp.com>
> > ---
>=20
> There's no signed-off-by from you here?  These are required, please see
> submitting-patches.rst.

Oh, there should have my signed-off-by here. For the big changes with 4.9 i=
n our git branch, I did some adaptation work.

Regards,
Clark Wang
