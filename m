From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: sh-msiof: Document hardware limitations related
 to chip selects
Date: Thu, 14 Dec 2017 11:45:44 +0000
Message-ID: <20171214114544.GC9788@sirena.org.uk>
References: <1513191913-10612-1-git-send-email-geert+renesas@glider.be>
 <1513191913-10612-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1513191913-10612-5-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2017 at 08:05:13PM +0100, Geert Uytterhoeven wrote:

> +			 Hardware limitations related to chip selects:
> +			   - Native chip selects are always deasserted in
> +			     between transfers that are part of the same
> +			     message.  Use cs-gpios to work around this.

Ideally the driver would be generating an error when it sees
multi-transfer messages.

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloyZGcACgkQJNaLcl1U
h9AT7Af/TK1+7gMVOO2nLm4h2HMrGHPUHeUhJJgnR7vsZozlcCnsq0/bxn0NXB56
1PbwCYZvC2QrfsvHI7AvO+R/XnORlFzGgvHF3i95+S4zkP3Bwpg/11tsgKOHeRxK
E0csFyJZAD0+8gGnTGNRMaLLmudUSJxJ9wNWSw94fMMrzbdlXoC3rjlrczJ0snkk
MBawsXyfVDQb6rG1UvY3jCf6scZvhjF2D1rrmh9BnzB0A/prc6DoO5wdXrKBOxTb
G0Tb+BAuDDn2CmgoEqCfYLK6/rhU+E5MoknJuVFny3WXD5QXdAMiaB6U54l9CkYM
eppmnsSjtjRs/K32pH7q9r0Y1CcpIw==
=p2YY
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
