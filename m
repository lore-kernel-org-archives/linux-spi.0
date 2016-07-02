From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Sat, 2 Jul 2016 12:15:10 +0200
Message-ID: <20160702101510.GJ6247@sirena.org.uk>
References: <20160629091304.GP1711@lahna.fi.intel.com>
 <20160629162127.GA6247@sirena.org.uk>
 <20160629163420.GC1711@lahna.fi.intel.com>
 <20160629183101.GN6247@sirena.org.uk>
 <20160629185155.GG1711@lahna.fi.intel.com>
 <20160629192059.GV6247@sirena.org.uk>
 <20160630124931.GD23527@lahna.fi.intel.com>
 <20160701101912.GL23527@lahna.fi.intel.com>
 <20160701145035.GP6247@sirena.org.uk>
 <20160702090114.GS23527@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8YDLdOu/DaKXZo9W"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160702090114.GS23527-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8YDLdOu/DaKXZo9W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 02, 2016 at 12:01:14PM +0300, Mika Westerberg wrote:

> There are these boards for Makers and IoT stuff which basically have pin
> header where you can connect different low speed peripherals, like
> sensors and so on. The main point is that you don't always know
> beforehand what devices will be connected to the board. Now, it seems

Sure, that's where most of this crap comes from.

> that IoT/Maker folks solved this in userspace so that they are not using
> existing drivers provided by Linux kernel but instead they are using raw
> access to buses like I2C and SPI, and provide their own "drivers" for
> those peripherals.

...which is of course a terrible solution which results in a huge amount
of wheel reinvention and effort duplication.  The best practice here is
to use overlays, there's people doing active work on standardizing
connectors for DT at the minute which will help a lot there but
engagement from the maker community in general seems depressingly poor
even though some of this stuff ends up getting productized.
Unfortunately you're going to have to redo all the overlay work for ACPI
to use it on x86.

What would be really nice would be if the schematic capture tools were
able to output DT overlays automatically, that'd make it really simple
to design an add on board/circuit and get the software support up with
no bother.

> Now, since spidev is just Linux software abstraction for raw access to
> the SPI bus I don't think it is good idea to allocate special ACPI ID
> just for that - it does not describe hardware. So instead I'm thinking
> we could re-use those Windows ACPI IDs in the driver.

Yes, exactly - spidev should never appear directly in ACPI or DT since
our ideas about the best way to control the hardware may change.

> With this we can either stick these devices with the boot firmware
> shipping with boards or alternatively provide overlays which can be
> loaded to the existing firmware as needed. Users of these boards can
> then take mainline Linux and use whatever existing IoT userspace
> components.

It really needs to be overlays, not everyone using these boards is doing
the roll your own driver stuff - they also get used by people developing
more substantial add on modules for example, or people prototyping more
real systems who want normal software support.

> I'm going to prepare a new patch adding these ACPI IDs to the spidev
> early next week.

Please also ensure that we complain loudly when we use them like we do
for spidev.  We shouldn't be encouraging people to develop software like
this.

--8YDLdOu/DaKXZo9W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXd5QdAAoJECTWi3JdVIfQEigH/RatMFHrZkjlhvvghu3lvIjD
6tmiQGuN2yz9tPgC5A6e7BkjAHGixb8EEkqgBLxnmQZWU7OghJbt5SOGI42SiAWA
RrpXqpsM3vb3FnoTSoKusezqjMJdNuc2w1jgBsBzxpbZzXFdGSG/wDqlinCPdyxB
lgBD1QMolf75d978fX6D0mRzeWyHSgrJfZY4M1ZN9vzGm61KMT8VFqVlJN4pYP5I
of69pS38/QfrxeUJMm46LkwcFJHrzfy8QhzHMug9PjqiV97sylkLf6UCZkCzzELN
c5b62+bx1R51SrROP4z7jNwzQnUZ/sZ2kZK9bUyryCd45EkkQ0YZFHnMUBKO+Zw=
=JQAW
-----END PGP SIGNATURE-----

--8YDLdOu/DaKXZo9W--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
