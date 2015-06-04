From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/11] spi: add more debug prints in s3c64xx
Date: Thu, 4 Jun 2015 10:16:35 +0100
Message-ID: <20150604091634.GY14071@sirena.org.uk>
References: <cover.1433364398.git.hramrach@gmail.com>
 <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+luzzTK7BKd/hj/D"
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <linux@arm.linux.org.uk>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Han Xu <han.xu@freescale.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marek Vasut <marex@denx.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Alison Chaiken <alison_chaiken@mentor.com>,
	Huang Shijie <b32955@freescale.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Knut Wohlrab <knut.wohlrab@de.bosch.com>,
	Bean Huo =?utf-8?B?6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<beanhuo@micron.com>, "grmoore@altera.com" <g
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--+luzzTK7BKd/hj/D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2015 at 09:26:42PM -0000, Michal Suchanek wrote:
> The SPI NOR transfers mysteriously fail so add more debug prints about
> SPI transactions.

Please try to only send patches to relevant people - the list of
recipients for this is so large that it only barely fits on a single
screen in my mail client.

Also for this patch (which just adds some trace) there isn't any clear
reason for it to be sent as part of the series at all, it doesn't help
deliver the functionality and doesn't depend on the rest of the series.

> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -18,6 +18,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>

Whatever you're doing here this indicates that there's a very big
abstraction problem going on.

> +	pr_debug("%s %s %s waiting for %ims transferring %zubytes@%iHz",
> +		 __func__, sdd->pdev ? dev_name(&sdd->pdev->dev) : NULL,
> +		 dev_name(&sdd->master->dev),
> +		 ms, xfer->len, sdd->cur_speed);

I'd say dev_dbg() but more generally this is just tracing things that
seem to be already covered by the trace points already present in the
core, the same goes for most of the rest of it.  If there's things
missing from the existing trace it seems better to add to it.

--+luzzTK7BKd/hj/D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcBdyAAoJECTWi3JdVIfQCnsH/3EO4Vu7AfB1/hgBGS5nixK1
1yBqIFZHwwyb2GWx5/Ori1jjzPy+UCFIN5F0zGlJ9yYjA6eGcwjAbHjhFAHNmjXG
EF+Kn+bCF0OBc8YN7VaJyia90lYYmvkm1fG28O+gpxV2Z3z5a2hh1DkcGrXgbahF
qVFn/4hywAEQsq7jOGod3gu8ozIO80RC8j8tbBKHikhZXsacJQlXDb4DZroo9VT/
gvU7nY1c5ZNIDjFvb6p7WWiF8laJLiBHBwYXUeukP5XqNRGsnzSwUt3pArIYFN4/
hAVyy1AHvIIh4DXoJ0vaynMS0X6YmkaCv53Dz+uK5PZrCNpsfbC50KlIoBjzkNI=
=ltZS
-----END PGP SIGNATURE-----

--+luzzTK7BKd/hj/D--
