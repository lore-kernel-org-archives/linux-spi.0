From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: x86: Add SPI slaves to PCIe SPI master?
Date: Thu, 12 Jan 2017 15:47:29 +0200
Message-ID: <20170112134729.GZ2330@lahna.fi.intel.com>
References: <3363354.jZif7TNsT8@ws-stein>
 <CAHp75VePTOd9WhkOTxW6GwKE2X3VR39J-7Song-P6iKsi7V6Ww@mail.gmail.com>
 <20170112120111.GY2330@lahna.fi.intel.com>
 <26043741.eW6UMG2Gj5@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <26043741.eW6UMG2Gj5@ws-stein>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jan 12, 2017 at 02:39:04PM +0100, Alexander Stein wrote:
> result: \_SB_.PCI0.D023
> 
> The node itself is just:
> > Device (D023)
> > {
> >     Name (_ADR, 0x001E0005)  // _ADR: Address
> > }
> 
> Well, I'm not experienced with ACPI tables at all, but adding a device like in 
> the 1st post I got my spi slave device, to my surprise I have to admit.
> 
> Thanks for that hint about the, kinda dummy, node for the PCIe device node. I 
> didn't expect adding a slave device there would result in having a linux 
> device too.

That node is needed because it provides _ADR that ACPI core uses to bind
the PCI device to the ACPI node. This further allows the SPI core ACPI
enumeration code to find your slave device under \_SB_.PCI0.D023.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
