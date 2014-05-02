From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Fri, 2 May 2014 10:40:48 -0700
Message-ID: <20140502174048.GV3245@sirena.org.uk>
References: <1398705774-12361-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140429183758.GH15125@sirena.org.uk>
 <20140430180609.GC3000@lukather>
 <20140501011811.GF3245@sirena.org.uk>
 <20140501223629.GJ3000@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4uRSjkMtiHUwt2KF"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140501223629.GJ3000@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4uRSjkMtiHUwt2KF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 01, 2014 at 03:36:29PM -0700, Maxime Ripard wrote:

> But it actually doesn't work in a case where you can't really predict
> what is on the other side of the bus. Either because, on the board
> you're using the pins are exposed and it's pretty much up to the user
> to know what to put on it. That could be handled by DT overlays
> though.

Right, that's a completely unrelated issue.

> What never works is where the device on the other side is so generic
> that you really can't tell what it does. Think of a microcontroller
> that would behave as a SPI slave. It's behaviour and what it does is
> pretty much dependant of what we flashed on it, and suddenly the
> compatible string is not the proper reprensentation anymore.

That sounds like another situation for overlays, really the thing that's
compatible here is going to be the whole assembly rather than just the
device in isolation (or you're in a similar situation to the one you're
in with FPGAs where you have a driver implementing an application like a
loadeer

> i2c-dev works great in these cases, because you always have access to
> all the bus, and all the devices, except if the device is already used
> by someone. The patch I suggested is an attempt to mimic this.

It seems better to implement something like this at the device model
level, provide a way to have a default UIO driver for anything on a
given bus.  I don't see anything bus specific apart from saying what the
default driver to use is and it avoids the icky code fiddling about with
what devices are bound and the races that might be involved duplicated
in individual buses.

--4uRSjkMtiHUwt2KF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY9idAAoJELSic+t+oim91ggQAIRRvs5rii15krEpu2Jjyaik
maNqSIcY0fMFm96uMFwb/8IynkuKGc7rgotRlFBCQoKS6XtbSDkPqxFGBEb1uxWu
hlArJEYTMot6JodLR2cnLtMWAQzQI/lgvHlEaMoKwMFC/hCMPFuhjufxFeV+oGxL
y2abgavREKjjQEtRh4tJA1qZl7mHEopvrrvazs+y1KFJHuhAovIX8pkuEq+/VIBG
ug4EIC5JrshDPHrN4QoY2ZZD2SPJkDWabqX/iYr6w5wdXtnQ9TlxJxmsUYVaITwB
fckEdke3lP1p6l1q2u/6dbgeDsjSzw9PWBGXBpft+n/NwxetaOwsPUirRiu/YAf6
Dw9+fw/QDxYnBLPig08hKZBDPGpxekxv20kVk4yZZ4LfEUai9GN5uiY2lcP42E5L
HiomBZBXwmgHd7UMyTzkLhlt0ir0fJkuGAaTbPrzNLUkzQixql2BbF6kKcYMuxXT
TUmCI1xI/28Gq8xFwu+/dynSQLEfuXh6YcNzJ30115BfgmY5ukHueVICBtOZYn1I
xAyLhU5xxF0Knen1g0HELqCUy7BgavWda8d+NaxyDtmDKrMFGmsuL9ipcwb/oYGG
piKCAPhcaaXG2nQKkhA+DXeC0qAOTRaAVqFhAfC+lkbNf4M8viI/3Io/6MO4jWKU
kY729JF6urJ4IEdhMJE8
=cfIw
-----END PGP SIGNATURE-----

--4uRSjkMtiHUwt2KF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
