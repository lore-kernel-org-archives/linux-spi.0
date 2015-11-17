From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/8] spi: Add file i/o to spidev_test
Date: Tue, 17 Nov 2015 16:53:28 +0000
Message-ID: <20151117165328.GT31303@sirena.org.uk>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <20151117153746.GS31303@sirena.org.uk>
 <2760715.DGIOLUoqL9@jclayton-pc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nDmTXYS4kVhtHHfR"
Cc: linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>,
	Adrian Remonda <adrianremonda@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2760715.DGIOLUoqL9@jclayton-pc>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--nDmTXYS4kVhtHHfR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2015 at 08:15:45AM -0800, Joshua Clayton wrote:
> On Tuesday, November 17, 2015 03:37:46 PM Mark Brown wrote:
> > On Tue, Nov 17, 2015 at 07:24:20AM -0800, Joshua Clayton wrote:

> > >   Documentation/spi/spidev_test.c: use one rx buffer
> > >   Documentation/spi/spidev_test.c: clean up input_tx
> > >   Documentation/spi/spidev_test.c: accept input from a file
> > >   Documentation/spi/spidev_test.c: output to a file
> > >   Documentation/spi/spidev_test.c: check error
> > >   Documentation/spi/spidev_test.c: fix whitespace

> > Please use subjct lines reflecting the style for the subsystem.

> OK. Will do.
> Assuming "spi: spidev_test: yadda..."=20

Something like that.

> It was a bit unclear due to the location of the file.

It's not really the location that you should be focusing on, it's other
commits in the file.

--nDmTXYS4kVhtHHfR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWS1uHAAoJECTWi3JdVIfQLDUH/1E9AnPKjh4geL3RQlOZ4zCk
YWe9Z2Axlnb7Gcr6ldatE3HqsSBKbJOQHPLk2TJlvNvzpD5JwJRiOT/eHoFJvVaD
zk6h+WxKSNxnuHJUSboSrpQ6IPDhBHwsMZ+CFSo63tlTId7dGxC53kKkKQV+X77g
uwEImDEt+0f6HLQLM9s1scvLSfvRlq4CttcNONWVQ59DfY31s1ur/Hv2UlgWuHnG
oaKbQM4gMEZhV0lrrGMH1BJyOA8jjAx7B/+fJQeQWk6OxUcIpUK7VtSfldwNF7A1
nS1P5caRIcDH2CIDqIQkIYSflwsimsXDVxq5paJwoXgdsJKksHF+jBX5RHjdfPU=
=J2gl
-----END PGP SIGNATURE-----

--nDmTXYS4kVhtHHfR--
