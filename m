From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] spi: mediatek: add power control when set_cs
Date: Thu, 24 Oct 2019 11:23:46 +0100
Message-ID: <20191024102346.GB5207@sirena.co.uk>
References: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
 <1571834322-1121-2-git-send-email-luhua.xu@mediatek.com>
 <20191023151121.GC5723@sirena.co.uk>
 <1571898319.4311.3.camel@mbjsdccf07>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
To: luhua xu <luhua.xu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1571898319.4311.3.camel@mbjsdccf07>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 02:25:19PM +0800, luhua xu wrote:

> Spi framework provideds  spi_setup() to modify spi settings for spi
> device (maybe spi is runtime idle now), and this will call
> spi_controller->set_cs() accessing registers.

OK, so fix that so it takes the power at the setup() level then.

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2xe7EACgkQJNaLcl1U
h9BupAf/enXFS1bm5HhfceiQntahs4gT3FPXaEDsQ+rJ2S90V4JwcUbi1oSpDvWj
w2OeywscDvkZdcEaQtre4ZASwvSefR01VajXmtigEOPry80kECDHAKGiSKVXBSJ/
9V9Qf/dFBi0ej5+/Nw+3wEGXN75TgQ472XrOoHykyWerqXI4qjnUWyCXTQXO7Asn
hzr9BF9bL/1BGCUG+eK86VPC7sG9bCaQL8pvn3VFHiTgiSfCdMlIIK24LfAMjS7x
/NfY0ARLNoF1MvvTbBHHGHbG1d1pp+FeqEo+Yj+5CgIvo390+KgCjSqhzTv+PQ4Z
RglXSQMhEAM9OExTQLMO86LCuoiC+Q==
=Qdg5
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
