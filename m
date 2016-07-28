From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Thu, 28 Jul 2016 19:34:21 +0100
Message-ID: <20160728183421.GJ11806@sirena.org.uk>
References: <20160622160726.GQ28202@sirena.org.uk>
 <CAKekbevYN3CLvqQs3stUXDFEMREMOJ0g4+w7Zsno1kV-ieYEiw@mail.gmail.com>
 <20160701160753.GX6247@sirena.org.uk>
 <CAC=U0a3WN9TGw7zwwP3qFf5MUsRteUcVLytFgjnP4zScZS0xXA@mail.gmail.com>
 <20160713111053.GG9976@sirena.org.uk>
 <5786B401.2050306@gmail.com>
 <20160713223638.GI9976@sirena.org.uk>
 <578EA695.1030909@gmail.com>
 <20160720112547.GE6509@sirena.org.uk>
 <583d6ec8-b367-b53a-7d9e-1d7ee06004c0@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bmlge7Pg4VPvffji"
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <583d6ec8-b367-b53a-7d9e-1d7ee06004c0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bmlge7Pg4VPvffji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2016 at 03:06:16PM -0700, Florian Fainelli wrote:

> Mark, would you oppose to a driver structure that looks like the
> Broadcom NAND driver under drivers/mtd/nand/brcmnand/, where we have
> something like this:

> - the core driver only deals with individual interrupt lines which are
> available in the original version of the IP block as integrated on
> Set-top-box/Cable Modem chips

> - the core driver allows for callbacks to perform additional interupt
> work when that is required for the iProc (Northstar, Northstar Plus,
> Northstar 2) and DSL SoCs where we have additional logic to
> enable/disable/acknowledge interrupt lines

That seems like it might work but I'd need to see the code.  Like I said
previously it might be easier to deal with this as a separate patch to
the core driver just from a review/code management point of view.

--bmlge7Pg4VPvffji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmlArAAoJECTWi3JdVIfQxL4H/1nIzCXWn6Js5omGowZ5Zeg7
glPS0qGHae4RxZz6v9qZKLq+JDhAA9a6rmPNyt0jTNojRl+DbUYO0XwgsW4JERDh
fp4zZNgXeuReSR2dfa/0XMpjXvnAXdtYpQmi1srzHdvh507bN+j1uH+EI5jICcjy
bZz677gglCPtLV98Tyaoy8qdtWsq8BfR+84lncWH1YgKJEDLKXUGSMHH4XW/3UuH
xd4hi31LnnHTFiJ2bt5inikJpiAUoX7qX6KSjYRCX3lVAIMUJ69H35AnPptuCJaK
97ll+D/EiBH8Z/qoq5VyBoBMM7sTsbqSWatht3vuDdVHUjTb/xUXo2bpzBUeNoM=
=tw6s
-----END PGP SIGNATURE-----

--bmlge7Pg4VPvffji--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
