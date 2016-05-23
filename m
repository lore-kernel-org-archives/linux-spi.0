From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spidev: fix possible arithmetic overflow for
 multi-transfer message
Date: Mon, 23 May 2016 12:15:21 +0100
Message-ID: <20160523111521.GQ8206@sirena.org.uk>
References: <1427133027-8134-1-git-send-email-abbotti@mev.co.uk>
 <CAKdAkRTEWthr6+FjkyukKN0-1YDAziy91Ww+tTOOE4MGkH2k1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SlnaBQtdWG0gYnqZ"
Cc: Ian Abbott <abbotti@mev.co.uk>,
	linux-spi <linux-spi@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>,
	"3.8+" <stable@vger.kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKdAkRTEWthr6+FjkyukKN0-1YDAziy91Ww+tTOOE4MGkH2k1Q@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--SlnaBQtdWG0gYnqZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 21, 2016 at 09:50:35AM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 23, 2015 at 10:50 AM, Ian Abbott <abbotti@mev.co.uk> wrote:
> > `spidev_message()` sums the lengths of the individual SPI transfers to
> > determine the overall SPI message length.  It restricts the total
> > length, returning an error if too long, but it does not check for

As documented in SubmittingPatches please send patches to the
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--SlnaBQtdWG0gYnqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXQuZIAAoJECTWi3JdVIfQqagH/j/J2b+ivkF4Z8Vg1/98/Otm
v3/X9SL8gs0TPVVs50dpLuf80D0es1LKkEWemgJiyqqgDnBYdM1G4D9QIRTKo0/N
Y98Ec7NTR+IgQoiuUEhzGWtDziiHoHpkznY5FcRNjbQcJS/N3Nng63D3qISHjyUx
O7d9JRTbJyQJt+2sWuoKvlo7CctLtIXEkD9fngZddSfQU1ZYNlf+GkCzXZkJnARc
AaPeMENdna3q0yWxvCbZ69J0bWOL4flGMAgNEmVbNTnUYyyJVS2f5b4y4fv6+wOM
HJa9n0voWGG7jmlguvFupmTzKNzHUURNjFCsLKZLk0SCBwK9ELzftLHCqFCZ8VM=
=up+5
-----END PGP SIGNATURE-----

--SlnaBQtdWG0gYnqZ--
