From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm63xx: fix reference leak to master in
 bcm63xx_spi_remove()
Date: Fri, 15 Nov 2013 10:33:02 +0000
Message-ID: <20131115103302.GB26614@sirena.org.uk>
References: <CAPgLHd_ha6AbaSkTFHH1cRdqk_z7PNpDwr=ibJ-vUoTprg6WzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HSVPcR81XVhxeM7P"
Cc: jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd_ha6AbaSkTFHH1cRdqk_z7PNpDwr=ibJ-vUoTprg6WzA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HSVPcR81XVhxeM7P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 03:50:59PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Once a spi_master_get() call succeeds, we need an additional
> spi_master_put() call to free the memory, otherwise we will
> leak a reference to master. Fix by removing the unnecessary
> spi_master_get() call.

Applied, thanks.

--HSVPcR81XVhxeM7P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShfhbAAoJELSic+t+oim9P0IP/jbLDlj/ikxgZQTN8svW8wNq
Eet3sc5y5GkgpSbJmtSMVWHAKrxEKa71zWboEuDnonM2AWaTAeaXQPPfO2iaVNUz
nKTF7iGh1+rfQhPF+Yw0OajQ563WcWI2EQA/toUNdfHT7lWLEgwzwRidwZvkLhyj
yXmthiqaK6wGND9MpG5FxOzQOGLWdmZI1l5dMHiu22mhm5lzPxKY+biVZr6jF3JG
LnKb4cg4+dF49QwlQk1RadppRj/x+0GEU6RzXWGFTJ547ceOZFytkBtfgCNS4cZ2
rHct15D1+u1FMW7Bf1PLNnpQyqr7lRC+5aMIhagZGKm1C/xXsHAULJOGize13kr6
ZacYaSszTFspOgr7K0h3OEYYol8z9qAOGHFWX6dNImjgUYmfpG67yilYr+8FwR0S
ZtXdOAPRM/WdvkPKTbOTUqqSBZtWIywJoZVgHQKm4prtrLYJWCieOpkcPlOuUCOi
KPqLCz88aySMHY/oS2MpIJ/srGHN17GQ0cPVqbIdF1xvVBx4xCLlteDsN1WRdSL/
S5VFZ1D3Onhteay+e2bDh7CqYxXzTTIXOpEf0oBiKbUsu3NEmkzleerUGhF6fNma
4DZesNaqtbb7ZEFQs8Aplo3eJaBcmK3kNmi+/b4M3cCDsZkq7+ksmx5yIncpDFbh
KUETCMKrCQAUSDaQ64+C
=xGXy
-----END PGP SIGNATURE-----

--HSVPcR81XVhxeM7P--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
