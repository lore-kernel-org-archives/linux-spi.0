From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: bcm-mspi: Add support for Broadcom MSPI driver.
Date: Thu, 14 May 2015 21:12:21 +0100
Message-ID: <20150514201221.GX2761@sirena.org.uk>
References: <1431452293-16697-1-git-send-email-jonathar@broadcom.com>
 <1431452293-16697-3-git-send-email-jonathar@broadcom.com>
 <20150512191718.GW3066@sirena.org.uk>
 <5553E31A.8060309@broadcom.com>
 <5553E9FA.4070708@broadcom.com>
 <20150514103144.GO2761@sirena.org.uk>
 <5554E715.7070203@broadcom.com>
 <20150514190823.GR2761@sirena.org.uk>
 <5554FDB4.50809@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tvtG/WQWmfqkB9kQ"
Cc: Scott Branden <sbranden@broadcom.com>,
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
To: Jonathan Richardson <jonathar@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5554FDB4.50809@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--tvtG/WQWmfqkB9kQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2015 at 12:55:32PM -0700, Jonathan Richardson wrote:
> On 15-05-14 12:08 PM, Mark Brown wrote:

> > All it takes is one hardware engineer who sees a SPI controller and a
> > GPIO they can use for chip select; I wouldn't be so sure that nobody
> > ever fixed this up locally (or happened to use a device that only needed
> > single duplex).

> Hi Mark. Would it help if we just set the flags to half duplex using
> SPI_MASTER_HALF_DUPLEX when we register the master?

That would deal with the data corruption issues, yes.  Though it seems
like there are some people who want full duplex support here - I don't
know if any of them can point you at suitable hardware to test?

--tvtG/WQWmfqkB9kQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVQGkAAoJECTWi3JdVIfQa74H/0w3k4rEjSKo2cIArSVb45X+
pqZzxht4+cfRjdBkrEZHKVSz15m04xNL23Lch/9Z6Z3G8uIWlw2yaoD3R38E63s5
jLz14PmvxOYeIaUcgdLhv3o2cK+pCDlRiobmOTBvDaPyHyD89mWeEhpZg7KrVDG6
6G+6TYMEfJEfBNuIbl6JWyIa6Q+CcSTlSWg3cNSLjK7q9/gJYEi0LbFSaEu4mkS7
kVYaGILDUpUIb1/fKvSM3axvV2V3Snv9+uWRp3KjRXx/WQhHwahAiwxVxtqJLI4n
xcxteAPB39xf4nb2XuJnZtXTuISBHOKQ7ReRTuWnGlxJBhfoVU0kJlOHy5PuA44=
=wgzK
-----END PGP SIGNATURE-----

--tvtG/WQWmfqkB9kQ--
