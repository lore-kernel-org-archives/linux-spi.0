From: Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v2 06/11] mtd: spi-nor: add support for DTR protocol
Date: Fri, 28 Feb 2020 14:18:14 +0100
Message-ID: <20200228141814.633c7195@collabora.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-7-p.yadav@ti.com>
        <20200227175841.51435e3f@collabora.com>
        <20200228093658.zc3uifqg4zruokq3@ti.com>
        <20200228115355.5033798f@collabora.com>
        <20200228120750.hstohetdnqja2g2p@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
To: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200228120750.hstohetdnqja2g2p-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 28 Feb 2020 17:37:50 +0530
Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org> wrote:

 
> > Isn't there an EXIT sequence that allows NORs to return to a single 
> > SPI state?  
> 
> Yes there is, but it comes with a lot of strings attached. There is a 
> hardware reset pin on some flashes that puts the flash in Power-on-Reset 
> (POR) mode. But that pin is not mandatory. It also might not be 
> connected on a given board.
> 
> The other option is a "Soft Reset" (also optional), which puts the flash 
> in POR mode after it is given the soft reset command. But to send the 
> command you need to know the mode the device is in. On top of that, the 
> Soft Reset opcode differs between flashes. According to the xSPI spec, 
> some flashes can have the opcode as 0xF0 and some others can have it as 
> a two command sequence of 0x66 and 0x99.
> 
> And the cherry on top is the fact that these reset operations return to 
> a state based on the value of the non-volatile bits. So, if the 
> non-volatile configuration is 8D-8D-8D mode, then all these resets 
> achieve nothing.

Looks like flash vendors don't learn from their mistakes, they keep
adding more features without really thinking about backward
compatibility :-(.

> >   
> > > 
> > >     So, the only solution I can now think of is having the flash name in 
> > >     its compatible string in the device tree. This way we can skip all 
> > >     the Read ID ugliness and can have flash-specific hooks to make it 
> > >     easier to detect the mode it is in (though I wonder if it is even 
> > >     possible to detect the mode in a flash that doesn't have SFDP in 
> > >     8D-8D-8D).  
> > 
> > Hm, I'd really like to avoid that if possible.  
> 
> Unfortunately, I don't really see a better alternative. Just so I 
> understand this better, why do you think it is something worth avoiding?

There are 2 main reasons:

1/ board manufacturers usually source their flashes from different
vendors so they're not tied to one of them. That means you can't really
make the compatible too specific or you'd have to deal with DT variants
(one variant per-flash).

2/ I feel like once we start accepting specific compats, people will
try to abuse it and decide that they need one for their flash too,
before even trying to see if there's not a different way to detect the
flash.
