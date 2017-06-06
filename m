From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] spi: mediatek: support adjust register define
Date: Tue, 6 Jun 2017 19:57:30 +0100
Message-ID: <20170606185730.mrvgvp4hynftwahx@sirena.org.uk>
References: <1496387923-31674-1-git-send-email-leilk.liu@mediatek.com>
 <1496387923-31674-3-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s5q23k2nvqkztuhz"
Cc: Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, sean.wang@mediatek.com
To: Leilk Liu <leilk.liu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496387923-31674-3-git-send-email-leilk.liu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--s5q23k2nvqkztuhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 02, 2017 at 03:18:42PM +0800, Leilk Liu wrote:

> +	/* some IC design adjust register define */
> +	bool adjust_reg;

Can we have a name that's more specific to the particular quirk please?
The current name will get confusing if some future chip also needs
slightly different register settings.

Otherwise this looks good.

--s5q23k2nvqkztuhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk2+xkACgkQJNaLcl1U
h9Cglgf/QmdHkkLNKqhxHzwztZYbtNDf6seGxLmC59VRyYAkFnKRKoCdibGw8OO5
fRJiYTQ4GL0EcfVkNzC9RE39MLzsw8ebKqLBjYurz0EfhxziOS0OxveHmJi+4clO
DVwN1WfC4h9p137fJOctKWynoA75vItaZgZuab7sWwOA2wv33TN1isAcPXGkNIOX
s7xCyMM7nhk1XGZD9epVGqhlKwJaRobDGEjaz4P6OWwIrpyVOQfv+xcDgBM4MiK7
/15uv20/hLfZXIfcgfuB/eUEV+UHSgfgI7AzZgpfyEkA+WRsn15Npds9TbEk9PTw
mVIZYMdnsQzPV0ODFCxhuNP64A9BfA==
=o7Oq
-----END PGP SIGNATURE-----

--s5q23k2nvqkztuhz--
