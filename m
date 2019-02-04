From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ARM: dspi: Provide support for DSPI slave mode
 operation (Vybryd vf610)
Date: Mon, 4 Feb 2019 14:03:56 +0100
Message-ID: <20190204130356.GF23441@sirena.org.uk>
References: <20180927150709.17010-1-lukma@denx.de>
 <20190109082644.14941-1-lukma@denx.de>
 <20190204113001.77d59570@jawa>
 <20190204105737.GE23441@sirena.org.uk>
 <20190204135242.7112d48c@jawa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Cc: Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204135242.7112d48c@jawa>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 01:52:42PM +0100, Lukasz Majewski wrote:
> > On Mon, Feb 04, 2019 at 11:30:01AM +0100, Lukasz Majewski wrote:

> > You've been sending ARM: patches to me (the SPI maintainer) and one of
> > the DT maintainers.=20

=2E..

> Moreover, I've CC'ed developers (Esben, Andrey, Martin) involved in the
> changes for previous work done in this file/driver.

> And those changes are solely related to SPI work in this driver, no ARM
> Vybrid.

If they're SPI patches they should have a changelog that looks like a
SPI patch which means that it should start with "spi" (see other patches
on the list or git log for examples).  When your patch subject lines
start with ARM: that means they are for arch/arm - I don't 100% know but
I suspect I've just not got far enough into the mails to notice that
they're for SPI, people do send a lot of patches that just happen to
mention buses to maintainers for those buses.  In general you should try
to make sure that the subject line for your patch matches the style used
in the relevant subsystem.

> What else shall I do?

You'll need to resend the patch, preferrably with a suitable subject
line.

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxYODkACgkQJNaLcl1U
h9DgQQgAgIDt2K7uNIIQCWmf0tz+YhIqnAV6fh/hvA12LQbTpN4ftZoMo5rgPbRH
JWreTvSwfdGdZzirzndN+UhweiK4x6JoqZRbrRFbGKxzRHNbp+n03fzNc0M14n1B
EH4nm4vyVzVmMND/HgJGuD2UcQaObYqU/4gVzDPrMJKkPVMPBeyQkUpW/p2A36Ga
I+UsFv9rCzBAF+X+wI/DEvAGT5R3ZdKUrii5cHuivaqNnUlGBdfi3JUgtv4n4bQh
HTdCR3ElX7QgA1lAeGxesmIZFYga/5BrKsxXabGgwzccIArFSdWtnlPuicmHbWEV
wqCsLjz17IPcjB0SH1tuUOAQXWo50w==
=yqeA
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
