From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v4 1/3] dt-binding: spi: Mediatek: Document devicetree
 bindings for spi bus
Date: Thu, 30 Jul 2015 21:27:33 +0200
Message-ID: <CAOiHx=k_0vdE=_gYO7v+-dSNJ+OsxHAjoPNs0esRuOYo6gUcmA@mail.gmail.com>
References: <1438167874-1305-1-git-send-email-leilk.liu@mediatek.com> <1438167874-1305-2-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438167874-1305-2-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Wed, Jul 29, 2015 at 1:04 PM, Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/spi-mt65xx.txt         | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> new file mode 100644
> index 0000000..f8005d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> @@ -0,0 +1,38 @@
> +MTK SPI device

You are calling it "MediaTek SPI controller" in the Kconfig entry, so
you should call it that here as well.

> +
> +Required properties:
> +- compatible: should be one of the following.
> +    - mediatek,mt8173-spi: for mt8173 platforms
> +    - mediatek,mt8135-spi: for mt8135 platforms
> +    - mediatek,mt6589-spi: for mt6589 platforms
> +
> +- #address-cells: should be 1.
> +
> +- #size-cells: should be 0.
> +
> +- reg: Address and length of the register set for the device
> +
> +- interrupts: Should contain spi interrupt
> +
> +- clocks: phandles to input clocks.
> +
> +- clock-names: tuple listing input clock names.
> +       Required elements: "main"
> +
> +- pad-select: should specify spi pad used, only required for MT8173.
> +        This value should be 0~3.

As already commented on the v3, this is a vendor property, and must
have a vendor prefix, so it must be called "mediatek,pad-select".

> +
> +Example:
> +
> +- SoC Specific Portion:
> +spi: spi@1100a000 {
> +       compatible = "mediatek,mt8173-spi";
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       reg = <0 0x1100a000 0 0x1000>;
> +       interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
> +       clocks = <&pericfg CLK_PERI_SPI0>;
> +       clock-names = "main";
> +       pad-select = <0>;
> +       status = "disabled";
> +};


Jonas
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
