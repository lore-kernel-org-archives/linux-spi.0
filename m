From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] [RFC] spi: rspi: Handle dmaengine_prep_slave_sg()
 failures gracefully
Date: Wed, 16 Jul 2014 22:42:13 +0100
Message-ID: <20140716214213.GF17528@sirena.org.uk>
References: <1404901583-31366-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLk8PSyqxe/ugcCT"
Cc: Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404901583-31366-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SLk8PSyqxe/ugcCT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2014 at 12:26:22PM +0200, Geert Uytterhoeven wrote:
> As typically a shmobile SoC has less DMA channels than devices that can use
> DMA, we may want to prioritize access to the DMA channels in the future.
> This means that dmaengine_prep_slave_sg() may start failing arbitrarily.

Applied both, thanks.

--SLk8PSyqxe/ugcCT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxvGxAAoJELSic+t+oim9DZMP/i41BIxVk9RwhD/ULKBWMMfw
DV7iaMyC6L5HPjFMbhe+IrZ1tPCqQdYH+cw/RB875cRSyAni23OLCLfaugm80JKz
oqI72LVufZjuAwuo8etj5xPNrDe3aCJtpRTJ4W6BSS/CLOYEBmATzCZbJwYmfy8q
Avmx/4JPbvYtcoaVfAw8fcYR8PDWJyzV0VwLM9FBEaHtAxMzGXBCcN7bO3C6cQyU
tWkr/wTvLLpPPx/xHlpfYupAwZ/3Pl+sshkQaK5x4BlzcwqOYOFk7x5qbopY41sz
LzZc1qMCt2uO5punsti3XFf1Q6+BrI6qyq+Cl7QxoBh7aM4k4SBQ8SuvWJevv7Pp
nUylr7zCuMM9dsAPoZy8TrHcYwPzAeszZVwWuyKFV2O5BEXLLARSaLV1xQMvRMD8
DdE36B2z0Cp71AtbRt6UA7M9ZbInWod65XSERapU2JqxzivzRIInoyn/AsIYhiPV
CQtjl4yB2VZ4kWTQ6i1gnlVZbKo86wBqV5n+pTwMPUD9aLn7KDlvEbLm0fkhj2Vz
zlctA6e6D7VJbfVBqciS158Ubj2r5JbZQxDoRr2wQojaEQnRwwQls/HSr+REQCJE
kYFujFIKYApNsqz8z+zhyxO88RzuiFQC/By+WtcPl2cTKVOhNf5pcPhax9XHtR08
XgmxK/CG76gQtBX8b4wM
=GeuM
-----END PGP SIGNATURE-----

--SLk8PSyqxe/ugcCT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
