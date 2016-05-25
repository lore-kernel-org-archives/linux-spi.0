From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Wed, 25 May 2016 17:06:33 +0100
Message-ID: <20160525160633.GC30956@leverpostej>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524174140.GE11605@leverpostej>
 <5745C3F8.4020909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5745C3F8.4020909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 25, 2016 at 08:25:44AM -0700, Frank Rowand wrote:
> On 5/24/2016 10:41 AM, Mark Rutland wrote:
> > On Tue, May 24, 2016 at 06:39:20PM +0200, Christer Weinigel wrote:
> >> +Normally SPI buses are assigned dynamic bus numbers starting at 32766
> >> +and counting downwards.  It is possible to assign the bus number
> >> +statically using devicetee aliases.  For example, on the MPC5200 the
> >> +"spi@f00" device above is connected to the "soc" bus.  To set its
> >> +bus_num to 1 add an aliases entry like this:
> > 
> > As Mark Brown pointed out, this is very Linux-specific (at least in the
> > wording of the above).
> > 
> > Generally, aliases are there to match _physical_ identifiers (e.g. to
> > match physical labels for UART0, UART1, and on).
> 
> Can you point to anything in the specification or any other place that
> states that aliases are for matching physical identifiers?
> 
> Can you point to anything in the specification or any other place that
> states that aliases are not to be used for anything else?

You have me there; I cannot find any wording to that effect, and I am
evidently going by my understanding alone.

IEEE 1275 simply states that there may be predefined aliases for a
machine, or that users can create and use them dynamically. ePAPR (and
the devicetree specification) only states that aliases exist, and that a
client program might use them (through some means which is never
described).

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
