From: Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH v5 6/8] arm: dts: Add bcm-nsp and bcm958625k support
Date: Mon, 1 Aug 2016 17:09:26 +0200
Message-ID: <CAOiHx=n8a64d-2LGGFHuyBQBg3Cz=ALVXEbvPRHxTyzFjWRMXA@mail.gmail.com>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-7-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Jayachandran C <jchandra@broadcom.com>, vigneshr@ti.com,
 linux-spi@vger.kernel.org,
 Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>,
 Mark Brown <broonie@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 MTD Maling List <linux-mtd@lists.infradead.org>, jon.mason@broadcom.com,
 vikram.prakash@broadcom.com, andy.fung@broadcom.com
To: Kamal Dasu <kdasu.kdev@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1469830393-13295-7-git-send-email-kdasu.kdev@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 30 July 2016 at 00:13, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> Adding qspi node compatible with the new spi-bcm-qspi
> driver for the broadcom's northstar SoC.
>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm-nsp.dtsi   | 33 +++++++++++++++++++++++++++++----
>  arch/arm/boot/dts/bcm958625k.dts | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
> index 6a40ed7..26c863e 100644
> --- a/arch/arm/boot/dts/bcm-nsp.dtsi
> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
> @@ -160,7 +160,7 @@
>
>         axi {
>                 compatible = "simple-bus";
> -               ranges = <0x00000000 0x18000000 0x0011ba08>;
> +               ranges = <0x00000000 0x18000000 0x0011c40a>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>
> @@ -206,9 +206,34 @@
>                         brcm,nand-has-wp;
>                 };
>
> -               rng: rng@33000 {
> -                       compatible = "brcm,bcm-nsp-rng";
> -                       reg = <0x33000 0x14>;

You remove the rng node, is this intentional?

> +               qspi: qspi@27200 {
> +                       compatible = "brcm,spi-bcm-qspi";
> +                       reg = <0x027200 0x184>,
> +                             <0x027000 0x124>,
> +                             <0x11c408 0x004>,
> +                             <0x0273a0 0x01c>;
> +                       reg-names = "mspi", "bspi", "intr_regs",
> +                                   "intr_status_reg";
> +                       interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "spi_lr_fullness_reached",
> +                                         "spi_lr_session_aborted",
> +                                         "spi_lr_impatient",
> +                                         "spi_lr_session_done",
> +                                         "spi_lr_overhead",
> +                                         "mspi_done",
> +                                         "mspi_halted";
> +                       clocks = <&iprocmed>;
> +                       clock-names = "iprocmed";
> +                       clock-frequency = <12500000>;
> +                       num-cs = <2>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
>                 };
>
>                 ccbtimer0: timer@34000 {
> diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
> index 2d84226..ab7ba8f 100644
> --- a/arch/arm/boot/dts/bcm958625k.dts
> +++ b/arch/arm/boot/dts/bcm958625k.dts
> @@ -126,3 +126,37 @@
>                 groups = "nand_grp";
>         };
>  };
> +
> +&qspi {
> +       bspi-sel = <0>;
> +       flash: m25p80@0 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "m25p80";
> +               reg = <0x0>;
> +               spi-max-frequency = <12500000>;
> +               m25p,fast-read;
> +               spi-cpol;
> +               spi-cpha;
> +
> +               partition@0 {
> +                       label = "boot";
> +                       reg = <0x00000000 0x000a0000>;
> +               };

these should be enclosed by a partitions node with compatible
"fixed-partitions", see
Documentation/devicetree/bindings/mtd/partition.txt.

> +
> +               partition@1 {

The address is 0xa0000 so this should be partition@a0000.

> +                       label = "env";
> +                       reg = <0x000a0000 0x00060000>;
> +               };
> +
> +               partition@2 {

likewise.

> +                       label = "system";
> +                       reg = <0x00100000 0x00600000>;
> +               };
> +
> +               partition@3 {

etc.

> +                       label = "rootfs";
> +                       reg = <0x00700000 0x01900000>;
> +               };
> +       };
> +};


Regards
Jonas

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
