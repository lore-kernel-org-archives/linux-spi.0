From: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH V2, 4/4] arm64: dts: Add ns2 SoC support
Date: Fri, 27 May 2016 13:26:54 -0700
Message-ID: <5748AD8E.3080808@broadcom.com>
References: <1464380097-25125-1-git-send-email-kdasu.kdev@gmail.com>
 <1464380097-25125-4-git-send-email-kdasu.kdev@gmail.com>
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
In-Reply-To: <1464380097-25125-4-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Kamal,

  Comment inline.

On 16-05-27 01:14 PM, Kamal Dasu wrote:
> Adding qspi node compatible with the new spi-bcm-qspi
> driver for the broadcom's northstar2 SoC.
>
> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
> V2 no change
> ---
>   arch/arm64/boot/dts/broadcom/ns2-svk.dts | 34 ++++++++++++++++++++++++++++++++
>   arch/arm64/boot/dts/broadcom/ns2.dtsi    | 18 +++++++++++++++++
>   2 files changed, 52 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
> index 54ca40c..0754841 100644
> --- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
> +++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
> @@ -132,3 +132,37 @@
>   		#size-cells = <1>;
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

The parititions are application specific and should not be specified in 
the dts file.  They should be passed on the boot command line?

> +	};
> +};
> diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> index ec68ec1..493fff6 100644
> --- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> @@ -399,5 +399,23 @@
>
>   			brcm,nand-has-wp;
>   		};
> +
> +		qspi: spi@66470200 {
> +			compatible = "brcm,spi-bcm-qspi";
> +			reg = <0x66470200 0x184>,
> +                              <0x66470000 0x124>,
> +                              <0x67017408 0x004>,
> +                              <0x664703a0 0x01c>;
> +			reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
> +			interrupts = <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "spi_l1_intr";
> +			clocks = <&iprocmed>;
> +			clock-names = "iprocmed";
> +			clock-frequency = <12500000>;
> +			num-cs = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>   	};
>   };
>

Regards,
Scott
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
