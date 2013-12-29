From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 4/6] [RFC] Documentation: dt: Add Renesas RSPI/QSPI bindings
Date: Mon, 30 Dec 2013 00:22:19 +0100
Message-ID: <2582506.8vb3LhHISh@avalon>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org> <2590710.91Xybr4TsD@avalon> <CAMuHMdXrPamASqFz8eCVxE0WKT=cdkrzxjDDT84m_AHT+1nmEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXrPamASqFz8eCVxE0WKT=cdkrzxjDDT84m_AHT+1nmEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

On Friday 27 December 2013 20:01:53 Geert Uytterhoeven wrote:
> On Fri, Dec 27, 2013 at 5:18 PM, Laurent Pinchart wrote:
> > On Tuesday 24 December 2013 12:56:48 Geert Uytterhoeven wrote:
> >> +++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
> >> @@ -0,0 +1,27 @@
> >> +Device tree configuration for Renesas RSPI/QSPI driver
> >> +
> >> +Required properties:
> >> +- compatible      : "renesas,rspi-<soctype>". "renesas,rspi-rz" as
> >> fallback,
> >> +                    or
> >> +                    "renesas,qspi-<soctype>", "renesas,qspi-rcar" as
> >> fallback.
> > 
> > I think you need to be a bit more verbose here and explain when to use
> > rspi and when to use qspi. I'm also wondering where we need the -rz and -
> > rcar
> 
> OK.
> 
> > suffixes for the generic compatible strings.
> 
> The rationale behind this is that RSPI DT would apply to RSPI on RZ/A1H.
> The spi-rspi driver also supports legacy SH7757, which may not move to
> DT anytime soon.
> For symmetry, I did the same thing for QSPI, which applies to QSPI
> on R-Car H2 and M2 (upon second look, it should be "renesas,qspi-rcar-gen2",
> as E1/M1/H1 have HSPI).
> 
> Does this makes sense? Or do you still prefer plain "renesas,rspi" and
> "renesas,qspi", and perhaps "renesas,rspi-sh" if we ever get DT there?

The compatible strings should define what the device is compatible with. They 
should start with the most specific compability and end with the less specific 
one. In this case we definitely want to list the SoC-specific compatible 
string first, even if we don't need it, as experience with Renesas SoC shows 
that subtle differences between different versions of the same IP core can be 
discovered later. If all RSPI cores are similar enough to be supported by a 
single driver configuration, then I believe "renesas,rspi" would be a proper 
second compatible string. If the RSPI cores in the SH and RZ chips are 
incompatible then we need two different strings. The same is true for QSPI.

A quick look at the driver shows that RSPI is supported without caring whether 
the SoC is an SH or ARM, so I believe "renesas,rspi" should do. The question 
in my opinion is whether we want to use

compatible = "renesas,rspi-r7s72100", "renesas,rspi";

or

compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz", "renesas,rspi";

> >> +- reg             : address start and address range size of device
> >> +- interrupts      : 3 interrupts for RSPI (SPEI, SPRI, SPTI),
> >> +                    1 interrupt for QSPI
> >> +- num-cs       : Number of chip selects
> >> +- #address-cells  : should be <1>
> >> +- #size-cells     : should be <0>
> > 
> > I would say "must" instead of "should".
> 
> OK.
> 
> >> +Example:
> >> +
> >> +     spi0: spi@e800c800 {
> >> +             compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
> >> +             reg = <0xe800c800 0x24>;
> >> +             interrupts = <0 238 IRQ_TYPE_LEVEL_HIGH>,
> >> +                          <0 239 IRQ_TYPE_LEVEL_HIGH>,
> >> +                          <0 240 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > You're missing the interrupt-parent property.
> 
> OK.
> 
> But we don't need it in the spi node in the actual .dts, as we already have
> "interrupt-parent = <&gic>;" in the enclosing node, right?

That's right.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
