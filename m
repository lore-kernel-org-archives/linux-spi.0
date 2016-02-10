From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: bcm2835aux: set up spi-mode before asserting cs-gpio
Date: Wed, 10 Feb 2016 10:59:29 -0800
Message-ID: <878u2s2xym.fsf@eliezer.anholt.net>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de> <1455041435-8015-4-git-send-email-stephanolbrich@gmx.de> <87d1s54f7f.fsf@eliezer.anholt.net> <20160210080149.GQ13270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: stephanolbrich-Mmb7MZpHnFY@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160210080149.GQ13270-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--=-=-=
Content-Type: text/plain

Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> On Tue, Feb 09, 2016 at 03:49:24PM -0800, Eric Anholt wrote:
>
>> This patch surprised me.  I would have thought that the solution was to
>> just write the updated CNTL bits for CPOL and wait a moment whenever it
>> changes.  The CS only gets asserted later on when we get some data in
>> the TX FIFO, so I think you're just reducing the chance of losing the
>> race to get our inverted clock noticed by the device before the CS gets
>> asserted.
>
> We support (and generally want to use since hardware chip selects are
> often very limited in what they do) chip select on GPIO.

Oops, this makes more sense now.  Subject even mentioned gpio, and a
GPIO CS must be getting set around the transfer_one call.  I'll be ready
to send an r-b for a v2 with the speed update bug fixed (unless transfer
speeds are guaranteed to be constant between a prepare and unprepare).

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWu4iRAAoJELXWKTbR/J7oZmQP/33+6e1xh2rNOafO6IThppcE
tfUMCXfyilIjFaPovx29rRBgyQOd8xVoa1M5OVKo3zbVD2RqgL6JPN2lJ1f4f7Dd
8vKlWsg9kZCc/RAdZmPAWUswQYP/puALwHe9a69PrJUumN7pb9BHwuvWKyxJ+7vB
garLS0OYW7EYX0zjX7vYbKtL3DTbeO/sBoiHgHrZGDq4XoE40fxRkO7uUme5NvhU
FpZLWDxbd/lpdAukMfKdHCCrPgAhQNX+Sa6/0dUkM3j3cn1NTHCG7jb8Q8JkI+vU
SO12X3tDrzcGMWUM4KJY9P3J0lWWQC6z/px8y4cV4zbvrfVaqPq55uQtBpLfij5z
gSZhGMvlGjqltuCOmHFSyuTvjb9UBdYITOx+QrA41zceq8c0/7jyWqWSeJfDu/rg
Mm5uzgnGMUKmrEZtC8nqiFW4lOzUfeEwzDpOo/G2aMbuFA8tlfr2+fHtzyZHJ8au
vBW79h5iG9hYReUsdb5+yO0jUPx8Okc0o70W6GFeW+4c0XMcqYEKeZPU06JdGoTF
U73os+mYeDLoqcWNfD4iAq5POG0+aNZd7AxC/2Jf0p91pYNDDSrV3CuAPQNInUHr
mZDItWRKdqfbnS0YJUFnemjGDVHh7URzB6TFUpaGdxnd91OGs0JprmlcHY78K6fF
D9t4p+nAJZjHh+nwiw2G
=br/N
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
