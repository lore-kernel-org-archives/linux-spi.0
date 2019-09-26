From: Mark Brown <broonie@kernel.org>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver
 is released
Date: Thu, 26 Sep 2019 08:17:52 -0700
Message-ID: <20190926151752.GU2036@sirena.org.uk>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
 <20190926121438.655f1f10@jawa>
 <CAMuHMdVBrKnA3TJnOEG0G0FVKf7VwQUvLzkmJc7DAX4kvHYWYQ@mail.gmail.com>
 <20190926144342.327a3c66@jawa>
 <CAMuHMdXm+vUB4iRTsTq64Kg2KC2p7AA1TwFgjc7FuCeiS9EG=Q@mail.gmail.com>
 <20190926160645.0a2623fa@jawa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ksG33M87StcVQX10"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190926160645.0a2623fa@jawa>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ksG33M87StcVQX10
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 04:06:45PM +0200, Lukasz Majewski wrote:
> > On Thu, Sep 26, 2019 at 2:49 PM Lukasz Majewski <lukma@denx.de> wrote:

> > > The question is if we shall call the spi_slave_abort() when
> > > cleaning up spi after releasing last reference, or each time
> > > release callback is called ? =20

> > TBH, I don't know.  Is it realistic that there are multiple opens?

> I'm using on my setup only one test program to use /dev/spidevX.Y and
> /dev/spidevA.B (loopback with wired connection).

> However, you also shall be able to connect via ssh and run the same
> setup in parallel...

It doesn't seem entirely realistic, but I can imagine cases like
fork()/exec() where we end up with two copies of the file open
but end up immediately closing one.

> > That means the abort is called only for the last user.
> > And only if the underlying device still exists.  Which means that if
> > it has disappeared (how can that happen? spidev unbind?),

> In my case, I just disconnect some SPI signals and the test program
> just hangs. I do need to ctrl+c to stop it (or use timeout).=20

> From my debugging the .release callback is called each time the program
> is aborted (either with ctrl+c or timeout).

Should be on file close IIRC.

--ksG33M87StcVQX10
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2M1p8ACgkQJNaLcl1U
h9Bsuwf/TlamYDm91mr1XHOC0hjSttkgh7Ert2fFhfaEAohEeAJN0x/rC8/LkLHD
XovhNkcxgUTfwfmU3mvS29CPqI5+bweRlut92TYTwqz8rPFJC2l9XxlKOI7uQVlr
p5+A8L7oIJcgWEjtKezRGh8YWRKJJVRkwUe4LyX2TstNVXtXLxZAIdtf6pdQEfoU
amOsXhJEG0nCtvXh/aay47c/wqs1WGHVrfTtVmUSsWaE7uXC46aDlTJLeGC1pCQC
3Vd/ZHtnneCngsCCxXOzg6lxFXTshzjltHBzhR4qQXlCAg+LqyEAHS4u4+6BrySI
x4UI4SRNKp9gkxM42VwNXzxBv+1qAg==
=WTW0
-----END PGP SIGNATURE-----

--ksG33M87StcVQX10--
