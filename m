From: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH] spi: dt-bindings: spi-controller: Fix #address-cells for
 slave mode
Date: Thu, 27 Feb 2020 14:09:37 +0100
Message-ID: <20200227130937.qvrjyxcwim7rfum7@gilmour.lan>
References: <20200227130323.15327-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f3mww5ct3acllifh"
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Linux-renesas <linux-renesas-soc@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200227130323.15327-1-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--f3mww5ct3acllifh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On Thu, Feb 27, 2020 at 02:03:23PM +0100, Geert Uytterhoeven wrote:
> Currently, the DT bindings for an SPI controller specify that
> "#address-cells" must be fixed to one.  However, that applies to an SPI
> controller in master mode only.  When running in SPI slave mode,
> "#address-cells" should be zero.
>
> Fix this making the value of "#address-cells" dependent on the presence
> of "spi-slave".
>
> Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Is this the right way to specify this?  I couldn't find an example, so
> this needed some trial-and-error.
>
> As of dtc commit 403cc79f06a135ae ("checks: Update SPI bus check for
> 'spi-slave'") and Linux commit c2e7075ca8303631 ("scripts/dtc: Update to
> upstream version v1.4.7-57-gf267e674d145"), dtc knows about SPI slave.
>
> However, when using "#address-cells = <0>" with W=1:
>
>     Warning (avoid_unnecessary_addr_size): /soc/spi@e6e10000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>
> Just removing #address-cells (using /delete-property/ in the board DTS)
> to fix this warning causes:
>
>     Warning (spi_bus_bridge): /soc/spi@e6e10000: incorrect #address-cells for SPI bus
>
> as spi_bus_bridge() uses node_addr_cells(), which defaults to 2 (due to
> dtc's ppc64 heritage? But node_size_cells() defaults to 1, not 2?).
>
> How should this be fixed?
> Should "#address-cells = <0>" be left out or not?
> Should node_{addr,size}_cells() in dtc default to zero?
>
> Thanks!
> ---
>  .../devicetree/bindings/spi/spi-controller.yaml   | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 1e0ca6ccf64bbd0a..ba2646258b94980e 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -20,7 +20,8 @@ properties:
>      pattern: "^spi(@.*|-[0-9a-f])*$"
>
>    "#address-cells":
> -    const: 1
> +    minimum: 0
> +    maximum: 1

Nit: This would be better described as an enum: [0, 1]

>    "#size-cells":
>      const: 0
> @@ -52,6 +53,18 @@ properties:
>      description:
>        The SPI controller acts as a slave, instead of a master.
>
> +if:
> +  required:
> +    [ spi-slave ]

Nit: Usually, that notation is when you would do it on the same line,
if you want to go to a new line, it would make more sense to use -

Maxime

--f3mww5ct3acllifh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXle/kQAKCRDj7w1vZxhR
xa6LAQDPD0Wfg60jxmxXfYCq+tNY5iv4eAFrR9urmk8cbC+RHQEApi8ZLG+vDjzq
xNsvRO1hEXfievcydp8EPO25yCjeGQA=
=2Dh4
-----END PGP SIGNATURE-----

--f3mww5ct3acllifh--
