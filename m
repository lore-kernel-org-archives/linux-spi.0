From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
 Zynq MPSoC GQSPI controller
Date: Fri, 24 Jul 2015 11:52:09 +0100
Message-ID: <20150724105209.GI11162@sirena.org.uk>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150715160146.GS11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150716085739.GT11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA81D12@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JUbEFkz87vQcUeYo"
Cc: Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"zajec5@gmail.com" <zajec5@gmail.com>,
	"marex@denx.de" <marex@denx.de>,
	"shijie.huang@intel.com" <shijie.huang@intel.com>,
	"juhosg@openwrt.org" <juhosg@openwrt.org>,
	"ben@decadent.org.uk" <ben@decadent.org.uk>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Harini Katakam <harinik@xilinx.com>,
	Punnaiah Choudary Kalluri <punnaia@xilinx.com>,
	"ran27jit@gmail.com" <ran27jit@gmail.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"computersforpeace@gmail.com" <computersforpeace@gmail.com>
To: Ranjit Abhimanyu Waghmode <ranjit.waghmode@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7CFCFE83B8145347A1D424EC939F1C3CA81D12@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--JUbEFkz87vQcUeYo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2015 at 10:42:35AM +0000, Ranjit Abhimanyu Waghmode wrote:

As I think you've been asked before please fix your mail client to word
wrap within paragraphs so your mails are more legible.

> To support the dual parallel mode in this controller, following minor
> things can be added to the driver.

> 1) Controller needs to know in which mode it is working, then it's
> obvious to set the appropriate flag for the same
> 2) There are more than one chip selects, so need to set the same
>=20
> So kindly suggest your view on the above request.

I'm not entirely sure what you're asking here from the point of view of
SPI, sorry - what exactly are you requesting?  If you want to add
support for new SPI bus modes please go ahead and do that, you need to
clearly document what any new modes you're adding are so that other
people can understand them.

--JUbEFkz87vQcUeYo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVshjYAAoJECTWi3JdVIfQrTwH/iGW8B+wWVA8yv3usL08Iand
PDOjYuDmwKik1jA0tvglRXq8lnaGi36GYi241O77SMuadpwNC/pp7+oYzLULexUl
feGMHfc0rCcvDRsNR/ovaHmPp+WGzu7dAmfonkh/+CYgCWnz+gdPVeL/6b2YlaKr
a6CxDx+tHHJtrEF2bpEM7sn+ZCU2D8qJbMmG9TBlSpRL/Mhg3mpZwHeJhhMvnOOt
UAab8dFIeKpyUT1yuQLvQCbI3Px3AXXK0AtQSCPHUXmGAgJ2v/MusF9KjWnLCn6X
Gum78OqCUsMzuYNvLV0RJfTGGPr3Debkiv4UJpUNJn88OcViLbCd8CaBYEsiZ+M=
=fYFJ
-----END PGP SIGNATURE-----

--JUbEFkz87vQcUeYo--
