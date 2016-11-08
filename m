From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: make architecture specific hardware depend on the
 associated hardware
Date: Tue, 8 Nov 2016 20:02:29 +0000
Message-ID: <20161108200229.3jx5i5yl3vncu3ob@sirena.org.uk>
References: <20161106222128.24433-1-pbrobinson@gmail.com>
 <20161107174935.25r32yoq626yselg@sirena.org.uk>
 <CALeDE9NiTvKd1So=Hw4oe2LQUNnZhq4e0NLroG6K_vc82_oE6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cbsbpw5iood6l25k"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALeDE9NiTvKd1So=Hw4oe2LQUNnZhq4e0NLroG6K_vc82_oE6w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cbsbpw5iood6l25k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 07, 2016 at 06:12:21PM +0000, Peter Robinson wrote:

> > This really needs cross checking with the various platform maintainers
> > that the dependencies are correct and it's breaking compile test
> > coverage for quite a few of the individual drivers.

> Was going on the get maintainers script, but on the breakage I'm not
> sure how it does breaks stuff as it just adds in the explicit ARCH
> config for those SoCs. Are the compile test breakages somewhere public
> where I can see them and cross verify with my testing?

If you are adding architecture dependencies to things that previously
had none and not also adding an || COMPILE_TEST then it is evident to
inspection that those things will no longer be included in as many build
tests and hence compile test coverage will be broken.

--cbsbpw5iood6l25k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYIi9RAAoJECTWi3JdVIfQweEH+wUwuiFI0SHYMlCpifS51Gbs
PTTeKkn1EEkSaDk+nfJNN42tgF0OQ5zEvf2Ib9ynbrhVjIpPqXW6UzusNtV6hSYN
A4GVvS1EpxXDOktWd7EAipeUsMfD/DifpY7Qm0H7mgjW5mRl5DYNUOQ+yR8EYnRN
Mu4eMkIQu85srt8sqHvgr7BYU3+LFVSksF5syfYeNObOar91kZ1vjRxHqlQDBpXv
6Xm19DC1WbxWJdoNXjSHqRRD2QmDxTnvAlBMNq8uWk5MZvTRNXH2H9o5w/92/Ltt
/+zJ7+6Ip/ZIhu1BkxojDyg9djGRTNJtGEJDgVPwVs4Q4MK+34TXxZ/J4WTZarE=
=koHa
-----END PGP SIGNATURE-----

--cbsbpw5iood6l25k--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
