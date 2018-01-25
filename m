From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a
 GPIO CS
Date: Thu, 25 Jan 2018 11:57:41 +0000
Message-ID: <20180125115741.GA21900@sirena.org.uk>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <CAMuHMdU-06YxWm3MPSBY5weCRCRVRQPUiabGxa-n8ikXi9D-3A@mail.gmail.com>
 <60b34619-5034-4e71-b0b2-75a62de0cf2c@cesnet.cz>
 <96ca6f6776cf4146bcfb56a884236165@svr-chch-ex1.atlnz.lc>
 <CAMuHMdUOFJS=s-8Dv-BBLayXxKqZ0kPAUednA-3NL0+AZYuq-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Cc: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUOFJS=s-8Dv-BBLayXxKqZ0kPAUednA-3NL0+AZYuq-w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

")
Fcc: +sent-mail

On Thu, Jan 25, 2018 at 09:51:06AM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 24, 2018 at 10:29 PM, Chris Packham

> However, Jan wrote:
> > semi-public datahseet, it seems that the SPI hardware really insists on
> > driving *some* HW CS signal whenever a SPI transaction is in progress.

> If that is correct, it behaves like MSIOF, so you must leave one native chip
> select unused. If all native chip selects are in use, one of them must be
> replaced by a GPIO chip select (which could be the same physical pin,
> depending on pinmux capabilities).

Using the same pin is the ideal thing obviously, or if not then
something that we know isn't routed out of the SoC (which may or may not
be possible with a given chip design).

> >          spi-flash@0 {
> >                 /* This is on CS0 when GPIO 17 is high */
> >          };
> >
> >          spi-sram@1 {
> >                  /* This is on CS0 when GPIO 17 is low */
> >         };
> > };

> > I'm not sure what else I could do. I can't claim the GPIO twice. If I
> > could I could probably use spi-cs-high to handle the high/low toggle.

> So this uses GPIO17 to drive a mux to connect CS0 to either the first or
> second device?

Interesting, coincidentally there was someone else sending a patch for
muxing the other day which looked like having some support for chip
select muxing would be the most sensible implementation.  I've copied in
Ben who had initially approached this with a mux for the full bus which
I'm not so convincd about.

> But you describe this as @0 being driven by CS0, and @1 by GPIO17, and you
> rely on CS0 still being driven when @1 is selected, right?
> That indeed won't work when an unused native chip select is driven when
> using cs-gpio.

> IMHO, this needs the mux to be described properly in DT.

Yes.

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlppxjIACgkQJNaLcl1U
h9CV3gf+KMhccpcOUh+f8Y/MHsSur/5hxZjlwvQZN9stJ854d/M98Kq4wSqt8iGW
VTcf5TDx5HI2Uhh8ns7EXEfT53cdPTtVnLAOce9QL+oNp1t57atbXQqNWo0WM7DF
4sTNYehCWhbzSUNNxUEHTgvTpyoTqeitklIqWAK+miRjRkAJuM4IhXMV26ecnsXI
htTTjaAaHxTRHOrqn7TKMfAShlko/PHbpCG8vKAupYwOxW0ty+K3VBnB896NLE6f
CvmjKHPY0+hZoAzjYtqkj54UzmwKmwlNhqoPwQZlx28/ha/tlkj5aHDgv56oBJhw
3cD48j1xToQOg3gHTpV//hOd72vf3g==
=nRnA
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
