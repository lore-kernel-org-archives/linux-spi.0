From: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH V2, 3/4] arm: dts: Add bcm-nsp and bcm958625k support
Date: Fri, 27 May 2016 13:28:14 -0700
Message-ID: <5748ADDE.2090402@broadcom.com>
References: <1464380097-25125-1-git-send-email-kdasu.kdev@gmail.com>
 <1464380097-25125-3-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464380097-25125-3-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Kamal,

Comment inline.

On 16-05-27 01:14 PM, Kamal Dasu wrote:
> Adding qspi node compatible with the new spi-bcm-qspi
> driver for the broadcom's northstar SoCwq.
>
> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
> V2 no change
> ---
>   arch/arm/boot/dts/bcm-nsp.dtsi   | 29 +++++++++++++++++++++++++++++
>   arch/arm/boot/dts/bcm958625k.dts | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 63 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
> index def9e78..b3082b9 100644
> --- a/arch/arm/boot/dts/bcm-nsp.dtsi
> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
> @@ -206,6 +206,35 @@
>   			brcm,nand-has-wp;
>   		};
>
> +		qspi: qspi@27200 {
> +			compatible = "brcm,spi-bcm-qspi";
> +			reg = <0x027200 0x184>,
> +			      <0x027000 0x124>,
> +			      <0x11c408 0x004>,
> +			      <0x0273a0 0x01c>;
> +			reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "spi_lr_fullness_reached",
> +					  "spi_lr_session_aborted",
> +					  "spi_lr_impatient",
> +					  "spi_lr_session_done",
> +					  "spi_lr_overhead",
> +					  "mspi_done",
> +					  "mspi_halted";
> +			clocks = <&iprocmed>;
> +			clock-names = "iprocmed";
> +			clock-frequency = <12500000>;
> +			num-cs = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>   		ccbtimer0: timer@34000 {
>   			compatible = "arm,sp804";
>   			reg = <0x34000 0x1000>;
> diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
> index e298450..5aea779 100644
> --- a/arch/arm/boot/dts/bcm958625k.dts
> +++ b/arch/arm/boot/dts/bcm958625k.dts
> @@ -114,3 +114,37 @@
>   		groups = "nand_grp";
>   	};
>   };
> +
> +&qspi {
> +	bspi-sel = <0>;
> +	flash: m25p80@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "m25p80";
> +		reg = <0x0>;
> +		spi-max-frequency = <12500000>;
> +		m25p,fast-read;
> +		spi-cpol;
> +		spi-cpha;
> +
> +		partition@0 {
> +			label = "boot";
> +			reg = <0x00000000 0x000a0000>;
> +		};
> +
> +		partition@1 {
> +			label = "env";
> +			reg = <0x000a0000 0x00060000>;
> +		};
> +
> +		partition@2 {
> +			label = "system";
> +			reg = <0x00100000 0x00600000>;
> +		};
> +
> +		partition@3 {
> +			label = "rootfs";
> +			reg = <0x00700000 0x01900000>;
> +		};

The partitions are applications specific so should be passed on the boot 
command line rather than embedded in the dts file.

> +	};
> +};
>

Regards,
  Scott
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
