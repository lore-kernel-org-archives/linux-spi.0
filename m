From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 30 Apr 2014 11:14:29 -0700
Message-ID: <20140430181429.GD3000@lukather>
References: <1398705774-12361-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140429183758.GH15125@sirena.org.uk>
 <24BF05CB-35FF-42E8-BE5C-A5E4E3D0C52A@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <24BF05CB-35FF-42E8-BE5C-A5E4E3D0C52A-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2014 at 11:31:49PM +0200, Martin Sperl wrote:
> On 29.04.2014, at 20:37, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> > On Mon, Apr 28, 2014 at 10:22:54AM -0700, Maxime Ripard wrote:
> >=20
> >> spidev device registration has always been a controversial subject sin=
ce the
> >> move to DT.
> >=20
> > Why can we not handle this by using sysfs to bind spidev to the device?
>=20
>=20
>=20
> I think the question is actually more generic than just "spidev" related.
>=20
> A solution should also help all those users of development boards like=20
> raspberry pi, beagle board,... where people want to add spi devices witho=
ut
> having to know too much about the fine details of the kernel configuration
> /kernel compiling/creating a new device tree or similar....=20
> They just want their device to work with the existing kernel=20
> with minimal effort!
>=20
> For just this purpose I got an out of tree module called spi-config that=
=20
> - as of now - allows to define the binding of spi devices (not solely=20
> focused on spidev) as per module argument while loading the driver.
>=20
> This could easily get extended to work also via sysfs.
>=20
> The problem here is mostly around the "passing" of driver specific platfo=
rm=20
> data, which this module currently handles in a sort of "binary blob" way,=
=20
> which is suboptimal (as it is very architecture specific),
> but at least it works...
>=20
> Some examples of what is there:
>=20
> Bind spidev to spi0.1 with a speed of 2MHz and SPI mode 3:
> modprobe spi-config bus=3D0:cs=3D1:modalias=3Dspidev:speed=3D2000000:mode=
=3D3
>=20
> Bind an mcp2515 CAN-bus controller to spi0.0 with 10MHz speed and=20
> IRQ triggered via GPIO25:
> modprobe spi-config bus=3D0:cs=3D0:modalias=3Dmcp2515:speed=3D10000000:gp=
ioirq=3D25:\
> mode=3D0:pd=3D20:pdu32-0=3D16000000:pdu32-4=3D0x2002
>=20
> The extra "pd...=3D" args are the ones describing platform data that is n=
eeded
> by the mcp251x driver to set up the device correctly.=20
> In the above example we define:
> * pd=3D20: the platform data size is 20 bytes (zero filled)
> * pdu32-0: a u32 at offset 0 with a value of 16MHz Quarz speed
> * pdu32-4: a u32 at offset 4 the interrupt flags used by the driver
>            (=3DIRQF_TRIGGER_FALLING|IRQF_ONESHOT)
>=20
> The above mcp2515 device now configured via sysfs could look like this:
> echo "cs=3D0:modalias=3Dmcp2515:speed=3D10000000:gpioirq=3D25:mode=3D0:\
> pd=3D20:pdu32-0=3D16000000:pdu32-4=3D0x2002" > /sys/class/spi_master/spi0=
/register
>=20
> Unregistering the device:
> echo "cs=3D0" > /sys/class/spi_master/spi0/unregister
>=20
> As said: the trickiest part is "platform data", all the "spi-parameters"
> are well-defined and are easily parseable.
>=20
> Options that come to my mind to increase "readability" are:
> * "const char *extra_parameters"=20
>   in spi_device containing all "unhandled" parameters left for the driver
>   to parse during probing.
> * "int (*config)(struct spi_device *,const char *key,const char *value)"
>   in spi_driver that sets the corresponding parameters
>   (creating platform data if it is not already set/allocated)=20
>   and which is called prior to calling spi_driver->probe(spi)
>=20
> So with those "readability" options the sysfs interface could=20
> look like this:
> echo "cs=3D0:modalias=3Dmcp2515:speed=3D10000000:gpioirq=3D25:mode=3D0:\
> can_oscillator_hz=3D16000000:interrupt_flags=3D0x2002" \
> > /sys/class/spi_master/spi0/register
>=20
> When using the second option the framework could fall back to the
> voodoo-"pd...=3D" approach that I have show above to avoid having to touc=
h=20
> all spi drivers immediately to make use of this interface.
>=20
> The biggest pitfall I see is that if a device driver expects platform
> data but none is provided, then loading the driver could crash the kernel.
> But that is something that probably should get fixed in the driver=20
> itself and not in the framework.
>=20
> A totally different approach could be the use of device-tree overlays,=20
> which is also not included in the kernel, but would allow for similar
> config schemes.
> But that would leave systems not using device tree without this option.
>=20
> So it seems as if we need to find an approach that is acceptable...

I'd really be in favor of using the DT overlays for this. All this is
nice, but very fragile. You can't really handle any weird
configurations that you might encounter, like weird interrupt
controllers that might be requiring more informations, or you don't
set any interrupt parents, and this parameter list will basically be
an ever-growing list of parameters to deal with all kind of crazy
corner-cases, and I'm not sure it's something we want.

You listed only ARM boards, that are not supposed to be non-DT. RPi is
using DT fine, just like the beaglebones. I don't really see why we
should care about !DT cases.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTYT2FAAoJEBx+YmzsjxAgpbYP/0kbXp+bca3GRFLtDd01T2h6
2J1M0/6JsLPLTaaXBjocsenXifw5KRGxNV+OxAibBMn8fqxLwYmFhyf+OXtaEwBA
o33ZJAk36KyTWamH/Zwi/dI3vRld1sH09kYCGtXn/OG91h/uE8xPm6hQ7Y6JqVKf
ghAdr4EzDi2TfuHqZbnybgwYhaB8Ry21z0OEmhqe4JC8HqweF9TkkZJf1J7ihCze
Iu/JXRR9TOAoxiLYzHGIIFt2LKwxzmp4e35CuRyf52BYwR24n32PdkKpLwD19X8V
pXNAw/WVvTay0kIVxoWw420qrR6xQwtVaQWWXkbz+gpiEhi1eAkGu0vj/vxFsInp
BQOErzOCcWVAp+e1oK0pc0CiJXb2zcSVQ4EaGX1NG+g3RLh/ELlbI0UegqLushGI
4UfJmAd6639vuF1gOMWLuwTymcyMBJ0/BZzCdT5bYqy9Mj3nNPNwpLSbhSngDvm3
Exqs5+D1vgHIg0a0ij22vFhKU/IAZZut8VxFViayuKyhtmo3gwDfv3+yPXNOaKLr
AqGuVjNQlTTSs+UyjWShSzakn6+/DrWjvdWvWqR7QWWX3UsXOFUD6yURn3MoJWuJ
Lns3zUQiH2rFGjG6A7jpeLw0+sNeubi752NTO1e+7LI646E7EuLdeBCrajk31HjU
pPGk8H99RL7l4g6n7kuD
=RHJa
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
