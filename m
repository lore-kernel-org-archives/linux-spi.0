From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: How to handle SPI components requiring heading/leading clock
 cycles with CS off
Date: Wed, 24 Aug 2016 12:12:06 +0100
Message-ID: <20160824111206.GD22076@sirena.org.uk>
References: <79679118-c092-1f9c-1972-0bb81bc59411@c-s.fr>
 <20160824094456.GB22076@sirena.org.uk>
 <8c6cbd99-7dd8-bbbf-89ee-a33752ab3063@c-s.fr>
 <20160824105640.GC22076@sirena.org.uk>
 <15444613-2f3d-9417-7d81-e545058afdf0@c-s.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="stFzI3XAseUQ09UW"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <15444613-2f3d-9417-7d81-e545058afdf0-GgN8y9CXRhA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--stFzI3XAseUQ09UW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 24, 2016 at 01:03:57PM +0200, Christophe Leroy wrote:

> CS is asserted inconditionnaly at begining of the function, regardless of
> its previous status.
> Then for all transfers but the last, when cs_change is set CS is deasserted
> for 10us then re-asserted.
> If cs_change is set for the last tranfer, the function leaves CS asserted.

> So I don't see how I can transfer some data with CS de-asserted.

Oh, yes we reset at the start of the function.  You'd need to change the
core to support this, and even then your compatibility with controllers
is going to be very limited.

What is this device, is there some reason for this?

--stFzI3XAseUQ09UW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXvYEFAAoJECTWi3JdVIfQdDMH/3mz/EmxznAu9ixboZmqT0zf
JyOAs5/sFpH90WeZFhjAVCkDPuBH4MVPHUq82sdUT/MbyBZLSLFHPn1aU1kflOFY
pQTMAHYk+aYUEBlN0nAVbXB2MHHdwhCwh/MjKAScVPOwWTwvL2cysSsEkcjRd1NB
00S6HxoSgTLIj3BE60PWzA9giusbh+SVvVKG3hzR8riewpYAwWs3YZsDoF15S/zT
OVxc1FFfepZS9Zhad2j08HKVzA0Lbb4C7+byEbpIXIJAHNmD9kRaWUkTdu3HtX0d
K/mkWko06djxHJoawxfppyyRcSzNys8LkGEEPTj0ovpylKQa/ZrCY+tcM8C/CII=
=3wiz
-----END PGP SIGNATURE-----

--stFzI3XAseUQ09UW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
