From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/8] spi: sirf: correct spi gpio and hardware chipselect
 behaviour
Date: Thu, 4 Sep 2014 20:20:25 +0100
Message-ID: <20140904192025.GP29327@sirena.org.uk>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
 <1409648468-5436-2-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m9EESf0ERqvzovaD"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409648468-5436-2-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--m9EESf0ERqvzovaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2014 at 05:01:01PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> the old codes check the cs-gpios, if the gpio number is 0 like:
> <&gpio, 0, 0>, the driver will use the only hardware chipselect.

Applied, thanks.

--m9EESf0ERqvzovaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCLt2AAoJELSic+t+oim9NNYP/j+63lh4v8PqRS1f77G1ZP6E
ciLZbPEqbEITO/hdZzlJBNcBJyDKbfv/uUlZIiBrzCJr1IoiiVtVk84J5b+VRvkL
n3fhbgAtDeoWylTUykWrz4poZZWCkGQKMyGHV2PAC/TH8Za4ULQczKFw0yXWZC0n
EX1ol/GnNq4mwkRehQyVTmUWmWEz/nuOtCsLEH5UZ0hNXxJNPf/6Kz5bc6R4ViC2
pcZ1tuGoONQtJ5rKz5dSTrOxesbqrw38GFfVjNAGQk5xVBuP4/pjtl4DIYyXrf2T
Ckqjd5zRnoMLtS8gSL6iFM2qkscdcFtb5DNAlTzG2oZTS10/mc44+Nky5/8iUkbN
5j8ozgWTU2xbODGONUbosPhAVPCmJBivAOKvWOq86hIrf5DcpPdSwnILT6AdweMx
wZrLOdNzdyPrRvywu7gdU+liD2373piCQ3CVp1GQACjl1VTNYC0wkrwAq58/uVAm
EVFJVbaGEwfsam7W2X5JI46xeG06i18EPnF/HuxKKNvzban7f0Ou1sBz/OqDl3RE
lXzu/rbkqtpGfufavRqkJJX/IjKnqYk/fTAf+P3rstlHOu5CSX7YZSiYIYkH+RmB
R+RAzi6V/Wyzg8I2dJ2eFBGOyCC3cJ+n+eFzhz1hKDCD2I5VJyeSF3OJpRKjboI1
3UTInbn5Oa2jjld31hz7
=+j48
-----END PGP SIGNATURE-----

--m9EESf0ERqvzovaD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
