From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH -next v2] spi: tegra: slink: make local symbols static
Date: Mon, 8 Apr 2013 13:41:21 +0100
Message-ID: <20130408124120.GJ9243@opensource.wolfsonmicro.com>
References: <CAPgLHd-sTt5eKoiLb13dWHipT6Q46qCbG=b9mCYNq=Q7YLmGVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4054153253478420280=="
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
 yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAPgLHd-sTt5eKoiLb13dWHipT6Q46qCbG=b9mCYNq=Q7YLmGVA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--===============4054153253478420280==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mZBmBd1ZkdwT1ny"
Content-Disposition: inline


--5mZBmBd1ZkdwT1ny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2013 at 09:45:36PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Neither tegra20_spi_cdata nor tegra30_spi_cdata are used outside this
> file so they can, and should, be static.

Applied, thanks.

--5mZBmBd1ZkdwT1ny
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRYrrnAAoJELSic+t+oim9tTEP/3RYhLvSavrpTxzdG56MBFPU
DgCvfahkXQJko7Hb5gdZJoAkFQuC96/is+rI6xO3lzb4rOsVnE6EL+4agy6mh1TV
b5Yg5k7PoY2yFg+iM1oBo8vXfIBw5+0VD4Rz7WWQXlRZS+CRRgR+naRlikeenx/E
ZyNnU+vJnvnlmRVbRtqKLQ4Tvwp2/rDR0wg57lOImTOOWZ4YPKSRwzwezgi8BeLQ
WAKIinGDVdzC1D09nBMGU1LXNYJ94QW4gHlW7HgKCJ5CA6iF+27Znokn8IVYSCrT
sdGAEAUZvpNI7RRO6PcwbCrTL5aig0RnV/wTgaa7vLRzhN01K156VqunbGKNHfm1
/fgUE7LyDNHOiScVx4x9IKbhqZQcdXX/fLmsObFhokXi0i1rD0NXmrw7dGBOZv5u
IvcZcbTIGZ/kkLiuKMsG4AVeSKjbgqqGB+Ped5W238YqTHviQ4cfHbhWLQ8EjUxu
Z02oWTaSwso6ErtRLFsUqxPaoM9f70/tkCFJUU1kj7DJFmDZEINqguh5WThS8kpP
VwnADHOp3FcHbN0JWyhWKIu3MtmFGMjrqzPYkmYQu02Q9WVolG3eeJGzxxphnwBS
3/C2qofeNMMN9lg/TT6qw4kgC4+GA8e4H/n9rg7TMJg6pH3VP/Sdtxl8PsEDpHkQ
lw1y7kLbPj/EoJ45yV9F
=pNwo
-----END PGP SIGNATURE-----

--5mZBmBd1ZkdwT1ny--

--===============4054153253478420280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4054153253478420280==--
