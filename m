From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
Date: Thu, 1 Aug 2019 13:35:03 +0100
Message-ID: <20190801123503.GC5488@sirena.org.uk>
References: <20190801111348.530242235@infradead.org>
 <20190801111541.917256884@infradead.org>
 <640721f8-8a20-b161-473f-98a9dbc053cc@collabora.com>
 <20190801121718.GE31381@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-spi@vger.kernel.org,
        Doug Anderson <dianders@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190801121718.GE31381@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2019 at 02:17:18PM +0200, Peter Zijlstra wrote:

> I'm thinking that isn't true 99% of the time, except of course when that
> bandsaw emergency break is attached through SPI, but in that case the
> admin can very well chrt the prio of this thread.

The SPI thread isn't usually RT, it's only made RT if something in the
system asks for it - the reason the ChromeOS people got CCed in is that
some of their embedded controllers are very fragile and need super tight
timing on some of the interactions over their control interface so
they're one of the users here.  Of course everyone is then going to
claim that their usage is the most critical usage in the system, and
they may well even be right, but I do tend to agree that just any old RT
priority is probably a sensible default since for most cases there will
be few if any other RT tasks anyway.

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1C3HYACgkQJNaLcl1U
h9Alfwf6AugMBoXb++tNEYu9FBXmJsqiEoyD4n90hKDCTMRgF8sokxYAvUGTJzQQ
iE0h+bYBl8vU2eJG4nCGRQZRRFmACX/amPXBY82xVOcBooUZ74g+igbRW35/nSuR
vtE8DGr2jugTuTznssPMVCKYSYcvxvV3PRzdvx30phQCUtqtBlpEFWVHH0FtacEM
UQPH01JiVA7QcE/ZqYXAR7Jsgfm7kNEMTAgaxvGUhYVVnHmWwZnioK8Ke/cE75SL
Uwa38z692JzCAL0c5qepeOF2aXLAjt+F1IPFWGrAjgmjRjqjS4ZzZWTGAWMMPscP
2Y/hPW2i7J6cvNkLxXborjsKCte3iw==
=t0Pu
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
