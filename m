From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Wed, 30 Oct 2013 14:57:16 -0700
Message-ID: <20131030215716.GV2493@sirena.org.uk>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org>
 <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com>
 <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com>
 <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org>
 <02BFF0F6-3836-4DEC-AA53-FF100E037DE9@sperl.org>
 <20131030171902.GL2493@sirena.org.uk>
 <8D8B0BAD-0E00-4147-B4C8-FBB18F060C96@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s0H35NU0PUc8VBh+"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8D8B0BAD-0E00-4147-B4C8-FBB18F060C96-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--s0H35NU0PUc8VBh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2013 at 07:33:30PM +0100, Martin Sperl wrote:

> I have seen your email and I have checked 3.12-rc7:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/incl=
ude/linux/spi/spi.h?id=3Drefs/tags/v3.12-rc7
> (Assuming this is the latest, but I would say that the version of Linus w=
ould=20
> be authoritative)

No, look in -next (or the SPI tree which you can see in MAINTAINERS):

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git

> The following would go into struct spi_master:
>   int (*prepare_message)(struct spi_device *dev,struct spi_message *mesg);
>   int (*unprepare_message)(struct spi_device *dev,struct spi_message *mes=
g);

Which, like I say, is exactly what's there in terms of a driver API.

--s0H35NU0PUc8VBh+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScYC5AAoJELSic+t+oim99vQP/3hHNzYem/dpJyO8GuzmnNCr
ISH19Ryd5JKnZv4rqs9kTvzkhXBzkSwI/OZlHXKsXn79Oz2CAxpy22nOxMaMuChc
hO9y8CqH0J5DktiG5ZnyB9qwUluPiuC+yTGiMGvyNJrXcnVz8TIGnqc5uIce7J3V
LN/6bsT1WuDWCLcDgvfdi8sKWKNIOjiP5S080Thi6yWZALbMNTSU6aPuB6laVAh4
fKQsjMML0d9e5DClJHBw0E2KDuVZU7wBfWbdir+vaQoq8htakDMsRQkZb4Pv+Mwf
6jjahlxAdZ1RT8XUgkCLuikVR21A0kxnWXzUjhhBBlt5xK3/+XrU++aNea9L3U16
57YfYkAdwS6lFKgspc6sMdQ05cASajBzIEaouPHl5fRutkN/0whRfIydWsjb7wfH
vXvS0f24FFjju5Wo2gM128cu1iJN1sCr8awmDnqrVpaQw7M89+PjKihYmxU3hK5O
TEYofpCmNHcQ5Us/c8y72Vr7LJ80Jud3zNMyl1fWn7xgBxhCF2hH7+mTjpcOTFsH
Puzc63aO9pQ/wL5UEB/WIDY2l0W6LwKzSXewRlcwWVcVrwpML8Iu5OvUrKDzHXwV
M7tfISMWRpf6ebZTob1jhT3H8mhkw5tcWaxAXOPH4o97pSWwIPDOXTz6+8IcTaEK
Vyekrd4Xoi9aJvxMOzF4
=Inkw
-----END PGP SIGNATURE-----

--s0H35NU0PUc8VBh+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
