From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Remove explictly set bus_num and num_chipselect to
 default setting
Date: Sun, 16 Feb 2014 09:51:34 +0800
Message-ID: <20140216015134.GW4451@sirena.org.uk>
References: <1392127819.9833.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O6iH21V1A1PEFpM6"
Cc: Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392127819.9833.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--O6iH21V1A1PEFpM6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 11, 2014 at 10:10:19PM +0800, Axel Lin wrote:
> The purpose of commit 1e8a52e18cfb
> "spi: By default setup spi_masters with 1 chipselect and dynamics bus number"
> is to avoid setting default value for bus_num and num_chipselect in spi master
> drivers. So let's remove the duplicate code.

Applied, thanks.

--O6iH21V1A1PEFpM6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTABmjAAoJELSic+t+oim9DxkP/REp1ZG1Vq8vovV8uqt9gUm/
46/U5i2ajDJvllwSusZC7wje0RhrJNQCzCbD7+joe9v/RtRgFTF/wDPhsF56cXSR
WQ2ssejn/gmzdEvWG1PE6H+6m/zTBE4AN7322ti5KQvqyz/d0Kk3HfoX2uf37rtr
WY/mcTRUX/3bVT4yr1bp168OXN9pH6tMKk8g6Q/WHKfLzeyBiJ8T1UwMbhQStu1V
u4kPC9zpA1+1TZxFG5nqq1K5g3dK9aLvHl11kUmaZ7WGhSELsRMDYc+WHLJ45/5e
cagF/S+KgjPbYxA9W4dBKT+nOT7swTndh2MZf0ijJBxsgYvy6h+3Qlh/aEcm307Y
Rt+NsYwLmBNzbSd0BssXq3jkSC5axQm2qrHHYaE1eCNmiu3O//s9jHMI5P1Uf602
k6CMSH0HECPqz1Eqr09MfOTYpZjMLYiYbrf6pqUsyvoEJYy4HAJI3MN8gwi24kOj
GprsuwVjw5PZ1U08EOF2x+/4ucKCB1/7gesT0AoquUi/OIfN1OG43jNKerroJndT
E3mUu+wNoa3kVvoZnvepOm4FQ8RVeMX31yg7WUUK+ziPvHgcJosVGp8EovPvEo3f
V1SsoDs4/D2BGvkJ8lqijvgWo7QTxw9Xh1aHEAQieNY2SsSz0RBZKVqpoqvrhdtp
b/AOAts+MQKi5faWYcqN
=V2Zb
-----END PGP SIGNATURE-----

--O6iH21V1A1PEFpM6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
