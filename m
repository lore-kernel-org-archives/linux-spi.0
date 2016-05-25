From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Wed, 25 May 2016 18:48:09 +0100
Message-ID: <20160525174809.GA8206@sirena.org.uk>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524174140.GE11605@leverpostej>
 <5744BC76.9090403@gmail.com>
 <20160525092034.GE1337@leverpostej>
 <5745C5A3.6060202@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aPIqI//Qhze8VsLV"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5745C5A3.6060202-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aPIqI//Qhze8VsLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 2016 at 08:32:51AM -0700, Frank Rowand wrote:
> On 5/25/2016 2:20 AM, Mark Rutland wrote:

> > Linux for legacy reasons, documenting it as a binding is not necessarily
> > in anyone's best interest. If we want to document it, we may want to
> > mark it as deprecated, with a pointer to better alternatives.

> Lack of documentation and bad documentation are a MAJOR problem for
> devicetree.

> Refusing to accept documentation of existing behavior makes no
> sense to me.

Sometimes the best thing to do is remove the behaviour, some of these
things are just bugs.  That's not quite the case here but it's in the
spectrum of things that happen so clearly just blindly documenting
everything people find happens to work is not great - if something isn't
being used because it wasn't discoverable sometimes we should be
thankful for that. =20

Adding documentation for every last implementation that happens to work
in a given situation through layers of indirection isn't going to help
with the usability issues DT has, one of the things that the
documentation does is tell both users and other OS vendors (and now I
guess also people writing ACPI machine descriptions) what they should be
doing when they implement or use the bindings.  This is especially true
if the documentation doesn't even cover the intended effects of the
implementation detail, that's just checkbox documentation.

One of the big problems we have with getting people to write high
quality bindings is getting them to understand that they're supposed to
be describing the hardware, not just dumping the current Linux
implementation into an external data structure.  If that's all we're
doing then device tree isn't buying us a huge amount, we're just putting
the same things in another format with worse tooling.  This is like the
issues we've got with all the historic bindings that just dumped raw
numeric constants in the DT - people see those and just write a binding
which dumps whatever internal constants Linux has into DTs.

Consider this case, the proposal is:

| +Normally SPI buses are assigned dynamic bus numbers starting at 32766
| +and counting downwards.  It is possible to assign the bus number
| +statically using devicetee aliases.  For example, on the MPC5200 the
=20
This has no practical meaning as a spec since it doesn't say what a bus
number either is or means so an implementation can happily ignore it
with no effect.  The details on how Linux currently does dynamic IDs are
unhelpful and possibly misleading if the bus gets reinstantiated but
that's somewhat secondary.

The actual effect Christer is intending to generate is that his systems
end up with stable names for spidev devices which are a very obvious
implementation detail of Linux on current systems - using raw spidev
directly in a binding rather than a compatible string for the attached
device is something that generates loud warnings since that's not
something that meets the DT goal of describing the hardware.  With the
compatible string it's fine since we have a description of the hardware
and the OS can bind whatever the most suitable support is to the device,
without we have literally no idea what we're supposed to be controlling.

Just documenting bus numbers is not going to say anything about how
Linux supports the particular devices, how spidev works and how
userspace names devices, nor is it going to help anyone who wants stable
naming over a class of boards with multiple sockets (eg, board A has two
SPI sockets on one SPI controller, board B has one controller per
socket) - the whole using one ramdisk over multiple boards use case that
Christer mentioned.

What would seem to be a lot more sensible here would be to define a
binding for whatever device is being described with some support for
providing a descriptive name which we can then bring out to userspace
for it to match on (and perhaps use for the device name so you get
spidev-socket1, spidev-gpschip or something which would be a lot more
useful for this type of application since it's easier to map onto the
physical system).  That directly addresses the need is a more robust and
general fashion.  I do wonder if such naming support should be at a more
general level, possibly even DT wide, since it seems like something that
will apply elsewhere.

If it's just some raw signals on an expansion connector then this seems
to be something that should be handled as part of the support for things
like BeagleBone capes, if no overlay is loaded perhaps that should
default to raw userspace access to devices.

--aPIqI//Qhze8VsLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXReVYAAoJECTWi3JdVIfQyR8H/jFQ56uJKUH8os40G4Txq1fA
JLe5kzgV5LXskQr34LZpHLmN3crXtScpN8SCYUipFSmFJv96OFrUaCFJPBNQYGsB
dVG9tX3ZwILnhBU/kIg620TN2RmgYSHfnZLNaIItXZI3Mxh1qwpC/kfWTyFoYApp
F0qVsdXVkts25roudehGAGNQ2ACrygd/gOd/8ZSpARtKyGeypuMuozLQPLhzUMJ3
dF0407njfRxDFHn7/kbpioADvLsKmV4O96q1t6DQjoDZ8lfYY5z/Pci0bkKZgMq9
Yj1ONqo69C6ttJxI4gMKIM7Esrgili4qpYDjzsmfnpyebiHhJ9eSkI8o+ftsZDU=
=sCjB
-----END PGP SIGNATURE-----

--aPIqI//Qhze8VsLV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
