From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 00/13] sunxi spi fixes
Date: Fri, 29 Jul 2016 22:22:47 +0200
Message-ID: <20160729202247.GJ6215@lukather>
References: <cover.1465490774.git.hramrach@gmail.com>
 <20160613195716.GD9354@lukather>
 <CAOMqctS6ZQ3_a97sE2e7H34ZCny2aDE38V1tQA=-SBZwF2sbDQ@mail.gmail.com>
 <20160725073204.GD7419@lukather>
 <CAOMqctQybJoOfUHGtpmpB_koQ=iY+GpQ_BOL2o0QBbwC_HXC0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ofZMSlrAVk9bLeVm"
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Timo Sigurdsson <public_timo.s-fWgRPtSzPNU3WX+qO2AYSQ@public.gmane.org>,
	Jonathan Liu <net147-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Gerhard Bertelsmann <info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>,
	Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TasMV2rI37PzA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQybJoOfUHGtpmpB_koQ=iY+GpQ_BOL2o0QBbwC_HXC0g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ofZMSlrAVk9bLeVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2016 at 10:03:14AM +0200, Michal Suchanek wrote:
> Hello,
>=20
> On 25 July 2016 at 09:32, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > On Fri, Jun 17, 2016 at 12:34:44PM +0200, Michal Suchanek wrote:
> >> Hello,
> >>
> >> On 13 June 2016 at 21:57, Maxime Ripard
> >> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >> > On Mon, Jun 13, 2016 at 05:46:48PM -0000, Michal Suchanek wrote:
> >> >> Hello,
> >> >>
> >> >> This is update of the sunxi spi patches that should give full-featu=
red SPI
> >> >> driver.
> >> >>
> >> >> First three patches fix issues with the current driver and can be o=
f use for
> >> >> stable kernels so adding cc for those.
> >> >>
> >> >> I merged the sun4i and sun6i driver because there several issues th=
at need to
> >> >> be fixed in both separately and they are even out of sync wrt some =
fixes.
> >> >> I guess some of the merge patches can be squashed.
> >> >>
> >> >> I tested this with A10s Olinuxino Micro. I have no sun6i device so =
I cannot
> >> >> tell if that side was broken by this patchset - especially the last=
 patch that
> >> >> adds DMA was afaik never tested on sun6i.
> >> >
> >> >
> >> > For the record, I'm still very much opposed to such a merge.
> >>
> >> What is the reason against the merge? I did not find the original
> >> discussion.
> >
> > I really prefer some code that is concise and clear but a little
> > duplicated over some code that shares every possible lines of code but
> > is a giant mess impossible to understand.
>=20
> Yes, it's been tried. In the case of this driver there is more duplication
> than differences. Also bitrot due to different variants receiving differe=
nt
> updates and fixes crept in already.
>=20
> Adding the remap layer certainly does not make the driver easier to
> understand but it's not becoming giant mess either.

Well, when you say that you're not quite fond of using your structure
all over the place because "it makes your eyes bleed", I wouldn't call
that a good sales pitch.

But again, reg_field seems like a good solution for that.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ofZMSlrAVk9bLeVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXm7sXAAoJEBx+YmzsjxAgN44QALni8ey49XrCL4PifJ3gnnsY
71M0TJp0VVKadiDNbcKEFzhc2dZLRd/F5fWPq2a9Wk78JhE0x0EW9VFHolXgsm6p
AQrhBiwcY7jUHQbMtgb4upH3BUfmaa06M1+VfYGmkeG20cUzoE5bTDdOgUXSftZC
OIh8QvYks0eJsJpBca2aou8NO/PUoR/XXytTFtiJN12sc4VjyGXkKiSVYhAkMtUm
6E961wMfYuy6LsdEMcIzPFPe3tcDa2gQD5Kt+KAT4C2fdcrBGSeTWp7bpFW3W/ae
8u1Py8BMJO83/Do0kEHQa81OzMkDUiZp/YUvbkQFAkKKGNMdcyWTLHuocjedvpPQ
pNHFsQNB8/bX+a918Mlv5HBpoEE1T8CG7JPN1lRCjankJTrw9vYdTgVi+xI+1NQk
jzA0IZyQCc6o+ifB7pfaYpEl+oIUeoRRf0ydqn3pau+g36aAcT53IO2y7OuGrmLS
Hl4i6ATWQcqRkPRicukkiyK+WDUngJVWr4Bzv1SziSxpgLJdhxkTj+/QzP7RQm80
/X3rAruQD+pUPar7PfW25WjV/M1sSsEfud3XO+G5GW9nej52GRtNAfTKiJFzww1c
9LHiv4KIX2XTng91xpUnDFFbHmuF3ayxas3RNVqD/z1+tRtMZuQLCJg7z/sCrBTS
Q1tmK6hlFyo6wYkFGMs6
=SoxN
-----END PGP SIGNATURE-----

--ofZMSlrAVk9bLeVm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
