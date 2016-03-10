From: Leif Liddy <leif.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI SPI slave device
Date: Thu, 10 Mar 2016 19:12:36 +0100
Message-ID: <CAAbRKOtkSBfdjNXXrSGbDzebsP2SLGgNPALpefdgF+OWu+ASvw@mail.gmail.com>
References: <20160303174806.GB11728@srcf.ucam.org>
	<20160303174535.GA11728@srcf.ucam.org>
	<20160303185553.GA24603@wunner.de>
	<20160303191246.GA14040@srcf.ucam.org>
	<CAAbRKOu8UWrn5bhxjrHx5cykFWOChyxr_ZCWK=R4nYCc11cvsw@mail.gmail.com>
	<20160309123625.GA26143@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Horan <knasher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160309123625.GA26143-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> I'm wondering, if the keyboard and trackpad are working on the MBP12,1,
> why aren't they working on the MB8,1?

this issue has been brought up before:
http://www.spinics.net/lists/linux-acpi/msg61848.html

It sounds like the MBP12,1 models have a way to access the
keyboard/trackpad via USB and SPI

OSX identifies the keyboard/trackpad on the MB8,1 as

"Product" = "Apple Internal Keyboard / Trackpad"
"ProductID" = 0x272

https://bugzilla.kernel.org/attachment.cgi?id=201111


**that is same device id as the MBP12,1 keyboard/trackpad, which is
referenced in a few kernel device drivers as:
USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI    0x0272


OSX appears to be binding an HID driver to the slave device via an SPI
transport driver.

there's no SPI transport driver for linux (yet??)
https://www.kernel.org/doc/Documentation/hid/hid-transport.txt

In any case I'd still like to try and make some progress on this
--it's a good learning experience


