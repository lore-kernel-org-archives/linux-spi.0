From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm2835: Allow platform to set realtime priority
Date: Thu, 23 Mar 2017 16:02:01 +0000
Message-ID: <20170323160201.v7n3o2xbf6bdq3sx@sirena.org.uk>
References: <c1ca8a5522272d06f5c3fb67d8442f148b2d6cfb.1490264661.git.lukas@wunner.de>
 <1503363fcfb92adfa765d1c1c3e69fc673e72dde.1490264661.git.lukas@wunner.de>
 <20170323110718.sncw32gspvls75u7@sirena.org.uk>
 <20170323120257.GC20546@h08.hostsharing.net>
 <20170323122118.i2gc77debz4eu5hq@sirena.org.uk>
 <20170323134336.GA10576@h08.hostsharing.net>
 <CACRpkdY2QKLNbW_+i=qBCYr8iOHckYmukePOHUHtVpdW5xpjWw@mail.gmail.com>
 <20170323142816.GA19878@h08.hostsharing.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7nldniavvgkmnlac"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
        linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
        Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170323142816.GA19878-KMaqurgeqYRAE5l8fViCMtHuzzzSOjJt@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7nldniavvgkmnlac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 03:28:16PM +0100, Lukas Wunner wrote:

> I'm still wondering though:  If the master thread is supposed to be
> run at a realtime priority *always*, 100%, all the time, what is the
> best way to achieve this?  Setting it with chrt from an initscript
> seems clumsy to me.  It's racy as the spi driver module needs to be
> loaded, whenever the driver module is removed and re-inserted, the
> priority needs to be updated again, there's always the difficulty of
> uniquely identifying the right thread, and so on.  Setting this from
> the device tree is much more elegant so I intend to keep the commits
> at least on our own branch.

What would be great would be if the priority were communicated from the
device driver using the controller (which might in turn want to get it
=66rom their users) rather than hard coding something into the middle of
the implementation.

--7nldniavvgkmnlac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljT8XgACgkQJNaLcl1U
h9BQfgf+NbiDZ1oyas0rtRxoE9F8BR9hBl6qBimX0iYBOZokavQ+NNUazXZPlSV/
urqssO2I/U7yqDKSbpT4rNOLn8ccpZ5WQxQWM3gSUKKFpmT/GfjAThTtVPdo/B1C
y3jlgK1jFT6X5jmv2v7hhYYbN/gSPjp9f/YVbVRA2sG7Kr/2YZWPnp3vGyFreT5l
aU6ZeWnv9x0PYR89bEv7MKW31S9SJcfnGxY+erGPbH1H0WNtazcrBgee+KxVWImD
I3jIrzExKiJn8iDQ29ooenpMbNd+/BYKTeNQybzWBw5BvEVgInXnnVqd0oWOkXzX
11Kd5F91ZAWcrpaNRTaE69Kqlwfz7Q==
=KSM6
-----END PGP SIGNATURE-----

--7nldniavvgkmnlac--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
