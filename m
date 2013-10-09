From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC/PATCH 3/3] drivers: mtd: devices: Add memory mapped read
 support.
Date: Wed, 9 Oct 2013 16:45:33 +0100
Message-ID: <20131009154533.GP21581@sirena.org.uk>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
 <1381332284-21822-4-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3161917266052284849=="
Cc: spi-devel-general@lists.sourceforge.net, computersforpeace@gmail.com,
 dwmw2@infradead.org, balbi@ti.com, linux-mtd@lists.infradead.org
To: Sourav Poddar <sourav.poddar@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1381332284-21822-4-git-send-email-sourav.poddar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============3161917266052284849==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ia+af9HxgiRv1+7n"
Content-Disposition: inline


--ia+af9HxgiRv1+7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2013 at 08:54:44PM +0530, Sourav Poddar wrote:

>  drivers/mtd/devices/m25p80.c |   13 +++++++++++--
>  include/linux/spi/spi.h      |    2 ++

You shouldn't be adding the SPI feature in the same change as you add
the user.

--ia+af9HxgiRv1+7n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVXoaAAoJELSic+t+oim9v4MQAIhsF7OtC0h4PrK0TinTAkQf
F7yrgSCJwLQJJqf3J7fPBhZ7Gj/gcWx9YMaefPlF9cenHxsVivntbi+w7DEMFHyR
JogSIpNPdW3CGseGMAuKybCGYwR48bz1PeJ06sx9pS3XmzSIH6DM3bhJJNNzcQou
zeF818qW0TBh0d+aIacghM9lJ0Lto3inDX/o3pzUXIe/b4xnwsVXft8ubxejU2Bt
PWouLOrlQAsaOT17UIT95kWwTN97ceEw/8ty62cVm8fADdQFcM7et0cMBH/6mWdn
F3aAcYYdO0cp3PgdzRLy0VOddS3+b6gYcm4pDh7Gwiy1PqX80sAKSqbZMIos/79n
oN4//BEYsclP21O3D2IyjiBcpwRZ7E2TmC6pYUZmdG5TzoSysf92+DrL6yuv/uOF
tcZp/9QKqxyMmo+2RctVNUXxGXvkG4ex8oNf8VzwoK+hUldVjOEEtKHyaZCu5Nom
SEaRnwfsntwJxVnvhoiiB5tKfRodrIDwIrw41apg8QsSDhX4gUCeJS1DAgHNkpVm
9q4ZPFnH+4nsGiPLKCuu9l5buVyV5thwvyoS22yQm5/RHHpA+cvj9eYxWidkFjGC
tYmA2x1ESPAD2Z0gA9HX0QL5exmLVNCKGQrCM7Q/0keS7pcmiF3Hxws97aezmIFc
9jV8GhsJ9eDyqTWsfGwz
=lY7d
-----END PGP SIGNATURE-----

--ia+af9HxgiRv1+7n--


--===============3161917266052284849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============3161917266052284849==--
