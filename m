From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] spi: xilinx: Use standard num-cs binding
Date: Mon, 23 Feb 2015 11:22:02 +0100
Message-ID: <54EAFF4A.1080605@monstr.eu>
References: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com> <CAHTX3dJRGhwo7FW+VJxfEJmx-9FdjFN5EnxG0RRDfMOm3=VU4A@mail.gmail.com> <20150214053543.GL9110@finisterre.sirena.org.uk>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EwMgIQb5OpKfkf3UTJ7N04QpEMkOhD7rj"
Cc: LKML <linux-kernel@vger.kernel.org>,
	=?windows-1252?Q?S=F6ren_Brink?= =?windows-1252?Q?mann?=
	<soren.brinkmann@xilinx.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150214053543.GL9110@finisterre.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EwMgIQb5OpKfkf3UTJ7N04QpEMkOhD7rj
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On 02/14/2015 06:35 AM, Mark Brown wrote:
> On Wed, Feb 11, 2015 at 12:07:20PM +0100, Michal Simek wrote:
>> 2015-01-16 13:55 GMT+01:00 Michal Simek <michal.simek@xilinx.com>:
>=20
>>> Use standard num-cs binding property and setup
>>> "xlnx,num-ss-bits" as deprecated.
>=20
>> Any update on this one?
>=20
> Don't send content free quoted pings, they're just adding to the e-mail=

> volume and hence wasting people's time.

How do you want me to send ping on pending patches?
Just send them with RESEND prefix?
I just want to clarify this.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--EwMgIQb5OpKfkf3UTJ7N04QpEMkOhD7rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlTq/0oACgkQykllyylKDCHpwgCePrLUYBGyVaIRuFuSWDX6qLC5
/TkAn1JBZUthx3d3+KkE5rvDbsqAm2Ly
=CbKy
-----END PGP SIGNATURE-----

--EwMgIQb5OpKfkf3UTJ7N04QpEMkOhD7rj--
