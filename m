From: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] arm64: dts: sun50i: H6: Add SPI controllers nodes
 and pinmuxes
Date: Mon, 13 Jan 2020 09:59:29 +0100
Message-ID: <20200113085929.24iseck4fljw5njh@gilmour.lan>
References: <20200108101006.150706-1-andre.przywara@arm.com>
 <20200108101006.150706-2-andre.przywara@arm.com>
 <20200111172639.to3lhzros6ca5hj2@gilmour.lan>
 <cea0a8ed-fcf7-53c8-daf9-cf27408d83f9@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ir7fewqs7mlcjtw5"
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: =?utf-8?B?QW5kcsOp?= Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cea0a8ed-fcf7-53c8-daf9-cf27408d83f9-5wv7dgnIgG8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ir7fewqs7mlcjtw5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2020 at 03:12:19PM +0000, Andr=E9 Przywara wrote:
> On 11/01/2020 17:26, Maxime Ripard wrote:
>
> Hi Maxime,
>
> > On Wed, Jan 08, 2020 at 10:10:05AM +0000, Andre Przywara wrote:
> >> The Allwinner H6 SoC contains two SPI controllers similar to the H3/A6=
4,
> >> but with the added capability of 3-wire and 4-wire operation modes.
> >> For now the driver does not support those, but the SPI registers are
> >> fully backwards-compatible, just adding bits and registers which were
> >> formerly reserved. So we can use the existing driver for the "normal" =
SPI
> >> modes, for instance to access the SPI NOR flash soldered on the PineH64
> >> board.
> >> We use an H6 specific compatible string in addition to the existing H3
> >> string, so when the driver later gains Quad SPI support, it should work
> >> automatically without any DT changes.
> >>
> >> Tested by accessing the SPI flash on a Pine H64 board (SPI0), also
> >> connecting another SPI flash to the SPI1 header pins.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> >> ---
> >>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 54 ++++++++++++++++++++
> >>  1 file changed, 54 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64=
/boot/dts/allwinner/sun50i-h6.dtsi
> >> index 3329283e38ab..40835850893e 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> >> @@ -338,6 +338,30 @@
> >>  				bias-pull-up;
> >>  			};
> >>
> >> +			/omit-if-no-ref/
> >> +			spi0_pins: spi0-pins {
> >> +				pins =3D "PC0", "PC2", "PC3";
> >> +				function =3D "spi0";
> >> +			};
> >> +
> >> +			/omit-if-no-ref/
> >> +			spi0_cs_pin: spi0-cs-pin {
> >> +				pins =3D "PC5";
> >> +				function =3D "spi0";
> >> +			};
> >
> > It seems suspicious to use it in the Pine H64, since PC5 is also used
> > by the eMMC (and this prevents either the SPI or the emmc controller
> > to probe, depending on which probed first).
>
> Argh, good catch! I saw that AW changed the pin sharing between SPI and
> MMC2 slightly, but didn't actually check that they made it worse :-(
> Because this time it's the MMC CMD pin affected, and not the somewhat
> optional DS pin as in the A64.
> So I see we can't really have both at the same time. So what about this:
>
> We keep the SPI flash chip described as in patch 2/2 (as it's soldered
> on every board), but mark it as disabled and explain this in a comment.
> This way we can't access it under Linux, but keep a potential eMMC chip
> accessible.
>
> In U-Boot's DT copy we could deviate and mark it as "okay", as U-Boot
> doesn't use both eMMC and SPI at the same time. I need to check whether
> this works or we would need to move the pinmux setup out of the probe
> routine into something later.
>
> And we could go one step further: If U-Boot detects an eMMC connected
> (it's on a socket and so optional), it changes the SPI flash status to
> "disabled", to allow EFI apps and kernels using this DT to access the
> eMMC - which is far more useful than the SPI flash.
> Otherwise (no eMMC connected) it can stay at "okay", as there would be
> no conflict.
>
> Does this make sense?

It does, it seems like a good plan

Maxime

--ir7fewqs7mlcjtw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhwxcQAKCRDj7w1vZxhR
xeN3AP472p91nx9oqXRJe6+0u8r0T386EdVwUUHUSJGHeqdtzwEA8UiwW9E3F42A
/XZ5acoOflKaj0ShNtTko85S2oaFWQM=
=8bva
-----END PGP SIGNATURE-----

--ir7fewqs7mlcjtw5--
