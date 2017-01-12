From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: x86: Add SPI slaves to PCIe SPI master?
Date: Thu, 12 Jan 2017 14:01:11 +0200
Message-ID: <20170112120111.GY2330@lahna.fi.intel.com>
References: <3363354.jZif7TNsT8@ws-stein>
 <CAHp75VePTOd9WhkOTxW6GwKE2X3VR39J-7Song-P6iKsi7V6Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VePTOd9WhkOTxW6GwKE2X3VR39J-7Song-P6iKsi7V6Ww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jan 12, 2017 at 01:48:13PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 11, 2017 at 5:08 PM, Alexander Stein
> <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org> wrote:
> > Hi,
> >
> > I have a customer board using Baytrail E3805 CPU. I want to access a chip
> > attached to SPI using spidev.
> 
> First of all, this is wrong approach. Do you have a driver for the
> chip? Are going to develop one?
> Elaborate, please.
> 
> > but for this the slave has to be attached.
> > This is the corresponding lspci entry:
> >> 00:1e.5 Serial bus controller [0c80]: Intel Corporation Atom Processor
> > Z36xxx/Z37xxx Series LPIO1 SPI Controller (rev 11)
> > PCIe vendor and product ID is 8086:0f0e
> 
> It's not what we are interested to see :-)
> 
> Basically you need
> a) not ancient kernel (what's version of yours?);
> b) check proper ACPI node for the PCIe device (something like _SB.PCI0.SPI1).

You can find the node by running following command

 # cat /sys/bus/pci/devices/0000:00:1e.5/firmware_node/path
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
