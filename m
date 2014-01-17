From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: sun6i: dt: Add PLL6 and SPI module clocks
Date: Fri, 17 Jan 2014 13:07:45 +0100
Message-ID: <20140117120745.GB3867@lukather>
References: <1389892285-11745-1-git-send-email-maxime.ripard@free-electrons.com>
 <1389892285-11745-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140116181528.GY8153@joshc.qualcomm.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBG534SLAKGQEGYDFESA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140116181528.GY8153-OP5zVEFNDbfdOxZ39nK119BPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Thu, Jan 16, 2014 at 12:15:28PM -0600, Josh Cartwright wrote:
> On Thu, Jan 16, 2014 at 06:11:23PM +0100, Maxime Ripard wrote:
> > The module clocks in the A31 are still compatible with the A10 one. Add=
 the SPI
> > module clocks and the PLL6 in the device tree to allow their use by the=
 SPI
> > controllers.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/sun6i-a31.dtsi | 48 +++++++++++++++++++++++++++++++-=
--------
> >  1 file changed, 38 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i=
-a31.dtsi
> > index 5256ad9..ae058eb 100644
> > --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> > +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> > @@ -73,16 +73,12 @@
> >  			clocks =3D <&osc24M>;
> >  		};
> > =20
> > -		/*
> > -		 * This is a dummy clock, to be used as placeholder on
> > -		 * other mux clocks when a specific parent clock is not
> > -		 * yet implemented. It should be dropped when the driver
> > -		 * is complete.
> > -		 */
> > -		pll6: pll6 {
> > -			#clock-cells =3D <0>;
> > -			compatible =3D "fixed-clock";
> > -			clock-frequency =3D <0>;
> > +		pll6: clk@01c20028 {
> > +			#clock-cells =3D <1>;
> > +			compatible =3D "allwinner,sun6i-a31-pll6-clk";
> > +			reg =3D <0x01c20028 0x4>;
> > +			clocks =3D <&osc24M>;
> > +			clock-output-names =3D "pll6";
> >  		};
> > =20
> >  		cpu: cpu@01c20050 {
> > @@ -182,6 +178,38 @@
> >  					"apb2_uart1", "apb2_uart2", "apb2_uart3",
> >  					"apb2_uart4", "apb2_uart5";
> >  		};
> > +
> > +		spi0_clk: clk@01c200a0 {
> > +			#clock-cells =3D <0>;
> > +			compatible =3D "allwinner,sun4i-mod0-clk";
> > +			reg =3D <0x01c200a0 0x4>;
> > +			clocks =3D <&osc24M>, <&pll6>;
>=20
> This looks weird.  You've set the pll6 #clock-cells =3D <1>, but you
> aren't using a specifier here.  Same below, as well.  The binding
> documentation indicates that #clock-cells should be 0 for the pll6 node.

Ah, right, it's a dumb copy/paste mistake.

I'd expect dtc to output a warning/error in such case, but apparently
it doesn't.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS2R0RAAoJEBx+YmzsjxAgZIMP/jSdAvtwBrXo5RfquYcPwaf/
eRbUfbUwhBxi1TgMOodxqr/RvgKZAix8cGXAZbn/lPevwCCF+YaB5ydCJrcnb9HK
yvFjFmb0kweYpMZDkfL3KNDEkgiK5l5+ayxT0A1C6kEv6yi/oXTsVOhP6sds1rVg
p3my6L3Id/hwq/2RD9QidzSTJVyR1OURCR3Uq8RHZIg9s6znQngLLytpVVsIUg2U
x6sDA9VzGfbJJkWC9xewGrZrYtUNTNAt8LoTLcHN60hdGRrILAF+HXisyy5tdww9
o1ZiHNnsn8M3DMABNQ2MBNMmy9CgTJqcUIIVlPkR/EyGFW4Fb4gcxT8+yTwgCfRy
Qw38N4F3W8WNpOu1OZtMy8/0J7OU5Mlkqqvygq5z9/hZ1hJVk87c/WkwpDLye25Y
oIhXE+Sv5p3n+uGaCj+rBpDtUkw8Vzyw4KrSYUC9PpOctBHO0NNEz1nVcBtrfqKy
j/DcZ8WJccfeCKb7q/7UpAGi5pe1kpCnOFdHaZlT+X0LioVeVp0rRbfPMdv9bCqo
d4FbJUAPmjVK1ECavcXdY4rMWxno9KI75SWU5yaBlQNUkFPlJFWYjasKkS55N56c
BCpTnlTg2DdBeOL7sQSZHAJGJ629H3AgiSi08B4l3n7JRvz/a61YTwfMjbofmGR/
tuPPDWIS9SEylXuuXdq3
=Ple6
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
