From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: bcm-mspi: Add support for Broadcom MSPI driver.
Date: Thu, 14 May 2015 11:31:44 +0100
Message-ID: <20150514103144.GO2761@sirena.org.uk>
References: <1431452293-16697-1-git-send-email-jonathar@broadcom.com>
 <1431452293-16697-3-git-send-email-jonathar@broadcom.com>
 <20150512191718.GW3066@sirena.org.uk>
 <5553E31A.8060309@broadcom.com>
 <5553E9FA.4070708@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VjpKO6h983+pAmpQ"
Cc: Jonathan Richardson <jonathar@broadcom.com>,
	Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5553E9FA.4070708@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--VjpKO6h983+pAmpQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 05:19:06PM -0700, Scott Branden wrote:

> The purpose of this mspi interface is to connect to NOR flash.  There are
> other SPI interfaces on the devices used to connect to other SPI devies.  We
> don't have any need to support full duplex slaves on this port (NOR have any
> hardware wired this way - pun realized after typing this).

Chip vendors often say this sort of thing and then get surprised by what
their users choose to do, and even if it only ever gets used with flash
all it would take is some new flash command which can use full duplex
for something.  Please write the code so it at least tries to handle
full duplex operation, if you can't test it fully that's not the end of
the world.  It doesn't look like it should be particularly difficult.

--VjpKO6h983+pAmpQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVHmKAAoJECTWi3JdVIfQXecH/jQw7X3dDC47kUIwKGYUSwGN
cDlDZ/td42IGqPfFFc6DCAp3LVPqSzYdWBgBIQWc92UEsAGRi4FJhNFB9usk/jzT
KsXCn8d/99l/lct6zGWG0G4Incr+FVu7s2miZup0xlv8Qiu7hF0uF3zdlJ/MYSAK
l5KpHWY6rolxT1BvYkhVxLYyJm5BXxpegzyS8DA7b1Aw9cSf8cu6EFfduScTLDH3
wj6MZIMOUz6RID6nxiGCd7jmi3I4i+RHHwq9Me1ZT9hEe6sH7TtW3jGgTUhEhYMN
/5+0purX147gYWHpaJ3LDlF/iej6Q7N9TKBOgffvfvNYMlsobbdHduZsomjJ4Jg=
=+ui+
-----END PGP SIGNATURE-----

--VjpKO6h983+pAmpQ--
