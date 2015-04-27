From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 27 Apr 2015 18:25:26 +0200
Message-ID: <CD7C1C3B-80B5-4627-94A4-2B83AAEC1DDB@martin.sperl.org>
References: <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com> <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org> <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com> <20150426125113.GF5627@lukather> <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com> <20150427093618.GL22845@sirena.org.uk> <553E099C.4070208@redhat.com> <20150427112539.GR22845@sirena.org.uk> <553E4447.6080202@martin.sperl.org> <20150427152705.GU22845@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hans de Goede <hdegoede@redhat.com>,
	Michal Suchanek <hramrach@gmail.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-sunxi <linux-sunxi@googlegroups.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-spi <linux-spi@vger.kernel.org>,
	linux-doc <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20150427152705.GU22845@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


> On 27.04.2015, at 17:27, Mark Brown <broonie@kernel.org> wrote:
>=20
>=20
> OK, so that is just a default overlay which is abusing the fact that =
we
> will bind to spidev without a DT compatible and when the binding is
> undocumented (which also applies to other devices and buses sadly).
>=20
> Unfortunately nobody ever mentioned this upstream and the feedback
> upstream that listing spidev in a DT is a bad idea has been ignored.

Maybe it should also have been documented as such in
Documentation/spi/spidev or in Documentation/devicetree/bindings/spi/

> The whole reason we're doing this in the first place is that we got s=
ick
> of telling people that using spidev in DTs like this was a bad idea.


The only reference I found in my history of the spi-list is this email:
> On 08.10.2014, at 22:05, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Wed, Oct 08, 2014 at 02:27:08PM -0500, tthayer@opensource.altera.c=
om wrote:
>=20
>> +			spidev@0 {
>> +				compatible =3D "spidev";
>> +				reg =3D <0>;	/* chip select */
>> +				spi-max-frequency =3D <100000000>;
>> +			};
>=20
> No, if you're putting spidev into the DT that's broken - describe the
> hardware, not the software you're using to control it.


And google found this patch from a little earlier:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/231050

So finding this piece of information on the =E2=80=9Cuse-policy=E2=80=9D=
 is quite hard
- google finds lots of links where it is described as working that way.

> It does sound like the people maintianing the u-boot fork for the Pi
> need to talk to both u-boot upstream (nothing here is specific to the
> Pi that I can see) and the kernel community a bit more.  I'd be a bit
> worried that they may be relying on other things that just happen to
> work without being intentional (and are therefore more vulnerable to
> issues) and it's a bit depressing to see things like this stuck in a
> fork where only a limited community can make use of them.
Actually this functionality is not in u-boot, but in the firmware
boot-loader itself, which can load the kernel (and the devicetree)
without u-boot, but which can also load u-boot as an additional
intermediate boot-stage.

>> The only thing that could possibly be better would be that
>> the user would define the "real" name of the device in the
>> device tree and spidev would bind to it if there is no driver
>> available (but that would require this "fallback" binding by
>> spidev in case of no driver).
>=20
> Yes, that is exactly the solution I'd suggest - change the UI to prov=
ide
> a DT compatible to be used for the new device.  That would also have =
the
> benefit of meaning that users who have connected some device that doe=
s
> have a driver that works with a simple binding wouldn't need to write=
 an
> overlay which seems like it should be useful.

Well then why did you just make the system complain loudly and bringing
problems to people instead of solving it in a usable manner that does n=
ot
require people to maintain an out of tree patch to work around that war=
ning?

We still have the one-line warning about using the depreciated=20
spi_master.transfer interface, but it is not such loud warning as this =
one.

I guess the time spent discussing this could have been better spent
implementing that solution instead.

All we need is a volunteer to get that implemented.

