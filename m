From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: atmel: Refactor spi-atmel to use SPI framework
 queue
Date: Thu, 9 Jan 2014 17:42:03 +0000
Message-ID: <20140109174203.GJ12858@sirena.org.uk>
References: <1389244755-16188-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5me2qT3T17SWzdxI"
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389244755-16188-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 01:19:15PM +0800, Wenyou Yang wrote:
> Replace the deprecated master->transfer with transfer_one_message()
> and allow the SPI subsystem handle all the queuing of messages.

Applied, thanks.

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzt9oAAoJELSic+t+oim90DQP/RH6oIIOxqSRxPBljD+ZHyFN
xMhJm5zf8HloQnMOPpV1g9ezBxYwXgjfiAzVVJ2Po/hc0wMf1HWXDru8Qzl1mc8T
UYCOWa5WKliYSw0eoypiYB5/cYaAq8TXh3wbeQZmFBY9MQxvHLH/Xs2UL0CG+Cba
IjdtAwktdpbFh0t+2YkHM8lMbQv16iqo2ZdZ2GA+hWGSbN2YL5AR/QoNJ0v+Ni54
fuxktzjIHXLy5v6gpgAzEqs7h9ZQLE741idzmFefHneWrJ/19/WBczRur32KumEC
BwPFVA8eVPzvXSEzTvy8H0n1qHJW4GEb/bFjoBupMPk2nTTvLdf43OXXI/9vC4Fs
dLcEawghUfsGkiZfYshaqHV6jUs5AseaBn3azv0AVIhC1FHVikIT9Y3+wwWgqlnC
dINPLmgnNi7UliJtaURkJO+I4GxPU4btx26T5zLGwsEc4Q2alyUYf3gmfPuSYPMR
azoMhqs/w8hFUWBWYL1zuWeWkE9fifH634pqbgFJK2I5JfCpW52r6CTEo4EKzDHD
7Ssjf4qkUrg0jfyXhqClScbIW5spjg2OAhBlwS+pyWvau5dDEK/7qpFtw9ls8ADB
TreFYOJsqQNMm29r46hlbarGSzvs/P9Ybp2r3rMPR/XJGch/jYdqU1G+EOocC69I
iByVhLPnzonpGJgTBJLF
=5I5s
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
