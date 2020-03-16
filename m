From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fix cs_change for last transfer
Date: Mon, 16 Mar 2020 15:13:20 +0000
Message-ID: <20200316151320.GI5010@sirena.org.uk>
References: <45912ba25c34a63b8098f471c3c8ebf8857a4716.1584292056.git.mirq-linux@rere.qmqm.pl>
 <20200316121750.GD5010@sirena.org.uk>
 <20200316143455.GA19141@qmqm.qmqm.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200316143455.GA19141-cHozx32mtrEEUmgCuDUIdw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 03:34:55PM +0100, Micha=C5=82 Miros=C5=82aw wrote:
> On Mon, Mar 16, 2020 at 12:17:50PM +0000, Mark Brown wrote:

> > This is the opposite of the intended behaviour - we want to deassert
> > chip select at the end of the message unless cs_change is set on the
> > last transfer.  If this were broken I would expect to see widespread
> > problems being reported.

> This is unfortunate naming I suppose. I reread the spi.h comments
> a few more times and it seems indeed, that .cs_change =3D=3D 1 on last
> transfer means to a driver: "you may leave CS unchanged" - quite the
> reverse compared to non-last transfers.

cs_change also means that we should add an extra chip select transition
on transfers other than the last.

> Please drop this patch then.

OK.

--81JctsDUVPekGcy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5vl48ACgkQJNaLcl1U
h9DeXgf+Msgq0Fm5YFrl6BpPbINtM7Fs6PHQdsIBzUMHwaUxzJ476+0jR9ILxEvu
oCl/v/BLaAw/KY/8ThuxaxG4H6S4s2U81tyOzDDJGINf+DIkbsTytxcHzC8fHlmC
cCX7v80+PGdLbNklVqd34sNgTPPiG0GgLUBbFJu4J9ALVA158w4RBYQMVRACaOi7
iqxBkcb2LoZA3d4Ack098jTiyFEbV3yUJGWb3mkOzlvEsoZEbZOG5hU+1YH10roJ
rXsen2GpoQ01/kt0T0qoPSMBPyVSYHcbs3mc+I3JroIo0my4bVTOxvMip+G33jwe
ftkmcl8XS3KCBDNLs08TsBWjugPd0w==
=4bFZ
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
