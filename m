From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] Revert "spi: s3c64xx: Added provision for dedicated
 cs pin"
Date: Thu, 17 Jul 2014 19:46:56 +0100
Message-ID: <20140717184656.GB17528@sirena.org.uk>
References: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
 <1405523950-2231-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SuGb6p5JEpzYJdwO"
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	Olof Johansson <olof@lixom.net>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1405523950-2231-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--SuGb6p5JEpzYJdwO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 16, 2014 at 05:19:07PM +0200, Javier Martinez Canillas wrote:
> This reverts commit 3146beec21b64f4551fcf0ac148381d54dc41b1b.

For the benefit of those who haven't memorized the SHA1s of every commit
that's "spi: s3c64xx: Added provision for dedicated cs pin" - please
include the human readable format whenever you reference a SHA1.

I've applied this.

--SuGb6p5JEpzYJdwO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyBodAAoJELSic+t+oim9QRIP/AuVtgr3Zc28JmD8GRipCoGG
WRNS6pELBUaiyIBRbr4Cp65ghHEoLnfXlta1oPiTK9i6PQZ87P/NUCOacqQpn0ss
VJo27Q3IQ2TqyFvOqFl+jE+3g15WDUhVqoaAAKvGQpnOfe6pByUoqFljdQKZlQzQ
93CFUIWiZr2Fh8yhdImRPKso9CGt2povajAWW/2qG4/31o4szsla3htSK6I94vf0
WQ159SlbnHK80jNWn0wBiHM2snKFYkmDZOVqw5s8qacYZBRx4qMhBJci1aJ5zevs
yqFfZvbsJ/1m+yEIvnmpmBQn6X+kmIqRwT67kC2VpTQ8j9ZLVLCFEwpE7xXm5Vsc
GeL8nv5bYMhoDg6W3mlaMHlUNpeijGmKQwRWNPFByB1zQwxmhDYhAHI1jZtgMyrM
FZAO1O565kpxBO/r5v4t/QdgqZI0T3HQqFHT+Ea0epvphfuep2EE409hND7ewtWu
G7loYUaBC4BKYADFMhlu4zWBpcYdpJXxzWM0Zv+/HIoxmKIeRpKJkMzla7BtwHiT
shFPD7nJ3fZOkCdkKXQCYE8CaAxKwQKja27lzNL3pQHZef/7Uat3ytQeXIqR7xmq
2WD2CKgk/l9W5TQ3FZKt5FwX5G409URIEBw+f3N8SuybYIUfAquXAVknqmZq4Txr
LDn7sgs7ZFFkQ86Ma4bL
=pjcX
-----END PGP SIGNATURE-----

--SuGb6p5JEpzYJdwO--
