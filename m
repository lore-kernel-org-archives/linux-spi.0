From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: spidev: only use up TX/RX bounce buffer space
 when needed
Date: Tue, 24 Feb 2015 00:46:24 +0900
Message-ID: <20150223154624.GH6236@finisterre.sirena.org.uk>
References: <1422643413-21796-1-git-send-email-abbotti@mev.co.uk>
 <1424098847-14390-1-git-send-email-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LWVQOr/QoF/fPPTS"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Ian Abbott <abbotti@mev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424098847-14390-1-git-send-email-abbotti@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--LWVQOr/QoF/fPPTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 16, 2015 at 03:00:47PM +0000, Ian Abbott wrote:
> This patch changes the way space is reserved in spidev's pre-allocated
> TX and RX bounce buffers to avoid wasting space in the buffers for an
> SPI message consisting of multiple, half-duplex transfers in different
> directions.

Applied, thanks.  This probably goes to the other extreme on changelog
verbosity!

--LWVQOr/QoF/fPPTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU60tPAAoJECTWi3JdVIfQn1IH/1TnH0vOL30l/NdGoJ0LjbkC
Z75oJikR76mCsZbjhVO3fZhyqGhiFF2cRS341jumDubNbdBR/CCfhyVaQ/ANCHAf
QheOQ38VqjEEfks16ZHP9oGAbuihG1EVloGTlC5X/LL64wXUh/L4wd4s4cS76QTe
WM8Q83bcXmIQYFFZTodLCzcg3mcy/NMQm7829D7KdZNs8+lKPC91+2u5nhov4laK
jIr59JPIbwmHo4VZOk6yXbQedVx8GYh73uaRJegJ39y4oa64AmavJ1Z8+IuBWJBa
eycp89FM2av6DSxTH2eqjqUkyuQKnsyCEP7CP/gXsmBoUdtcQzscnfEw+I7U1YY=
=LQ9l
-----END PGP SIGNATURE-----

--LWVQOr/QoF/fPPTS--
