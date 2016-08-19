From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 8/8] spi: nsp-qspi: Add Broadcom NSP, NS2, Cygnus SoC
 support
Date: Fri, 19 Aug 2016 17:42:34 +0100
Message-ID: <20160819164234.GC22076@sirena.org.uk>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-9-git-send-email-kdasu.kdev@gmail.com>
 <20160816184030.GB9347@sirena.org.uk>
 <CAC=U0a31LOphD=21-tBtiCxN-JqxSArxqhQ4_=fXwH-vEKnbHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        vigneshr-l0cyMroinI0@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list"
        <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list"
        <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC=U0a31LOphD=21-tBtiCxN-JqxSArxqhQ4_=fXwH-vEKnbHA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 19, 2016 at 11:43:24AM -0400, Kamal Dasu wrote:
> On Tue, Aug 16, 2016 at 2:40 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > I am confused why we are parsing the interrupt-names property here?

> For Muxed L1 single source interrupt, there is only one irq, and  SoCs
> could use a different different name wanted to use that name. But I
> could force a name as well.

Either don't use names or force a name, trying to mix the two is just
messy.

> >> +     /*
> >> +      * Some SoCs integrate spi controller (e.g., its interrupt bits)
> >> +      * in specific ways
> >> +      */
> >> +     if (soc) {
> >> +             qspi->soc = soc;
> >> +             soc->bcm_qspi_int_set(soc, MSPI_DONE, true);
> >> +     } else {
> >> +             qspi->soc = NULL;
> >> +     }

> > The variable name "soc" here doesn't seem hugely descriptive when it's
> > just for the interrupt controller.

> Named it that way since it could potentially have other SoC specific
> settings for spi master bus needed in future.

But then that'll break this code - if it's going to be a feature flag
bitmask or something like that it should have an appropriate name and be
used in a way that reflects this.

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXtzb5AAoJECTWi3JdVIfQ6qQH/iuV9ZWjAeEx1DG8Fth3fC5i
8/J6X96M+MDGjvCbSBTzmiH58BwIbd3jkq9PJxhUxttaeqFxnmUXqy8lN3TqTa1H
pd4H9m3spKdMgWnbfgXKW6tnuCTYposZ6OsRkSGQUzl5a0pK7Z90F+cCQB7IIbiR
0+5SwDzGrUzSzo8uCClh8RGX7HhjCgldxEAMsMEye1eIElrj01b3FNdnKT/bj25Y
IaX8DqG6zHcklreSZZ5+VEOsy+BsZz66J2+ZMYIc8gXGB+pZSd5yA0npJw+LUHTo
3gbHOn3nTiS3cuYEij8eM8Yk9pjOeM2E2Xios6v7VKFjJ87/orrZho86b3Shl28=
=Wq9s
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
