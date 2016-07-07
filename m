From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: SPI: performance regression when using the common message
 queuing infrastructure
Date: Thu, 7 Jul 2016 11:50:34 +0200
Message-ID: <20160707095034.GL6247@sirena.org.uk>
References: <577CD464.6050506@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w41lMVNXnOw3ZHPk"
Cc: "Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	"Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <Nicolas.FERRE-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, hs-ynQEQJNshbs@public.gmane.org,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <577CD464.6050506-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--w41lMVNXnOw3ZHPk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 06, 2016 at 11:50:28AM +0200, Cyrille Pitchen wrote:

> So do you recommend us to keep our current generic implementation relying on
> the SPI framework workqueue or to go back to a custom implementation using
> tasklet?
> If we keep the current implementation, is there a way to improve the
> performances so we go back to something close to what he had before?

I'd suggest trying to implement whatever it is that your customm
implementation was doing in the core, having individual drivers trying
to open code the message pump is obviously not sensible.  If what you're
doing makes your controllers run faster it'll probably make everyone
else's run faster too.

--w41lMVNXnOw3ZHPk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXfiXpAAoJECTWi3JdVIfQ3pMH/0+2tOY6dyWDj4/sY0mnm83b
xA0xzJkDKRFfHEiy3GAdrnP8rzdQf/7hlQj7oAWH0G95uf1XqCfRBLZ1weanUKD5
HEN+S/m2R9ARO4tzqFYPhl3DBPRsWz0LQ8oN9VZ3n8u8njxyR15T/B/YOXbBkVBB
P5GwpDS9Wgdqg6XzoNZgAc/hIaZl3CZOnbymv8ys3PmqpSkyZQoyFQapfQBUfgey
NpMWUT382z30oQCg4Td1Hp73tBuoDbuTYNwenLGRErO8O2rIgznckhvX1KeSpU5J
rOiH1zNSfmdysNHJMqUBOIrBg9+wIYtHWaiqfNlEuZW9d4B6GnmU4ySNaQIPUeo=
=OEyT
-----END PGP SIGNATURE-----

--w41lMVNXnOw3ZHPk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
