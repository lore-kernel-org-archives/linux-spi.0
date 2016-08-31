From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/1] spi: sc18is602: Add reset control via gpio pin.
Date: Wed, 31 Aug 2016 15:49:34 +0100
Message-ID: <20160831144934.GA5967@sirena.org.uk>
References: <1472628698-10599-1-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1472628698-10599-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 31, 2016 at 03:31:37PM +0800, Phil Reid wrote:
> I didn't not check for null on devm_gpiod_get_optional as gpiod_set_value
> does this on entry. Frequency of this seemed low enough that the function
> call doesn't add any significant overhead. I can add a check if required.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXxu5yAAoJECTWi3JdVIfQN70IAIDIz7vL5UX37kAq/uHjHcm1
4nh15ZTBRbz5hN7C3BLGc+bjzEJHG5AWgVB1VpW9h/Yi0535Hi3A1++B6mk+U0Sz
cEWwyFJNXiLvm3Ff/VSMdh8/cCy9uh4VLr3vshZYE1q8nb74Jl9wB0oIQxZDPgUV
U3CXxiF8N8Vst0CecDS4X0DMsgrl+LNYQyF2ovVucDFsrkTMp5XV7JiKCYVT7TtL
ozZlcDYu8ZeKbe9EGzLR2+iCq++7vWGo9l/zCs8AEqtyvszhRSF3ta+ZDIXSxVy1
Fl2hXZ6MqykoQHWJZzaeSijkVUZihuobmns/jDJjdVyYZ8a+CM5rhowZ+WjGAMY=
=XINZ
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
