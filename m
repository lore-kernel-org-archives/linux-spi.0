From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Tue, 29 Mar 2016 14:00:18 -0700
Message-ID: <20160329210018.GL2350@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <21028994.N5ajfyoUoV@wuerfel>
 <20160329195230.GK2350@sirena.org.uk>
 <7339827.UeYZLZET5g@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="deSP9Bnrq3taYiYM"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7339827.UeYZLZET5g@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--deSP9Bnrq3taYiYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2016 at 10:04:59PM +0200, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 12:52:30 Mark Brown wrote:

> > Well, we currently don't have any XIP or whatever support at all, it's
> > still only in the SPI operations so it's academic - that'd be a future
> > issue if we did start doing things that accessed the memory map outside
> > of the SPI flow.

> Isn't this just about implementing .point()/.unpoint() in the spi-nor
> driver?

Implementing that would require the SPI core to export something
providing access to the memory regions.  We don't currently do that,
it'd require us to deal with the interaction with access as a SPI device
(this hardware often seems to only accelerate reads so we still need to
use regular SPI access for writes).

> > For me the simplest thing seems like just using one window for all the
> > devices, it seems more likely to deliver useful results without the
> > system integrator having to think about how to configure this for
> > optimisation.

> Do you mean single-window mode? I don't see the difference to the other
> modes, but that's certainly fine with me if it helps.

I don't like having to assign windows per device, like I say it seems
like more work.

--deSP9Bnrq3taYiYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+uzcAAoJECTWi3JdVIfQRtIH/iQTQWtKzO+nYbgsDaXyWoYK
xqT59ZNoJ1COR0y02EOsXo8tIyOyGap5UaEDgMGEvR/avH74aR9aVL0H4eurH+LS
gGwdzeoxHpSGj0z+xpFPoFoniMC+xFT8Q+sNYIuAgVrqrO1lWZ3PSqKZI4siofyD
cOqqcTmj7WRfOUnG2ug7sZUB3JhhfSnp3bMuDX4z2/9lq5/sEcWQH+uv29kziqmw
u3mOtZrXC58YCmwAcgl8MUmm6tHTcAjCS5x+3vCW2z7WP5wDPVQ7eYtSijatYHmm
VR6vHgmerRsp0M6l7Twu+okTOlftd03tjt366fRd8YxT+o35hHISrFPY/luP2tQ=
=7gEc
-----END PGP SIGNATURE-----

--deSP9Bnrq3taYiYM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
