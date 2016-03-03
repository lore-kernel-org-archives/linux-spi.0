From: Lukas Wunner <lukas@wunner.de>
Subject: Re: ACPI SPI slave device
Date: Thu, 3 Mar 2016 12:47:40 +0100
Message-ID: <20160303114740.GA24132@wunner.de>
References: <CAAbRKOu+s=OZw8vw2kfWs=JCQB1YcVg+51N5Yh_dCJOuytR2zA@mail.gmail.com>
 <20160229082114.GC1770@lahna.fi.intel.com>
 <CAAbRKOt=CDOqD1FESZkxv4fdYSDm6qoi4J0wYn=e5mvN-NLpCA@mail.gmail.com>
 <CAAbRKOscDyYaUqBTFVFZ2Fe81a_Kkx9oeNXHrttm3Qs_27fAzQ@mail.gmail.com>
 <20160301160726.GA23371@wunner.de>
 <CAAbRKOuESP+_65cmeCPNtO5HzN1+ct7bDv1stbE+a8u=KEwDKw@mail.gmail.com>
 <CAAbRKOsNxsu4CYq=EByck997RWRO3fQ-+LAAS5AbSL3XNRSh7A@mail.gmail.com>
 <20160302114250.GA23487@wunner.de>
 <CAAbRKOvP9yudKbzu_GquPUzhz2VQBtuKYmJbqLpt1jFcB6U1kQ@mail.gmail.com>
 <CAAbRKOs=ySAtqn71Mf5tyHvjqOGGRs5xsO6oU5YPYWgOSXqehA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	linux-spi@vger.kernel.org
To: Leif Liddy <leif.linux@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAbRKOs=ySAtqn71Mf5tyHvjqOGGRs5xsO6oU5YPYWgOSXqehA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

[Cc: += Matthew Garrett, linux-spi]

Hi Leif,

On Wed, Mar 02, 2016 at 03:37:27PM +0100, Leif Liddy wrote:
> On Wed, Mar 2, 2016 at 2:07 PM, Leif Liddy <leif.linux@gmail.com> wrote:
> > On Wed, Mar 2, 2016 at 12:42 PM, Lukas Wunner <lukas@wunner.de> wrote:
> >> On Wed, Mar 02, 2016 at 04:13:16AM +0100, Leif Liddy wrote:
> >>> I'll post more tomorrow, need to evaluate the changes I made --but I
> >>> think the change that did it was changing this:
> >>>
> >>> Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> >>> {
> >>>     If (!OSDW ())
> >>>     {
> >>>         Return (WBUF) /* \_SB_.PCI0.SPI1.WBUF */
> >>>     }
> >>>
> >>>     Return (ConcatenateResTemplate (RBUF, DBUF))
> >>> }
> >>>
> >>> to:
> >>>
> >>> Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> >>> {
> >>>       Return (ConcatenateResTemplate (RBUF, DBUF))
> >>> }
> >>
> >> If that is true then the fix is to change the OS we're reporting to ACPI:
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/osl.c#n141
> >>
> >> We had trouble with this before:
> >> https://mjg59.dreamwidth.org/29954.html
> >>
> >> I've just grabbed the acpidump you've posted here:
> >> https://bugzilla.kernel.org/attachment.cgi?id=200961&action=edit
> >>
> >> I'll take a look at it hopefully this afternoon to see what they've
> >> changed in the OSDW method.
> >>
> > You're right, it's not evaluating the OSDW method properly. I tracked
> > it down to this single change:
> >
> > change this:
> >
> >       If (!OSDW ())
> >       {
> >           Return (UBUF) /* \_SB_.PCI0.SPI1.SPIT._CRS.UBUF */
> >       }
> >      Return (ABUF) /* \_SB_.PCI0.SPI1.SPIT._CRS.ABUF */
> > }
> >
> > to:
> >
> >      Return (UBUF) /* \_SB_.PCI0.SPI1.SPIT._CRS.UBUF */
> >
> This issue is more easily resolved by just changing !OSDW to OSDW for
> that method. The default behavior it seems is for Linux to identify
> itself as OSX, but there are a few methods where we don't want to
> identify as being OSX. I'll try and come up with a list of methods of
> where we don't want to identify as being OSX.

I'm not aware that it's possible to choose the OS per method.

I've compared the \_SB.PCI0._INI method (which sets \OSYS) and the
OSDW method (which returns true iff \OSYS == 0x2710 (Darwin))
between your MB8,1 and my MBP9,1 and nothing relevant has changed.


