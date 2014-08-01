From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH/RFC V8 1/1] clk: Support for clock parents and rates
 assigned from device tree
Date: Fri, 1 Aug 2014 18:15:57 +0200
Message-ID: <20140801161557.GA3277@katana>
References: <1403105372-30403-1-git-send-email-s.nawrocki@samsung.com>
 <1403105372-30403-2-git-send-email-s.nawrocki@samsung.com>
 <53B59221.5080100@samsung.com>
 <20140725214231.5177.86866@quantum>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Cc: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140725214231.5177.86866@quantum>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2014 at 02:42:31PM -0700, Mike Turquette wrote:
> Quoting Sylwester Nawrocki (2014-07-03 10:25:53)
> > On 18/06/14 17:29, Sylwester Nawrocki wrote:
> > > This patch adds helper functions to configure clock parents and rates
> > > as specified through 'assigned-clock-parents', 'assigned-clock-rates'
> > > DT properties for a clock provider or clock consumer device.
> > > The helpers are now being called by the bus code for the platform, I2C
> > > and SPI busses, before the driver probing and also in the clock core
> > > after registration of a clock provider.
> > >=20
> > > Signed-off-by: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > > Acked-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >=20
> > Could someone please take a look and review that patch ?
> > Any further suggestions, ACKs/NAKs ?
>=20
> Patch looks good to me. I'm happy to take it.
>=20
> >=20
> > I would appreciate a DT, SPI or the I2C maintainer opinions.
>=20
> Yes, Acks from SPI and I2C maintainers would be good. I might need to
> drop those parts of this patch if they don't come through :-(

For the I2C part:

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT2708AAoJEBQN5MwUoCm2aCYP/365qBaTpbuWjzeZ1mlBEwpR
3/qVH7fE0MfwEHd03BafDmNAf3rV3zTdQjvTyz3w7eH1Tvwf5nWJr3Wgqltkp5iU
Dcm4FUO6r17Fae+bZLO88By7UOm8WccZtsI8TorQTruGanCVZbavul/AvJdDX7ck
ffhNzao4AMuQdjFMz3FQr7kkGo3GpveC3tmNhK4aFnDWsleEgNvQ2NvaRLdz6wbe
OTxk42sIJtG7iKjleKz2xthCp6R/AvhdU1O6SZCKmskpmZW3eHp6107WuCqd0IMr
ifs9cwEK62iqVAix0cNp5GxmsOpEUBtExk2RAxTQMGCwFePPu4BI5iXYMYuDXbDl
4xHzLoSr0wbCW8EGl17+Pd3i+llfjgZxvKIi0DUOh6IeuvWtB8sVNA6h1+6w3VTi
DmUOEBcdbpNR1y0OdszrApcP5CJYbYlFzUYWfVn+MV01nj9lNaAwGB2ynlk2CpMI
r9u0PbShD9lib5CgbO/rbQqSJfG+o5rjlzP/YtTw+InVZQT+2OQqYh/RxsKVGjcE
9SHHRKesGwBhiDtLS5oRTI5GakkYjqg5+euIFKcHBshmoTgf54BiWAV4WATKuxwT
gjcfbiUHdTDJ6+z2klekmIelujnlAMgAoKcksb0toRkMXZbq91bqB/ytak6/wHEG
YtLYHZZiHTwejG8qi5jm
=mIbT
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
