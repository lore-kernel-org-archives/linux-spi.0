From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: How to handle SPI components requiring heading/leading clock
 cycles with CS off
Date: Wed, 24 Aug 2016 11:56:40 +0100
Message-ID: <20160824105640.GC22076@sirena.org.uk>
References: <79679118-c092-1f9c-1972-0bb81bc59411@c-s.fr>
 <20160824094456.GB22076@sirena.org.uk>
 <8c6cbd99-7dd8-bbbf-89ee-a33752ab3063@c-s.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LkL3iLkxWcC48rNm"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8c6cbd99-7dd8-bbbf-89ee-a33752ab3063-GgN8y9CXRhA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LkL3iLkxWcC48rNm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2016 at 12:49:55PM +0200, Christophe Leroy wrote:
> Le 24/08/2016 =E0 11:44, Mark Brown a =E9crit :

> > If you leave the device with cs_change set so the chip select is low it
> > should do the right thing after the first message, though obviously you
> > won't be able to share the chip select then.

> What is needed is to get some SPI clock cycles with CS off i.e. CS high.
> With cs_change, CS will remain low i.e. CS active

No, it'll change chip select so if it's already set it'll deassert and
if you leave it deasserted at the end of a transaction it should leave
it deasserted.

--LkL3iLkxWcC48rNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXvX1mAAoJECTWi3JdVIfQAIoH/24CHV3pJ+Z+8Zl8rp8iODQQ
qWZm2ApY3knjWDjpdxYHWkvuCXY6JuncquGxizeuUmZyPpoxvJhgFglI5XoHK4kC
I+6aYF34h8RE/qMJdW45IcsTTWjCEmFW1eNYGGn82rMqUEAwp8s4bx8xZKD+r7fG
/9szczveFggA8z9bGb3gQ/szSPeW7kPC/NwbayPtnGt+Sg7krgEaPjkLeQd++l0e
Kx9lbfXlz3ACtjjoppPighg/3C+jlcI8YeLuimoBGCQaBx9GQDOIrvUwZBJAgM5x
SNhellulsEaP6SzZblkXuz4bKI59I2dAmHOzdDXrrvKqhuIiFDDWCmNViWE6TTw=
=TK7a
-----END PGP SIGNATURE-----

--LkL3iLkxWcC48rNm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
