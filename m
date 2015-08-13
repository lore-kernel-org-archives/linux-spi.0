From: lei liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 3/3] arm64: dts: Add spi bus dts
Date: Thu, 13 Aug 2015 11:35:16 +0800
Message-ID: <1439436916.21454.15.camel@mhfsdcap03>
References: <1438931991-17044-1-git-send-email-leilk.liu@mediatek.com>
	 <1438931991-17044-4-git-send-email-leilk.liu@mediatek.com>
	 <CAGS+omA0dabyGkCB2JYORn1CjXvgMs_3x7nqSOOJKMg4HRhCSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omA0dabyGkCB2JYORn1CjXvgMs_3x7nqSOOJKMg4HRhCSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> > +               spi: spi@1100a000 {
> > +                       compatible = "mediatek,mt8173-spi";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <0 0x1100a000 0 0x1000>;
> > +                       interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&topckgen CLK_TOP_SPI_SEL>, <&topckgen CLK_TOP_SYSPLL3_D2>;
> > +                       clock-names = "spi-clk", "parent-clk";
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&spi_pins_a>;
> > +                       mediatek,pad-select = <0>;
> 
> The pinctl and pad-select fields are board specific.
> Please move to mt8173-evb.dtsi, along with status = "okay";
> 

OK, I will fix it.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
