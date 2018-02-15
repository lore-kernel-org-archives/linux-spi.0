From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: orion: Software control for inter-word delays
Date: Thu, 15 Feb 2018 17:29:08 +0000
Message-ID: <20180215172908.GH8374@sirena.org.uk>
References: <bc8bf712358fbb000ea7e2ea9e1aec42b21988e6.1518704854.git.jan.kundrat@cesnet.cz>
 <475b63c52b17187089d3f2ecf8ff4b8c45a7e58b.1518704854.git.jan.kundrat@cesnet.cz>
 <20180215151907.GD8374@sirena.org.uk>
 <c5d27950-0d13-422c-afe9-990b4adad45a@cesnet.cz>
 <20180215154945.GF8374@sirena.org.uk>
 <1518715087.25567.68.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDnEQgWzhgf+8aPe"
Cc: "jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org" <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>,
        "Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org"
        <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        "m-karicheri2-l0cyMroinI0@public.gmane.org" <m-karicheri2-l0cyMroinI0@public.gmane.org>,
        "andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "grygorii.strashko-l0cyMroinI0@public.gmane.org" <grygorii.strashko-l0cyMroinI0@public.gmane.org>,
        "gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org"
        <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org" <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>,
        "geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org" <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1518715087.25567.68.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2018 at 05:18:08PM +0000, Trent Piepho wrote:
> On Thu, 2018-02-15 at 15:49 +0000, Mark Brown wrote:

> > Ugh.  Using the whole padding is probably OK.

> There could be a flag that switches delay_us from being a post xfer
> delay to being a post word delay. Then no need field needs to be added.
>  If someone wants both a post word and post xfer delay in the same
> xfer, then they'll just need to split it, which should be possible
> since it must be longer than one word to need a delay after each word.

> Not that great either.

Yeah, that'd work too but isn't a model of elegance either.  I wonder if
just making a new ioctl() might not be better...  not ideal either but
probably cleaner.

--dDnEQgWzhgf+8aPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqFw2MACgkQJNaLcl1U
h9DeOwf/dWZJmHYbxcJIUg/pPST7dzfBoJXVZa8bJpxA0cC5oXcxSE3WcBb9kel7
8VsdGSQRZdifYeoYgy6sMVkoXLWEX2bo0FzzNsbI43T4AxtkmhMvMU1+RobGfXGZ
nUJQLp9OfpknKhYDkj1tn3KWJwiAozSbD0LpttvQcB5bOlxIiVNXWjAmKbK2Vptj
yBmEkXk0OeQ/F+S1WEMK08/6fVekRouOMhdLJrXtUqT9++Ry6RD+6Al5JDuHkrz3
o3aY2i63dHqSTIrJgq0cvXqYkV1TWOCjY32/qrp8QO5tCyyBOv2oUdIs4GIEnYHB
nOLVNDahS3KfTZal6zENTwVrn2fISA==
=Kse1
-----END PGP SIGNATURE-----

--dDnEQgWzhgf+8aPe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
