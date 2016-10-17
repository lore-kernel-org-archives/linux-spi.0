From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 0/2] spi, i2c: mark device nodes only in case of successful instantiation
Date: Mon, 17 Oct 2016 22:15:27 +0300
Message-ID: <72515578-AF72-4F37-AB69-EC1930D27FF4@konsulko.com>
References: <20161017135957.20297-1-ralf@ramses-pyramidenbau.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
        Linux SPI <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Ralf Ramsauer <ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161017135957.20297-1-ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Ralf,

> On Oct 17, 2016, at 16:59 , Ralf Ramsauer =
<ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org> wrote:
>=20
> Hi,
>=20
> this one fixes initialisation of I2C/SPI nodes.  Upon failure during
> intialisation, nodes were erroneously populated and never unmarked.
>=20
> This lead to the problem that re-loaded drivers will never probe those =
devices
> again and can easily be fixed by clearing the OF_POPULATE flag when =
the node
> doesn't successfully initialise.
>=20
> For the discussion of v1, see
> https://lkml.org/lkml/2016/10/14/483
>=20
>  Ralf
>=20
> changes since v1:
>  - also fix I2C core driver
>  - keep the atomic test-and-set, as Geert suggested
>=20
> Ralf Ramsauer (2):
>  spi: mark device nodes only in case of successful instantiation
>  i2c: mark device nodes only in case of successful instantiation
>=20
> drivers/i2c/i2c-core.c | 11 ++++++++++-
> drivers/spi/spi.c      |  5 ++++-
> 2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.10.1
>=20

Thanks for catching this.

Acked-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
