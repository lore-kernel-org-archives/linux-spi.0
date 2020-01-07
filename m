From: Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: RE: [EXT] [PATCH] spi: nxp-fspi: Ensure width is respected in spi-mem
 operations
Date: Tue, 7 Jan 2020 05:39:33 +0000
Message-ID: <AM0PR0402MB3556E16D1027FB5D6C3FDC88E03F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
References: <20191211195730.26794-1-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>
To: Michael Walle <michael@walle.cc>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211195730.26794-1-michael@walle.cc>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Michael Walle
> Sent: Thursday, December 12, 2019 1:28 AM
> To: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>; Ashish Kumar
> <ashish.kumar@nxp.com>; Mark Brown <broonie@kernel.org>; Michael
> Walle <michael@walle.cc>
> Subject: [EXT] [PATCH] spi: nxp-fspi: Ensure width is respected in spi-me=
m
> operations
>=20
> Caution: EXT Email
>=20
> Make use of a core helper to ensure the desired width is respected when
> calling spi-mem operators.
>=20
> Otherwise only the SPI controller will be matched with the flash chip, wh=
ich
> might lead to wrong widths. Also consider the width specified by the user=
 in
> the device tree.

Could you please mention the flash and modes you tested. Does it support DU=
AL/QUAD mode?
I couldn't test these modes as NXP LS1028ARDB has "mt35xu02g" which support=
s SINGLE and OCTAL modes only.

Thanks
Kuldeep

>=20
> Fixes: a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller=
")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/spi/spi-nxp-fspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c inde=
x
> c36bb1bb464e..8c5084a3a617 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -439,7 +439,7 @@ static bool nxp_fspi_supports_op(struct spi_mem
> *mem,
>             op->data.nbytes > f->devtype_data->txfifo)
>                 return false;
>=20
> -       return true;
> +       return spi_mem_default_supports_op(mem, op);
>  }
>=20
>  /* Instead of busy looping invoke readl_poll_timeout functionality. */
> --
> 2.20.1
