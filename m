From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] spi: qup: Add DMA capabilities
Date: Sat, 7 Mar 2015 11:21:09 +0000
Message-ID: <20150307112109.GJ28806@sirena.org.uk>
References: <1425463325-25805-1-git-send-email-stanimir.varbanov@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C7PTD44AewjTsiSV"
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Andy Gross <agross@codeaurora.org>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425463325-25805-1-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--C7PTD44AewjTsiSV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2015 at 12:02:05PM +0200, Stanimir Varbanov wrote:
> From: Andy Gross <agross@codeaurora.org>
>=20
> This patch adds DMA capabilities to the spi-qup driver.  If DMA channels =
are
> present, the QUP will use DMA instead of block mode for transfers to/from=
 SPI
> peripherals for transactions larger than the length of a block.

Applied, but why is there no devm_dma_request_slave_channel_reason()?

--C7PTD44AewjTsiSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+t8lAAoJECTWi3JdVIfQs4gH/0nm7+UyZMKhHaNG8wqmRR4o
Q2trD/02vP3Ftdf2FV9Cr56HRpIYWUXqXF4vX9agqu3lWlWCFInmXS92bRfEeEFu
oqlaIXjL3rCHWotNM/WkaDxDZjHz9kC0+2EyieOpaTsDHivw7dXKcTzHelcJyoB2
58LGjB+QDCPAJwdGHVNM40Hm0eSvMoTXf69EFdKWS+LLaWr9BP9ZRDrGn6IdjROL
prC0P7CgfVXvWTFVaSTNjJ19Ob1RhoMjiWu1ePuFhtqcx3tU1UenrPkji1jJM0rc
4OP1skvOhWv7KWFBGx2tUb43c3fvESUQHdNoR5pB7o/lLOtauoCN4fGwylJ1H4Q=
=98XD
-----END PGP SIGNATURE-----

--C7PTD44AewjTsiSV--
