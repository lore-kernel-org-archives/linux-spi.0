From: lei liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 5/5] arm64: dts: spi bus dts support multiple devices
Date: Mon, 26 Oct 2015 13:39:48 +0800
Message-ID: <1445837988.24921.1.camel@mhfsdcap03>
References: <1444793015-30359-1-git-send-email-leilk.liu@mediatek.com>
	 <1444793015-30359-6-git-send-email-leilk.liu@mediatek.com>
	 <20151014055809.GN7858@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151014055809.GN7858-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Sascha,

On Wed, 2015-10-14 at 07:58 +0200, Sascha Hauer wrote:
> On Wed, Oct 14, 2015 at 11:23:35AM +0800, Leilk Liu wrote:
> > This patch support multiple devices for MT8173.
> 
> The subject of this patch and also the above sentence should contain the
> board name this patch is changing so that the reader knows this is about
> a single board, and not arm64 in general.
> 
OK, I'll fix it.

> Sascha
> 
> > 
> > Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > index 04b38ed..1c8c407 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > @@ -194,7 +194,7 @@
> >  			pinmux = <MT8173_PIN_69_SPI_CK__FUNC_SPI_CK_0_>,
> >  				<MT8173_PIN_70_SPI_MI__FUNC_SPI_MI_0_>,
> >  				<MT8173_PIN_71_SPI_MO__FUNC_SPI_MO_0_>,
> > -				<MT8173_PIN_72_SPI_CS__FUNC_SPI_CS_0_>;
> > +				<MT8173_PIN_72_SPI_CS__FUNC_GPIO72>;
> >  		};
> >  	};
> >  };
> > @@ -399,6 +399,7 @@
> >  &spi {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&spi_pins_a>;
> > +	cs-gpios = <&pio 72 0>;
> >  	mediatek,pad-select = <0>;
> >  	status = "okay";
> >  };
> > -- 
> > 1.8.1.1.dirty
> > 
> > 
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
