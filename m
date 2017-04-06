From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: don't use uninitialized variable
Date: Thu, 6 Apr 2017 19:12:16 +0100
Message-ID: <20170406181216.m4rke6smv2bajdqv@sirena.org.uk>
References: <1491466583-6121-1-git-send-email-rabin.vincent@axis.com>
 <20170406105502.baaj4c2xcetp5z6p@sirena.org.uk>
 <20170406113924.GA7801@axis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vjl6qsurfbepmyik"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rabin Vincent <rabin.vincent-VrBV9hrLPhE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170406113924.GA7801-VrBV9hrLPhE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vjl6qsurfbepmyik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 06, 2017 at 01:39:24PM +0200, Rabin Vincent wrote:

> Yes, I could add something like:

>  By setting the default value to zero, we ensure that the probe fails if
>  the num-cs property is missing.

> But I noticed that you already applied this and your automated email says:

>  If any updates are required or you are submitting further changes they should
>  be sent as incremental updates against current git, existing patches will not
>  be replaced.

> So I guess it's too late to submit a new changelog?

Yes, this is more for future reference - I already did the checking to
figure out that this does the right thing.

--vjl6qsurfbepmyik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljmhP8ACgkQJNaLcl1U
h9DExgf/cC1MQWR2EN7T6pG/ioD76zmvaWc/+vODmAVlJ4x2tRS4+OvQpocS+F9E
dI363CN4+vRg0KevcjEnH/Env9GAnrI52afz78cE1dYFn3mU1cv4NLDsye3sZevS
obKSRm8IW7j0npGUcWT3TcSYGBJ38Y93LH1yv708sAl6lTMyOzDLtflXtyBKzKfR
rbJcHvq8Hnp/SIZDyS0xaVDlLAn5dCzEBhokY9umXDLfiQ3MEphbcRfVqVDjyZy/
YNX0UGbDeGK4lwB4z80nLwCouf8C46VxI7TCS4eKbLqlQvRJk8vHN4toaMUPOUs2
lPkjIzgn0nsvVpu3KoZb4YD9xuUi3A==
=el4J
-----END PGP SIGNATURE-----

--vjl6qsurfbepmyik--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
