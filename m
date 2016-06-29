From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Wed, 29 Jun 2016 12:13:04 +0300
Message-ID: <20160629091304.GP1711@lahna.fi.intel.com>
References: <1467027248-6191-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160627122448.GU28202@sirena.org.uk>
 <20160628092234.GG1711@lahna.fi.intel.com>
 <20160628114742.GM17217@sirena.org.uk>
 <20160628143528.GK1711@lahna.fi.intel.com>
 <20160628150752.GO17217@sirena.org.uk>
 <20160628152338.GN1711@lahna.fi.intel.com>
 <20160628161822.GQ17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160628161822.GQ17217-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jun 28, 2016 at 05:18:22PM +0100, Mark Brown wrote:
> On Tue, Jun 28, 2016 at 06:23:38PM +0300, Mika Westerberg wrote:
> > On Tue, Jun 28, 2016 at 04:07:52PM +0100, Mark Brown wrote:
> 
> > > If that's the case then it's definitely broken - we either always warn
> > > or never warn, neither is good.
> 
> > For DT we warn if the device is used directly (by the node name) as
> > previously. For ACPI we never warn because it is not possible to use the
> > node name directly. We always require use of a proper compatible string.
> 
> > I don't see how that is broken.
> 
> So you're saying that it's not possible for ACPI to use anything
> *except* an explicitly listed compatible string to bind?  What we want
> to avoid is any ACPI tables that explicitly list spidev since that's a
> total abstraction failure.

That's exactly what I'm saying. We never match using the node name
(which is always 32-bit "string" like "SPI0"). For PRP0001 match to
succeeed you need to have "compatible" property.

The ASL code looks like:

        Device (SPID) {
                Name (_HID, "PRP0001")

                Name (_CRS, ResourceTempate () {
                        SpiSerialBus (1, PolarityLow, FourWireMode, 0x08,
                            ControllerInitiated, 0x007A1200, ClockPolarityLow,
                            ClockPhaseSecond, "\\_SB.SPI1",
                            0x00, ResourceConsumer)
                })

                Name (_DSD, Package () {
                    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                    Package () {
                        Package () {"compatible", "rohm,dh2228fv"},
                    }
                })
        }

Without the "compatible" property you get a warning from ACPI core:

  \_SB.SPI1.SPID requires 'compatible' property

and it will not match anything.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
