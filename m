From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/8] spi: davinci: Use SPI framework to handle DMA mapping
Date: Mon, 13 Feb 2017 11:30:53 +0000
Message-ID: <20170213113053.w53wfxugxtbitnn3@sirena.org.uk>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
 <1486740584-17875-2-git-send-email-fisaksen@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="akhtf4ch7t2ngbuh"
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
To: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1486740584-17875-2-git-send-email-fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--akhtf4ch7t2ngbuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 10, 2017 at 04:29:37PM +0100, Frode Isaksen wrote:

> Note that the dummy buffer used when doing one-way transfer, must
> still be mapped in this module.

No, the driver shouldn't be doing this - it should specify if it's
_MUST_RX and/or _MUST_TX and let the core handle it.

--akhtf4ch7t2ngbuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlihmOwACgkQJNaLcl1U
h9DPEAf/aY93MqMBiTAH7avRQ2dLSNCleRUbdk0anYQGcshnjwggfdWrQgKLNjyj
zPhBCNBvWnphtRDFlG+K33FsQ9qpePuecyr0/UnssXVFzQH6z8fxIm2yXDurfp0d
kHR5hWlnFstQI4aENaPfVdeMGPH/TbyxWe2ejhjZfJgwWHQV05F78shBAZKMLOLU
sFfEA9rxgMaRzcIZYiZg0nVqdiTUrbFGjmjd9Y/R7UzhH/Nfb9ZlmRlvICq0FneW
EiOOFjdaA2OCN5Sg6cEKGfsmavpL1r74WT14OO9OY2pM9MZ7L3d0CAo534htrfQ+
tICKfVCI+JFcXYWfqMyws0TcI8xW5w==
=GmLy
-----END PGP SIGNATURE-----

--akhtf4ch7t2ngbuh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
