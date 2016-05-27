From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Fri, 27 May 2016 17:43:59 +0100
Message-ID: <20160527164359.GM16172@sirena.org.uk>
References: <20160525174932.GA10753@rob-hp-laptop>
 <5745E9B6.5090204@gmail.com>
 <20160525184442.GE8206@sirena.org.uk>
 <57464D0A.1030706@weinigel.se>
 <CAL_JsqJwQvPGtscheZjoJyhF1UPxDSqbS-QB9qm3M4HbpOicVA@mail.gmail.com>
 <574657BB.6070300@weinigel.se>
 <20160526100753.GB16172@sirena.org.uk>
 <5746D6CE.5020605@weinigel.se>
 <20160526184746.GF16172@sirena.org.uk>
 <574764D2.5060709@weinigel.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FhKpTYimqQF2+bfE"
Cc: Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Christer Weinigel <christer@weinigel.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <574764D2.5060709@weinigel.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--FhKpTYimqQF2+bfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 26, 2016 at 11:04:18PM +0200, Christer Weinigel wrote:

> My point is that I don't think it would be doable to get every
> devicetree file out there into the mainline kernel; it's not even
> desirable.  devicetree files for custom platforms are a lot like
> userspace applications, the devicetree implementation is an ABI, and
> devicetrees for a lot of different platforms are built for that ABI.

Right, but we're nowhere near at the point where it's a very firm ABI -
the overwhelming majority of the devices that ship aren't anywhere near
shipping mainline usefully and where people are there are generally at
least a representative subset of boards that are supported upstream and
some visible community.

> Using "the dts file is not in mainline" or "there is no user of that
> devicetree feature in mainline" as an argument for breaking existing
> dts files is in my opinion not a good argument.  That will be a change
> that is visible to userspace (because device names will change).

It's not just that one thing - there's also things like the fact that
instantiating these devices is going to be producing enormous warnings
in the kernel logs and just the general use cases I'm aware of for
spidev being very much out of tree custom systems with lots of other
assumptions ones and things like "I need to wiggle the pins on this EVB
for test".  The picture is very different to the installing a standard
distro on your desktop one that's most crticial here.  The systems that
are upstream are doing something completely different and setting
symbolic names which it might be useful to pay attention to.

Like I say I don't actually particularly want to remove the code, I just
don't want to tell people that it's a thing they should be doing or make
it more discoverable since it's a bad interface and is going to be a
problem long term for anyone who is trying to use it as an ABI.

> > Right, but it doesn't follow that aliases are what we should be=20
> > doing here - both Rob and myself have mentioned providing a way to=20
> > label the actual SPI devices themselves, this seems like a more=20
> > robust way of doing things.

> That would be good.  It would probably be clearer to have
> "i2c-sensors" than "i2c3".  But it won't solve all of the issues that
> were flagged as bad with aliases.  For example, someone mentioned that
> even if aliases worked with devicetree fragments there could be
> collisions in the numbering f aliases.  As long as user assigned names
> are used there are going to be mistakes and collisions are going to
> happen.  Some nut like me will come along and build lots of
> temperature sensors and have multiple buses to talk to them, and then
> you end up with half a dozen "i2c-sensors" busses :-)

Right, this is one of the reasons why this sort of in kernel stuff is
not a great solution and something like udev really is much more robust
- it can assign names based on the totality of information it has
including the full path to the device, record the choices it made and
remember devices that aren't currently in the system.  In the event of
collisions the kernel can try a bunch of things to attempt to provide a
useful default but ultimately it's limited.

> > Just numbering the buses provides a partial solution for some=20
> > systems with usability drawbacks (you need to know the number to=20
> > name mapping somehow), naming devices is both more direct and more=20
> > general.

> Except that being able to assign static bus numbers devicetree is
> something that works _now_ and at least for me it is good enough.

=2E..

> It would probably be better if some future devicetree extension would
> allow abitrary user-friendly naming of devices, but in the absence of
> that I'd take numbers every time.  If I'd have to wait for a perfect
> solution before doing something I'd never get anything done.  A dumb
> and ok solution is often "better" than a complex one.

A better solution is not rocket science, a better solution is reading a
more suitable string from the DT.  That's pretty trivial.  But people
mostly only seem interested in documenting and hence promoting the
existing poorly considered stuff.

--FhKpTYimqQF2+bfE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXSHlNAAoJECTWi3JdVIfQYOoH/ier+lSGH8QTET6y/2LUmmRe
cdTC1gQtHxy1dsHUKl+rf21CJHfc5DUCLHaGP9DOdvw3qe7X9sqPm/2INOZie3Ta
zVQ88N9lBeWd87kv38qpr8KI1Ty6HmuKLHEGCQQr+S/jWC3Sn5xqeGvaIdDmMU70
+uEjyKl5P8RYW8mFZV1crUu3qlqS4DJo0wEE7mFS1F8GkFbWdDD+dT6P3qZ1nltp
iaJubcI1lcFtp9Ar94N58r1v1Bd/IswBZS8TfqiSvlz8fKORGWqcaLyG7PpkBK3Q
wf6bV/eNpY6O64O7fVb+v7KfJ7M/RMd3/RB9rG1aJb9BmjcR+g7kNHdXJr+6/Ag=
=QnVB
-----END PGP SIGNATURE-----

--FhKpTYimqQF2+bfE--
