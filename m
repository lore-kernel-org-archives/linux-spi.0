From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] of: Add binding document for IMG SPFI controller
Date: Wed, 12 Nov 2014 22:09:35 +0000
Message-ID: <20141112220935.GS3815@sirena.org.uk>
References: <1415828274-24727-1-git-send-email-abrestic@chromium.org>
 <1415828274-24727-2-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pJCrgSoq0Ldj8RFP"
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	James Hartley <James.Hartley@imgtec.com>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415828274-24727-2-git-send-email-abrestic@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--pJCrgSoq0Ldj8RFP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2014 at 01:37:53PM -0800, Andrew Bresticker wrote:
> The Synchronous Peripheral Flash Interface (SPFI) controller found
> on IMG SoCs supports single, dual, and (optionally) quad mode SPI
> transfers.

This is OK but please use subject lines matching the style for the
subsystem; people often filter on subject line when describing what to
read.  I do note that the binding lists the DMA as mandatory but the
implementation tolerates it being missing, this is fine since the code
is more liberal.

--pJCrgSoq0Ldj8RFP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUY9qeAAoJECTWi3JdVIfQud8H/3pe3bHtN5f7+tljerf9qKWv
6hgAKEORrHS9mMieTqb0bAKsv7WSAP7P1sZt8+eRVNHBiPAQ5KWB4BNk6JGpGTEd
zChO11UDiLT0bwhLmWn5flvtvfqypHKjsGrBER2EopuWZkYAglapjohwEf8rRdh7
J8d77YzYXuq6PGwXxG53Fn49T3I6iDi6sFchTjloHnr0ztJr3T0lTHE4fh9TKQIP
cPkB/5r1xAbSkyTLUlJwOoKiyYQ63fe/+QNIX6I9jUGMySupeoIJLGvCA90MRl2e
FmEEx56hVIszyHlzXxq/o2gZrCP+FiL47m6HZMRmXCs3mvST6p7TILTuw9kML3Q=
=YnDi
-----END PGP SIGNATURE-----

--pJCrgSoq0Ldj8RFP--
