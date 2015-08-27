From: Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Not really following Mark Brown's spidev patch
Date: Thu, 27 Aug 2015 14:42:01 -0400
Message-ID: <CAFZh4h9-adeYvE-oeOvfqsRURn7g+=LKGjHWyJ+FkpmF_ujt+Q@mail.gmail.com>
References: <CAFZh4h8D=rGwjG7eRGPyC3QP6Cj-4kHe3N7MhMELQNWgv76VhQ@mail.gmail.com>
	<CAMuHMdW1qTzcqeyt=9Xt9X5xOKySzZfCnZHE1ozhm-=9P_5diw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdW1qTzcqeyt=9Xt9X5xOKySzZfCnZHE1ozhm-=9P_5diw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mr. Geert board man!  Good to hear from you.  Do you have any new
cool projects in the works?

On Thu, Aug 27, 2015 at 7:24 AM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> Hi Brian,
>
> On Tue, Aug 25, 2015 at 11:53 PM, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> &mcspi1 {
>>     pinctrl-names = "default";
>>     pinctrl-0 = <&mcspi1_pins>;
>>
>>     spidev@0
>
> Missing opening curly brace

You got me, I coppied from an email and not actual code (I was away
from the machine that had the real code on it at the time I sent
this).

>
>>         compatible = "spidev";
>
> The "compatible" value should match the real SPI slave that is connected.
> After that, you can may add that value to drivers/spi/spidev.c if no other
> driver exists.

This is where I kind of get confused ... I thought it was pretty much
a given that if you are using spidev it's because you DON'T have a
slave device driver so you are using the generic API which is the
whole point of spidev.  So it's OK for me to just make up a node
called "ti,my-spidev" in my .dts and place that also in the spidev ID
array?  That appears to work after trying it but I'm rather upset that
I have to modify code (spidev.c) to put this name in there when
"spidev" had been OK for years.  This almost sounds like a
philosophical or holy war debate.  I guess it's just me but I thought
the point of device trees is to have one kernel image for different
flavors of hardware but now I have to modify spidev.c any time I have
variant hardware?  OK, off soap box now ;)

>
>>         spi-max-frequency = <100000>;
>>         reg = <0>;
>>         #address-cells = <1>;
>>         #size-cells = <1>;
>
> Why do you need these two properties?

Because it looked cool!  Being serious now, I found some working
examples and just copied what they did.   It looks to me like this can
be reduced or normalized quite a bit but at the time I was just trying
to get something to work and get that hideous error to go away and
wasn't quite understanding what Mark was saying about the ID or 'why'
it was necessary.  We made up an ID and put it in the spidev ID array
and that gets rid of the warning but I don't see any good examples
that would allow me to know what my &mcspi1 node should look like (in
light of this patch I'm talking about) given what the old board file
entry looked like (the board file snipit I provided).  In Linux 4.2, I
searched the .dts files looking for examples and I see several
existing .dts files that look like what I was trying to do ...
imx28-tx28.dts, spear1310-evb.dts, tegra30-apalis-eval.dts,
tegra30-colibri-eval-v3.dts.

The very first example I found was
http://elinux.org/BeagleBone_Black_Enable_SPIDEV but that kind of
threw me because it uses compatible = "linux,spidev" but yet when I
searched the kernel code I could not find a binding for "linux,spidev"
so I got pretty confused on how to go about even getting spidev to
work like I used to have it working in 2.6.37.

Regards,

Brian

>
>>     };
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
