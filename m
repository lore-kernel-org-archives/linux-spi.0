From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: qup: Add DMA capabilities
Date: Fri, 27 Jun 2014 11:50:57 +0100
Message-ID: <20140627105057.GF23300@sirena.org.uk>
References: <1403816781-31008-1-git-send-email-agross@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ozdenm5Azl6mQ8k"
Cc: linux-spi@vger.kernel.org, Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	"Ivan T. Ivanov" <iivanov@mm-sol.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
To: Andy Gross <agross@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403816781-31008-1-git-send-email-agross@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--3ozdenm5Azl6mQ8k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2014 at 04:06:21PM -0500, Andy Gross wrote:

> +	if (xfer->rx_buf) {
> +		rx_dma = dma_map_single(controller->dev, xfer->rx_buf,
> +			xfer->len, DMA_FROM_DEVICE);

It would be better to use the core DMA mapping code rather than open
coding.  This code won't work for vmalloc()ed addresses, or physically
non-contiguous addresses unless there's an IOMMU fixing things up.

--3ozdenm5Azl6mQ8k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTrUyOAAoJELSic+t+oim9g64P/0DCLX3QOf409MCNcPwrkB4k
CO/xvPxt70PNhbPO/Ari3MdqcuLJv1PtobDMlSFEgiWtE5ApwK7CbFX4O84aYjFb
mtiTQQc29mjvPzoJ2DNcfNuch4880/CseAdHBYvcgsG6787UDSt7eLJjDJLuRmnX
ccpoPKwbkPAq0klGWOGZ6vf3Kjeu4YA6Iq+s83CYhQEJ0uZr+YTBHPuauhRNsFAM
sJ7YTkc3jTLmM4nIWBtol/llL0byZcdpD/TCPwCrXqoeYJDaTqhZJ/RjFgsxKtlf
1F1gyPk4Nay/mqJ8d3HU/Yx4jj/k1rYeJAVsFvff7jwusY3+Sqyq81K6naohsi0x
PccU9xMiSv5QVBka/2i3MawsAoiqwRI1xNSY2Z1o14neJI1jz1iffMhLKuu48FwJ
hD1NXVYqm6msbGSav5KSnySuxoBZuekOty/kl3vX08mVlOmVuWnJSMnVUygK9mX9
sx1NCVdg1XL85mhyShqVH9SGM8XAh5eu2mmrJo3MyRQM7V7GqBNakRpQ9OfOFTQo
HptjIMpNwy68EkBPlS/stIO6RDWQ6W48bBcQyoUOJBuhZOY3lCx/hkYx3aI3ceBs
nLTWAyF00He0WLu50679lmg8vfxGiuIRjDC/jble/bGcWbzSRc9G1UPwdo3MmHH7
pKlT3865UCYcX0hEjxLc
=YGCI
-----END PGP SIGNATURE-----

--3ozdenm5Azl6mQ8k--