DSDT shows the following (named gpio's???) being assigned to the SPI master

"gspi-pin-cs",
Buffer (0x08)
{
     0x57, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* W....... */
},

"gspi-pin-clk",
Buffer (0x08)
{
     0x58, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* X....... */
},

"gspi-pin-mosi",
Buffer (0x08)
{
     0x59, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* Y....... */
},

"gspi-pin-miso",
Buffer (0x08)
{
     0x5A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* Z....... */
}

I'm trying to sort out what these values represent and how to use them.
My guess is that they function as gpio's, although this is not the
standard format of passing this sort of information.


The config I'm using for the controller in spi-pxa2xx.c is

 {       /* LPSS_LPT_SSP */
        .offset = 0x800,
        .reg_general = 0x08,
        .reg_ssp = 0x0c,
        .reg_cs_ctrl = 0x18,
        .reg_capabilities = -1,
 }


**presumably it should be finding the parameters for controlling the
device from these memory locations.
**ACPI ID of controller INT33C1 matches this config
**In any case I'm going to spend the next couple of weeks
deconstructing this driver...


> Hm, according to DSDT the interrupt for APP000D should be 0x1E, i.e. 30.

I was referring to that fact that the SPI controller and the DMA
controller (and I2C1 and UART0) all share the same
interrupt. If the two controllers don't share the same IRQ, then no
communication will occur between the two controllers

I ran some basic DMA tests to highlight this:
https://bugzilla.kernel.org/attachment.cgi?id=207871

I don't think I need to worry about about the IRQ of the slave device
just yet, I don't *believe* that comes into play when
using spidev + DMA + spidev_test.

**I've modified the DSDT tables so that UBUF is returned..

[   39.509846] xxx spi.c acpi_spi_add_resource :if
(acpi_dev_resource_interrupt(ares, 0, &r))
[   39.509849] xxx spi.c acpi_spi_add_resource spi->irq = r.start --is
equal to 30
[   39.509851] xxx spi.c acpi_spi_add_resource --start
[   39.509853] xxx spi.c spi->irq = 30
[   39.509856] xxx resource.c acpi_dev_get_resources acpi_dev_name=APP000D:00
[   39.509859] xxx resource.c acpi_handle is ffff8802650be000 returns
c.count 0...
[   39.509864] xxx spi.c acpi_spi_add_device :spi->max_speed_hz is 8000000


> If you grep /System/Library/Extensions on OS X for these strings you'll
> find the SPI drivers. Disassemble those and you'll find these methods are
> called in the following functions:

Thanks for sharing that...really useful!!!

-Leif


On Wed, Mar 9, 2016 at 1:36 PM, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> Hi Leif,
>
> I went through my collection of MacBook acpidumps and noticed that the
> MacBookPro12,1 also uses SPI, the DSDT entries are identical (save for
> some changes in the ISOL method and an additional UIST method). That's
> the 13" 2015 MacBookPro model.
>
> John Horan and Henrik Rydberg added support for that model's keyboard
> and trackpad with:
> d58069265c9d ("Input: bcm5974 - add support for the 2015 Macbook Pro")
> a4a2c54560f2 ("HID: apple: Add support for the 2015 Macbook Pro")
> efbd34702fb1 ("Input: bcm5974 - prepare for a new trackpad generation")
>
> I'm wondering, if the keyboard and trackpad are working on the MBP12,1,
> why aren't they working on the MB8,1? Adding John and Henrik to cc: in
> the hope of clarifying this.
>
>
> On Tue, Mar 08, 2016 at 03:40:14PM +0100, Leif Liddy wrote:
>> > We could extend drivers/acpi/property.c:acpi_init_properties() to
>> > check if dmi_match(DMI_BOARD_VENDOR, "Apple Inc."), and instead of
>> > calling _DSD, call _DSM with Apple's UUID and populate adev->data
>> > with that. Or add the properties to the existing data, if any.
>>
>> Lukas, this a bit beyond my skill level at the moment. I'd like to
>> start with something with a bit easier, and then work my way up.
>>
>> Here's how I gather things are supposed to work.
>>
>> The references inside the _DSM method for SPIT device: {spiSclkPeriod,
>> spiWordSize, spiCSDelay....etc} are meant to be parsed out and used as
>> parameters to configure the SPI controller/protocol driver (or not
>> used at all).
>
> Yes. Call the _DSM method and you'll get back a "package". Basically
> that's a fancy ACPI term for a struct. You can then retrieve the values
> out of that package.
>
>
>> My goal at the moment is just to be able to perform basic connectivity
>> testing with the slave device.
>> The first issue I ran into was that the IRQ assigned to the DMA
>> controller (dw_dmac) was wrong.
>>
>> /proc/interrupts
>> 20:    dw_dmac                            --by default, it's set to 20
>> 21:     pxa2xx-spi.0
>>
>> /proc/interrupts
>> 21:     dw_dmac, pxa2xx-spi.0    --should be set to 21 and share IRQ
>> with spi controller
>
> Hm, according to DSDT the interrupt for APP000D should be 0x1E, i.e. 30.
>
> I notice that the interrupt is specified in the device's ResourceTemplate
> (_CRS.UBUF) but not in the package returned by the _DSM. If we need that
> value then we cannot solve this by just parsing the values returned by the
> _DSM. The only option we'd have is to retrieve that UBUF ResourceTemplate.
>
>
>> IRQ 21 is what is shown in the DSDT table for both the DMA and SPI
>> devices. I think because the DMA controller is called by its PCI ID
>> (dma/dw/pci.c)that's it's not checking ACPI for the IRQ value.
>>
>> modprobe spi_pxa2xx_pci     --everything seems to come up fine
>>
>> ....
>> xxx pxa2xx.c setup() tx_thres: 160 tx_hi_thres: 224 rx_thres: 64
>> xxx pxa2xx.c setup() chip->enable_dma is 1
>> xxx pxa2xx.c setup() bits_per_word: 8 dma_burst_size: 1 dma_threshold: 1088
>> spi spi-APP000D:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
>> pxa2xx-spi pxa2xx-spi.0: registered child spi-APP000D:00
>> ....
>>
>> I've modified spidev.c to bind to the APP000D slave device. However,
>> when I run spidev_test nothing gets received.
>>
>> ./spidev_test -D /dev/spidev0.0
>>
>> spi mode: 0x0
>> bits per word: 8
>> max speed: 500000 Hz (500 KHz)
>> RX | 00 00 00 00 00 00 00 00 00 00.......
>>
>> **dmesg (prink statements) shows it running through the whole dma
>> transfer transfer process
>>
>> I'm wondering what functions SIEN, SIST, and ISOL methods are meant to
>> perform on the SPIT device (in the DSDT table) --and how to use them.
>
> If you grep /System/Library/Extensions on OS X for these strings you'll
> find the SPI drivers. Disassemble those and you'll find these methods are
> called in the following functions:
>
> ISOL gets called in AppleIntelLpssGspi.kext from
>        AppleIntelLpssGspi::gpioConfig()
>        AppleIntelLpssGspi::initGspiGpio()
> SIEN gets called in AppleIntelLpssSpiController.kext from
>        AppleIntelLpssSpiController::_setSPIBusDeviceEnable()
> SIEN, SIST und UIST in the same kext from:
>        AppleIntelLpssSpiController::getSpiDevices()
>
> Apple often uses nonstandard ACPI methods like this for power management,
> i.e. to power a chip up and down and query its status. SIEN takes one
> argument which can be 1 or 0 and modifies GPIO pin 13. You'd need the
> schematics of the mainboard to know what this pin is connected to but
> this might be a power switch which powers the SPI controller up and down.
> So the "EN" in "SIEN" might stand for "enable", which matches with the
> function it's called from (_setSPIBusDeviceEnable). Likewise SIST returns
> the status of GPIO pin 13 so the "ST" might stand for "status".
>
> I don't know what ISOL does. "Isolation" maybe? This also modifies a few
> GPIO registers. And UIST ist only present in the MBP12,1 DSDT, it returns
> the status of GPIO pin 26.
>
> HTH,
>
> Lukas
>
>> Here's what I got so far:
>>
>> .....................................................
>> static int spi_hid_probe(struct spi_device *spi)
>> {
>>         struct acpi_object_list input;
>>         union acpi_object param[1];
>>         acpi_status status;
>>         param[0].type = ACPI_TYPE_INTEGER;
>>         param[0].integer.value = 0x01;
>>         input.count = 1;
>>         input.pointer = param;
>>
>>         status = acpi_evaluate_object(ACPI_HANDLE(&spi->dev), "SIEN",
>> &input, NULL);
>>         if (ACPI_FAILURE(status))
>>                 printk("xxx mb81_spi_probe --ACPI_FAILURE\n");
>>
>>         return 0;
>> }
>>
>>
>> static const struct acpi_device_id spi_hid_acpi_match[] = {
>>         { "APP000D", 0 },
>>         { },
>> };
>> ...
>> ...................................................
>>
>> If I load & unload this test module --and then run spidev
>>
>> ./spidev_test -D /dev/spidev0.0  -v
>> spi mode: 0x0
>> bits per word: 8
>> max speed: 500000 Hz (500 KHz)
>> TX | FF FF FF FF FF FF 40 00 00 00 00 95 FF FF FF FF FF FF FF FF FF FF
>> FF FF FF FF FF FF FF FF F0 0D  | ......@....???..................???.
>> RX | 20 D0 00 00 00 00 04 00 A0 80 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00  | .???......??????....................
>>
>> It changed something....
>> It looks like SIEN is modifying the GPIO registers, but its function
>> isn't exactly clear.
>>
>>
>> Lukas, can you help me sort out what the purpose of these methods are
>> and how to use them?
>>
>> -----------------------------------------------------------------------------------------------
>>
>> Method (SIEN, 1, Serialized)
>>                     {
>>                         If ((Arg0 <= 0x01))
>>                         {
>>                             If ((Arg0 == 0x01))
>>                             {
>>                                 GP13 = 0x01
>>                                 GD13 = 0x00
>>                             }
>>                             Else
>>                             {
>>                                 GD13 = 0x01
>>                             }
>>                         }
>>                     }
>>
>>                     Method (SIST, 0, Serialized)
>>                     {
>>                         Local0 = GD13 /* \GD13 */
>>                         If ((Local0 == 0x01))
>>                         {
>>                             Return (GL13) /* \GL13 */
>>                         }
>>                         Else
>>                         {
>>                             Return (GP13) /* \GP13 */
>>                         }
>>                     }
>>                 }
>>
>>                 Method (ISOL, 1, Serialized)
>>                 {
>>                     If ((Arg0 <= 0x01))
>>                     {
>>                         If ((Arg0 == 0x01))
>>                         {
>>                             GP87 = 0x01
>>                             GP88 = 0x00
>>                             GP89 = 0x00
>>                             GP90 = 0x00
>>                             GD87 = 0x00
>>                             GD88 = 0x00
>>                             GD89 = 0x01
>>                             GD90 = 0x00
>>                             GU87 = 0x01
>>                             GU88 = 0x01
>>                             GU89 = 0x01
>>                             GU90 = 0x01
>>                             Local0 = GP87 /* \GP87 */
>>                         }
>>                         Else
>>                         {
>>                             GU87 = 0x00
>>                             GU88 = 0x00
>>                             GU89 = 0x00
>>                             GU90 = 0x00
>>                             GP87 = 0x00
>>                             GP88 = 0x00
>>                             GP89 = 0x00
>>                             GP90 = 0x00
>>                             GD87 = 0x00
>>                             GD88 = 0x00
>>                             GD89 = 0x00
>>                             GD90 = 0x00
>>                             Local0 = GU87 /* \GU87 */
>>                         }
>>
>>                         Return (0x00)
>>                     }
>>
>>                     Return (0xFFFFFFFF)
>>                 }
>>             }
>>
>> -----------------------------------------------------------------------------------------------
>>
>> Decoded DSDT table:
>> https://bugzilla.kernel.org/attachment.cgi?id=202141
>>
>> On Thu, Mar 3, 2016 at 8:12 PM, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org> wrote:
>> > On Thu, Mar 03, 2016 at 07:55:53PM +0100, Lukas Wunner wrote:
>> >
>> >> We could extend drivers/acpi/property.c:acpi_init_properties() to
>> >> check if dmi_match(DMI_BOARD_VENDOR, "Apple Inc."), and instead of
>> >> calling _DSD, call _DSM with Apple's UUID and populate adev->data
>> >> with that. Or add the properties to the existing data, if any.
>> >
>> > Just do it unconditionally, it's cheap.
>> >
>> >> E.g. in the case of this SPI slave we need to fill in five values
>> >> of struct spi_device and we would add a quirk for APP000D which
>> >> retrieves each value via acpi_dev_get_property() instead of
>> >> acpi_dev_get_resources().
>> >
>> > Mm. It'd be nice to avoid having to keep a list of Apple devices - some
>> > sort of mapping function might be easier, returning the values from _CRS
>> > if they're present or from _DSM/_DSD otherwise?
>> >
>> > --
>> > Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
