From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4] spi: s3c64xx: Enable Word transfer
Date: Wed, 30 Oct 2013 10:00:29 -0700
Message-ID: <20131030170029.GK2493@sirena.org.uk>
References: <1382074356-28430-1-git-send-email-rajeshwari.s@samsung.com>
 <20131019162504.GA1863@sirena.org.uk>
 <CAPs=JDeOqkJT32quBH1tF9FtFUOt=CHP7m6ZqzhfASM2uPj-dw@mail.gmail.com>
 <CAPs=JDdzvnM5BzgRLhLsJrdwcVSwxd6x8_kFz0EvB=OjFfVszw@mail.gmail.com>
 <20131029163926.GA6776@sirena.org.uk>
 <CAPs=JDeDbevjOtMH0y+9aVSbNSV4zmEQxWygtB-f69XzooSinQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cN0A5YokcrYPGsSB"
Cc: Rajeshwari S Shinde <rajeshwari.s-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Rajeshwari Birje <rajeshwari.birje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPs=JDeDbevjOtMH0y+9aVSbNSV4zmEQxWygtB-f69XzooSinQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cN0A5YokcrYPGsSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 11:52:54AM +0530, Rajeshwari Birje wrote:

> The following patch already sets bits_per_word_mask for
> drivers/spi/spi-s3c64xx.c in s3c64xx_spi_probe, hence I had a doubt do
> I need to set the same again.

OK, so how did this work before then?  You're just adding new code but
the driver was previously claiming to support different bits per word
(and now I look at the code there is some handling for that in code).
Is this a bug fix?

--cN0A5YokcrYPGsSB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScTsqAAoJELSic+t+oim9dugP/RwCbnbUyAooxZbpd/3gJkZ7
6hX3HsB7ekUqMwGJ/E8qIw3bXaFoNXxkwzNbdpPucGkA+UtP8VVH6Oxc8rvuZsTD
8cFCcWZE0kJVb3NgvEXghJwLUdm9oBSUpiPyDvF9BQ7bBGNA/nAYpia8/9njlirh
XpSf5tRnIn2OAKYQohp0qAm7lDe/5M+FbVasToTFxnZRiQpp6PeqAp86FBuKjjb0
/v1dcDs6FbJKZtj43JQ9LKYqVK4CTIsPftHrepSq4rFr5TP2BLMhdzj0pRljSrEJ
6hF0quvDG4wwy9BqIBjbBy0S3+O7NJG6B1JEDhqHK7pduQLeYkRJMU/Hl/dhAEPS
/CD8uDiSh4oUZC8KwuljadgJBvFLf/oJimixR6dkRtJkzZamumaxRUIhNCsUNSib
QXUZJhkUnT3n+myrFOGFuE0RyEIbRuk/Ra6ButMUZkF1offfqArbPhA9xWDRABKZ
KtwM4GAv0SEtM1st6ZqfF+amOaJiVb07yMb5e1BgFw5gMqoOQLMKmjvDHjg4/Lja
T+U4Sc26OEE4wl6142uIS0bIMgXit6bfKrGvR1IuRQEuuZzbro6CLiRsZ6REoiu7
2rSWB+LWkZUDPW0MTHwTiCNP5tNMC26VruCO6ut+kbULtSQkHWaYACMNrfHrouPP
joYzQ3SsQ7Tp4q2aZlia
=I/Or
-----END PGP SIGNATURE-----

--cN0A5YokcrYPGsSB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
