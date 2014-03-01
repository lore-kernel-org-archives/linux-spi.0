From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: spi-imx: spi_imx_remove: do not disable disabled
 clocks
Date: Sat, 1 Mar 2014 13:09:25 +0900
Message-ID: <20140301040925.GN29849@sirena.org.uk>
References: <530EFE8E.5050303@freescale.com>
 <1393492575-32495-1-git-send-email-phdm@macqel.be>
 <20140228034620.GH9383@sirena.org.uk>
 <53100FEF.7060600@freescale.com>
 <20140228061344.GD29849@sirena.org.uk>
 <53102C74.2070609@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xTKfHyrFnSV9DG3y"
Cc: Philippe De Muyter <phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53102C74.2070609-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xTKfHyrFnSV9DG3y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2014 at 02:28:04PM +0800, Huang Shijie wrote:
> =E4=BA=8E 2014=E5=B9=B402=E6=9C=8828=E6=97=A5 14:13, Mark Brown =E5=86=99=
=E9=81=93:
> > little while after the last use has finished?  That's a little more
> > involved though and would still need this due to runtime PM being

> yes. we can use the runtime PM too.

> but i am not sure which one is _better_. the runtime PM? or the current w=
ay?

If you are able to unprepare the clocks then depending on the system
that may allow more power savings so if runtime PM solves a performance
problem it's going to be better for that.  Similarly if the SoC does
something with runtime PM (eg, powering down power domains) then that'd
be helpful but that depends on the SoC.

--xTKfHyrFnSV9DG3y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEV1yAAoJELSic+t+oim9ARMQAIwDBCbA0Og41AmaPBkLU08M
1AFOJvoX4f03fC11gaNUU+o3UEAweBEHW7pOoA0LgRhZMI67S8Ssu+o+ZOAnJcKi
d+3uiMC9V9brqG6VxhZnS5jDYPaZfum+a7zPOEdmzHX2QLgBGUWU5v3rK3N86673
dVWERyHrBxiixbXvWj3UomGRUhwg/V+Vn3AaLsvDUMbXwjhBFaNFn9/eQxIgxjVn
n0kMIM6rx4qeuieURmDArhT/BQi1ZUv8RlKFux6hTK84maRP6uRlckBHQLOH1AXn
dbMqep0dsZb49zy4f2+OvOy3SIoQxV4qwVgcSlt9QwILdbF7mRklJl9VioGFsoT+
eKyIM78IZZITK6gWHclJ6ml1B3Gm/PWuLmuAvGuTh3no3aTsKawnKhI6JYguWCZm
tu6V8KxTKd+EquS5B7qLZN2uP1rtPuh6ZBxlZf8IbiaPI3NjtzuSGkqHX4PwzSQ5
fmAjE5CLYO4C025IPkyEK4gDMiQEWwptClizCEfcekHmVQCxSFfTuuXAu/faWTqS
Yr54jUEscpuWZLl1O1enkFyV0VycDucQZxwHAdzhssAQDhnBZsviP9Bni5gr4F4c
iOh7SLhGQbjPtCYcZ6MpnHipQ3lKEICyyuD9ss7/+TQCmrvaVL+WWDN9fn/B4zmA
U8PycOWW/l50Vn41JBqX
=8vh1
-----END PGP SIGNATURE-----

--xTKfHyrFnSV9DG3y--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
