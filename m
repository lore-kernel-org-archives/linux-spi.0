From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] spi: add spi multiplexing functions for dt
Date: Wed, 24 Jan 2018 14:54:30 +0000
Message-ID: <20180124145430.GD9366@sirena.org.uk>
References: <1516661472-16452-1-git-send-email-ben.whitten@gmail.com>
 <1516661472-16452-2-git-send-email-ben.whitten@gmail.com>
 <20180123111123.GB7600@sirena.org.uk>
 <CAF3==it=5_YQVJ9xg8CLzSPw7LQZbCHQHfsufYwwCb=n7x3L0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAF3==it=5_YQVJ9xg8CLzSPw7LQZbCHQHfsufYwwCb=n7x3L0g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 24, 2018 at 02:01:55PM +0000, Ben Whitten wrote:
> On 23 January 2018 at 11:11, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > level.  Things that have their own transfer function would be better off
> > just being first order SPI controllers I think so that they get access
> > to everything the framework offers and can correctly advertise
> > capabilities and so on.

> This runs as a very simple fake SPI controller per bus that the mux is
> controlling. Having this custom transfer message allowed me to pop
> in the way my device exposes the downstream devices, through its
> regmap.

Which like I say is a problem - if your device (which just sounds like a
SPI controller) has different capabilities and constraints to the parent
then client drivers won't see that.

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlponiUACgkQJNaLcl1U
h9DF9Qf/ZmVGzLukP8G7gRAoIfdmjqFSJrEMpkTAKiXR0CS8RAxbdkZDm1RIKhLZ
JERqcAmaSv5f8JHVBZJ5/JYSf8C/BEeGqQt1YHOdBjRXvOeu2hj4qB9TZvCev4P4
RUJIe0qJbMGiD5mIXm0CNkJjg0eZ5tQctJjV84GAjC/qTllDY3qFZg3bPrMQuTbO
x3hiPFbv9C40Yze/bL4uMm8KDkxSdte8rGyKG2kjH8CBZvZPEoh0MpkPgAzM/UIu
jgtl96wWJSXgTSHL99vtwD5AghIhn+N4oTkpzkIVxlrUrqGP5kONZZjG3J4Uc+XJ
UruYUIeEctmMeWLzieTfn8eu/kTR9g==
=urIv
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