However after looking at the DSDT I can explain what's going on:

The standard way of describing resource settings is to let _CRS
return them.

The OS X way of describing resource settings is to let a _DSM
return them. If you disassemble AppleACPIPlatform.kext and search
for the label gDSM_GET_PROP_UUID, you'll find a UUID that looks
like this: a0b5b7c6-1318-441c-b0c9-fe695eaf949b. The kernel
extension invokes the _DSM with this UUID for every ACPI device
and merges the package it returns into the device's entry in the
I/O registry. The SPI driver on OS X then retrieves the settings
from the I/O registry.

If you boot OS X and invoke "ioreg -l | grep spiSclkPeriod"
you should see the value stored in this device's _DSM (0x0000007d).

Now the problem is, in the DSDT of your machine, the _CRS method
for the SPIT (spi-topcase) device returns a proper ResourceTemplate
for non-Darwin OSes (UBUF) and an *empty* ResourceTemplate for Darwin
(named ABUF). Conversely the device's _DSM returns zero for non-Darwin
OSes and the I/O registry package for Darwin. (Excerpt of the DSDT
included below for others following this thread.)

Further down in the DSDT, the exact same snafu is present for the
Bluetooth resource settings (BCM2E7C, apple-uart-blth). Perhaps
on this particular laptop it's better to not masquerade as Darwin
at all? On the other hand e.g. in SSDT5 it's apparent that without
masquerading as Darwin, the USB controller's _PS0 and _PS3 methods
are no-ops, so it looks like it cannot enter low power modes.
Quirking SPI and Bluetooth is probably the lesser evil.

I think you want to add a quirk to spi.c:acpi_spi_add_device()
which checks if acpi_dev_get_resources() returned nothing and
the HID of the acpi_device is APP000D: Search the namespace below
the acpi_device's handle for _CRS.UBUF (using acpi_get_handle()).
If this exists, call acpi_walk_resource_buffer() on it (with the
acpi_spi_add_resource callback). You need to somehow convert the
acpi_handle to an acpi_buffer, maybe that just involves filling in
acpi_buffer->pointer = acpi_handle and somehow determining the
length of the resource settings from the handle. Someone more
intimately familiar with the layout of the namespace in memory
should be able to answer this. Hopefully this will already get
you started, if not just ask questions.

HTH,

Lukas

-- cut here --

            Scope (\_SB.PCI0.SPI1)
            {
                Device (SPIT)
                {
                    Name (_HID, EisaId ("APP000D"))  // _HID: Hardware ID
                    Name (_CID, "apple-spi-topcase")  // _CID: Compatible ID
...
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Name (UBUF, ResourceTemplate ()
                        {
                            SpiSerialBus (0x0000, PolarityLow, FourWireMode, 0x08,
                                ControllerInitiated, 0x007A1200, ClockPolarityLow,
                                ClockPhaseFirst, "\\_SB.PCI0.SPI1",
                                0x00, ResourceConsumer, ,
                                )
                            Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
                            {
                                0x0000001E,
                            }
                        })
                        Name (ABUF, ResourceTemplate ()
                        {
                        })
                        If (LNot (OSDW ()))
                        {
                            Return (UBUF) /* \_SB_.PCI0.SPI1.SPIT._CRS.UBUF */
                        }

                        Return (ABUF) /* \_SB_.PCI0.SPI1.SPIT._CRS.ABUF */
                    }
...
                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If (OSDW ())
                        {
                            If (LEqual (Arg0, ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
                            {
                                Store (Package (0x10)
                                    {
                                        "spiSclkPeriod", 
                                        Buffer (0x08)
                                        {
                                             0x7D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* }....... */
                                        }, 

                                        "spiWordSize", 
                                        Buffer (0x08)
                                        {
                                             0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                        }, 

                                        "spiBitOrder", 
                                        Buffer (0x08)
                                        {
                                             0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                        }, 

                                        "spiSPO", 
                                        Buffer (0x08)
                                        {
                                             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                        }, 

                                        "spiSPH", 
                                        Buffer (0x08)
                                        {
                                             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                        }, 

                                        "spiCSDelay", 
                                        Buffer (0x08)
                                        {
                                             0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                        }, 

                                        "resetA2RUsec", 
                                        Buffer (0x08)
                                        {
                                             0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                        }, 

                                        "resetRecUsec", 
                                        Buffer (0x08)
                                        {
                                             0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                        }
                                    }, Local0)
                                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                Return (Local0)
                            }
                        }

                        Return (0x00)
                    }
