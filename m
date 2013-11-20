From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] added API: spi_message_compile/optimize/hint/...
Date: Wed, 20 Nov 2013 19:42:44 +0100
Message-ID: <9DE09AF6-AD13-45DE-A36F-BD65E619C342@martin.sperl.org>
References: <0C7D5B1E-E561-4F52-BEA8-572EB0CA26A6@martin.sperl.org> <20131120112920.GX2674@sirena.org.uk> <05C64EF6-0F3B-4CBC-A462-45ED8F1564A7@martin.sperl.org> <20131120162449.GJ2674@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131120162449.GJ2674-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


>> As mentioned before I will take the opportunity to move the flags into
>> spi_transfer for optimization hints, because there is where the change 
>> really happens...
> 
> These are set by the caller?

yes - well similar to change_cs, delay_us,...

Patch looks like this:
@@ -585,6 +587,17 @@ struct spi_transfer {
        u16             delay_usecs;
        u32             speed_hz;
 
+#define SPI_OPTIMIZE_FIXED_TX_BUF              (1<<0)
+#define SPI_OPTIMIZE_FIXED_TX_DMA              ((1<<1)|(1<<0))
+#define SPI_OPTIMIZE_FIXED_RX_BUF              (1<<2)
+#define SPI_OPTIMIZE_FIXED_RX_DMA              ((1<<3)|(1<<2))
+#define SPI_OPTIMIZE_FIXED_LEN                 (1<<4)
+#define SPI_OPTIMIZE_FIXED_DELAY               (1<<5)
+#define SPI_OPTIMIZE_FIXED_SPEED               (1<<6)
+#define SPI_OPTIMIZE_FIXED_BITS                        (1<<7)
+#define SPI_OPTIMIZE_FIXED_ALL                 (-1)
+       u32             optimize_hints;
+
        struct list_head transfer_list;
 };


> 
> I'd be tempted to start with assuming everything is fixed and then add
> flags to mark things as variable rather than the other way around since
> that's the most conservative option and should permit the greatest level
> of optimisation.
> 

I thought the same at some point - it is just a matter of naming them.

One argument for explicitly naming what IS fixed, is the fact that
this way the default 0 maps to the current behavior, where you may not 
make any "assumptions".

This way you could also optimize transparently (without an explicit call),
but doing the optimization transparently means opening up a can of worms:
* when to release the memory that was "optimized"? Do we really want to 
  add garbage collection to the kernel?
* such transparent "optimization" would also occur during an interrupt
  and then it would need to allocate with GFP_ATOMIC
* also time spent in interrupt would be minimal - adding a thread for 
  that ads complexity

that is why the spi_message_optimize contains also a gfp_t flag to 
allocate from the correct pool...

It is in the end a matter of taste, so tell me which way you prefer the
solution:
*  0 = everything variable (so the zkalloced memory is set like this)
* -1 = everything variable 

>> I will provide the patches as soon as I have pulled your tree - only
>> problem is that I can not really compile it on this tree on my RPI...
> 
> You should at least be able to do build tests, it's OK if you can't do
> runtime tests - I can do validation myself, as can other people working
> with -next.

I right now started to build a kernel from your sources, but it compiles 
slowly on a raspberry-pi... (also the default .config is not complete and
a lot of things are left outside, like can support as module,... - I wish
someone would maintain a better .config I could use instead of starting 
with make bcm2835_defconfig)

> Yes, there's some tricky issues here...  let's have a think about it and
> try to do this incrementally.
we are on the same page on this!

First get the driver really working with the Foundation kernel and maybe
by that time we have the RPI-dmaengine also in the kernel...

Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
