From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: bcm2835aux: set up spi-mode before asserting
 cs-gpio
Date: Wed, 10 Feb 2016 08:01:49 +0000
Message-ID: <20160210080149.GQ13270@sirena.org.uk>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <1455041435-8015-4-git-send-email-stephanolbrich@gmx.de>
 <87d1s54f7f.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qnK4RqISe3HuYx1/"
Cc: stephanolbrich-Mmb7MZpHnFY@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87d1s54f7f.fsf-omZaPlIz5HhaEpDpdNBo/KxOck334EZe@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qnK4RqISe3HuYx1/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 09, 2016 at 03:49:24PM -0800, Eric Anholt wrote:

> This patch surprised me.  I would have thought that the solution was to
> just write the updated CNTL bits for CPOL and wait a moment whenever it
> changes.  The CS only gets asserted later on when we get some data in
> the TX FIFO, so I think you're just reducing the chance of losing the
> race to get our inverted clock noticed by the device before the CS gets
> asserted.

We support (and generally want to use since hardware chip selects are
often very limited in what they do) chip select on GPIO.

--qnK4RqISe3HuYx1/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuu4zAAoJECTWi3JdVIfQG3MH/2zwOpqOrVaUjEKKvM3RWs0N
Rl5hndG7yME/uiDPz8kbiPzTmVuO0faFV/c3BAZT1kcmY/D5ew2P9vf9vHMx/S81
xzewUx1g41n+fJiP/xBUxi+5XeGuXPlnlE+psBWLSAvxizpak+DYTGjGjvyoOmvs
lIAra3Iy6jc65AIrtAT3GFN/Arm+BxxL/MfjChV1TBdWep7KVgIM24H52XgZU+hL
j8elu4TPYUBF1UhQRa2snT8zJj4nQQaPvDGaRjLPVusx67KvoEdW0jqr3tbp+TiM
+Gv+nMfsQNIRC/LvaZmF1dJ59V6WL4Vck1ll1XoJ0yhjkIkf9SwpgGeyAANqLkA=
=Q+8t
-----END PGP SIGNATURE-----

--qnK4RqISe3HuYx1/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
