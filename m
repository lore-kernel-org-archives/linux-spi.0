From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: How to handle SPI components requiring heading/leading clock
 cycles with CS off
Date: Wed, 24 Aug 2016 10:44:56 +0100
Message-ID: <20160824094456.GB22076@sirena.org.uk>
References: <79679118-c092-1f9c-1972-0bb81bc59411@c-s.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bSr84fpmRhc6ULjY"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <79679118-c092-1f9c-1972-0bb81bc59411-GgN8y9CXRhA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bSr84fpmRhc6ULjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 23, 2016 at 06:10:48PM +0200, Christophe Leroy wrote:

> The only way I see to achieve that is to transfer a 4 bits word with CS off
> before and after the data.
> I've not found any way to do so in the current SPI subsystem implementation,
> is there any ?
> If not, what would be the best approach to implement that ?

If you leave the device with cs_change set so the chip select is low it
should do the right thing after the first message, though obviously you
won't be able to share the chip select then.

--bSr84fpmRhc6ULjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXvWyXAAoJECTWi3JdVIfQ7XkH/RK+33zwWEvnc0EyQR+DXQht
t410wG/PdIBSvFEg1bnKZJFyq8i8uKItKm358VcDJM/JTbXB5+V8opyzMWXAKQrT
lcYckZRKFOKvmCDYKbIxk+jbZwKnioQOZD5UMM73BtEUAT6gg/nBfDKQMluTlCoH
qPjp7sA41H+NNWjLNgmrVcBh1a3nxd945uQCxJ08d3eRiv770ME2p+AO3RWlEAiP
fGaY0zL/JxmfQNSHnJdoRYpv9TkFBknJep9V6Q5oTg3NrCuYSQbISYDvqVuGodRz
axTudQbTcaoMatsba1C2i7k6d2S+29GZYW8CvnWUtdr6G52NO0ZraVkAHmziFe4=
=GRq5
-----END PGP SIGNATURE-----

--bSr84fpmRhc6ULjY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
