From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Fri, 1 Jul 2016 18:07:53 +0200
Message-ID: <20160701160753.GX6247@sirena.org.uk>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
 <1466197433-11290-2-git-send-email-kdasu.kdev@gmail.com>
 <20160622160726.GQ28202@sirena.org.uk>
 <CAKekbevYN3CLvqQs3stUXDFEMREMOJ0g4+w7Zsno1kV-ieYEiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BzhqTaE66jeIVBY0"
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
In-Reply-To: <CAKekbevYN3CLvqQs3stUXDFEMREMOJ0g4+w7Zsno1kV-ieYEiw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BzhqTaE66jeIVBY0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 01, 2016 at 11:39:03AM -0400, Kamal Dasu wrote:

> > All this interrupt code and especially the fact that it's a completely
> > separate register range in the binding looks very much like it's just
> > an interrupt controller IP that's not particularly anything to do with
> > the SPI controller and should therefore be in a separate driver.  Why is
> > this part of the SPI controller driver?

> Some SoCs need this since they do not implement a separate interrupt
> controller and have dedicated l1 interrupt for spi. Also the handling
> is not generic enough to cover other ips as well in those case. Hence
> have to handle it within the driver.

That doesn't seem to match what the code is actually doing.  The
register block this is controlling is separate to the rest of the IP.
It's perfectly OK to have a driver for an interrupt controller which is
only used in one place, though you may find one of the generic ones
might be able to handle it anyway.

> >> +     default:
> >> +             break;
> >> +     }

> > We just ignore other widths?

> These are the only supported widths will make SPI_NBITS_SINGLE default.

If the user is trying to set an unsupported configuration you should
return an error rather than silently set a different configuration.

--BzhqTaE66jeIVBY0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdpVYAAoJECTWi3JdVIfQNP4IAIC+tDmPOrLaPAeE4z59FVAs
XlHBIFx3Weeqrvn4ok+zpMqEAL5fINjlQ3iHMvs1HTLtwS3qZsSin9qeaVTvxdCT
lNg0dQPEsl8x+n2LreZaZs0239j9Vf29zZcCsVibvxQv9RgZG99BfEDQmEuQe/kR
1/Ji9WZ80rB7M4JH8FtRO7e3bB520uFs4OljhXCdXw2u3QotpjwkPM2lwybwwDU2
R2tHWxt1HzKL+XWvEiAHWhC2EtXhJTFI74YTaqh8bXSpWmmGR0DhbHUObl5JPukT
lFUjOp9y3wxIvoU+gMXkOBJNH3L2l2R7z7jqMh1q+vstiikWi2abrS7NyYqbXJY=
=dmLp
-----END PGP SIGNATURE-----

--BzhqTaE66jeIVBY0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
