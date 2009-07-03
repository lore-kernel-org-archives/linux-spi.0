From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [RESEND][PATCH] SPI: xilinx_spi: Added platform driver and support for DS570
Date: Thu, 2 Jul 2009 18:09:01 -0700
Message-ID: <200907021809.01990.david-b@pacbell.net>
References: <4A366622.2050606@mocean-labs.com> <200906231237.54278.david-b@pacbell.net> <4A41DF44.4060705@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard =?iso-8859-1?q?R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756732AbZGCBJP@vger.kernel.org>
In-Reply-To: <4A41DF44.4060705@mocean-labs.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 24 June 2009, Richard R=F6jfors wrote:
> On 09-06-23 21.37, David Brownell wrote:
> > On Monday 15 June 2009, Richard R=F6jfors wrote:
> >> This patch splits xilinx_spi into three parts, an OF and a platfor=
m
> >> driver and generic part.
> >>
> >> The generic part now also works on X86 and also supports the Xilin=
x
> >> SPI IP DS570
> >=20
> > Your Kconfig still mentions only DS464.
>=20
> Correct, will update.

Just checking -- you didn't send an update yet, right?


> >> +	  See the "OPB Serial Peripheral Interface (SPI) (v1.00e)"
> >> +	  Product Specification document (DS464) for hardware details.
> >> +
> >> +config SPI_XILINX_PLTFM
> >> +	tristate "Xilinx SPI controller platform device"
> >> +	depends on SPI_XILINX
> >=20
> > This should go first in the Kconfig, so that you don't goof up
> > the dependency display ... the OF bits depend on it.
>=20
> The OF parts only depend on SPI_XILINX, not SPI_XILINX_PLTFM. But
> I can change the order anyway(?)

Maybe I misread something.  Make sure the Kconfig doesn't goof.


> >> +	/* devices to add to the bus when the host is up */
> >> +	struct spi_board_info *devices;
> >> +	u8 num_devices;
> >=20
> > This is duplicating functionality in the SPI core code.
> > That's not really the way to fly.
>=20
> I have discussed the same problem in the I2C list.
>=20
> We have a PCIe device which is a MFD (multifunction device).
>=20
> Several MFD devices could be connected to a standard PC ->
> we don't know the bus numbers in advance, and there could be
> several PCIe devices connected. Which mean the we can not use
> spi_register_board_info.

You could, actually, given metadata about those devices.
That's one of the things ACPI does -- in a way that many
of us find ugly! -- and the "device tree" some PPCs use.


> We can not call spi_add_device from the MFD because when it's
> probed the drivers for the SPI bus might not be available.

And you can't call spi_register_board_info() there since
the init section is gone.

=20
> So the solution in the I2C case was to add this into the driver
> and if this tend to be a generic problem some generic solution might
> be implemented.
>=20
> So I would like to have the same thing in here.

What I've done in such cases is make sure the bus adapter
driver (in this case, for the spi_master) can issue some
callback to code which makes spi_add_device(), or similar,
calls.

But if your initialization doesn't have that sort of
clean structure, it's probably kind of awkward to add
it just now...  :(

- Dave
