From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Thu, 21 Jul 2016 23:47:34 +0100
Message-ID: <20160721224734.GU6509@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="E1BPhOSoTthPQdPL"
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


--E1BPhOSoTthPQdPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2016 at 03:06:16PM -0700, Florian Fainelli wrote:

> Mark, would you oppose to a driver structure that looks like the
> Broadcom NAND driver under drivers/mtd/nand/brcmnand/, where we have
> something like this:

> - the core driver only deals with individual interrupt lines which are
> available in the original version of the IP block as integrated on
> Set-top-box/Cable Modem chips

I need time to look at this (hopefully before Monday but stuff might
come up) but I definitely think it would help to merge an initial driver
that doesn't handle the extra register range and then deal with the
extra register range as an incremental patch on top of that - this would
mean we can get the common code that's used on all boards (which is
fairly straighforward IIRC) merged and then whatever solution is used
for the more complicated integrations can be handled separately.  If
nothing else it'd make it easier to think about the more complicated
cases if we're looking at just that code in one patch.

But no need to do that if you don't want to, it might help speed things
along though.

--E1BPhOSoTthPQdPL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXkVEFAAoJECTWi3JdVIfQhKcH/Ah5T6kLJNsTEFqjzw6/xpeO
BfVcs5XAAWgpwvqdwSE/CkLJwHmugPZYvii8xPhspEFtXgBFFgUQ6M8upDU0mfKG
BpaoZVNQs3S5TIRb/ORyBLHhWWR9KR5v7rwgxbK2YNtoIGMUSppw9aOat+xZcgL5
9Ffo1NnmDTHcpk1AjFX/60XOfPJMFGJQ5dGA81hitXihQewD8cIESdU3JIQHyNR3
fa73dlFr0oJS7rtUAIg7BNu62gxn3aTo5KenXETKRUksqwFWtTObuTFw3EgjhgI9
g1b0CWtk+4sKoVxJe/NewI7aP2AnkdRjurU2lKhv+rx598eUM/lmJ9kCrkp9u64=
=xg44
-----END PGP SIGNATURE-----

--E1BPhOSoTthPQdPL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
