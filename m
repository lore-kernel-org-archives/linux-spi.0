From: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: spi: sunxi: Document new compatible
 strings
Date: Thu, 16 Jan 2020 15:23:01 +0100
Message-ID: <20200116142301.w2t4o6pg3dapp3g6@gilmour.lan>
References: <20200116005654.27672-1-andre.przywara@arm.com>
 <20200116005654.27672-4-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dtp4obhou6ga2i2o"
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200116005654.27672-4-andre.przywara-5wv7dgnIgG8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dtp4obhou6ga2i2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jan 16, 2020 at 12:56:54AM +0000, Andre Przywara wrote:
> The Allwinner H6 SPI controller has advanced features over the H3
> version, but remains compatible with it.
> Document the usual "specific", "fallback" compatible string pair.
> Also add the R40 version while at it.
>
> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml     | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> index f36c46d236d7..c19dfbe42d90 100644
> --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> @@ -18,9 +18,15 @@ properties:
>    "#size-cells": true
>
>    compatible:
> -    enum:
> -      - allwinner,sun6i-a31-spi
> -      - allwinner,sun8i-h3-spi
> +    oneOf:
> +      - const: allwinner,sun6i-a31-spi
> +      - const: allwinner,sun8i-h3-spi
> +      - items:
> +          - const: allwinner,sun8i-r40-spi
> +          - const: allwinner,sun8i-h3-spi
> +      - items:
> +          - const: allwinner,sun50i-h6-spi
> +          - const: allwinner,sun8i-h3-spi

Having

oneOf:
  - const: allwinner,sun6i-a31-spi
  - const: allwinner,sun8i-h3-spi
  - items:
    - enum:
      - allwinner,sun8i-r40-spi
      - allwinner,sun50i-h6-spi
    - const: allwinner,sun8i-h3-spi

Will be easier to maintain in the long run

Maxime

--dtp4obhou6ga2i2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiBxxQAKCRDj7w1vZxhR
xRUZAQDisZVXdmeqha8atHLsAl78/m8TbSfhS0431utHf0z35AEArNAvTTDGJZT3
fIwJSFWfYpI4H2JuT4OzXW9UJtlNUQ0=
=tA6x
-----END PGP SIGNATURE-----

--dtp4obhou6ga2i2o--
