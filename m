From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] spi: spidev: create spidev device for all spi
 slaves.
Date: Tue, 19 Jul 2016 18:19:59 +0100
Message-ID: <20160719171959.GD30372@sirena.org.uk>
References: <cover.1468880530.git.hramrach@gmail.com>
 <5bfcceff7b6132cf3447f97c24d1646043224164.1468880530.git.hramrach@gmail.com>
 <20160718225952.GW30372@sirena.org.uk>
 <CAOMqctQ7Uq7JEYZovYqzQHLpjgk8HoK8Q2Bei3gEzFboyUxNyg@mail.gmail.com>
 <20160719124409.GC30372@sirena.org.uk>
 <CAOMqctRTNRTKKLVMXgxzdJEq0giRp5f8ujAUf-gUty9fSjqGXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KzTpGdFWKkiGyjCs"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctRTNRTKKLVMXgxzdJEq0giRp5f8ujAUf-gUty9fSjqGXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KzTpGdFWKkiGyjCs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 19, 2016 at 05:32:24PM +0200, Michal Suchanek wrote:
> On 19 July 2016 at 14:44, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> >> -       status = register_chrdev(SPIDEV_MAJOR, "spi", &spidev_fops);
> >> +       status = register_chrdev(SPIDEV_MAJOR, "spidev", &spidev_fops);

> > also looks like a needless ABI change

> ABI change to what?

> The spidev ABI should be the IOCTLs on /dev/spidev*. These are preserved.

> What parts of the kernel or userspace should depend on spidev
> devices belonging to class spi?

It's a string that's exposed to userspace (via /proc/devices if nothing
else).

> > If userspace is managing to figure out how to control the device then
> > providing a description of the hardware is clearly within the bounds of
> > possibility and there is no need to fake anything.

> However. maintaining the hardware description in multiple places is
> redundant and error-prone. Since the userspace somehow managed to
> figure it out on legacy kernels without devicetree it does not need
> the information in devicetree. Users of such software will not want the
> hardware description in devicetree and if forced to provide it will stub it out.

Userspace is just as capable of looking at the DT as anything else, I'd
expect that where this is a viable way of deploying things people would
be writing udev/systemd magic to fire up userspace drivers automatically
when they see suitable hardware.  The only way this has ever worked in
the past has been with system specific hacks which lead to fragile,
non-portable userpaces that are hard to upgrade.  If we're trying to say
this is an interface that's there for all devices then we shouldn't be
defining it in a way that makes it difficult to automatically configure.

> Also world is not all devicetree so userspace applications should be free
> to consult devicetree information if present or use whatever other means
> at their disposal to determine what hardware they are dealing with.
> When portability is a concern consulting devicetree may be a secondary
> source at best.

ACPI has similar facilities (it's got a direct translation of DT in it
these days so most things with a DT binding also have an ACPI one for
free).

--KzTpGdFWKkiGyjCs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXjmE+AAoJECTWi3JdVIfQxyYH/12ye9vY+3zPheohK0h2YTMy
L3bY2QDvN+Un4ukRgv0dTCAsM409s4qa7SGa1u1ZST0kHWaFcZYnZKYbjOii1j/M
ZZYbBDwF2Kdaxq9oQ8U/P3ul7yoLaFFm4hhSKIG6jcV89AeKYy6YcwWNLqL+4Z2g
op789XuMJFfmV4XX8IcnmuETuUB//sa7kPDbv6dEaxiyhH6xD0aUpAMBO9UJ4pdR
NPdQUnnaU60jSK5z1V+5YAdt80dR27WOBKFAL6C/h9ik14polvl+cjBvv5gyDnXI
5qGDIIeVOIEuelLd0euyLtYuwFe5RX9r4PSBSEqy/PayJzmr7+cPnXnV31PojpE=
=3CPS
-----END PGP SIGNATURE-----

--KzTpGdFWKkiGyjCs--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
