From: Leif Liddy <leif.linux@gmail.com>
Subject: Re: ACPI SPI slave device
Date: Tue, 8 Mar 2016 15:40:14 +0100
Message-ID: <CAAbRKOu8UWrn5bhxjrHx5cykFWOChyxr_ZCWK=R4nYCc11cvsw@mail.gmail.com>
References: <20160303174806.GB11728@srcf.ucam.org>
	<20160303174535.GA11728@srcf.ucam.org>
	<20160303185553.GA24603@wunner.de>
	<20160303191246.GA14040@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com,
	linux-spi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160303191246.GA14040@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> We could extend drivers/acpi/property.c:acpi_init_properties() to
> check if dmi_match(DMI_BOARD_VENDOR, "Apple Inc."), and instead of
> calling _DSD, call _DSM with Apple's UUID and populate adev->data
> with that. Or add the properties to the existing data, if any.

Lukas, this a bit beyond my skill level at the moment. I'd like to
start with something with a bit easier, and then work my way up.

Here's how I gather things are supposed to work.

The references inside the _DSM method for SPIT device: {spiSclkPeriod,
spiWordSize, spiCSDelay....etc} are meant to be parsed out and used as
parameters to configure the SPI controller/protocol driver (or not
used at all).

**that's exactly what i2c-designware-platdrv.c does in configuring the
ss_hcnt, ssh_lcnt...etc parameters


SPI controllers are relatively simple devices and I'm just going to
assume that the default parameters used in spi-pxa2xx are sufficient
for now. **I can always manually adjust them later

My goal at the moment is just to be able to perform basic connectivity
testing with the slave device.
The first issue I ran into was that the IRQ assigned to the DMA
controller (dw_dmac) was wrong.

/proc/interrupts
20:    dw_dmac                            --by default, it's set to 20
21:     pxa2xx-spi.0

/proc/interrupts
21:     dw_dmac, pxa2xx-spi.0    --should be set to 21 and share IRQ
with spi controller


IRQ 21 is what is shown in the DSDT table for both the DMA and SPI
devices. I think because the DMA controller is called by its PCI ID
(dma/dw/pci.c)that's it's not checking ACPI for the IRQ value.


modprobe spi_pxa2xx_pci     --everything seems to come up fine

=2E...
xxx pxa2xx.c setup() tx_thres: 160 tx_hi_thres: 224 rx_thres: 64
xxx pxa2xx.c setup() chip->enable_dma is 1
xxx pxa2xx.c setup() bits_per_word: 8 dma_burst_size: 1 dma_threshold: =
1088
spi spi-APP000D:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
pxa2xx-spi pxa2xx-spi.0: registered child spi-APP000D:00
=2E...


I've modified spidev.c to bind to the APP000D slave device. However,
when I run spidev_test nothing gets received.

=2E/spidev_test -D /dev/spidev0.0

spi mode: 0x0
bits per word: 8
max speed: 500000 Hz (500 KHz)
RX | 00 00 00 00 00 00 00 00 00 00.......

**dmesg (prink statements) shows it running through the whole dma
transfer transfer process


I'm wondering what functions SIEN, SIST, and ISOL methods are meant to
perform on the SPIT device (in the DSDT table) --and how to use them.


Here's what I got so far:

=2E....................................................
static int spi_hid_probe(struct spi_device *spi)
{
        struct acpi_object_list input;
        union acpi_object param[1];
        acpi_status status;
        param[0].type =3D ACPI_TYPE_INTEGER;
        param[0].integer.value =3D 0x01;
        input.count =3D 1;
        input.pointer =3D param;

        status =3D acpi_evaluate_object(ACPI_HANDLE(&spi->dev), "SIEN",
&input, NULL);
        if (ACPI_FAILURE(status))
                printk("xxx mb81_spi_probe --ACPI_FAILURE\n");

        return 0;
}


static const struct acpi_device_id spi_hid_acpi_match[] =3D {
        { "APP000D", 0 },
        { },
};
=2E..
=2E..................................................

