From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: sh-msiof: Convert to clk_prepare/unprepare
Date: Thu, 28 Nov 2013 16:44:34 +0000
Message-ID: <20131128164434.GL27568@sirena.org.uk>
References: <1385602783-3439-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385602783-3439-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131128103407.GI14725@sirena.org.uk>
 <2098733.0eJJDEzLLR@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4oF+6Ged69J0+4/e"
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2098733.0eJJDEzLLR@avalon>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4oF+6Ged69J0+4/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2013 at 03:16:19PM +0100, Laurent Pinchart wrote:
> On Thursday 28 November 2013 10:34:07 Mark Brown wrote:

> > Applied, thanks.  However it does seem like you should be able to move
> > the prepare and disable to runtime PM rather than leaving it prepared
> > for the entire time the driver is loaded.  In most systems this won't
> > make any difference since prepare won't do anything but it's a bit
> > neater.

> It would be, but I believe the driver is currently broken in that regard.=
 It=20
> calls the runtime PM sync API with a spinlock held, which if I'm not mist=
aken=20
> isn't right. That should be fixed, but is a bit out of scope of this work=
,=20
> hence the simple solution.

Yeah, that's broken and should be fixed - like I say I doubt it'll
matter either way in practical systems if the clock is prepared all the
time anyway.

--4oF+6Ged69J0+4/e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSl3LvAAoJELSic+t+oim9LlIP/RJvQpuOQ6b7KhgYgPBIwYUG
rBfBnKJuwj9sZ8mN3s4nIFgVp0mkx3OTiW8encjo9PSPdnZZPmR3E5gsY3XOR4e4
6f5T8B0/ahyI+DcKrwS/TjPiF8bX7YDFBcj5k/KMXWuafHKZxXcyD8/pf1F8WKxS
jYr5dCZOdqScq87hy3Dsx7pTRQNdoSdBoRbHUPYd5PQNLb69qtwoDXutcQG7DPrZ
KW5DrSQX1ZRriBI7969zBIjc0T3nvfhW3MnggWK8cOZL8w3j+WVNEYEmRWu+z8Vt
dkQradiafkaF404tFERwB82Q6MiYybeyJ8y3sa/DQP6fMJFOeEk1yO5s6XcBphyq
FWuMn7hUFLUeZHCRXINctTXDljaL/qYe4ov0Ltr0r4TbY/N/zqSx8mGoufGMvJUM
7q8lld7GY9ZCesY7jxIxeJuGVHwM8hXqGtbQ821OZG8OA/JVyY8lrc+WXmLoA+aP
yuZYHREhpJDephxp7qfMvIdrHd32YHwDZjGvU6dayt4JtCi4DY2WfTrdmk/jKJKH
djsTWQ816Fr4AlR/tINCkoKj1zmDoNej/R03KnGgNJi8uWPuamhMgM7xinNliX7J
LIHaYLqmlBoZYw9sjwec23bZBIyW6d1Nml4080zh52SQLnDZPRk2zEhSv1sf2u7n
aTDblIuhndsCMem43k6G
=Wifs
-----END PGP SIGNATURE-----

--4oF+6Ged69J0+4/e--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
