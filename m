From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Use ida to manage SPI bus number
Date: Wed, 6 Sep 2017 14:28:46 +0100
Message-ID: <20170906132846.il4ycaxu75ezsyt4@sirena.co.uk>
References: <2a15b398a8f8d3f6f46f9fd6e8591242d29c44a2.1504697026.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3guhzl5rqptqybw3"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2a15b398a8f8d3f6f46f9fd6e8591242d29c44a2.1504697026.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3guhzl5rqptqybw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 06, 2017 at 07:26:51PM +0800, Baolin Wang wrote:
> This patch adds one static ida variable to manage SPI bus number, moreover
> we can get dynamic bus number from ida instead of one "dynamic" IDs, which
> can be removed.

Someone else actually addressed this TODO item just in the last
development cycle, v4.14 should contain an equivalent patch.  Always
best to check linux-next for the latest development state!

--3guhzl5rqptqybw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmv+A4ACgkQJNaLcl1U
h9BFhQf/Y0zAEJjGTDFX/tOfF2Cz0WZSX1z0rJ6gMy5roCiFwIf9eKSJ33H25pGs
sNGA7snBhDfApWeOCZm3xHamSozsBm99QSby9cIiX4JLfTalTrJrP7VyB8GdCnsK
uNC/sU2xPNlY2PRApvT4qrf359t4Muz4e67pegE0a9949OhUqOwskYGQlo/XUjmY
7XDoKM9mqD2y0uXvZ+/v72kg/pZSIT1vnRkSreyi7ChYF66kJ5OReomRPZrRHuhA
RN4+GaHzyMhzPTkGIQj2baZx5Vl490/Fi291dVRWCOiqfiSSsaVq42NGtcKDQQHB
4H8BbldigOv1rCkc5ocahOG4JrV4mw==
=VdK/
-----END PGP SIGNATURE-----

--3guhzl5rqptqybw3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
