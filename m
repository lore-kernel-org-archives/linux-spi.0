From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: sun6i: Add binding for Allwinner H3 SPI
 controller
Date: Thu, 20 Oct 2016 17:45:16 +0200
Message-ID: <20161020154516.w44mxnylg3uu43i6@lukather>
References: <20161019140234.13518-1-woogyom.kim@gmail.com>
 <20161019140234.13518-2-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qk2laixkptfgoxdn"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161019140234.13518-2-woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qk2laixkptfgoxdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2016 at 11:02:32PM +0900, Milo Kim wrote:
> H3 SPI has same architecture as A31 except FIFO capacity.
> To configure the buffer size separately, compatible property should be
> different. Optional DMA specifiers and example are added.
>=20
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> Signed-off-by: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--qk2laixkptfgoxdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYCOaMAAoJEBx+YmzsjxAgAl4QAKM82rsJmwZAPFtZkwdln0p9
3v8ex9Rk7PKPvWZ3OttDQ/uJJpiH/lfEt2byOamhZnMCAGn6hMeSf+VeYwYtEh7t
RslamngIu6ybOs38T3PeLF7x+eX7UHVsyFdf36wS0PMD9dMHegwVKLhX6RP9TJnI
uKRDIw9GhrifVGtW3xPIkGhMOQCHCt3ftuR3Y4TYCo9DvqzlEiB1144yW4OyfZCq
3WJtb53tY4/VxkY9zjnVwH7Ksrmo7zkVzRrM/EDZHJ3Xk7owGLgs2cAeNF2Ev4VV
GgB/VP+EGK+Uqz4Q+j7Ujs0UQV18tni7bOYj5D0Re+zzg7gIWsHiQ9dLNCEzRqrQ
PqTQ68s6QEDV3qW/1aX5PfJdrazJPzLHCkIqRvQK79asY6KDYWunxXrYULDVBmQi
qHZX88EmTKysXctD8yxR1F+ZvKfzC662r8+/saJJDB3s80fUbQHR3s+6BJFrqsff
/LvTYxoZICir4Th6fUhJuQHMkuH+CBdLomRdBgYC9KBSDwUcVk8b9CQdj/ZMcDwg
ngBy4EpZswsHErUc3/ErLgKDaDerAmuqxfRUALPS/YpIOacc/3Vf8k51onfME97w
bWXCymbXosUA8qTBzK4hYeVybJgBItlQh1hUAh7ZLcJB3vXUVSM7pjXXj0kPkHHy
L1/jj58tZujY7aPfGvty
=yyWQ
-----END PGP SIGNATURE-----

--qk2laixkptfgoxdn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
