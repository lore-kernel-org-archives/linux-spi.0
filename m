From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 6/6] [RFC] arm: shmobile: genmai reference: Add RSPI nodes
Date: Sat, 28 Dec 2013 12:48:27 +0100
Message-ID: <1503028.o7PtQzEmGv@avalon>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org> <2198668.ESbmzZvna4@avalon> <CAMuHMdVH4PyhxR3JLLPX9a3fKaEgdpQpd2aa4YKL6DUD8+Pw2Q@mail.gmail.com>
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
In-Reply-To: <CAMuHMdVH4PyhxR3JLLPX9a3fKaEgdpQpd2aa4YKL6DUD8+Pw2Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

On Friday 27 December 2013 20:08:18 Geert Uytterhoeven wrote:
> On Fri, Dec 27, 2013 at 5:20 PM, Laurent Pinchart wrote:
> > On Tuesday 24 December 2013 12:56:50 Geert Uytterhoeven wrote:
> >> Add pinctrl and SPI devices for RSPI on Genmai.
> >> 
> >> On this board, only rspi4 is in use. It's bus contains a single device
> >> (a wm8978 audio codec), for which no bindings are defined yet.
> >> 
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> >> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> ---
> >> 
> >>  arch/arm/boot/dts/r7s72100-genmai-reference.dts |   18 ++++++++++++++++-
> >>  1 file changed, 17 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> >> b/arch/arm/boot/dts/r7s72100-genmai-reference.dts index
> >> 114510f8bf09..6d99630627e4 100644
> >> --- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> >> +++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> >> @@ -43,7 +43,7 @@
> >>  };
> >>  
> >>  &pfc {
> >> -     pinctrl-0 = <&scif2_pins &ethernet_pins>;
> >> +     pinctrl-0 = <&scif2_pins &ethernet_pins &rspi4_pins>;
> > 
> > You should add pinctrl-0 and pinctrl-names properties to the spi4 node
> > instead. Device nodes should reference their pinctrl configuration
> > directly, scif2 and ethernet are exceptions as DT bindings for those
> > devices are not in mainline yet.
> 
> I put it there because the actual driver doesn't use DT yet. Is that OK?

I had missed that. That's fine, but shouldn't you then delay patch 5/6 until 
the driver gets DT support ?

You've already sent a DT bindings proposal (thanks for that !), wouldn't it 
make sense to implement support in the driver before this patch ? We're pretty 
close to that from what I can see.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
