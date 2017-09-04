From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH v10 07/16] Documentation: DT: MIPS: lantiq: Add docs for
 the RCU bindings
Date: Mon, 4 Sep 2017 19:40:52 +0200
Message-ID: <CAFBinCD_q4=x-HB1rnLkGt_x+2dgUqhUe6t1a+PVt41hZGPhAQ@mail.gmail.com>
References: <20170819221823.13850-1-hauke@hauke-m.de> <20170819221823.13850-8-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        kishon-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170819221823.13850-8-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Aug 20, 2017 at 12:18 AM, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org> wrote:
> From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>
> This adds the initial documentation for the RCU module (a MFD device
> which provides USB PHYs, reset controllers and more).
>
> The RCU register range is used for multiple purposes. Mostly one device
> uses one or multiple register exclusively, but for some registers some
> bits are for one driver and some other bits are for a different driver.
> With this patch all accesses to the RCU registers will go through
> syscon.
>
> Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

thank you Hauke for pushing this!

> ---
>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> new file mode 100644
> index 000000000000..7b9be2d13c53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> @@ -0,0 +1,90 @@
> +Lantiq XWAY SoC RCU binding
> +===========================
> +
> +This binding describes the RCU (reset controller unit) multifunction device,
> +where each sub-device has it's own set of registers.
> +
> +The RCU register range is used for multiple purposes. Mostly one device
> +uses one or multiple register exclusively, but for some registers some
> +bits are for one driver and some other bits are for a different driver.
> +With this patch all accesses to the RCU registers will go through
> +syscon.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible   : The first and second values must be:
> +                 "lantiq,xrx200-rcu", "simple-mfd", "syscon"
> +- reg          : The address and length of the system control registers
> +
> +
> +-------------------------------------------------------------------------------
> +Example of the RCU bindings on a xRX200 SoC:
> +       rcu0: rcu@203000 {
> +               compatible = "lantiq,xrx200-rcu", "simple-mfd", "syscon";
> +               reg = <0x203000 0x100>;
> +               ranges = <0x0 0x203000 0x100>;
> +               big-endian;
> +
> +               gphy0: gphy@20 {
> +                       compatible = "lantiq,xrx200a2x-gphy";
> +                       reg = <0x20 0x4>;
> +
> +                       resets = <&reset0 31 30>, <&reset1 7 7>;
> +                       reset-names = "gphy", "gphy2";
> +                       lantiq,gphy-mode = <GPHY_MODE_GE>;
> +               };
> +
> +               gphy1: gphy@68 {
> +                       compatible = "lantiq,xrx200a2x-gphy";
> +                       reg = <0x68 0x4>;
> +
> +                       resets = <&reset0 29 28>, <&reset1 6 6>;
> +                       reset-names = "gphy", "gphy2";
> +                       lantiq,gphy-mode = <GPHY_MODE_GE>;
> +               };
> +
> +               reset0: reset-controller@10 {
> +                       compatible = "lantiq,xrx200-reset";
> +                       reg = <0x10 4>, <0x14 4>;
> +
> +                       #reset-cells = <2>;
> +               };
> +
> +               reset1: reset-controller@48 {
> +                       compatible = "lantiq,xrx200-reset";
> +                       reg = <0x48 4>, <0x24 4>;
> +
> +                       #reset-cells = <2>;
> +               };
> +
> +               usb_phy0: usb2-phy@18 {
> +                       compatible = "lantiq,xrx200-usb2-phy";
> +                       reg = <0x18 4>, <0x38 4>;
> +                       status = "disabled";
> +
> +                       resets = <&reset1 4 4>, <&reset0 4 4>;
> +                       reset-names = "phy", "ctrl";
> +                       #phy-cells = <0>;
> +               };
> +
> +               usb_phy1: usb2-phy@34 {
> +                       compatible = "lantiq,xrx200-usb2-phy";
> +                       reg = <0x34 4>, <0x3C 4>;
> +                       status = "disabled";
> +
> +                       resets = <&reset1 5 4>, <&reset0 4 4>;
> +                       reset-names = "phy", "ctrl";
> +                       #phy-cells = <0>;
> +               };
> +
> +               reboot@10 {
> +                       compatible = "syscon-reboot";
> +                       reg = <0x10 4>;
> +
> +                       regmap = <&rcu0>;
> +                       offset = <0x10>;
> +                       mask = <0x40000000>;
> +               };
> +       };
> +
> --
> 2.11.0
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
