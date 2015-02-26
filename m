From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spidev_test: Added functionalities
Date: Thu, 26 Feb 2015 11:01:06 +0900
Message-ID: <20150226020106.GU6236@finisterre.sirena.org.uk>
References: <1424891324-24784-1-git-send-email-adrianremonda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="skgCfLFhCSVZJUH9"
Cc: Jonathan Corbet <corbet@lwn.net>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
To: Adrian Remonda <adrianremonda@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424891324-24784-1-git-send-email-adrianremonda@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--skgCfLFhCSVZJUH9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2015 at 08:08:44PM +0100, Adrian Remonda wrote:
> This is a patch that add functionalities to the spidev_test tool found
> in Documentation/spi/spidev_test.c.

> - Cleaned hexadecimal dump
> - Added verbose mode to see the transmitting sequence
> - Added input buffer from the terminal. Now it is possible to send
>   string and hexadecimal data as an input parameter:

Since this is doing several different things then it should be a series
of patches rather than a single patch - please see SubmittingPatches for
advice on how to prepare patches for submission.  It is hard to review
changes which do more than one thing.

--skgCfLFhCSVZJUH9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7n5hAAoJECTWi3JdVIfQNGwH/Ri/NJss2tT7za5c7bGYSEsY
gu7gJVs9Qssg43WGqCUY+V772seAVfiHfWJgh58rHqY1sCs+W6U3CXJRU+t5py5P
A02PIxHYem/y1xvP/oIxpZNJV6ajgEd+EJzKeYQHtnjDOfuJtX+KI8DQdUi6lMkD
SKw7iILDI6xBZ0ghfr3TA1+AWeav8xR7xuc9T6JOnAnRwrseu3s6USSE/4CCqU8W
veowrLMWVnyXKabp9ggx7XayhHioQ641nrtuLgrdsO8gLD0iIfa88ALb0f6pgEsB
SG4nalW47MZNxU8a+AkQytElelUlDTwVjdeJcJzlQ5DqFi33+v9h5JDa+splBRE=
=OlM7
-----END PGP SIGNATURE-----

--skgCfLFhCSVZJUH9--
