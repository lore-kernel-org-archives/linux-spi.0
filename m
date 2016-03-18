From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] spi: sun4i: add DMA support
Date: Fri, 18 Mar 2016 21:23:10 +0100
Message-ID: <20160318202310.GS30977@lukather>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
 <20160306214206.GW8418@lukather>
 <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg@mail.gmail.com>
 <20160317072721.GJ30977@lukather>
 <CAOMqctQzMhR_bf=rMyROcTAPcrgx2EBqhH+qJL=b-U=iG9ZF4Q@mail.gmail.com>
 <20160317114308.GF2566@sirena.org.uk>
 <CAOMqctSoA5WxtBCUK0PoHTV9OBi_fw4mdqOw+Dc_1DB_jghqng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7fVM7fn5T1d7Fqim"
Cc: Mark Brown <broonie@kernel.org>, Priit Laes <plaes@plaes.org>,
	Chen-Yu Tsai <wens@csie.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctSoA5WxtBCUK0PoHTV9OBi_fw4mdqOw+Dc_1DB_jghqng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--7fVM7fn5T1d7Fqim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 17, 2016 at 12:54:08PM +0100, Michal Suchanek wrote:
> On 17 March 2016 at 12:43, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Mar 17, 2016 at 11:58:05AM +0100, Michal Suchanek wrote:
> >> On 17 March 2016 at 08:27, Maxime Ripard
> >
> >> > You're mixing two things up: the fact that we can't do more than the
> >> > FIFO length in PIO and that we're missing DMA support. We have patch=
es
> >> > to address both, and there's no depedency between the two.
> >
> >> The only thing is that although DMA is optional on pretty much any
> >> system you will have DMA available unless you broke your config. You
> >> really do want the DMA support when it is available. So there will be
> >> nobody testing the non-DMA part and it will be prone to bitrot.
> >
> > Well, it might be worth doing PIO for very short transfers even if you
> > have DMA - it's quite common for this to perform better.
>=20
> That's what the driver does. The discussion revolves around the fact
> that the driver does not attempt to work (even for very short
> transfers) when the DMA channels are not configured and just bails
> out. AFAICT the channels are always available when the system is
> properly configured and the dmaengine driver loaded.

I guess we just don't have the same defininition of "proper".

Let's take an opposite view. Can you have SPI working now if the
DMAEngine framework is not there? Yes. Why should it change? And even
more so, why should it change silently?

> Very few device drivers would work with 63byte transfers only and the
> code for manually driving the CS line in case the DMA engine fails to
> configure will necessarily go untested most of the time since most
> systems will have DMA configured properly.

That's not true. A significant portion would work. I don't like to
make up numbers, but I guess only the EEPROMs and rather big screens
wouldn't work.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--7fVM7fn5T1d7Fqim
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW7GOuAAoJEBx+YmzsjxAgmCgP/ioWs2IDw9g/g56rz3z4n4XI
9qKK28SjzLucJZGC45+F5Lkrqh2tzD8M6o2Azoo81WoxQ8yTRWg4mRbQJsIizboJ
s1WBuqjVI2D86nQ8PHzao3fx7JkwVgTmZrCN/erdk29t8qDvyl2XnNy3QvIuKNS6
1OlgldN6wOU0NHW4wxZeC7lvGqsb08xMeqzzx4nXw9vHpQwtTyiRSu0VuYc7Uy00
dogmhkdonWYd/GtDK7RsfVUz1my69LkyyjHQw/7Xhn2wTZtdoUoUpBDyelq66OVw
Rzp9DUIltwD67rkbi3fY+IEKnMeY3ehf9BEj1ciz4DCPJnw+Nu8eyRkU/opLqB4x
vKQtTPLV7EK5ECUF4zLWISdiLH0TZYKEddVP5JL+soo/MHN0xXd19emC6IGrTU+t
1UYFMsDF4MAN6Dc1/haHVlBHz+Csc06pSDPa9UyUUMUrhhAMQCxHEJz9GNHP4Lbw
n3QsV3WGUiuNE3AJbdUPYiIRR4VaTSHut2t0/QZT3LHb6jVQgp/SR5QHGGTqH+Sd
WE3mZ/G9qzJJBA/+kL2VpbsQH1vUJUirZO5pTkGM8ijyIH32wO7Kqs6rqEtSplRh
ZwHxUC4TrBjsplHQZgr/TQRqaGp+SVqIzPa/rCmvnbGHNVWky+nEOCx+dxS8V2E7
VWjNjfdGZ1guwabY714s
=s1U/
-----END PGP SIGNATURE-----

--7fVM7fn5T1d7Fqim--
