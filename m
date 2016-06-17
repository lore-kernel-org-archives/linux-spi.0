From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [V3, 2/4] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Fri, 17 Jun 2016 12:32:51 +0100
Message-ID: <20160617113251.GF26099@sirena.org.uk>
References: <1465589171-25575-1-git-send-email-kdasu.kdev@gmail.com>
 <1465589171-25575-2-git-send-email-kdasu.kdev@gmail.com>
 <20160613101352.GF2282@sirena.org.uk>
 <CAKekbesr2i3N+yw0VV1aYqJONbBraKTNpibzm7NO_+sBbwENyw@mail.gmail.com>
 <20160614165816.GT2282@sirena.org.uk>
 <CAKekbesG+_9wOuP4HXGKJdK-kmEn443g=vUdyu6Zdn==NO-YHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKekbesG+_9wOuP4HXGKJdK-kmEn443g=vUdyu6Zdn==NO-YHw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2016 at 06:56:10PM -0400, Kamal Dasu wrote:

> I was looking at spi_flash_read() caled from m25p80_read()  and spi
> core implementation. I have a case where when we have very small reads
> or  unaligned buffers and addresses passed then I have to fall back to
> using standard MSPI reads. How best to handle this ?. One of the
> options without having to replicate code  involves a minor change to
> m25p80 driver as shown below.

That looks reasonable.  Another option might be to provide a way for
m25p80 to discover the constraints itself.

> >> Currently not used. But I did not see a good way to be able to send
> >> commands, like finding the ID, setting 3/4 byte addressing mode , quad
> >> mode, on a PM resume(). Are you suggesting I make a driver similar to
> >> m25p80  ?.

> > I am suggesting you implement the standard flash interfaces and as a
> > result directly use m25p80.

> Are you suggesting to use something like spi_read_then_write() in
> cases where I want to set the addressing and single/quad modes ?.

Or an explicit series of transfers.

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY9/hAAoJECTWi3JdVIfQRVEH/jKLtzBFr2rgEKJ9UQ5SvZ7/
rtgRCeLZBaA/3X+qyn8P5fJ3t2aIUxjFNRH3CtePg9n1dGBNjPwmIfgk7Canxfev
3sqwtYzR6SX81GiVKhhJsq6hhBKwZ4Dp6lnIMiYpnwjydlurmrcy1KKHkuPqFuzA
O68u5ifT/bbeS/OYA6zD6vF9Cqn+0DUr2XgfpcqEEt/SW/NlvnJ4UnWbCddCyS1H
hpMV70/4tXSukQXOil/Gf7DTg3PwqHDUlatMJH1AAJzbP+MORxg4eFLxnSazbfdn
44tTxdC+Lf21zUgAJODI32ClaElFSoXIx+h5wuzdGOMI5kzMo3IsHWKqWsArk+o=
=Pgzt
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
