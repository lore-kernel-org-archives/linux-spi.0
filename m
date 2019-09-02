From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] spi: ep93xx: Repair SPI CS lookup tables
Date: Mon, 2 Sep 2019 09:18:44 +0200
Message-ID: <20190902091844.7151e0c7@jawa>
References: <20190831180402.10008-1-alexander.sverdlin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.E1ugfHjC1jx=p6Oc2PH0Ak"; protocol="application/pgp-signature"
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190831180402.10008-1-alexander.sverdlin@gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/.E1ugfHjC1jx=p6Oc2PH0Ak
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 31 Aug 2019 20:04:02 +0200
Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:

> The actual device name of the SPI controller being registered on
> EP93xx is "spi0" (as seen by gpiod_find_lookup_table()). This patch
> fixes all relevant lookup tables and the following failure (seen on
> EDB9302):
>=20
> ep93xx-spi ep93xx-spi.0: failed to register SPI master
> ep93xx-spi: probe of ep93xx-spi.0 failed with error -22
>=20
> Fixes: 1dfbf334f1236 ("spi: ep93xx: Convert to use CS GPIO
> descriptors") Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  arch/arm/mach-ep93xx/edb93xx.c       | 2 +-
>  arch/arm/mach-ep93xx/simone.c        | 2 +-
>  arch/arm/mach-ep93xx/ts72xx.c        | 4 ++--
>  arch/arm/mach-ep93xx/vision_ep9307.c | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/mach-ep93xx/edb93xx.c
> b/arch/arm/mach-ep93xx/edb93xx.c index 1f0da76a39de..7b7280c21ee0
> 100644 --- a/arch/arm/mach-ep93xx/edb93xx.c
> +++ b/arch/arm/mach-ep93xx/edb93xx.c
> @@ -103,7 +103,7 @@ static struct spi_board_info
> edb93xx_spi_board_info[] __initdata =3D { };
> =20
>  static struct gpiod_lookup_table edb93xx_spi_cs_gpio_table =3D {
> -	.dev_id =3D "ep93xx-spi.0",
> +	.dev_id =3D "spi0",
>  	.table =3D {
>  		GPIO_LOOKUP("A", 6, "cs", GPIO_ACTIVE_LOW),
>  		{ },
> diff --git a/arch/arm/mach-ep93xx/simone.c
> b/arch/arm/mach-ep93xx/simone.c index e2658e22bba1..8a53b74dc4b2
> 100644 --- a/arch/arm/mach-ep93xx/simone.c
> +++ b/arch/arm/mach-ep93xx/simone.c
> @@ -73,7 +73,7 @@ static struct spi_board_info simone_spi_devices[]
> __initdata =3D {
>   * v1.3 parts will still work, since the signal on SFRMOUT is
> automatic. */
>  static struct gpiod_lookup_table simone_spi_cs_gpio_table =3D {
> -	.dev_id =3D "ep93xx-spi.0",
> +	.dev_id =3D "spi0",
>  	.table =3D {
>  		GPIO_LOOKUP("A", 1, "cs", GPIO_ACTIVE_LOW),
>  		{ },
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c
> b/arch/arm/mach-ep93xx/ts72xx.c index 582e06e104fd..e0e1b11032f1
> 100644 --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -267,7 +267,7 @@ static struct spi_board_info bk3_spi_board_info[]
> __initdata =3D {
>   * goes through CPLD
>   */
>  static struct gpiod_lookup_table bk3_spi_cs_gpio_table =3D {
> -	.dev_id =3D "ep93xx-spi.0",
> +	.dev_id =3D "spi0",
>  	.table =3D {
>  		GPIO_LOOKUP("F", 3, "cs", GPIO_ACTIVE_LOW),
>  		{ },
> @@ -316,7 +316,7 @@ static struct spi_board_info ts72xx_spi_devices[]
> __initdata =3D { };
> =20
>  static struct gpiod_lookup_table ts72xx_spi_cs_gpio_table =3D {
> -	.dev_id =3D "ep93xx-spi.0",
> +	.dev_id =3D "spi0",
>  	.table =3D {
>  		/* DIO_17 */
>  		GPIO_LOOKUP("F", 2, "cs", GPIO_ACTIVE_LOW),
> diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c
> b/arch/arm/mach-ep93xx/vision_ep9307.c index
> a88a1d807b32..cbcba3136d74 100644 ---
> a/arch/arm/mach-ep93xx/vision_ep9307.c +++
> b/arch/arm/mach-ep93xx/vision_ep9307.c @@ -242,7 +242,7 @@ static
> struct spi_board_info vision_spi_board_info[] __initdata =3D { };
> =20
>  static struct gpiod_lookup_table vision_spi_cs_gpio_table =3D {
> -	.dev_id =3D "ep93xx-spi.0",
> +	.dev_id =3D "spi0",
>  	.table =3D {
>  		GPIO_LOOKUP_IDX("A", 6, "cs", 0, GPIO_ACTIVE_LOW),
>  		GPIO_LOOKUP_IDX("A", 7, "cs", 1, GPIO_ACTIVE_LOW),

Reviewed-by: Lukasz Majewski <lukma@denx.de>



Best regards,

Lukasz Majewski
--Sig_/.E1ugfHjC1jx=p6Oc2PH0Ak--
