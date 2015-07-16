From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
 Zynq MPSoC GQSPI controller
Date: Thu, 16 Jul 2015 09:57:39 +0100
Message-ID: <20150716085739.GT11162@sirena.org.uk>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150715160146.GS11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nvwB+Y2gyxL5aXTF"
Cc: Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"computersforpeace@gmail.com" <computersforpeace@gmail.com>,
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
	"ran27jit@gmail.com" <ran27jit@gmail.com>
To: Ranjit Abhimanyu Waghmode <ranjit.waghmode@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--nvwB+Y2gyxL5aXTF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2015 at 07:27:34AM +0000, Ranjit Abhimanyu Waghmode wrote:

> For an example take two flashes connected in stacked mode.
> For user it doesn't matter whether how many flashes are really connected.=
=20
> There will be situation like, single partition is spread across two flash=
es (partition staring at the end of one flash and continued to the second f=
lash). But it has to be shown contiguous to user.
> In this scenario, I am not clear how MTD layer will handle the case.
> It would be great if you could just put some light on it.

That's something for the MTD layer or possibly even a layer above it to
worry about - this situation is the same as we have with disks where we
have md which combines other devices, if something similar is needed for
flash we should use a similar pattern.

--nvwB+Y2gyxL5aXTF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVp3ICAAoJECTWi3JdVIfQFH4H/jgoYSPT5C2B/zTNqOObAyHF
fTf6kdLH3FXQaw5nenrlDtmAKe4I7jEx3Dc+pqKCQTyu6PazwiIVzFgg36NmaK21
IS2H8bScruoIq+Ur2776UaTgfA/AWBfxLasUZSF9TO1zKKh7c+WcyIG+2BTn1Jnb
4RrT7HNX8QYZ6mSIo1VfsxBM0MkwHfB6QtTZMSQm6Z968J1bqM4gI2scyq0OXsWT
kveJeJiDYV82leFGfqhFUIDB4ySrFoAkYja8VDQ0cd3H68LJkFc9lziV92HRvqFm
6iu8l1ZM+BkjPK90G6SOuk8hEH97O1XAvYawOEDhZTqh7wolAXiOfJjjLKkO99E=
=phUr
-----END PGP SIGNATURE-----

--nvwB+Y2gyxL5aXTF--
