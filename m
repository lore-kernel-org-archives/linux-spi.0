From: NeilBrown <neil@brown.name>
Subject: Re: [PATCH 2/2 v2] staging: spi: mt7621: Minor code cleanup
Date: Fri, 01 Feb 2019 21:07:30 +1100
Message-ID: <87va23kejh.fsf@notabene.neil.brown.name>
References: <20190201085712.32380-1-sr@denx.de>
 <20190201085712.32380-2-sr@denx.de> <20190201090311.GA4639@kroah.com>
 <61b2570c-84c6-ccc3-2535-4197030f2cd6@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2337602402628275760=="
Cc: devel@driverdev.osuosl.org, Sankalp Negi <sankalpnegi2310@gmail.com>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 John Crispin <john@phrozen.org>
To: Stefan Roese <sr@denx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <61b2570c-84c6-ccc3-2535-4197030f2cd6@denx.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org

--===============2337602402628275760==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01 2019, Stefan Roese wrote:

> On 01.02.19 10:03, Greg Kroah-Hartman wrote:
>> On Fri, Feb 01, 2019 at 09:57:12AM +0100, Stefan Roese wrote:
>>> This patch cleans up some minor issues with this driver:
>>> - Remove unnecessary header includes
>>> - Sort header alphabetically
>>> - Use correct comment style
>>> - Add return code check on device_reset()
>>> - Remove SPI_BPW_MASK definition (already available in
>>>    include/linux/spi/spi.h)
>>> - Use macros instead of hardcoded values for SPI_MASTER register access
>>>    as suggested by Neil Brown (in mt7621_spi_reset and mt7621_spi_prepa=
re)
>>=20
>> When you have to start listing the different things you do in a patch,
>> that's a huge sign you need to break this up into different patches :)
>
> I personally find this over complex for these type of changes, that's
> why I prefer to send such "minor" changes in a single patch. But I
> can definitely split this up into multiple patches, if this is what's
> preferred by you (and others).

I'll put my hand as an "other".
I understand the temptation to combine changes and I've been guilty of
it occasionally myself, but it is generally best avoided.

The key issue for me is ease of review.
I like to be able to look at the patch description, understand it, then
look at the code changes and think "yes, that looks right" though with
more complex changes I'll need to study the code are bit more closely of
course.

I would probably keep

>>> - Remove unnecessary header includes
>>> - Sort header alphabetically

together, but each of the other changes should be one-per-patch.

You also:
 - made some white-space changes
 - deleted a point pre-declaration of struct mt7621_spi

The white-space changes could be combined with comment-style fixes,
the deletion could be combined with the SPI_BPW_MASK deletation.

But in any case, they should be mentioned.

Thanks - these are all valuable improvements.

NeilBrown


>=20=20=20
>> Please do that here, it should be a series, each one doing a single type
>> of thing.
>
> Sure, will do.
>=20=20=20
> Thanks,
> Stefan

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlxUGmIACgkQOeye3VZi
gbmPtRAAw7n3/XhT6L5WMcD2T14qKKQFKL1uAGaPFsakNvR7Cc22gqN+jlfAKQJw
j9+te8Tjrc3y0T2Hc0GjLOc+I1Jb54TBJpOU3100tULlsa9nVkSN9TePdzMJPT/c
s0twjzMOHeWyuzPGOgGfXFou9yUb/Lnhc69Q3aSuDKqUHH9tzlwQ6GPzOthc3inf
yrZxPHR4CpA+tkzxeINJmRGmcmU3Q1kD3RVrdCqanPAvJDgxUrYMknCZ7qbG8eX7
LRwSYMd+QGnPIWVT1jaPatkrDCfS+8SGP0agrbdIXA4I7aoIPJb6S2GSmsJg45GD
6hMJBpoiAKs02VqI0AAq8dFzlmTaMMkyLF2BECiBC7zKhk8oHUgG1orvL0atO5Ty
GkY1RWzFZqPkzLW4M0T3ybXqqeJLlwlJj7GIf3rMY2u/QRqoRgVS38Ay8TjNl/ft
Y48Rd+0pHcqmcWhhgYnS6EwhB0sUAM15tUE9ZPBpAh+80vHIIy5lIoZM4iO9QJHr
g2Y0q9TRfHlucNJrlpqTi9E2b4mZYXzGfdJEJu3dJySihe+GdykbTUkaCnfCBdJY
rNyizznCc+aCORRT+NoSiZ/HFA9IYDzixx7dCFcDbtSUMXQ0cAsWLU8/i3hSdmqW
1Io1dou3DHgWwfA88pPOKzXdsBgtSUHfWJDbqVNd2uDwJiqdW7E=
=LeUB
-----END PGP SIGNATURE-----
--=-=-=--

--===============2337602402628275760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============2337602402628275760==--
