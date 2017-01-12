From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: x86: Add SPI slaves to PCIe SPI master?
Date: Thu, 12 Jan 2017 13:48:13 +0200
Message-ID: <CAHp75VePTOd9WhkOTxW6GwKE2X3VR39J-7Song-P6iKsi7V6Ww@mail.gmail.com>
References: <3363354.jZif7TNsT8@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3363354.jZif7TNsT8@ws-stein>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jan 11, 2017 at 5:08 PM, Alexander Stein
<alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org> wrote:
> Hi,
>
> I have a customer board using Baytrail E3805 CPU. I want to access a chip
> attached to SPI using spidev.

First of all, this is wrong approach. Do you have a driver for the
chip? Are going to develop one?
Elaborate, please.

> but for this the slave has to be attached.
> This is the corresponding lspci entry:
>> 00:1e.5 Serial bus controller [0c80]: Intel Corporation Atom Processor
> Z36xxx/Z37xxx Series LPIO1 SPI Controller (rev 11)
> PCIe vendor and product ID is 8086:0f0e

It's not what we are interested to see :-)

Basically you need
a) not ancient kernel (what's version of yours?);
b) check proper ACPI node for the PCIe device (something like _SB.PCI0.SPI1).

If there is no such node, just incorporate it using ACPI upgrade table
mechanism.

> I tried using the following entry in APCI DSDT as a subnode to the SPI device:
>> Device (TAMP)
>> {
>>     Name (_ADR, 1)
>>     Name (_CID, "SPT0001") // Dummy name for spidev
>>     Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
>>     {
>>         Name (UBUF, ResourceTemplate ()
>>         {
>>             SPISerialBus
>>             (
>>                 1,          //Slave select CS0 (_ADR)
>>                 PolarityLow,        //Polarity of CS0 output(_DPL)
>>                 FourWireMode,       //(_MOD)
>>                 8,          //8-bit frame(_LEN)
>>                 ControllerInitiated,    //(_SLV)
>>                 2000000,       //Speed Hz (_SPE)
>>                 ClockPolarityLow,  //(_POL)
>>                 ClockPhaseFirst,   //(_PHA)
>>                 "\\_SB.SPI1",          //Controller
>>             )
>>         })
>>         Return (UBUF)
>>     }
>>
>>     Method (_STA, 0, NotSerialized)  // _STA: Status
>>     {
>>         Return (0x0F)
>>     }
>> }
>
> Apparently this only works when the device is probed by ACPI but not when
> using PCIe (driver: pxa2xx_spi_pci). So I am wondering: How can I add a slave
> to this PCIe spi master.

Adding Mika to Cc list he might have some additional information to share.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
