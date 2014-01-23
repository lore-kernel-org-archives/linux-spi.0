From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 3/4] spi: dw: add support for gpio controlled chip
 select
Date: Thu, 23 Jan 2014 16:32:04 +0000
Message-ID: <20140123163204.GO17314@sirena.org.uk>
References: <cover.1390481412.git.baruch@tkos.co.il>
 <cc63df805aa126eede50aa11b3fb3c5bdef67f65.1390481413.git.baruch@tkos.co.il>
 <20140123132623.GN17314@sirena.org.uk>
 <20140123140546.GG12751@tarshish>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZeTaE3WtSQWmE2Pd"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140123140546.GG12751@tarshish>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZeTaE3WtSQWmE2Pd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2014 at 04:05:46PM +0200, Baruch Siach wrote:
> On Thu, Jan 23, 2014 at 01:26:23PM +0000, Mark Brown wrote:

> > If you convert to the generic queue then there's generic support for
> > managing a GPIO based /CS if you set cs_gpio in the spi_device.  We
> > should extend that for GPIO descriptors too.

> Thank. This further simplifies things. AFAICS the generic gpio chip selec=
t=20
> code does not request the GPIO. Is there a reason for that?

Mostly because it might not interact so well with deferred probe, lots
of drivers only request/figure out the GPIOs in setup at the minute but
for deferred probe we ought to be doing it as part of the main driver
probe().  We should also be switching away to the GPIO descriptor API is
part of it, but also I want to do a pass and add standard DT bindings
for this.

--ZeTaE3WtSQWmE2Pd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4UQBAAoJELSic+t+oim9CvUP/ihOn+mySVlBbpfG6dd3jnDU
eNewn7wxkdYhJY5J/RUZs1xc0eId728Cz60XAQ/tz1gEqcogWAdA9DpAOIQ77pSC
zPkBf/BBlQx/AhjFeGfsLA5RJU2g9d25qdz06kf0Pkk5PT+OhQ4c6kHOYGDVJLqx
Iuyr6CRqgB6y5gO+ARJlgUZ2ciNA42OkqCN636v2G8QbkXOlqjGgiUOfyG9WrJUE
S/lJiG8hHAMDvzS4M6Wg87xAloY5TKRQDaNUlUQLGA35p6N9z5OjEUqvlLIM/cWD
EDWh36g6vorQQG14NK6DjgaDYvVQgudK9KsfIcCZg3V4t4qEJo6fCPnlDNjl+ECm
ghEleOv/8Rcch3nnvBcy7V93O/i3GLABG1MdvW225N3v5UhKsGcrMO9Kx0zcJFOu
xHUqI9f6oEiNWKF9rXWiSrZMFMkOLXx7iH980y7p/gDb2zSedEu+WVVbckWKiDxr
BXF0CXJD3bj5UQAmwIxdgUN3b7qepwsaJr+PKdsecxCE4QxWHD3D256lN8R46Dfo
Fwcd6Dod8ai4aXdBMaPR0y7zzxZGswuTxCYRXZxwGv1KtZLX78AndvH/Mrjlszl4
YWgUYjlDVlZWy3w0GBQQIMk3K0hMWx5cZWp4QQX7Q0n0neRENmxbe39co3SJl0VU
18OWhwPEBEAUWIsDoztd
=MZRu
-----END PGP SIGNATURE-----

--ZeTaE3WtSQWmE2Pd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
