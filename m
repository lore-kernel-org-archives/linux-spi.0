From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Thu, 26 May 2016 19:47:46 +0100
Message-ID: <20160526184746.GF16172@sirena.org.uk>
References: <20160524183256.GP8206@sirena.org.uk>
 <5744E51A.1040506@gmail.com>
 <20160525174932.GA10753@rob-hp-laptop>
 <5745E9B6.5090204@gmail.com>
 <20160525184442.GE8206@sirena.org.uk>
 <57464D0A.1030706@weinigel.se>
 <CAL_JsqJwQvPGtscheZjoJyhF1UPxDSqbS-QB9qm3M4HbpOicVA@mail.gmail.com>
 <574657BB.6070300@weinigel.se>
 <20160526100753.GB16172@sirena.org.uk>
 <5746D6CE.5020605@weinigel.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7uYPyRQQ5N0D02nI"
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5746D6CE.5020605-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 26, 2016 at 12:58:22PM +0200, Christer Weinigel wrote:

> One of the main drivers behind devicetree was that Linus got fed up
> with the churn for all platform device changes in arch/arm.  I faintly
> recall him writing that he would be rather unhappy if that just got
> replaced with churn for devicetree dts files.

Since device trees are hardware descriptions they really shouldn't be
churning at all - if they are that's an indication that we're failing at
device tree.

> It makes sense to include dts files for reference boards in the
> mainline kernel.  To include dts files for every vendors variant of a
> design would add just as much churn and be rather pointless.  My guess
> is that the dts file for most platforms are kept private.

Well, a huge proportion of platforms don't work with upstream or upgrade
kernel versions at all but rather use vendor BSPs with all sorts of fun
stuff that the broader community would question strongly.  It's really
quite muddy.

> For platforms based on a FPGA such as the Xilinx Zync it's even more
> pointless to submit dts files to mainline.  When you have "hardware"
> that can be reconfigured the device tree files can't be set in stone.
>  If I use Xilinx tools [1] to add one more UART I have just added new
> hardware this needs to be reflected in the devicetree for the devices
> to be usable in Linux.  And something like aliases which provides a
> stable device name can be very useful here.

Right, but it doesn't follow that aliases are what we should be doing
here - both Rob and myself have mentioned providing a way to label the
actual SPI devices themselves, this seems like a more robust way of
doing things.  For example in a FPGA environment it would allow you to=20
keep names stable even if you decide to reorganize the distribution of
devices between controllers or mappings of chip selects and would have
similar benefits for handling board variants.  Just numbering the buses
provides a partial solution for some systems with usability drawbacks
(you need to know the number to name mapping somehow), naming devices
is both more direct and more general.

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXR0TRAAoJECTWi3JdVIfQ2A4H/3nYZZAE1s1hfgs8GsaNA3Jw
Jaw07ihFscl5pF3EuoD39cqteH+OVGZ9FAN230TP8Wbs4Q81J5Fy0A/j/nshP0dP
KRJxmSmcBTmjHRyyDrJDRGmMzEDFWciRh2ECPz7uUeV/xQK7lhpycs/RrKRSRYXZ
p3yAF3h73XxpkJW2365Tv18BJBBKQiu82mw2ViSbfQKWO6WXaowvfZ2bpojcIPUV
rKruLxlpEulCmzrI5PWhFcI5VJ14Dm1fy5r/tfVDNtEqC+OG1P8itspa2xdXLRfT
5gUIRcwJOLTM1A9xKxkGw/u/xDwKmJmfU5fNnwphoVRkepKvsu1lJoaBK3XrmQU=
=PL/V
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
