From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Tue, 28 Jun 2016 16:51:07 +0100
Message-ID: <20160628155107.GP17217@sirena.org.uk>
References: <cover.1467053363.git.hramrach@gmail.com>
 <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach@gmail.com>
 <20160627190949.GB5111@kroah.com>
 <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw@mail.gmail.com>
 <20160627221259.GA10054@kroah.com>
 <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MWF3YmTHhoLNIVQC"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MWF3YmTHhoLNIVQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 28, 2016 at 02:40:41PM +0200, Michal Suchanek wrote:

> There is no hardware other than pin header. You are preparing a
> factory image for a devboard with a pin header that can be used for
> connecting SPI devices. Some devices have fine kernel drivers and for
> these you prepare fine overlays. Some devices have fine userspace
> drivers and you do NOT want kernel driver for them even if it is
> available later on. What compatible do you put in the factory image so
> that the user can just connect an external device and run a
> corresponding application to use it?

The answer is still the same here: if you've got a plug in module you
need to load an overlay for that plug in module (see Pantelis' work for
mechanisms to do that).  That overlay should describe the hardware in
the standard DT fashion.  If the current way to support a given bit of
hardware is with a userspace driver then you should add the compatible
string for that hardware to spidev or join up the dots to allow that to
be done at runtime and then do it at runtime.

Repeating yourself over and over again is not going to help here, it's
just going to make people more annoyed.  Please stop this.

> >> So it would have to be implemented on SPI. How? On PCI new_id is a PCI
> >> id. What is it on SPI? ACPI PnP id? DT compatible? How do you tell?

> > Those sound like sensible ideas.

> There is slight problem that SPI bus can have *both* ACPI PnP IDs and
> DT compatibles. so you cannot tell which one it is. Even if you put in
> all the infra to tell if the particular bus uses one or the other it

The formats of compatible strings and ACPI IDs are both well enough
defined and incompatible with each other, distinguishing them is not
hard.

> still does not solve the basic problem that SPI is generic
> communication bus and users want to just send and receive data on the
> bus.

If there is no hardware connected we can massively optimize this by just
not doing anything to the bus in software.

> > Identifiers are just a useful way of describing what the hardware is,
> > the fact that some of them can be read back from hardware isn't terribly
> > important here.

> Maybe the fact that some buses are useful for just sending random data
> that the kernel does not understand and has no business meddling with
> is important then.

This is not helpful.  None of the discussion here is about what is done
with devices once drivers are bound, it's all about how we bind drivers.

--MWF3YmTHhoLNIVQC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcpzqAAoJECTWi3JdVIfQKrMH/1AWGp3YD93mUdtNAUh6C3mU
uQqoYbQi5HNJ42MgIzzXIBjVQIR8ypp65kwcAb39InHnovqxz8A9u0fqVYR8gy7C
TKr7/Y38y4iJPObUpuU7yOe8a4yzhu39jxH7pFWlPQ3waUsH1SUJxXZTaETVCzoM
pAp7E8Zb3AK1R8LhQu4Y1y73VMCXGuejr8quL+tYSIv6i2PxKI1BFR9fJyqfZeoW
JwYRisaKmxeJZ72vy3ayvDCXsdkZ7E6/A5hVwKGetFXGsXObjHxx4CkSY7apR61/
47kTqjCdNGTCiTgYXpqW/MJZmIapRDR1k/6S7WJtQscxAmwKB4kl/wP8pUk6kyk=
=riuc
-----END PGP SIGNATURE-----

--MWF3YmTHhoLNIVQC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
