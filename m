From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v1 4/4] spi/xilinx: Use of_property_read_u32 for reading
 value from node
Date: Tue, 09 Jul 2013 07:26:27 +0200
Message-ID: <51DB9F03.3050203@monstr.eu>
References: <ff70173bee5f9223ffea2b92b903b4e46ef8b323.1373290150.git.michal.simek@xilinx.com> <95fea2ecead16435fc526b1d7f36a0a1ec1635ff.1373290150.git.michal.simek@xilinx.com> <20130708145119.GJ27646@sirena.org.uk>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2ADBNTXABHNLMWRXRUPHV"
Cc: Michal Simek <michal.simek@xilinx.com>,
	linux-kernel@vger.kernel.org,
	linux-spi <linux-spi@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130708145119.GJ27646@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2ADBNTXABHNLMWRXRUPHV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On 07/08/2013 04:51 PM, Mark Brown wrote:
> On Mon, Jul 08, 2013 at 03:29:17PM +0200, Michal Simek wrote:
>> It simplifies driver probing.
>=20
> Applied, thanks.

have you applied this patch?

I can't see it in your topic/xilinx branch.
https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/log/?h=3Dtop=
ic/xilinx

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



------enig2ADBNTXABHNLMWRXRUPHV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHbnwMACgkQykllyylKDCF6QQCeKJQsUUtv9HttOPbTCPBfMMCh
lQwAoJOvLUhzLxVpaYcOm+CgnSDe3xQy
=n7ld
-----END PGP SIGNATURE-----

------enig2ADBNTXABHNLMWRXRUPHV--
