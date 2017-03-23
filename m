From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm2835: Allow platform to set realtime priority
Date: Thu, 23 Mar 2017 12:21:18 +0000
Message-ID: <20170323122118.i2gc77debz4eu5hq@sirena.org.uk>
References: <c1ca8a5522272d06f5c3fb67d8442f148b2d6cfb.1490264661.git.lukas@wunner.de>
 <1503363fcfb92adfa765d1c1c3e69fc673e72dde.1490264661.git.lukas@wunner.de>
 <20170323110718.sncw32gspvls75u7@sirena.org.uk>
 <20170323120257.GC20546@h08.hostsharing.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j4b3hs7ztb2nvwtw"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
        linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
        Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170323120257.GC20546-KMaqurgeqYRAE5l8fViCMtHuzzzSOjJt@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--j4b3hs7ztb2nvwtw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 23, 2017 at 01:02:57PM +0100, Lukas Wunner wrote:
> On Thu, Mar 23, 2017 at 11:07:18AM +0000, Mark Brown wrote:

> > This is going to depend on the software running on the board, I'd expect
> > it to be something configured at runtime rather than fixed in DT.

> On the Revolution Pi, the SPI master is hardwired to two KSZ8851 Ethernet
> controllers which are connected to various fieldbus gateways in a
> plug-and-play fashion.  Low latencies are needed to achieve a decent
> cycle rate when reading/writing data to the fieldbus devices.

> Hence for this use case, the RT priority is mandated by the hardware
> platform, which is why I put it in the devicetree.  It is needed
> regardless of which software is running.

Caring about having low latency access to fieldbus devices is a property
of the application, and achieving that via the use of RT priority for
the SPI pump thread is a property of current Linux implementations.
Neither of these things is a description of the hardware, the SPI pump
thread bit is already changing (for a very large proportion of use cases
we only use the thread to shut down devices once they become idle these
days).

> We could accommodate to setting the RT priority on the command line but
> we'd like to avoid always having to set it at runtime.  That is already
> possible by invoking chrt(1) from user space after the SPI master driver
> has loaded and wouldn't require a kernel patch.

Right, there's already mechanisms to do this at runtime.

> Also, if you question setting the RT priority in the devicetree, why
> was that functionality allowed for pl022 in the first place?

This was being done via platform data not via device tree, unlike
platform data device tree should provide a long term stable OS neutral
ABI.

--j4b3hs7ztb2nvwtw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljTvb4ACgkQJNaLcl1U
h9BBuwf/TRQ+VQkh5P7GNJSJm/I9Q1Gplp4q48GKjBqQ5OOHzk0cJAj4LMQKIFMD
3NC8kZBV9tRi25gRllVwWLT3FwtZHg1yS4IWop2TJ8mwep3Sdg77N92q3iENxYcV
u/Jdq0RAYl5Ij48m6sM6DwVUWOLSTvPnUHNL8l9WwzpPGzS7KnbZ6J0irwfgejjr
2uZ+9/lCXFbCWJ1P+Uj5G5/kkC4DdUYEh9aNmYVJ5U5rMmxX6eqB1+gdoy0VZj9X
bOegWi+Nfa0mtZ9jAJtSgkkDlODZmkQNBRoxOVSPnuA62wwAV4QyvsZZXtvidVsR
AS3wOVej3ygD1qA6turkTr//+u7+Mw==
=14Ez
-----END PGP SIGNATURE-----

--j4b3hs7ztb2nvwtw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
