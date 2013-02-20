From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] spi: tegra114: add spi driver
Date: Wed, 20 Feb 2013 13:34:09 +0000
Message-ID: <20130220133409.GF2726@opensource.wolfsonmicro.com>
References: <5124CEF5.3060605@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	"grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	"rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org"
	<devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5124CEF5.3060605-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 20, 2013 at 06:56:13PM +0530, Laxman Dewangan wrote:

> spi_clk = devm_clk_get(&pdev->dev, "spi");
> spi_clkm = devm_clk_get(&pdev->dev, "clmkm");
> spi_pllp = devm_clk_get(&pdev->dev, "pllp");

> and call clk_set_parent(spi_clk, spi_clkm) or clk_set_parent(spi_clk, spi_pllp).

This also seems like something that ought to be factorable out, ideally
it'd all Just Work(tm) with the clock framework but...

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJNCNAAoJELSic+t+oim9ScAP/1ZGZpOPzPHDhIlJkmGvDnwG
+EwyN9RUfuhGdLzIK9i8S0VR+TXZ84GnL8cksFehESdf1tXk9lCrRYm1z/FKcQbd
cszjaBNrT7jDiqVaPcX7gPCYN8bFYtVrfKpSsfzWkuPFw+cIXkNr3YRpsMQ1nLBG
6EjPbI50w3yXC/jPf+i64zF9Jp2tkh9TDr/CtBjQPzKCS/hC120AdkZ9Ao89AZBk
/LnW/BiOWwBPnQe2SzuaXqtykDAj7jAQg3MxwxIq47BW9+lxBrRuPgzdAx9iXKei
okks80TssvaoxnzVsmTY1EJzrv4F0XGp3qnPX8r0y/a8TCfojnIl7uQWbFTJRpJe
c1fk8njZW/B1rnrR3TKJKGa67wesY3Rgu8cCeY+B5LeusOdSW/BWy/i8iLMch5HE
CtAKKeDg7cK71PvAQh84eppOO0Le67mwrfrsjcNrGbunAO75WvAuplBsggwluut3
fbaHlco4PYf+0l3JsuXu1kBpQAYTNfgMtIZkM/6RK4P7uJuJjqrQOfBRiAD0fry9
3O4/pGitgYQgnm8GO/3eLVF7pesltHidLQnOmIbvtMAv7KW5BjQtzBUjpa1w99QZ
idaWMtZk0N8SBq1knr3Hza/9z9ibiE6i5GGsLV3K/ANLyf5T40mgelp+G5J0NjJY
X8pPI9Pb3heyicNTr0eq
=RNEx
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
