From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Wed, 13 Jul 2016 12:10:53 +0100
Message-ID: <20160713111053.GG9976@sirena.org.uk>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
 <1466197433-11290-2-git-send-email-kdasu.kdev@gmail.com>
 <20160622160726.GQ28202@sirena.org.uk>
 <CAKekbevYN3CLvqQs3stUXDFEMREMOJ0g4+w7Zsno1kV-ieYEiw@mail.gmail.com>
 <20160701160753.GX6247@sirena.org.uk>
 <CAC=U0a3WN9TGw7zwwP3qFf5MUsRteUcVLytFgjnP4zScZS0xXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sLx0z+5FKKtIVDwd"
Cc: Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list"
	<bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC=U0a3WN9TGw7zwwP3qFf5MUsRteUcVLytFgjnP4zScZS0xXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sLx0z+5FKKtIVDwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 12, 2016 at 06:06:04PM -0400, Kamal Dasu wrote:

> The NS* SoC  SPI blocks has hw glue logic specific to MSPI+BSPI, so
> the re-usability of an interrupt controller driver for this  logic is
> limited.  The spi only (spi protocol) block does use l2 controller,
> however for the MSPI+BSPI block used for the spi-nor flash had to
> introduce the code to handle l1 interrupts within the code itself. In
> this case can the driver be accepted without having to introduce a new
> intc driver ?.

It's not really about reuse, it's about maintainability.  All the code
for handling this within the driver is quite unusual and makes the
driver harder to understand and review.  That's going to have an impact
now and make things harder to follow in future too.  Fitting in with the
frameworks means that we get the benefit of the structure and support
code that the frameworks provide while minimizing the amount of unusal
code in the driver.

You may find that you may even be able to use one of the existing
generic interrupt controller drivers if the hardware is simple enough.

--sLx0z+5FKKtIVDwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXhiG8AAoJECTWi3JdVIfQGLMH/3+PAqoXb5FoKd2yANhAIGev
1rv0zeouokLgvF0hNfni7ptlIweeKbwffzj4inx8h8UnBohAK4amfVEfqzAOsjOP
UmWAhTPsjaLq5/h51dtsnliz9CNH8/a1gk47fiyCWRJ0yuuUs1ROwAPs74VREx8q
l4D7KPWPYiHpqHcJBwmdORqauH0rL9eQTetL4DOO0YpsdhKarUSOOQSLyeWyMepV
s0chK80nHpf+Bj39X+GexvnO3CEItmuzHNrosZk+b4MLIFDZQTxHzNMfLZSQVaze
ZL7t3iHWkW7MjBjbIbjgaorOlWfujKJ1O0tXa1NDmnw10nMos0XnxAAqopdCMoM=
=TCCV
-----END PGP SIGNATURE-----

--sLx0z+5FKKtIVDwd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
