From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 30 Apr 2014 15:19:50 -0700
Message-ID: <20140430221950.GI3000@lukather>
References: <1398705774-12361-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140429183758.GH15125@sirena.org.uk>
 <24BF05CB-35FF-42E8-BE5C-A5E4E3D0C52A@martin.sperl.org>
 <20140430181429.GD3000@lukather>
 <DA3907EB-0C1B-42FB-B288-9E33F6E24E3E@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <DA3907EB-0C1B-42FB-B288-9E33F6E24E3E-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2014 at 10:00:18PM +0200, Martin Sperl wrote:
>=20
> On 30.04.2014, at 20:14, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>=
 wrote:
> > I'd really be in favor of using the DT overlays for this. All this is
> > nice, but very fragile. You can't really handle any weird
> > configurations that you might encounter, like weird interrupt
> > controllers that might be requiring more informations, or you don't
> > set any interrupt parents, and this parameter list will basically be
> > an ever-growing list of parameters to deal with all kind of crazy
> > corner-cases, and I'm not sure it's something we want.
> >=20
> Problem is getting DT overlays included in the kernel it seems...
>=20
> I agree arguments will tend to increase, but the "core" stuff would be
> not changing all that often, as there are only so many parameters of
> spi_device that can get set/configured anyway.
>=20
> Everything else is either a driver specific parameter that the driver
> supports itself or we have to resort to some voodoo magic blob=20
> kind of thing.
>=20
> But for the most part we want to configure simple devices for those
> boards: ADCs, LCD-Displays, Network Controller,...

Except that for every single one of these devices, you'd have
different requirements, since platform data are driver specific.

> These typically do not have that many parameters of their own that=20
> have to be set up during probing/initialization (mostly interrupt flags,
> maybe some extra GPIO, maybe an attached clock speed).

Except that even if the properties are similar, you'd have to maintain
the map to your common definition to the actual structures.

> The other stuff gets typically set up via other interfaces=20
> (netlink et.al) anyway. So I do not see that many parameters that=20
> would realistically get set.
>=20
> Also note that this should allow people to do simple stuff quickly=20
> - like spidev - not complex stuff.

Yeah, but you were talking about LCD displays, that are just crazy
complex most of the time.

> So from the support-perspective of an end-users it is easier to say:
> * echo "cs=3D1:...." > /sys/bus/spi_root/spi0/register
> * if it does not work:=20
>   echo "cs=3D1" > /sys/bus/spi_root/spi0/register
> * and run again slightly modified:=20
>   echo "cs=3D1:...." > /sys/bus/spi_root/spi0/register

And the devil is in these "...."

> than:
> * install dt compiler with=20
> * create that file (dt) and modify the settings
> * run the compiler
> * copy the compiled DT-overlay to /lib/firmware
> * echo "..." > /sys/devices/bone_capemgr.*/slots
> * reboot if it does not work...
> * run steps 2 to 5 again and see if it works...

I'm not sure that "kernel development is hard" has ever been a good
argument.

> SPIDEV is for people wanting to do rapid development.

Yep. It can be used for that. But what you suggest goes far beyond
spidev alone.

> The register part + kernel-driver is the next step up in complexity,=20
> where spidev is not fast enough for some reason, or does not provide
> for all the needs (shared access,...).
>=20
> The complex clock example of yours is something that would fall in the=20
> DT-overlay case - these things are most likely too complicated for=20
> the simple user and requires extensive knowledge of the design.
> Those people tend to know how to build a kernel and compile DTs.
>=20
> Different tools for different level of complexities.

So, you're saying that, to the end-users you're concerned about,
saying "yeaaah, you know, sometimes you can use this spi register
thing, sometimes you can use the DT overlays, but you know, only in
cases where it is complicated." is actually easier than being
consitent and always requiring to use the overlays?

> > You listed only ARM boards, that are not supposed to be non-DT. RPi is
> > using DT fine, just like the beaglebones. I don't really see why we
> > should care about !DT cases.
> I listed those ARM boards because I have most experience with them.
>=20
> I do not know how those INTEL Galileo boards work, but I doubt=20
> they run DT - ACPI more likely.
> But people still want to do rapid development on those using existing
> arduino shields, so the DT-overlay requirement would cut them off.

Then ACPI should probably provide informations on whatever shield is
plugged in there.

> Same for future ARM64 devices where there seems to be a push by=20
> vendors to move to ACPI for those systems - not DT.

Both ACPI and DT will be used for ARM64.

> Other examples are the WIFI router, most of which also have SPI=20
> interfaces and people have done all sorts of things with them - not=20
> all run ARM either - at least all those WIFI routers I have seen
> so far do not run DT-kernels...

I'm not sure I get your point here. Most likely, the router won't have
a kernel that have your tool anyway. So you'd have to recompile
it. Why not just change the board file (if it's a board file) before
recompiling?

> So there is more to it than just ARM and we should be able to handle
> the "easy" cases for all systems independent from how we configure=20
> the rest of the system.

But there is not much more than ACPI + DT + board files.

> Also the proposed setting is along the same lines as GPIO management
> via /sys/class/gpio.

Not at all. Individual GPIOs are not single devices. The GPIOs
controllers are. And you can't bind or load those controllers driver
=66rom /sys/class/gpios

> Following your argument we should not have this interface either
> but use DT for these GPIOs as well - similar argument for I2C...

Hmmm, you can't do it for i2c. Or you're no longer talking about
"loading any driver on any device through sysfs", and only about
i2c-dev. In this case, Take a look at the patch that started the
discussion, and Mark's comments.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTYXcGAAoJEBx+YmzsjxAgQ0sQAI0QMUm1A1uHM6xBkZf4amtA
/6hZFRArvhPBF4IA1k/cgIIsM8Y79N4ouBFS6alWH9LpHFTTlWNkOj+ts/OieABD
8WHFuXw8kMhfmFrYR+0Yga9I7iiivRlCFoXVE9N5A+pvUXE0v1VFjhqAYtKwCxuC
p2BvL3+GrMAFi88s57VKCFcANab+WuhMFsdi1T9iPngthp0Vm7LMw/EWO90Jwevo
L6UME/eol6daW0zbYWclUdS2zxjhr/Gbdh2qkRbtwCra+qVswg4eDIGdUuBycbW3
geSuPMBTgBtiRZZzbX5aEI1uMbEdRtCPcUjgykbXTnFGeYJ9iD/vjl8dQyTv4qc1
SlF0a1+Eq7/1YAlOqD8Bn2w+hVHVIIvj1MJBuZ0rVNAKOVj96KGJWjcBaxHsIUUf
PnBtlhEK6zl4QLmbvOoVe9qxDOuuYGJRx9nYP7PXP9nZsSsVDgn0Wfw5EAXG3+i5
1sFkHG+DfxC1kCJW+eK7I2ijjFzMosOltIcU5QyCgU5W8lfhg2X/8o3EdgjS6DxO
XEdf9IXtSPNt8NJJlCh+Sv3oPiaswVcURzxFldHBLQCjXCJfvnsl86XSVJ4HTYdX
CsTyOL0pf/OzstgXEXCJ6yfBJklajp10fgyBQmLIfROvkhRUrrv3IlZvNmB9rYx4
1UR6nbfz+1xLglwMamU4
=gArF
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
