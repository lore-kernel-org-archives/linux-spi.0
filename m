From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Mon, 5 May 2014 12:17:23 -0700
Message-ID: <20140505191723.GK22111@sirena.org.uk>
References: <1398705774-12361-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140429183758.GH15125@sirena.org.uk>
 <20140430180609.GC3000@lukather>
 <20140501011811.GF3245@sirena.org.uk>
 <20140501223629.GJ3000@lukather>
 <20140502174048.GV3245@sirena.org.uk>
 <20140505042147.GE11606@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ppIqr1kl39GnwQx"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140505042147.GE11606@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1ppIqr1kl39GnwQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 04, 2014 at 11:21:47PM -0500, Maxime Ripard wrote:
> On Fri, May 02, 2014 at 10:40:48AM -0700, Mark Brown wrote:
> > > i2c-dev works great in these cases, because you always have access to
> > > all the bus, and all the devices, except if the device is already used
> > > by someone. The patch I suggested is an attempt to mimic this.

> > It seems better to implement something like this at the device model
> > level, provide a way to have a default UIO driver for anything on a
> > given bus.  I don't see anything bus specific apart from saying what the
> > default driver to use is and it avoids the icky code fiddling about with
> > what devices are bound and the races that might be involved duplicated
> > in individual buses.

> Hmmm, yes, that's probably a great long-term way of dealing with this,
> but I don't see it happening soon.

Isn't the code in the patch that started this thread roughly what's
needed, just done in a SPI specific way instead of a generic way?

--1ppIqr1kl39GnwQx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+PAAAoJELSic+t+oim9aW4P/ArBbFSeTMnRpbd/LQqpqSIP
AgnV9jXQf/A0+RCyo5RPO5Yw5V3WlMTNunVDNpQxyv7HdP9rZT8m1d/2BtabQYfJ
lSbh0d/+aEum+t77TxDrakZr16X9dXh6KNwSqlS2T2ltkfHl9kkPZ7zcXTyld0za
IEd0gIoSuwDkwWtzmVMuKgoJfPdU35edAtq3p4dRzbs1TpYyZiWAGsEYZ99YdI67
tOonoLWqoxNqiK6rUF/fHyh3mpCyYIwGp3AipUrSo5tPDDEtd3TK82ummFdoaN4i
x/yao9jDGnVNwb9lMTj3E4td3w91yXUMq/B3gRv3XIP/QbmFQgEkZTc9aujDB+rK
ek63FCdtbjNb6CQKwqusQVZuQCPaFYjuoVjhify2NkXU94TWJ+BNHKVQz/zDAzqa
9AtKzDNehpzBmzsYFwqNIYFseCQIx6ZuEO/EGuE91N+f0kQX01tDLUqflEPPMx35
JFC5O/Jnof5/6BPGgtVfZDltUfHg2hX+5xsd/m61sgEVskJek0N4g8OYKbvHpYTy
fhD6L266f8be3HjUQBErmPuj4XqmYA4PB+UHUkYx9vz0BWl/EWk15JefT3JqzTRd
1i7NZZ9U1nMRBdxnnbCBR+ySe8Mqm6Aq1TV3GyKaxSL496x6u1MvFpIae88cGvuy
3Hut9XF4k0OS81Jaus3l
=NxhC
-----END PGP SIGNATURE-----

--1ppIqr1kl39GnwQx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