If I load & unload this test module --and then run spidev

=2E/spidev_test -D /dev/spidev0.0  -v
spi mode: 0x0
bits per word: 8
max speed: 500000 Hz (500 KHz)
TX | FF FF FF FF FF FF 40 00 00 00 00 95 FF FF FF FF FF FF FF FF FF FF
=46F FF FF FF FF FF FF FF F0 0D  | ......@....=EF=BF=BD................=
=2E.=EF=BF=BD.
RX | 20 D0 00 00 00 00 04 00 A0 80 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00  | .=EF=BF=BD......=EF=BF=BD=EF=BF=BD....=
=2E...............

It changed something....
It looks like SIEN is modifying the GPIO registers, but its function
isn't exactly clear.


Lukas, can you help me sort out what the purpose of these methods are
and how to use them?

-----------------------------------------------------------------------=
------------------------

Method (SIEN, 1, Serialized)
                    {
                        If ((Arg0 <=3D 0x01))
                        {
                            If ((Arg0 =3D=3D 0x01))
                            {
                                GP13 =3D 0x01
                                GD13 =3D 0x00
                            }
                            Else
                            {
                                GD13 =3D 0x01
                            }
                        }
                    }

                    Method (SIST, 0, Serialized)
                    {
                        Local0 =3D GD13 /* \GD13 */
                        If ((Local0 =3D=3D 0x01))
                        {
                            Return (GL13) /* \GL13 */
                        }
                        Else
                        {
                            Return (GP13) /* \GP13 */
                        }
                    }
                }

                Method (ISOL, 1, Serialized)
                {
                    If ((Arg0 <=3D 0x01))
                    {
                        If ((Arg0 =3D=3D 0x01))
                        {
                            GP87 =3D 0x01
                            GP88 =3D 0x00
                            GP89 =3D 0x00
                            GP90 =3D 0x00
                            GD87 =3D 0x00
                            GD88 =3D 0x00
                            GD89 =3D 0x01
                            GD90 =3D 0x00
                            GU87 =3D 0x01
                            GU88 =3D 0x01
                            GU89 =3D 0x01
                            GU90 =3D 0x01
                            Local0 =3D GP87 /* \GP87 */
                        }
                        Else
                        {
                            GU87 =3D 0x00
                            GU88 =3D 0x00
                            GU89 =3D 0x00
                            GU90 =3D 0x00
                            GP87 =3D 0x00
                            GP88 =3D 0x00
                            GP89 =3D 0x00
                            GP90 =3D 0x00
                            GD87 =3D 0x00
                            GD88 =3D 0x00
                            GD89 =3D 0x00
                            GD90 =3D 0x00
                            Local0 =3D GU87 /* \GU87 */
                        }

                        Return (0x00)
                    }

                    Return (0xFFFFFFFF)
                }
            }

-----------------------------------------------------------------------=
------------------------

Decoded DSDT table:
https://bugzilla.kernel.org/attachment.cgi?id=3D202141

On Thu, Mar 3, 2016 at 8:12 PM, Matthew Garrett <mjg59@srcf.ucam.org> w=
rote:
> On Thu, Mar 03, 2016 at 07:55:53PM +0100, Lukas Wunner wrote:
>
>> We could extend drivers/acpi/property.c:acpi_init_properties() to
>> check if dmi_match(DMI_BOARD_VENDOR, "Apple Inc."), and instead of
>> calling _DSD, call _DSM with Apple's UUID and populate adev->data
>> with that. Or add the properties to the existing data, if any.
>
> Just do it unconditionally, it's cheap.
>
>> E.g. in the case of this SPI slave we need to fill in five values
>> of struct spi_device and we would add a quirk for APP000D which
>> retrieves each value via acpi_dev_get_property() instead of
>> acpi_dev_get_resources().
>
> Mm. It'd be nice to avoid having to keep a list of Apple devices - so=
me
> sort of mapping function might be easier, returning the values from _=
CRS
> if they're present or from _DSM/_DSD otherwise?
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
