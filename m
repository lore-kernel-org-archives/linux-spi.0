From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: add support for changing message transfer
 speed
Date: Fri, 8 Nov 2013 11:11:52 +0000
Message-ID: <20131108111152.GL2493@sirena.org.uk>
References: <1383816846-10561-1-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s6Wo+7iKhEdF4/RK"
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Wenyou Yang <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1383816846-10561-1-git-send-email-richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--s6Wo+7iKhEdF4/RK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 07, 2013 at 10:34:06AM +0100, Richard Genoud wrote:
> The only speed available was max_speed (the maximum speed declared for a
> device).
> This patch adds the support for spi_tranfer->speed_hz parameter.
> We can now set a different speed for each spi message.

Applied, thanks.

--s6Wo+7iKhEdF4/RK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSfMb1AAoJELSic+t+oim9mokP/iqAJ0SWcE4KJH9Tg73t7FDL
m6QQImAgYJL4cBsRAYzu9kwnAXXbLlgq7qPNw6iH6pjn/FdGw5tqQoxvamDEx0IK
bxy2dGvX1HsIGkQou0AcPn0vVJzx5N9sh397rdqzOzcV2N0JDJCi5P0TsuxjjBFy
PNXbf/nTm6OA17ksoFFINHZhO+rTOVO38rb+SCYX8pyQNV7Bl7j/qKY+orfbE17h
1DKAUfxBZF2zq8L2zJ1SMO7NIbwwzm7423g9W1W2f/UQHX7jmM0TNebLNH0I0Nx0
ZejIHKm4YiYNc617MNcdVWMAf9JyBvvJ7aBDZ6zzJ0m+xK0XK16tozZj9OshNQHB
8jmnEOkrRN0NG8//G7uh7aEk+vH4JrV5uJWX2VeJuOC5N6V/9uxlFIfUEy1soMUj
hhKbJDHYKZcN4a9PcumFOFxfWqdlAEqcX8HCBM5xuclAbfBwnkrCbkmg4oKukA86
maLMiOMQo1rGMx/aUILbwvZPQWiiWeB41ADMMlPY8iKIdW30jQdQOHjH766bcI04
zarsI3zr7Hc57lLYzhcHFq76l+STn2VbYlgRXHzSzDPhUVvK5ZB/ZKyC1SY9ttrJ
5c6dqEk2upHBO6n6bTFIOZrfOFtEObVVvhZhcppRuqDERhlasZQjhMWTU3um3aUS
FqROpNSFRv2GZaJORWFl
=6SqR
-----END PGP SIGNATURE-----

--s6Wo+7iKhEdF4/RK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
