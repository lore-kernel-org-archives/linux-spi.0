From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 4/8] spi: rspi: Add support for 8-bit Data Register
 access
Date: Mon, 13 Jan 2014 15:55:07 +0000
Message-ID: <20140113155507.GZ29039@sirena.org.uk>
References: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
 <1389522464-1569-5-git-send-email-geert@linux-m68k.org>
 <20140113122912.GT29039@sirena.org.uk>
 <CAMuHMdViLJD9O4gnovR6x7RTWor9GYPBZuzP5X7JmVw5g=o4kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cv++WRjpEUwHXUCE"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdViLJD9O4gnovR6x7RTWor9GYPBZuzP5X7JmVw5g=o4kw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Cv++WRjpEUwHXUCE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 13, 2014 at 02:29:28PM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 13, 2014 at 1:29 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > This looks very strange - if no platform data is specified the value set
> > for spdcr is one that can't be arrived at via platform data.  What's
> > going on here?  It'd seem more idiomatic to treat missing platform data
> > and a zero data_width identically too.

> The else branch is also taken when platform data is specified, but
> data_width is zero. So you can indicate legacy 16-bit data width through
> platform data.
> It's unfortunate that the bits inside spdcr to configure the data width are
> different for RSPI on SH and RSPI on ARM.

So what you want here is either a separate bit of platform data for the
architecture or just some ifdefs.  Deciding what architecture the driver
is running on based on platform data isn't at all clear, someone is
likely to come along and fix this as a cleanup at some point especially
given the lack of comments to indicate that this is intentional.

--Cv++WRjpEUwHXUCE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1AxYAAoJELSic+t+oim9wQUQAIRr7JPLgvFQabHO9t+ZiCTs
hJx/j5NjuW2NHH/c2xiA+cXX8YSupvY+rYgAD//rYdhrd8cJuZrcVGwBDcbR68Dw
86avUIubhnxn7MuNgLhY73mTLiTKdsiPlrnk5cX+q+x4c6jzwIV7Osn7oPiB6M7r
tNou8IQ8l6lyiHo9Jo3SqHet6CIPM905Wc78agWLwZ01AZWUphul5eh0yKnct57z
SEFswOImRZvA4R4sYzXOmB2xCSNR47zfxPlQiMb/Fpw2QBfWcyhGF1P1/lCl339K
QjcL/YGjCXSNlukfEU2lEAcUiHjSi/KoY1nQT4O3M/3cOV5GJUUtand6p5WzOr3t
pNV4Jem/YzmdNoeDRHPqDZwhT5wm7oY/AQtqXkdgcowj8upVJKvq06mjPdDkFN3S
J/swgRvGL+oH+aHskdVfCLTWc0mm4EM90sOjxcOhBbbLpiUcGTWva0YeixD4etb5
oaLavOmk/hBcvyy+SFxI0uF3/SUnLxire+vMwLnSOsEijpApwqnyvQEYJnnPawGd
UsLsb2vrdrP6ZJ5dbwEThB33DnT6qOiRTF5iT7H7mCyCMin0id4hXVfP3tyT5cNC
s9AxEEu8I//sI+o1JvcGOjhh+lTjQ58oH4vnicgLcqGKx/HJ92SL6XymGXmEBR8b
63PgHjpt9KBQg9XWRFBM
=0Wwb
-----END PGP SIGNATURE-----

--Cv++WRjpEUwHXUCE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
