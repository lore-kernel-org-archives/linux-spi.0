From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH resend 1/2] spi: add driver for ar934x spi controller
Date: Thu, 6 Feb 2020 13:54:03 +0000
Message-ID: <20200206135403.GP3897@sirena.org.uk>
References: <20200206084443.209719-1-gch981213@gmail.com>
 <20200206084443.209719-2-gch981213@gmail.com>
 <20200206113158.GK3897@sirena.org.uk>
 <CAJsYDVKnOv+4NT8V+9fFy_0KE7QSoeTL0jHTdq31Z=88vBzHgQ@mail.gmail.com>
 <CAJsYDV+C+-uqurM+yTS3XXXrEDe+G3XFrpYEAaZLvzECLNoF+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T6OnZCvW5HcnivXR"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJsYDV+C+-uqurM+yTS3XXXrEDe+G3XFrpYEAaZLvzECLNoF+A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--T6OnZCvW5HcnivXR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2020 at 08:33:33PM +0800, Chuanhong Guo wrote:
> On Thu, Feb 6, 2020 at 8:30 PM Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> > Chipselect is also handled during transfer. Controller asserts
> > corresponding chipselect in SHIFT_CTRL register, and if SHIFT_TERM bit
> > is set, controller will deassert chipselect after current transfer is
> > done. I need to know whether this is the last transfer and set
> > SHIFT_TERM accordingly.

> Oh, I remembered that I saw transfer_one function name somewhere and
> thought maybe I could shorten the function name a bit. I'll correct
> this back to ar934x_spi_transfer_one_message in v2.

OK, sounds good - I see the chip select handling now.

--T6OnZCvW5HcnivXR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl48GnkACgkQJNaLcl1U
h9Abxwf/bD6z7Zyx5ZcODXIHhsjroI14CG3xmml4eA/SkHeU5P02YglZOlXrAjQK
AxJfhBpbiDy+R/eKMrzK4bsFjEOWsVLBiJ9HItN0qnnUmTXwfm5hyyxgw5qeHejb
Uzu6XVVf5KmUS9XrOZ4p4JIIO5HWitOpmCtrfMQtvjp7hi+5NIjApdSw5nCMZYxb
edOMq+0DDhXeMdLytbsQOehx6Vflyi7nEZS9TNEeLYG1zQPotBJccAiHypEtU0P0
l/T1U624W5dSwFkSARM+Ko6HNSVgriPTMS1ZVqz4RHnfB+U3g3IsnjAdNgU1nUQP
okovYCXjjOzLRa1fubeUMcjxNrRaZg==
=fyFm
-----END PGP SIGNATURE-----

--T6OnZCvW5HcnivXR--
