From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: x86: Add SPI slaves to PCIe SPI master?
Date: Wed, 11 Jan 2017 16:08:41 +0100
Message-ID: <3363354.jZif7TNsT8@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

I have a customer board using Baytrail E3805 CPU. I want to access a chip 
attached to SPI using spidev. but for this the slave has to be attached.
This is the corresponding lspci entry:
> 00:1e.5 Serial bus controller [0c80]: Intel Corporation Atom Processor 
Z36xxx/Z37xxx Series LPIO1 SPI Controller (rev 11)
PCIe vendor and product ID is 8086:0f0e

I tried using the following entry in APCI DSDT as a subnode to the SPI device:
> Device (TAMP)
> {
>     Name (_ADR, 1)
>     Name (_CID, "SPT0001") // Dummy name for spidev
>     Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
>     {
>         Name (UBUF, ResourceTemplate ()
>         {
>             SPISerialBus
>             (
>                 1,          //Slave select CS0 (_ADR)
>                 PolarityLow,        //Polarity of CS0 output(_DPL)
>                 FourWireMode,       //(_MOD)
>                 8,          //8-bit frame(_LEN)
>                 ControllerInitiated,    //(_SLV)
>                 2000000,       //Speed Hz (_SPE)
>                 ClockPolarityLow,  //(_POL)
>                 ClockPhaseFirst,   //(_PHA)
>                 "\\_SB.SPI1",          //Controller
>             )
>         })
>         Return (UBUF)
>     }
>     
>     Method (_STA, 0, NotSerialized)  // _STA: Status
>     {
>         Return (0x0F)
>     }
> }

Apparently this only works when the device is probed by ACPI but not when 
using PCIe (driver: pxa2xx_spi_pci). So I am wondering: How can I add a slave 
to this PCIe spi master.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
