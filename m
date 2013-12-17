From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/11] spi: bcm2835: Use devm_request_irq()
Date: Tue, 17 Dec 2013 22:59:00 +0000
Message-ID: <20131217225900.GX28455@sirena.org.uk>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
 <001701cef4c8$eaa87c30$bff97490$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5860PwWXAiuGjz3C"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Chris Boot' <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
	'Stephen Warren' <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	'Laurent Navet' <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <001701cef4c8$eaa87c30$bff97490$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5860PwWXAiuGjz3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 09, 2013 at 07:25:00PM +0900, Jingoo Han wrote:
> Use devm_request_irq() to make cleanup paths simpler.

Applied, thanks.

--5860PwWXAiuGjz3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsNcxAAoJELSic+t+oim9WUwP/3CREfqSdiZrZn9pbqARvEVH
IuRlHHwZtmIBwomDka+JMaV2RMUrKGc8O2UWyCHyP3voXwjMR2jDpoMBmCoHb8sy
54TfhMMYfT9qm/Si1wI7O1qByCMJJ2fkymI07Ydlgnt78xgj3wXTiok68i1OD/xg
c5imyhUA/KpcTjWGQWIm7JbnbvpZcQsBBGrHQxNPBBAO+hKUi4Kuy2vXaotOznbs
qGt8ZxweRKC76ZzNFZWpFs3jgDWxHshJooM/4rk1sn651ShnIEGLBBk3sozjADIm
yqoXogG8NywyBCht8gq0vabQtHLtlHqw6e8ADME7h7FvlVUti1wisNuIY67mEfbM
Ov68N6PlKNXL2xnhYWzYU1Vp8rcLB6Xs+xSH2Wro78YrFU3vw2e1CYMJTLM1zWhq
3AMf/vAwcv1O4MhyvM9199iDmAemT7SmW0gACEtW7NwNE0Yb97VC5D6qlKfwYZBR
5nO5VfPhiQmYMxoD0iEZsBX8pAbNYciov4D6phEyoW5OqgKUsFLvBRPARajEmZwT
5yVRHIZwUTIExyUX8tef84GDMbUjFShWKAy0POB9AJeNl+zIUaPvG88q0ZxYt+x0
QOD+ljTBTgXd/7+ZGDma0ltStjW/O/InQNxrRQEWYWmalClR8uSWCbXZZFvocaAz
opznAYfOfoFfwVmQIvAf
=Hnnn
-----END PGP SIGNATURE-----

--5860PwWXAiuGjz3C--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
