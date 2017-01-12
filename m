From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: Re: x86: Add SPI slaves to PCIe SPI master?
Date: Thu, 12 Jan 2017 14:39:04 +0100
Message-ID: <26043741.eW6UMG2Gj5@ws-stein>
References: <3363354.jZif7TNsT8@ws-stein> <CAHp75VePTOd9WhkOTxW6GwKE2X3VR39J-7Song-P6iKsi7V6Ww@mail.gmail.com> <20170112120111.GY2330@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170112120111.GY2330-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thursday 12 January 2017 14:01:11, Mika Westerberg wrote:
> On Thu, Jan 12, 2017 at 01:48:13PM +0200, Andy Shevchenko wrote:
> > On Wed, Jan 11, 2017 at 5:08 PM, Alexander Stein
> > 
> > <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org> wrote:
> > > Hi,
> > > 
> > > I have a customer board using Baytrail E3805 CPU. I want to access a
> > > chip
> > > attached to SPI using spidev.
> > 
> > First of all, this is wrong approach. Do you have a driver for the
> > chip? Are going to develop one?
> > Elaborate, please.

There is no driver and I won't do any either. Can't say much more about that, 
sorry.

> > > but for this the slave has to be attached.
> > > 
> > > This is the corresponding lspci entry:
> > >> 00:1e.5 Serial bus controller [0c80]: Intel Corporation Atom Processor
> > > 
> > > Z36xxx/Z37xxx Series LPIO1 SPI Controller (rev 11)
> > > PCIe vendor and product ID is 8086:0f0e
> > 
> > It's not what we are interested to see :-)
> > 
> > Basically you need
> > a) not ancient kernel (what's version of yours?);

This is a up-to-date archlinux, so I'm running 4.8.13-1-ARCH kernel.

> > b) check proper ACPI node for the PCIe device (something like
> > _SB.PCI0.SPI1).
> You can find the node by running following command
> 
>  # cat /sys/bus/pci/devices/0000:00:1e.5/firmware_node/path

result: \_SB_.PCI0.D023

The node itself is just:
> Device (D023)
> {
>     Name (_ADR, 0x001E0005)  // _ADR: Address
> }

Well, I'm not experienced with ACPI tables at all, but adding a device like in 
the 1st post I got my spi slave device, to my surprise I have to admit.

Thanks for that hint about the, kinda dummy, node for the PCIe device node. I 
didn't expect adding a slave device there would result in having a linux 
device too.

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
