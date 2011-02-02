From: Bernhard Walle <walle@corscience.de>
Subject: Re: [PATCH] spi: spidev: Add 32 bit compat ioctl()
Date: Wed, 02 Feb 2011 11:56:56 +0100
Message-ID: <4D493878.9090607@corscience.de>
References: <1296550966-4015-1-git-send-email-walle@corscience.de> <20110202043944.GG29148@angua.secretlab.ca> <201102021037.14364.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA85D9A5DAE4E57C64CD4854B"
Cc: Grant Likely <grant.likely@secretlab.ca>,
	dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201102021037.14364.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA85D9A5DAE4E57C64CD4854B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 02.02.2011 10:37, schrieb Arnd Bergmann:
> On Wednesday 02 February 2011, Grant Likely wrote:
>> On Tue, Feb 01, 2011 at 10:02:46AM +0100, Bernhard Walle wrote:
>>> Add the compat_ioctl for operations on /dev/spi* so that 32 bit
>>> userspace applications can access SPI. As far as I can see all data
>>> structure are already prepared for that, so no additional conversion =
has
>>> to be done.
>>>
>>> My use case is MIPS with N32 userspace ABI and toolchain, and that wa=
s
>>> also the platform where I tested it successfully (Cavium Octeon).
>>>
>>> Signed-off-by: Bernhard Walle <walle@corscience.de>
>>
>> Arnd, can you please give your opinion on this one?  I haven't fully
>> got my head around the subtleties of 32/64 bit file_operations.
>=20
> The patch is correct on everything except s390, which does not have SPI=
=2E
> The only thing that is missing for s390 is a pointer conversion of the =
ioctl
> argument, like:
>=20
> static long    =20
> compat_spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long =
arg)
> {
> 	return spidev_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
> }

Thanks for the input. I modified my patch and sent it again.


Regards,
Bernhard


--------------enigA85D9A5DAE4E57C64CD4854B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJNSTh4AAoJEIQVJz6X/I4D1P4P/1SYAE3uGnD63jKMi53T5nFn
ENtdmHySZfo/zra4d5AU6XeM3hkRxWzLadbnPIJ7fSdfIaex45c4SXKDw1oWS+2e
O2XAUZWWGYwUxGJ9Nh3aJCsxwNvMv3j/kFpuQV9Zh33ga2jMcuoPMbIC0UsTZ5pz
JGoNh3J/k0NpJO+uL+f5D7NpxPY335jsdxyG1d568aNq4g1y2XNwzs4i8BZxsRgJ
BskLue+SRHX50e3/F6MVUtYruRQnFLyFKZItpx8KI/qHOR8t+8+Dea+9GxM5+D7e
AAWZKWETl2mAO9gil8YZsNPZ/4yOaJrvqxIdyIJNkC4/phX9zQGmlpnJd/vFo9IC
0ORHH6tSfiT3fD4MRDaNV9ZageM8HDFW+bWl60hGI8DHTcLDw32MdHZ5+oamcYqN
05vec3MU/K+ONRZRO75jHLNtveEIhAwy+bhnNSPm2OEy1EZn0dcSgDhUs3nu3D0q
5ChB/V6M6sgSXFxpXqKnlYVlehAroXdgzAIzfokWJrXyHbNvlxhSqAPL1AV5EXQY
ps5gpFBwM7DXV9fxiby48m71EmTgB4SJH9oRVewa5WahxnFivwws0EpMoAyB+U5U
xVBwwqAXpm5B/rbbnF6AR1RdS81YZDeQZ7sRkZ01/Rp/vAvuGLia0lzzhF8HK0oZ
oKQUdoGfegG2R6PhN1l1
=UsxN
-----END PGP SIGNATURE-----

--------------enigA85D9A5DAE4E57C64CD4854B--
