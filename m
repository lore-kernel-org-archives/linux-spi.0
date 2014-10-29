From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 0/2] spi: dw-mid: fix simplex DMA transfers
Date: Wed, 29 Oct 2014 22:15:30 +0000
Message-ID: <20141029221530.GQ18557@sirena.org.uk>
References: <1414513502-595-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20141028224156.GN18557@sirena.org.uk>
 <1414579076.2396.62.camel@linux.intel.com>
 <20141029111712.GE18557@sirena.org.uk>
 <1414588848.2396.64.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6wTtw7qecL6chBEz"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414588848.2396.64.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6wTtw7qecL6chBEz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2014 at 03:20:48PM +0200, Andy Shevchenko wrote:
> On Wed, 2014-10-29 at 11:17 +0000, Mark Brown wrote:

> >  - how exactly has this been tested? =20

> I don't know how it was tested before, but, besides intel-mid-dma is
> somehow broken (I won't spend time to patch it), I'm using patch I
> already published which converts driver to use dw_dmac driver. With it I
> run tests on a loop back.

How exactly do you run those tests though, what is the client driver?

> > tx_dma and rx_dma
> > *can* be provided by users but vanishingly few actually do so.  Drivers
> > must not rely on the caller doing this, the feature will be going away
> > apart from anything else.  If the driver is relying on this it probably
> > needs to have the DMA support that's there removed as a fix and should
> > be converted to use the core DMA mapping functionality in -next.

> So, regarding to above what would you like me to do as next step?

Looking at map_dma_buffers() it's probably actually safe since it checks
that the message has is_dma_mapped set which virtually no clients will
do.  However this means that we're not bothering to DMA almost all the
time which is silly - I'd like to see the driver converted to provide a
can_dma() operation and let the core worry about mapping, that will mean
a substantial performance win for most clients.

--6wTtw7qecL6chBEz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUWcCAAoJECTWi3JdVIfQThAIAIM2uCA9oPTK2V8wnx4hSzsv
w4gyLq9a5drhhowfPsFsMypQBB42YjU4Yzajn2pMvcugz/1VuAB48UQWbJP4y9oj
1TClgkL5SgvYsgULLXqTWRDfpydEjCESAMcyuzcpJZ9yKQqIR9wUIANcEV5C2G3X
mJJpl0uG+zJ1PQ1yZz13T27DQns0cTJVZlqTtXPCSVpUlo4noeBRkHMen6UZPRAL
MKiqGjQPilKXqZWiXWiZHwKEJXfvIWfCG8kS3oV0FjT1qVRwPG1uu0FAggr/RXYx
HvrRdMoJZhh0JIgbVeacHn2pkUmO0Mz1uAsKan6zyAp19aeg4j0GpUOhlAtn9vE=
=yv1w
-----END PGP SIGNATURE-----

--6wTtw7qecL6chBEz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
