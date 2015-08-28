From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Not really following Mark Brown's spidev patch
Date: Fri, 28 Aug 2015 09:53:27 +0200
Message-ID: <CAMuHMdWCOz4GO+anX1VsT3BnGGFEJbeXYF4NRzM0DHtAVWV0hA@mail.gmail.com>
References: <CAFZh4h8D=rGwjG7eRGPyC3QP6Cj-4kHe3N7MhMELQNWgv76VhQ@mail.gmail.com>
	<CAMuHMdW1qTzcqeyt=9Xt9X5xOKySzZfCnZHE1ozhm-=9P_5diw@mail.gmail.com>
	<CAFZh4h9-adeYvE-oeOvfqsRURn7g+=LKGjHWyJ+FkpmF_ujt+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFZh4h9-adeYvE-oeOvfqsRURn7g+=LKGjHWyJ+FkpmF_ujt+Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Brian,

On Thu, Aug 27, 2015 at 8:42 PM, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>         compatible = "spidev";
>>
>> The "compatible" value should match the real SPI slave that is connected.
>> After that, you can may add that value to drivers/spi/spidev.c if no other
>> driver exists.
>
> This is where I kind of get confused ... I thought it was pretty much
> a given that if you are using spidev it's because you DON'T have a
> slave device driver so you are using the generic API which is the
> whole point of spidev.  So it's OK for me to just make up a node

Yes, you want to use spidev because you don't have a driver.
Still, you have an actual named SPI slave connected to the SPI bus,
right?

> called "ti,my-spidev" in my .dts and place that also in the spidev ID
> array?  That appears to work after trying it but I'm rather upset that

I doubt "ti,my-spidev" is the real name of your SPI slave device?

> I have to modify code (spidev.c) to put this name in there when
> "spidev" had been OK for years.  This almost sounds like a

I think we do need a way to add compatible entries to spidev dynamically,
cfr. how PCI IDs can be added to an existing driver through sysfs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
