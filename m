From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi_write_then_read with different tx/rx bits_per_word
Date: Mon, 13 Jan 2014 15:36:22 +0000
Message-ID: <20140113153622.GX29039@sirena.org.uk>
References: <20140108223538.GA2861@frolo.macqel>
 <20140110102745.GA29039@sirena.org.uk>
 <20140113133518.GA6613@frolo.macqel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O82bwzp7nMTZS6dV"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philippe De Muyter <phdm-KobBqTBAxd8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140113133518.GA6613-NqYOdiUDesgPnqCj3zZnUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--O82bwzp7nMTZS6dV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 13, 2014 at 02:35:18PM +0100, Philippe De Muyter wrote:
> On Fri, Jan 10, 2014 at 10:27:45AM +0000, Mark Brown wrote:
> > On Wed, Jan 08, 2014 at 11:35:38PM +0100, Philippe De Muyter wrote:

> > > Is there a convenience function similar to spi_write_then_read
> > > to handle that case or must I roll my own one in my driver ?

> > Try regmap?

> Thanks.

> Actually it was late in the evening and I was confusing read in
> `spi_write_then_read' with read as in 'read a register'.

> `spi_write_then_read' should probably better be named `spi_xmit_then_rcv'

Well, the main application of the function is actually to implement
register I/O.

--O82bwzp7nMTZS6dV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1AfzAAoJELSic+t+oim9pKUP/2l71lSOPfpmT77XLKz0VBd1
iVaD1YcNB3gt56iYr3GrmDGHm9o3i5y7ssQOy+q7gqESO2qdGiwyVtSbq2ha7JZB
Ko2nRYyNxItUDkZZ67CmwqiZNXEjcvPLdVMY3F7tcFjayxZ59DUBcAyuVyjTWXoA
OttLOw7ck0NHtvCh1mfTjcQfNkG+NFR8Np7leWhgD8MX/R0uEkH4cFeYHcvGKtHY
pdaF/gjV/N5mxkdNVD1E7DZsI0h3Jsi7CsyH2NxG2JJJShZGXITugpMkvdv9Zp4Q
1/dQwzH2Di40iAxRNRv4/dSFZLz+qCnV6R+6DZ44LypUB6YOZz8F1edrTtYdBGJK
hxcu7zx/TWdYbaN/oKJRrbDDf8HmPldcx5uGA3RmAtTbK0abyM52ICjmmOwEXg6V
qCi/CvmM2RSFKt7RX2fuhTG0J0ogxmbE1ESaPKHt7sIV0MJA39mPxWJ8R3Q7TI88
p58ReDADotXNMnv7JT4ru0ckfLS/aBqulHBDQfS8A/sonTa6o1sDjPR9rKzltVbf
ryDExz3RgAALgTKAdNq0NLei2AirdpCfKNFZyh4Z8jN3iAOsQVIXImtfyn9LtwZB
tnwwxxGlvGC8BIzXKSAdgtfYEAFrkYgZPE/NIa9uZ8VBrYU4A9VrXuoVncKp2ZyP
nDEk96KujU+heQfb23NA
=CjNG
-----END PGP SIGNATURE-----

--O82bwzp7nMTZS6dV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
