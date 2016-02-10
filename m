From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: bcm2835aux: set up spi-mode before asserting
 cs-gpio
Date: Wed, 10 Feb 2016 19:02:04 +0000
Message-ID: <20160210190204.GD13270@sirena.org.uk>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <1455041435-8015-4-git-send-email-stephanolbrich@gmx.de>
 <87d1s54f7f.fsf@eliezer.anholt.net>
 <20160210080149.GQ13270@sirena.org.uk>
 <878u2s2xym.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0VNbQffo0Gc48lc+"
Cc: stephanolbrich-Mmb7MZpHnFY@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <878u2s2xym.fsf-omZaPlIz5HhaEpDpdNBo/KxOck334EZe@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0VNbQffo0Gc48lc+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 10, 2016 at 10:59:29AM -0800, Eric Anholt wrote:

> Oops, this makes more sense now.  Subject even mentioned gpio, and a
> GPIO CS must be getting set around the transfer_one call.  I'll be ready
> to send an r-b for a v2 with the speed update bug fixed (unless transfer
> speeds are guaranteed to be constant between a prepare and unprepare).

No guarantee that they'll not change, especially in a situation where we
have two devices on different speeds on a bus working at the same time.

--0VNbQffo0Gc48lc+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWu4krAAoJECTWi3JdVIfQ5u0H/iJBpudo7nkanGMXSy1XFLGm
CkIxMKQYs+R2zyTspf+n8UAkyGssmboY5kNnj386jhK+8Ohh8izfZxf+OP06Dvpt
yoq04fUY4MYEgixFi9ybSDXT8GDOXt0tS77NKSTnL4x8tKS/qqzY29DPUDHwR/A6
OqX9i1UdgXwh0wc91GeaFiewbBB6VRN3Qe07VqagHY0sTkY4UV7Wb5454e9ZRa2M
+rMapfKvr+zhq400xIb83qS3bIayWruIIVBiCgJMSeNYIzPvik74w/1tqW3HAx2i
tLKtqsYJHPDvnmGyYeWp4PzJE7Du/a2PP8z4umb5ZGsk7+5g0Btoj6EPx+VJMOY=
=+6rD
-----END PGP SIGNATURE-----

--0VNbQffo0Gc48lc+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
