From: Mark Brown <broonie@kernel.org>
Subject: Re: Handling clocks on external busses
Date: Wed, 2 Dec 2015 13:30:10 +0000
Message-ID: <20151202133010.GJ1929@sirena.org.uk>
References: <20151124173718.GK18889@ck-lbox>
 <20151202125855.GB6058@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r7YfqnGwAF7PgTLe"
Cc: linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org, linux@arm.linux.org.uk,
	mturquette@baylibre.com, sboyd@codeaurora.org, wsa@the-dreams.de
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151202125855.GB6058@localhost.localdomain>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--r7YfqnGwAF7PgTLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2015 at 12:58:55PM +0000, Charles Keepax wrote:

> So after a bit more digging it seems this has been mitigated slightly
> as a lot of SPI driver have been updated to execute transfers in
> thread rather than from a worker thread and it seems the clock
> framework lets you re-enter the locked sections if called from the
> same thread.

No, this isn't something the drivers support (it's a framework feature)
and it isn't something that we're guaranteed to do, if the bus is busy
we defer to the thread and it's possible the drivers might do something
multi-threaded themselves.  It might work a lot of the time but it's
never going to be guaranteed to work.

--r7YfqnGwAF7PgTLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXvJhAAoJECTWi3JdVIfQA+AH/Rj5XoHAusUguUDYc4NViJGW
evlxnShud6Y4PKjbRvsJMb2sjO9REmwxXjKMSMrR3fBaGRDlCUWybrK5bu4YXW1U
RkoykLwpbwEqqQ6RSGN9bvh9xuaQoRKTNHJfyFcVw8puFFHooo9c5RHN+UnaeavR
o1rSdWyah01z2SS8hnKMKvs6FclOnpku02STFVZxRaH9vtiBPkBLS1uGMX/54yE1
c3yhW3PGcllG4ieJlcfcJHH4QB0sVKvxbQ+DVxzy0/J6LxrEjhPbOpyjq4DvdrCQ
hPQqCSmQS89dLW1aaqLT7TI1b2p11CxukcOy99ZFHt0lhlAi6BeM+TRyP+iYT5o=
=1wIb
-----END PGP SIGNATURE-----

--r7YfqnGwAF7PgTLe--
