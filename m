From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: core: Fix logic mismatch in spi_master.set_cs()
Date: Tue, 14 Jan 2014 13:45:28 +0000
Message-ID: <20140114134528.GG15567@sirena.org.uk>
References: <1389699411-29135-1-git-send-email-geert@linux-m68k.org>
 <20140114125242.GE15567@sirena.org.uk>
 <CAMuHMdVmSUh8yphZ4oPR=QYp5uMS9BXgPRVuwa19S9q7jWxxiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVmSUh8yphZ4oPR=QYp5uMS9BXgPRVuwa19S9q7jWxxiQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2014 at 02:23:37PM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 14, 2014 at 1:52 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >On Tue, Jan 14, 2014 at 12:36:51PM +0100, Geert Uytterhoeven wrote:

> > This also pushes the handling of CS_HIGH back out into the driver which
> > doesn't seem like it's helping anything.  Flipping the sense of enable

> It depends: on hardware with separate register bits for chip select polarity
> and chip select assertion it avoids having to invert the enable value a second
> time.

If we're manually setting /CS it really makes no difference what the
chip thinks the polarity is - something that is controlling /CS
autonomously can't implement this operation and something that can just
set it at any time doesn't need to worry if the chip thinks it's
asserted or not.

> > when calling set_cs() is probably OK though.

> Just flipping the sense of enable still needs a documentation update.

Huh?  Why were you updating the code then...

--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1T91AAoJELSic+t+oim9tIwP/2/SgvM2l05oxvTaRmpUMjvP
c20RIruqXkijo0g9QoNPHVAK65dk3S5TuPwo61f/T8LPQ8brA3g/x1y1AbHs7UhU
0q2+vZJ9y0WnwP+8Mh6O401TcnMlspAYJ02e6U+fNCx9eHvDAsz/eIxIDr2Q8uuy
LIWQRaF+HSHzO8OhWs6Ce8Jlk3hCw5AJQDqs8El3oa4ZQVBACkyxo1o8/YknVn5V
KyFQ5DW+UsFePI1uPHs27itYSS608Yr1nfgn2JPlMx+en7jEfPAk7hJm7FaZHfO9
N65LfUYr4PjGBbVLxbd8Fo/v76lbOhpyJpyIpre3FTeD4Kw6G66wEe/qd9Y+XvVd
9cvFRY0mGPW1S6WPCnJ+cB+a4Ot0V5kQnYfUqrEeOD32rQizHTG6hfpT0JWF+xeG
A5q78wadsdcVp9zraHWbw16r5bJmi4cCr6DOxbgwpMJ9Ev3CVfZRqWSyUci62jjL
2Ai2QEfm364z9PhxGk/sC5Nu7CKott5z6qgQrAL+eD7fLf24ce+t1gHWOBVUf/+F
iGU4wP9Njz3sPnAC/yzFqDmNqV/AMxuvA9ngM9wqD3pehKmXm3gGpxhxVZa+YOxr
5mtnhTfkAti+uo+aYlpsTikMvBDiMY4iDOBrrgDaTW6FvvtSroASNZFfhYbiGve4
UxapnPH/NefQKzE+2E8J
=rdbn
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
