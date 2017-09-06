From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum ADI controller
 documentation
Date: Wed, 6 Sep 2017 15:59:00 +0100
Message-ID: <20170906145900.yesyfyruv5wd3wxj@sirena.co.uk>
References: <ccbb0641fa123021249c7a51cbe2dcd975c41f39.1504677110.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oluwjvarstogn7iq"
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ccbb0641fa123021249c7a51cbe2dcd975c41f39.1504677110.git.baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--oluwjvarstogn7iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 06, 2017 at 02:10:43PM +0800, Baolin Wang wrote:

> +- hwlocks: Reference to a phandle of a hwlock provider node.
> +- hwlock-names: Reference to hwlock name strings defined in the same order
> +	as the hwlocks.

What are these hwlocks protecting, and what names are expected?

> +Optional properties:
> +- sprd,hw-channels: Specify the hardware channel number and mapped address
> +	for hardware channel accessing.

What do these mean and how are the numbers and how will the binding be
interpreted?

--oluwjvarstogn7iq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmwDTMACgkQJNaLcl1U
h9CUGQf+O/pj2u8KYc4c7NKGnX2sYesWBFu+gQMoQfhC76+ywLmTgfx4yAOm2KiE
qEn6UCAncZv51aj2nRz/TVTWCuiwo1W8oaw0lgfdB26PhvNMuwSSJznyh2P75Pd9
MG1gsR67OPykgHYut8SHgobqn3mIP2JylSqgeUxej3Ajn3HcGejo2g44cZdYbejZ
iQ3DHd3Gzt+KhykOsFuPaG5pGFtaXoNgHC1QbLojHGfpEWeKny10gZTsrigEK/iE
wImsLJmUTd4SbO0GAtPC1lA7O7H6qzlNa5vpAx9Ox/Zsa/W0t8AkBv4jJtcMS874
A24WTsl6w3/3XQQJ0pdsYskkLyzUIw==
=u39S
-----END PGP SIGNATURE-----

--oluwjvarstogn7iq--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
