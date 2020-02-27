From: Amit Kucheria <amit.kucheria-LY4KaoCqKrnby3iVrkZq2A@public.gmane.org>
Subject: Re: [PATCH 6/6] arm64: dts: sc7180: Add interconnect for QUP and QSPI
Date: Thu, 27 Feb 2020 17:41:03 +0530
Message-ID: <CAHLCerM8Av_x8smUfOS_-TMEMzi1xRjgs0ta7=tqdYL2CgjNrw@mail.gmail.com>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org> <1581946205-27189-7-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
        linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1581946205-27189-7-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Akash,


On Mon, Feb 17, 2020 at 7:01 PM Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
> Add interconnect ports for GENI QUPs and QSPI to set bus capabilities.
>
> Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
> Note:
>  - This patch depends on series https://patchwork.kernel.org/cover/11313817/
>    [Add SC7180 interconnect provider driver]. It won't compile without that.

I've tried picking up v4 of Odelu's series to add the SC7180 but I'm
still unable to compile this. I see the following error:

Error: /home/amit/work/sources/worktree-review-pipeline/arch/arm64/boot/dts/qcom/sc7180.dtsi:353.32-33
syntax error
FATAL ERROR: Unable to parse input tree
make[3]: *** [scripts/Makefile.lib:296:
arch/arm64/boot/dts/qcom/sc7180-idp.dtb] Error 1

As part of picking up the dependencies, I've pulled the following
series on top of v5.6-rc2:

- https://lore.kernel.org/r/1581932974-21654-2-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
- https://lore.kernel.org/r/1581932212-19469-2-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
- https://lore.kernel.org/r/1581946205-27189-2-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
- https://lore.kernel.org/r/1582646384-1458-2-git-send-email-okukatla-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
- https://lore.kernel.org/r/20200209183411.17195-2-sibis-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org

What am I missing?

I've pushed the aggregate branch here for convenience:
https://git.linaro.org/people/amit.kucheria/kernel.git/log/

Regards,
Amit

>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 199 +++++++++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index cc5a94f..04569c9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -352,6 +352,14 @@
>                                 interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>,
> +                                               <&aggre1_noc MASTER_QUP_0
> +                                               &mc_virt SLAVE_EBI1>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
>                                 status = "disabled";
>                         };
>
> @@ -365,6 +373,11 @@
>                                 interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -376,6 +389,11 @@
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&qup_uart0_default>;
>                                 interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -389,6 +407,14 @@
>                                 interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>,
> +                                               <&aggre1_noc MASTER_QUP_0
> +                                               &mc_virt SLAVE_EBI1>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
>                                 status = "disabled";
>                         };
>
> @@ -402,6 +428,11 @@
>                                 interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -413,6 +444,11 @@
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&qup_uart1_default>;
>                                 interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -426,6 +462,14 @@
>                                 interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>,
> +                                               <&aggre1_noc MASTER_QUP_0
> +                                               &mc_virt SLAVE_EBI1>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
>                                 status = "disabled";
>                         };
>
> @@ -437,6 +481,11 @@
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&qup_uart2_default>;
>                                 interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -450,6 +499,14 @@
>                                 interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>,
> +                                               <&aggre1_noc MASTER_QUP_0
> +                                               &mc_virt SLAVE_EBI1>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
>                                 status = "disabled";
>                         };
>
> @@ -463,6 +520,11 @@
>                                 interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -474,6 +536,11 @@
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&qup_uart3_default>;
>                                 interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -487,6 +554,14 @@
>                                 interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>,
> +                                               <&aggre1_noc MASTER_QUP_0
> +                                               &mc_virt SLAVE_EBI1>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
>                                 status = "disabled";
>                         };
>
> @@ -498,6 +573,11 @@
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&qup_uart4_default>;
>                                 interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -511,6 +591,14 @@
>                                 interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>,
> +                                               <&aggre1_noc MASTER_QUP_0
> +                                               &mc_virt SLAVE_EBI1>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
>                                 status = "disabled";
>                         };
>
> @@ -524,6 +612,11 @@
>                                 interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -535,6 +628,11 @@
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&qup_uart5_default>;
>                                 interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_0
> +                                               &qup_virt SLAVE_QUP_CORE_0>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_0>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>                 };
> @@ -561,6 +659,14 @@
>                                 interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>,
> +                                               <&aggre2_noc MASTER_QUP_1
> +                                               &mc_virt SLAVE_EBI1>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
>                                 status = "disabled";
>                         };
>
> @@ -574,6 +680,11 @@
>                                 interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -585,6 +696,11 @@
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&qup_uart6_default>;
>                                 interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -598,6 +714,14 @@
>                                 interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>,
> +                                               <&aggre2_noc MASTER_QUP_1
> +                                               &mc_virt SLAVE_EBI1>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
>                                 status = "disabled";
>                         };
>
> @@ -609,6 +733,11 @@
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&qup_uart7_default>;
>                                 interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -622,6 +751,14 @@
>                                 interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>,
> +                                               <&aggre2_noc MASTER_QUP_1
> +                                               &mc_virt SLAVE_EBI1>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
>                                 status = "disabled";
>                         };
>
> @@ -635,6 +772,11 @@
>                                 interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -646,6 +788,11 @@
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&qup_uart8_default>;
>                                 interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -659,6 +806,14 @@
>                                 interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>,
> +                                               <&aggre2_noc MASTER_QUP_1
> +                                               &mc_virt SLAVE_EBI1>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
>                                 status = "disabled";
>                         };
>
> @@ -670,6 +825,11 @@
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&qup_uart9_default>;
>                                 interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -683,6 +843,14 @@
>                                 interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>,
> +                                               <&aggre2_noc MASTER_QUP_1
> +                                               &mc_virt SLAVE_EBI1>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
>                                 status = "disabled";
>                         };
>
> @@ -696,6 +864,11 @@
>                                 interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -707,6 +880,11 @@
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&qup_uart10_default>;
>                                 interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -720,6 +898,14 @@
>                                 interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>,
> +                                               <&aggre2_noc MASTER_QUP_1
> +                                               &mc_virt SLAVE_EBI1>;
> +                               interconnect-names = "qup-core", "qup-config",
> +                                                       "qup-memory";
>                                 status = "disabled";
>                         };
>
> @@ -733,6 +919,11 @@
>                                 interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>
> @@ -744,6 +935,11 @@
>                                 pinctrl-names = "default";
>                                 pinctrl-0 = <&qup_uart11_default>;
>                                 interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
> +                               interconnects = <&qup_virt MASTER_QUP_CORE_1
> +                                               &qup_virt SLAVE_QUP_CORE_1>,
> +                                               <&gem_noc MASTER_APPSS_PROC
> +                                               &config_noc SLAVE_QUP_1>;
> +                               interconnect-names = "qup-core", "qup-config";
>                                 status = "disabled";
>                         };
>                 };
> @@ -1051,6 +1247,9 @@
>                         clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
>                                  <&gcc GCC_QSPI_CORE_CLK>;
>                         clock-names = "iface", "core";
> +                       interconnects = <&gem_noc MASTER_APPSS_PROC
> +                                       &config_noc SLAVE_QSPI_0>;
> +                       interconnect-names = "qspi-config";
>                         status = "disabled";
>                 };
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
