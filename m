From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: bitbang: Make setup_transfer() callback optional
Date: Sat, 18 Apr 2015 12:00:55 +0100
Message-ID: <20150418110055.GC26185@sirena.org.uk>
References: <1428919685-14190-1-git-send-email-per.nilsson@xelmo.com>
 <1429018817-18117-1-git-send-email-per.nilsson@xelmo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Cc: ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
To: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429018817-18117-1-git-send-email-per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2015 at 03:40:17PM +0200, Pelle Nilsson wrote:
> Some controller drivers have no need of this callback (spi-altera even
> causes a NULL pointer dereference because it doesn't register the callback,
> falsely assuming that it is already optional).

I've applied this but really for something like this the commit message
should be explaining *why* it's reasonable for the callback to be
omitted.

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMjlmAAoJECTWi3JdVIfQ50IH/2MouOJWjYXgUv0V0IRIWeM9
I9CoE2XqrpCHIZItf5L22/aorm7y6pMPacixej7b9rl+ktsIJlSZTVUWQ2sMdzGN
xdrf2lF84wHVuLtYUSVnkACEhpTmCIV7hLqDcK8i9FaIaE3kwguN2cbSLUVKPzXz
MN9nJQ1ndduqMqR8B7ILniLwDVT420NYGbP73f0DgCQjn2qBBAkc/CBPuu+dKZLS
rjNWlxGx8aU9tr62E69A/JXmL4Gw3jASAVcVXzHQEiyH7snL7C3iklBwGAgaO6Wz
JXNlXABLBhk3CrTR0tRcbIiPCky8hLi7xk6etDXR4GX8dN2v6Ubt/7vy+nBLAuY=
=21Ex
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
