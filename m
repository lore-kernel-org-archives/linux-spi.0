From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 10/12] spi: add driver for J-Core SPI controller
Date: Wed, 25 May 2016 11:17:08 +0100
Message-ID: <20160525101708.GS8206@sirena.org.uk>
References: <cover.1464148904.git.dalias@libc.org>
 <00b31c4d09c340bd69fd4bbbc0ea06371aecc502.1464148904.git.dalias@libc.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oXUzUgc67Nrfa9SE"
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Rich Felker <dalias@libc.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00b31c4d09c340bd69fd4bbbc0ea06371aecc502.1464148904.git.dalias@libc.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--oXUzUgc67Nrfa9SE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2016 at 05:43:03AM +0000, Rich Felker wrote:

> changes based on ml discussion of the v2 patch. The chipselect change
> has not been made yet, except for rewriting the current logic to be
> more clear. If the decision is that it's needed, I can do it easily,
> but it needs testing still.

You need to fix that, it's not good to just decide to ignore review
comments.  It is astonishing that you are doing this while expecting to
bypass the normal process for merging things.  I'm not going to look at
this version, please ensure you have addressed all the feedback from the
previous review before any new version you submit.

--oXUzUgc67Nrfa9SE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRXujAAoJECTWi3JdVIfQqhMH/32K7IAWR+uduXoH3KN6i8dr
2PyB0wzhOWkL0+C86z7D5HMDMjThbcO5imD6Lrha+lIh7BJEWnk+2T/IvAIqYsPk
Grkogoz5P65IF9F/aNlaH0Y7sW0QMSM982p7vcAMPWDnRrRxXkXupRvSXvDz3fIQ
u2IiC7ih25tZUynsbD8/SyMcnJ74/QT5Pndbe3Vd444ITxl7kkkqobUenSDPfKgq
YhnNiiKRQq3vv0Hn9yKQgtmCrTNv9AMJsSVCehWsI+6JMC0WGupYMchN2A3y03+h
Cz4lkC3s1RfhM9Nk2ie2Rq0Ql+W5IeMCi7LKLq5eGOYEIXN9rq4SkxY/ymiK0Sc=
=3xzz
-----END PGP SIGNATURE-----

--oXUzUgc67Nrfa9SE--
