From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: use gpio_desc instead of numeric gpio
Date: Wed, 24 May 2017 18:02:03 +0100
Message-ID: <20170524170203.s3otxu23wsiireys@sirena.org.uk>
References: <20170523040322.10433-1-chris.packham@alliedtelesis.co.nz>
 <20170523040322.10433-2-chris.packham@alliedtelesis.co.nz>
 <CAHp75VcHktwnXg26sq6x=EqM6TFAEc6yQrRFZQu1CCpYYfq6wQ@mail.gmail.com>
 <ca3b3f5247624a35b8203472a53df79a@svr-chch-ex1.atlnz.lc>
 <1be4374ca1b1422fb2b14298bf21ae9d@svr-chch-ex1.atlnz.lc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dajwoting7fj4bkx"
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1be4374ca1b1422fb2b14298bf21ae9d-5g7mGxlPNYb6GjIOKuZY+ItlCAj8ZROq@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dajwoting7fj4bkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 05:42:38AM +0000, Chris Packham wrote:

> I'm a little too nervous about messing up spi-ep93xx.c and spi-ep93xx.c=
=20
> to push ahead with changing all of SPI core. I'd be happy to help out=20
> someone with access to platforms using those.

Well, if you try writing the patch blind we can hopefully find someone
to test it separately?

--dajwoting7fj4bkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlklvIsACgkQJNaLcl1U
h9B3MAf9F0AJGxMmSXFuuiJZo18Mv9NSkdSu22/u3IyvjcWKkqqGlJUT15kh14Vr
zDSOheA2gcWtVZGDRUtx9pYDQL3QftzBQ7iBlyFPdRDTitqkxyu/NtE95T2SQx3F
Fip8Uw1Z7nglPDajiC21NpVYc47uxsn7VraWYDTliKY4xShDCxmoixjBohHJLcti
dC1EYtC8GMKbGAhwQX+mo2FPGhjqngwBiOQUZC4JXtL14J/0I4rzHn0DFWl7DaQM
y1/UqstRTtNELxg7SamW5SVBuEKl7N0c57zzvpIdTII5ws5pcbTS5O/Dl+CFz1Fm
G+Jn0F+5RZPsgS/TUaeLSY3ebAXW5A==
=9HZS
-----END PGP SIGNATURE-----

--dajwoting7fj4bkx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
