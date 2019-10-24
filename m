From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] spi: mediatek: add power control when set_cs
Date: Thu, 24 Oct 2019 12:19:20 +0100
Message-ID: <20191024111920.GE5207@sirena.co.uk>
References: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
 <1571834322-1121-2-git-send-email-luhua.xu@mediatek.com>
 <20191023151121.GC5723@sirena.co.uk>
 <1571898319.4311.3.camel@mbjsdccf07>
 <1571911880.4955.11.camel@mbjsdccf07>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
To: luhua xu <luhua.xu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1571911880.4955.11.camel@mbjsdccf07>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 06:11:20PM +0800, luhua xu wrote:

>       (3)Enable spi clk  in  controller->set_cs  callback,  such as
> spi-geni-qcom.c.   =20
>       My patch works the same as (3).For mtk platform, without this
> patch, if user do spi_setup(), cs setting cannot take effect, and reg
> access violation occurs.

Other drivers having problems isn't a good reason to introduce more
drivers with problems.

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2xiLgACgkQJNaLcl1U
h9A/Kwf+IpDhddKQiCGZu0Oyc2g59QHLKn2G271BZAq1tw3Rnnj/s4VqQkyLn/SJ
Spw/eC2ufhZI8/CblwrL5cwx6flAbfOi1EdLDdA26qGeWwso/Qxu2odY24OvV/8M
MZaXuDfYonJssSVXw1ri90G4mkXtMzzVxb4UoA5ssi3UF2JkZWcZ4ePaK3buteIf
lwvnDj4gNJYKDnZcz/wpTbrZoKWTAn2IjthZh2AlDFPCSZx/I0wJ2yU7rWYzS84H
rMbflX/QGmgPTfTtep+TIy2xTqLYGS/7Up7n0F0SLcOdDXCpK+Jo4lNJoeB75Q7Y
zHXfh3e//9ZULctc7j/NvX/TUeanyQ==
=vrlq
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
