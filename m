From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sun4i: add DMA support
Date: Thu, 17 Mar 2016 08:27:21 +0100
Message-ID: <20160317072721.GJ30977@lukather>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
 <20160306214206.GW8418@lukather>
 <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ssZxAlvqSOvXAj81"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ssZxAlvqSOvXAj81
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 10, 2016 at 10:01:04AM +0100, Michal Suchanek wrote:
> Hello,
>=20
> On 6 March 2016 at 22:42, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > On Fri, Feb 26, 2016 at 01:51:51PM +0100, Michal Suchanek wrote:
>=20
> >> Besides this non-technical objection there were multiple technical
> >> objections.
> >>
> >> IIRC one was that the driver does not handle the case when the DMA
> >> channels are not available. As I understand it the channels are
> >> exclusively reserved for a particular peripherial on sunxi platform so
> >> this ShoulNotHappen(tm). So it's probably fine for the driver to fail
> >> probe  when you have broken DT or no DMA engine support for sunxi
> >> platform.
> >
> > There's a quite trivial scenario that would trigger this: if the dma
> > driver or dmaengine is not enabled / loaded.
>=20
> There are other trivial scenarios under which the driver will fail
> like loading wrong DT, not compiling or loading the sunxi pinmux
> driver, and whatnot.

I don't see what the pinmux has to do with SPI and DMA, and you're
wrong, the pinmux driver is always compiled in if you enable the sunxi
support.

And you're missing the whole point. DMA accesses are optional, pinmux
and proper machine support are not.

> When you misconfigure your kernel it does not work. So long as the
> driver just fails and does not crash and burn it's normal. Since the
> driver is pretty much useless without DMA as it is now (63 byte
> transfer limit) losing the non-DMA functionality when DMA engine is
> not compiled-in does not seem that terrible.

You're mixing two things up: the fact that we can't do more than the
FIFO length in PIO and that we're missing DMA support. We have patches
to address both, and there's no depedency between the two.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--ssZxAlvqSOvXAj81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW6lxZAAoJEBx+YmzsjxAgWfgP/11/1n3BoOGXXEUEruBZk2WP
gLXzYJ7OZPOTDtNpYuUnbqjgRP9J5sM5BL9idVJydSRXTROWjAmFEtOxOza7GuE8
rtCldTVmDHrKLiJMEmO0DiXSK1LMTJuS9MyU8ERHdzqebDmRp4LpaAkv56PHvtot
33oqy6KA8HICmOp5xOYR8lJjbLshg28OK0u6ylQ6AtAD1HqksWI9AJQyyG4Woy3y
2YxpwUT5zpfvQVePr9swc1QFmQSyN5rG3CiPX9N5wN3Op+/U9cSLhbAAesOyZ9XL
84c/Hg6nJlhnTbIGcxU6hW0e/1fGHQPpLuJgOSSiOYPHSUV0aij3NectYkbDrOMr
qgzmnhU9YYKMQKEPvZ+8fDYe33N2/tv0snvQf4RXpkcpY0FTm5WziJZI6HJoprpO
aQW6Y+D7GSq4Npf/0SvynbEwlzjsaYyDh+cuMcALmuFTie2hkcGn9MYhP9brSX48
uwRwPmp62bJXPFrtTgOm0Huk4uvnW4DBOxMWRxx8imzCCX4tnCoHeqDcPUEGg2Kk
S6zIH95mu5HBIt/DCEQ09qbLhl3irpF3QTy+4z8NPnFngYw1B85DtRy3Ib9uJWLX
HxDV8+DdnuUvxQS+Ywr9HZJfXu4yp+FOtD4WisPxGCQnx0vmkXfJbattfc6KeEZR
ltDeRdNSx89yLjhLOVoM
=C55V
-----END PGP SIGNATURE-----

--ssZxAlvqSOvXAj81--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
