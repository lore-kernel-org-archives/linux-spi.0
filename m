From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus number.
Date: Thu, 26 May 2016 10:21:00 +0200
Message-ID: <CAMuHMdXm4jQE4SO3LweVtQe2x9f7gF4J4b74KH6UyMTeK1=U6g@mail.gmail.com>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
	<20160524174140.GE11605@leverpostej>
	<20160525184421.GB10753@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160525184421.GB10753@rob-hp-laptop>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, May 25, 2016 at 8:44 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, May 24, 2016 at 06:41:41PM +0100, Mark Rutland wrote:
>> On Tue, May 24, 2016 at 06:39:20PM +0200, Christer Weinigel wrote:
>> > Document how to use devicetree aliases to assign a stable
>> > bus number to a spi bus.
>> >
>> > Signed-off-by: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
>> >
>> > ---
>> >
>> > Trivial documentation change.
>> >
>> > Not having used devicetree that much it was surprisingly hard to
>> > figure out how to assign a stable bus number to a spi bus.  Add a
>> > simple example that shows how to do that.
>> >
>> > Mark Cced as the SPI maintainer.  Or should trivial documentation
>> > fixes like this be addressed to someone else?
>> >
>> >   /Christer
>> >
>> >  Documentation/devicetree/bindings/spi/spi-bus.txt | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> > index 42d5954..c35c4c2 100644
>> > --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>> > +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> > @@ -94,3 +94,13 @@ SPI example for an MPC5200 SPI bus:
>> >                     reg = <1>;
>> >             };
>> >     };
>> > +
>> > +Normally SPI buses are assigned dynamic bus numbers starting at 32766
>> > +and counting downwards.  It is possible to assign the bus number
>> > +statically using devicetee aliases.  For example, on the MPC5200 the
>> > +"spi@f00" device above is connected to the "soc" bus.  To set its
>> > +bus_num to 1 add an aliases entry like this:
>>
>> As Mark Brown pointed out, this is very Linux-specific (at least in the
>> wording of the above).
>>
>> Generally, aliases are there to match _physical_ identifiers (e.g. to
>> match physical labels for UART0, UART1, and on).

Indeed.

> While there may be some correlation to physical identifiers, the reality
> is aliases are used for mapping to Linux numbering. Their primary use
> has been to avoid breaking existing userspace and kernel command lines
> when converting to DT. The reality is that matters on very few platforms
> and can be solved in other ways for new platforms. For serial port
> console, that means using stdout-path for example.

Fortunately the SPI aliases are optional, while for serial devices they
are mandatory in most (all?) drivers. But this is more a relic of the aging
serial subsystem, which still relies on allocating arrays of NR_MAX_PORTS at
driver registration time, and thus can't support uart_port.line counting down
from 32767 for dynamic numbers like SPI does.
(BTW, I'd really like to see that fixed ;-)

Aliases are also an obstacle for DT overlays:
  1. You can't update the aliases from an overlay (I did post a patch to
     implement that, but it's ugly and buggy, but I still use that as I need to
     load DT overlays for serial port testing),
  2. They're almost a guarantee for conflicts (does your overlay provide spi2,
     or does mine?).

So yes, try to stay away from aliases if you can.
There's nothing a udev rule can't solve, can it?

> For SPI, I think we should use "label" which reflects a name that is
> defined by the h/w design and is meaningful to the user. Then perhaps
> the device becomes "/dev/spi/by-name/<label>/spidev.0" or simply
> "/dev/spidev-<label>.0".

I guess using the node name is not an option (say "use standard node names")?

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
