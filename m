From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: SPI_TI_QSPI should depend on HAS_DMA
Date: Mon, 15 May 2017 11:53:19 +0100
Message-ID: <20170515105319.5vm46modegh3gfke@sirena.org.uk>
References: <1493883438-19462-1-git-send-email-geert@linux-m68k.org>
 <20170514095020.roqoeohylvrgoad7@sirena.org.uk>
 <CAMuHMdUOMk9zpaVS9gj=jC5Cy2WFpj50+ut5TG=T69mYjMZ7hQ@mail.gmail.com>
 <20170515101235.uy776lopdsyd4h73@sirena.org.uk>
 <CAMuHMdUs31Bq5SU5uMcmoRtPd7zpop18XYRF9mAOzJ8e62JHaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oena2zzbyvehanrw"
Cc: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUs31Bq5SU5uMcmoRtPd7zpop18XYRF9mAOzJ8e62JHaQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oena2zzbyvehanrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2017 at 12:21:33PM +0200, Geert Uytterhoeven wrote:
> On Mon, May 15, 2017 at 12:12 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > No, I was thinking more just not needing the dependency at all.

> Then what's the point of the existence of COMPILE_TEST?
> We can just have stubs for everything, and always build everything.

It's useful for platform specific devices (like this one should be) but
having to add dependencies for basic kernel APIs like the DMA one is
just making for a lot of noise.  There's plenty of platforms without DMA
that also have no real use for this driver, it's not really a relevant
thing when deciding if the driver might be useful if what you're trying
to do is hide drivers that aren't useful on the platform.

--oena2zzbyvehanrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkZiJ4ACgkQJNaLcl1U
h9Ds2Af/QX2ralGx2fjEH+tnbq8kRgkp71sS7kdbS/pi4Jhdux5a4zoSfqOc74a8
qxxsxQe3yBnY/Yzbp1gUFHlCNyTmcz3MY5p3MfMTpM+dJ45/4E4/NPwAVsTtbB3U
S595rMhfjFJmTUyiqSmIxZWAPITGqqs+oVDgc+FLGoN7ncgR2NyFmzKua8LG6exV
0XQrZxGdlED3DYp82DJGIIt2fv8qS6NEuHP9oaNLk5AOFl13s3SDsHFR3neyP4wB
PfMlJax1QzsSwA8vrLYrDW8YNFwGkzd5AxRZ5+Mef8KaxFQrIhRtER0rMG+KcCLf
uowM64sRt0cmWFX+kK+IQ0be/W3jXQ==
=nZ9i
-----END PGP SIGNATURE-----

--oena2zzbyvehanrw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
