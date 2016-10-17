From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: mark device nodes only in case of successful instantiation
Date: Mon, 17 Oct 2016 22:16:07 +0300
Message-ID: <7E9AA420-8A88-43DE-BB68-568E3BA5472E@konsulko.com>
References: <20161017135957.20297-1-ralf@ramses-pyramidenbau.de> <20161017135957.20297-2-ralf@ramses-pyramidenbau.de>
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
In-Reply-To: <20161017135957.20297-2-ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Ralf,

> On Oct 17, 2016, at 16:59 , Ralf Ramsauer =
<ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org> wrote:
>=20
> Instantiated SPI device nodes are marked with OF_POPULATE. This was
> introduced in bd6c164. On unloading, loaded device nodes will of =
course
> be unmarked. The problem are nodes that fail during initialisation: If =
a
> node fails, it won't be unloaded and hence not be unmarked.
>=20
> If a SPI driver module is unloaded and reloaded, it will skip nodes =
that
> failed before.
>=20
> Skip device nodes that are already populated and mark them only in =
case
> of success.
>=20
> Note that the same issue exists for I2C.
>=20
> Fixes: bd6c164 ("spi: Mark instantiated device nodes with =
OF_POPULATE")
> Signed-off-by: Ralf Ramsauer <ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org>
> ---
> drivers/spi/spi.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 5787b72..838783c 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1618,9 +1618,11 @@ static void of_register_spi_devices(struct =
spi_master *master)
> 		if (of_node_test_and_set_flag(nc, OF_POPULATED))
> 			continue;
> 		spi =3D of_register_spi_device(master, nc);
> -		if (IS_ERR(spi))
> +		if (IS_ERR(spi)) {
> 			dev_warn(&master->dev, "Failed to create SPI =
device for %s\n",
> 				nc->full_name);
> +			of_node_clear_flag(nc, OF_POPULATED);
> +		}
> 	}
> }
> #else
> @@ -3131,6 +3133,7 @@ static int of_spi_notify(struct notifier_block =
*nb, unsigned long action,
> 		if (IS_ERR(spi)) {
> 			pr_err("%s: failed to create for '%s'\n",
> 					__func__, rd->dn->full_name);
> +			of_node_clear_flag(rd->dn, OF_POPULATED);
> 			return notifier_from_errno(PTR_ERR(spi));
> 		}
> 		break;
> --=20
> 2.10.1
>=20

Thanks for this.

Acked-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
