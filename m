From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH -next] spi: tegra: slink: make symbol static
Date: Fri, 5 Apr 2013 09:58:36 +0200
Message-ID: <20130405075836.GD15848@avionic-0098.mockup.avionic-design.de>
References: <CAPgLHd_oC4z6YbswNOo-bpObgH7v420DupSgx_pmmB6B29HjEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5654631670524180938=="
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
 rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
 linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAPgLHd_oC4z6YbswNOo-bpObgH7v420DupSgx_pmmB6B29HjEg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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


--===============5654631670524180938==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2013 at 03:45:12PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> symbol '' was not declared. It should be static.

This description doesn't make any sense. The patch looks good, though.
Maybe something like:

---snip---

Neither tegra20_spi_cdata nor tegra30_spi_cdata are used outside this
file so they can, and should, be static.

---snip---

Is more accurate?

Thierry

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRXoQsAAoJEN0jrNd/PrOhER0QAJkYB2WsFrIli4wdQo9wiTjW
6cwQJOYDkqODevzy5bvvBeMO0l38us55tp7tJvPGkaiVFtG+6I8zG5/OcvDyLXwh
lAfPdjghAn0OZHc33A3/fUjh1927UnK8W1fF0PC481JqLOSpChnOJnViPgvd2D0J
WkZ98w26cxCXUyFKujRb6ZE2+s+EBV9TkVeS/y6hHRw++GhYTBMSFfMRKy6LVR7r
yHbyrhzcu5Ibr9Tg6hP/5VwFLS4dJ81jKSJGKey+UO6pCQpYWNpZEnKqCHUTpNL+
VCeuMmMEVNlwa3ok8hq7ZBGij0GdF9QT2GuSR5QfwjfBGzc1OX4WS6Uq81H/FBdo
J53GRLNimBF3UOSe3SWir8LOBR/+xBsZDJS0mXYrr59dVpfl0VUg0EjSUF9zszfj
lcfhhw7Sx468sIl3G8lAfyssP54127XKxs57sk3MZNm2DCTrOcHqtLtg+X/mgaGU
SaBrUHNUlob0mIM+ztHMY7CYVcyApsVLBfjZ3NvW0veVfFGwffoPqYe1SZfiIitd
BmBql4CYbIHwPCVn8S5M+36jnsHxByEQTqIKYLl8+BDP08fPi2G8CUDsG8NqPHie
1XVrChf6QhADth8V5VERq7Qhiz6TiUNinlw9lVIZst1O82kCT5HTppWp0rR+x54v
MnflIXxm8mORj7pmyCT0
=krGu
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--

--===============5654631670524180938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5654631670524180938==--
