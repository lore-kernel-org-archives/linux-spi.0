From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: Add spi bus dts
Date: Tue, 30 Jun 2015 12:43:16 +0800
Message-ID: <CAGS+omDOU9UwtNVPA5YCWXgWQKjeskX-3uK_vxmeAgLzb9sxXg@mail.gmail.com>
References: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com> <1435583070-9600-5-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435583070-9600-5-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Leilk,

On Mon, Jun 29, 2015 at 9:04 PM, Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> This patch adds MT8173 spi bus controllers into device tree.
>
> Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 512e4eb..923d2eb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -259,6 +259,15 @@
>                         status = "disabled";
>                 };
>
> +               spi: spi@1100a000 {

This should be between i2c2: i2c@11009000 and i2c3: i2c3@11010000.

Thanks,
-Dan

> +                       compatible = "mediatek,mt8173-spi";
> +                       reg = <0 0x1100a000 0 0x1000>;
> +                       interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&pericfg CLK_PERI_SPI0>;
> +                       clock-names = "main";
> +                       status = "disabled";
> +               };
> +
>                 mmsys: mmsys@14000000 {
>                         compatible = "mediatek,mt8173-mmsys", "syscon";
>                         reg = <0 0x14000000 0 0x1000>;
> --
> 1.8.1.1.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
