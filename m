From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3.7] spi/bcm63xx: fix transfer bits_per_words check
Date: Mon, 26 Nov 2012 13:23:17 +0000
Message-ID: <20121126132316.GH9411@opensource.wolfsonmicro.com>
References: <1353764690-5961-1-git-send-email-jonas.gorski@gmail.com>
 <20121124180151.GJ4719@opensource.wolfsonmicro.com>
 <CAOiHx=nXRgF6YCLJ+U77boeuuWb6TOdT9dg=cie=Gruz6eS6xQ@mail.gmail.com>
 <2175243.jGVtISFVra@flexo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oox5VnwalALFvA7"
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>,
	Maxime Bizon <mbizon@freebox.fr>,
	Kevin Cernekee <cernekee@gmail.com>, stable@vger.kernel.org
To: Florian Fainelli <florian@openwrt.org>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2175243.jGVtISFVra@flexo>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--2oox5VnwalALFvA7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 02:11:20PM +0100, Florian Fainelli wrote:
> On Saturday 24 November 2012 19:19:34 Jonas Gorski wrote:

> > Well, I noticed this particular problem on a 3.6 kernel (3.6.7 to be
> > exact), so by that definition at least one noticed, unless I don't
> > count as anyone ;-). So, how can I make this driver less broken for
> > release kernels? I somewhat doubt the framework change will be picked
> > up by release kernel maintainers.

> Considering it is a simple one-liner in spi-bcm63xx and that you don't want to
> propagate a framework-level change back to -stable (which makes sense), don't
> you want to pick that one?

> At least two other users told me about this bug in private conversations.

Feel free to submit it for stable but it doesn't seem sensible to apply
it to development kernels, we want to remove this code from individual
drivers not add new copies.

--2oox5VnwalALFvA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQs2y2AAoJELSic+t+oim9t9MQAJMJrxx9oOIV/QYH3V895ewW
m5h1ZYmA2o9Bzy1EeQJB0HzbeoJNp9bjWnMND2kbcUR6214hxy9tvhTS0yXv4CZV
npPKqLtI1PCqcVtI5gq974h7t7/rfTCtqETjKMrnO74YzuU71DD34Phg99tDLd6j
dQb9phCef5J5sP5uUcig7y+9QiKuMznMxH/FSz895l5MXfM/Ib8AbTv5gSlgk5/a
ATemruprQGj8TC+NPD3xqewjpZUm0neATzbrbeQw61uvoDPtBsvxk0cn3PzA/kF2
tjjzgxlsvEYhHiu4O9oHfRMGhdkDKSVT1ZOZZybZRoWla+j67spRNEGpSwVm0WxE
tKFZTRXVTNJtS6QdBseiKmn2J0Et+YmAOnark7T0yjBGxGAV8ohUBsGCzf2LAnTw
s/BsRs7lnK+McTiVTRrySXsFVB4MkwMwVSPRcuAGXNeMJesQ/rVK64x5MELSofvr
KAXnfbvgwLw7l0NzH1ty20G10/0MFC9H5mxzd7PMdzFPeJAdlERjRhvDkvKRycHv
lCJ0yw57+wfkXCjKEf8emCeKs+0u1GymH2cs9wzG8NXnQv6SeBTIlesvGlC2OVgg
8U247jxAfhVy3kPZH5DRsSERYvfUQBTGJwRfOvCLMkoMB9rgD6WQAMB6EDskuXJe
wjl8zpV+QGviIu8i4QNv
=kjkr
-----END PGP SIGNATURE-----

--2oox5VnwalALFvA7--
