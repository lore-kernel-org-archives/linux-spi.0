From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v2 1/3] spi: qup: Remove chip select function
Date: Sat, 21 Jun 2014 11:13:03 +0100
Message-ID: <20140621101303.GE5099@sirena.org.uk>
References: <1402601652-24641-1-git-send-email-agross@codeaurora.org>
 <1402601652-24641-2-git-send-email-agross@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMPRVcIY2SVCbCAc"
Cc: linux-spi@vger.kernel.org, Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	"Ivan T. Ivanov" <iivanov@mm-sol.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
To: Andy Gross <agross@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402601652-24641-2-git-send-email-agross@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--dMPRVcIY2SVCbCAc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 12, 2014 at 02:34:10PM -0500, Andy Gross wrote:
> This patch removes the chip select function.  Chip select should instead be
> supported using GPIOs, defining the DT entry "cs-gpios", and letting the SPI
> core assert/deassert the chip select as it sees fit.

Why?

--dMPRVcIY2SVCbCAc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpVqrAAoJELSic+t+oim9WH4P/3DIoc4zhoOmkCIcHckB0/GH
wB+wI0Gta/ewzJx5MMuUvJmm75lL1C1ITb3QjP7kljk+kpbLX/7idQtqfzetlPuR
ukFNfNJ3jWzmI3C/DYd21ucWSnT+gDdsGUIMEQFTE+SXexFOUCzBHORs65bFk6yp
9pEMxtJjNLiGRUKgNrv1TrQCTkMSNIg2e/1aTAdB2br3S6a2UpT0PhL3D4nWhuIl
rAWeTFtiisGluhQkvGcu8RUkLYk0d9Pv3EZACDGjzcEvjvxOM+uuXxxHR2ky2zi0
Ay61a9WsSG6fbKlKjH+d3EXqYp+f1sCnQZhTphuMEyhfIcLHnU32fx1YwWqmU2lf
aZrGZjXvbbUvNGIzJc3AayxoD5UTG1jggypPtaZ/SSnKqxoQr9aUJzcVMsEHOumK
ATfZKwiPGW52W73iU2kIl8blXlzhP4NNfTxjpDqxEvxHyVP3SEKCDyvMwTqfd4u0
RKKzvinpce/ae7sjCWvfTDfBONjxLnt3u09gcUryPulDjmcPYKES9psJ18T1u/jf
tN/B2HXiymPMWSR7JgnfA05Avds2C6lKn1uvBiZ9PPC+TjIa+2DngWkV6AWYWB+t
rL/6g2ISqdD0S6CdvkajEunLUp2tPNeJelF/mfzs5JPuTt/cEyRU+cPuC/wGfhBo
/vztYfei1u4IJSYVnBVV
=1CXQ
-----END PGP SIGNATURE-----

--dMPRVcIY2SVCbCAc--
