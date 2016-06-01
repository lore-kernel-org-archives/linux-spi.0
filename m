From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 1/5] spi: sunxi: fix transfer timeout
Date: Wed, 1 Jun 2016 20:20:00 +0200
Message-ID: <20160601182000.GC4908@lukather>
References: <cover.1464130597.git.hramrach@gmail.com>
 <cb90b922caa6ac07c1425d726ea19709ee5284f4.1464130597.git.hramrach@gmail.com>
 <CAGRGNgWDrVHG26umTSHHAxFC3KXjwmpDejBAfKqvuik0_2-Jcw@mail.gmail.com>
 <CAOMqctS0AD6rHGt3wjxxyidee=_5xqby95t5TGuozAA12DdPjQ@mail.gmail.com>
 <CAGRGNgW=UnmwwiREV+nVcws6sk18-4fKz3qf-WKf4LY9-VqBKg@mail.gmail.com>
 <20160530112350.GI29837@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a7qI9m+4lZX6A7IJ"
Cc: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Mailing List, Arm" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160530112350.GI29837-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--a7qI9m+4lZX6A7IJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, May 30, 2016 at 12:23:50PM +0100, Mark Brown wrote:
> On Fri, May 27, 2016 at 03:10:11PM +1000, Julian Calaby wrote:
> > On Fri, May 27, 2016 at 3:05 PM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
>=20
> > >> Also, should the changes for the drivers be in two separate patches =
also?
>=20
> > > That's basically the same driver with different constants so I guess =
not.
>=20
> > Fair enough, I withdraw my comment then.
>=20
> If it's the same driver with different constants it should really
> actually be the same driver - I did ask this when the drivers were
> originally merged...

I think we already had this discussion a few times :)

The thing is that the SPI framework now deals pretty well with the SPI
controllers, and you basically only have the probe function and how to
start a transfer. Which is nice.

However, the sun4i and sun6i SPI controllers have very significant
register layout differences: the registers offset are different, some
registers in the sun4i have been split in several in the sun6i. So
while I concur that they look alike, merging the two in a single
driver would complicate a lot the code, while we would not be able to
share most of the code, so I am really not sure it's worth it.

Where the issue really lies is that they've been both written at the
same time, and share the same flaws, especially in their probe
method. But that's not really related to the controller itself, but
more because the code has been close to copy/pasted.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--a7qI9m+4lZX6A7IJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXTydQAAoJEBx+YmzsjxAgXOQQAKVJuO8xYuMbZZHrQ2OsYDrA
wtWSS2S9jYUxnwIBocQrPJ9nwTtGBzrgqxaHlvPXvOz5yTKMX4fKSyRwcIOmD5Cr
u15wohITPtMk/1FyAwfaoZjUG37Ga3nUpSZOo+CsRcV5UTGr0bjGNSB7LzbWTy+c
ihpM/2uISFF3GKyCBgKEmiza/WHdusbpA81wyV+eUx3E/bpD6RyJZ2yChmJo7k0H
38fwNXjQLL9P7UuySbcdcgovCls6J6fZ69s3RQqz80Pks0awx2bcY3+BX6rKQTnf
p0Zuo3U/kXLjtqlSA5nzPO9+TjTLP0hD6FuWS+cRwnSGTzTRS4NuCGED6scI4Gns
pG+eYNP8dPWu6+/5hjMp6baDjTFu8s0rzMTRWQha8ZdCJfDI8cFCAN0uwiOGgqT/
Zqi4pCg10O0t+LvrJDEyurTNLY0zduJcrodHNQzb/n7Q+jJYHpWl10QpQrKC+9O9
5km+om6wu0g2WprZZa8BfjLLqLi9bh0AkuQudRu48mWUy7IAb0i66VfJeFMOGiQe
E7At66iVxxzc5faP+E13ymFGoOeDgXDlkUzILtwPqn6WaX5ijBxDWbDcDwp7iyDw
z54Wc9Yb7EDgzqbBmx+pZsrh8vQwksIRN6u+8GSewWqtSItSdjFrfMx7MfhzxI2p
DaTowsh0Nu80+edM4vv1
=Y4WK
-----END PGP SIGNATURE-----

--a7qI9m+4lZX6A7IJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
