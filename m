From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 6/6] arm64: dts: sc7180: Add interconnect for QUP and QSPI
Date: Mon, 17 Feb 2020 19:18:30 -0800
Message-ID: <20200218031830.GX955802@ripper>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-7-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gregkh@linuxfoundation.org, agross@kernel.org, wsa@the-dreams.de,
        broonie@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org
To: Akash Asthana <akashast@codeaurora.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1581946205-27189-7-git-send-email-akashast@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon 17 Feb 05:30 PST 2020, Akash Asthana wrote:

> Add interconnect ports for GENI QUPs and QSPI to set bus capabilities.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Note:
>  - This patch depends on series https://patchwork.kernel.org/cover/11313817/
>    [Add SC7180 interconnect provider driver]. It won't compile without that.
> 
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 199 +++++++++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index cc5a94f..04569c9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -352,6 +352,14 @@
>  				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> +				interconnects = <&qup_virt MASTER_QUP_CORE_0
> +						&qup_virt SLAVE_QUP_CORE_0>,
> +						<&gem_noc MASTER_APPSS_PROC
> +						&config_noc SLAVE_QUP_0>,
> +						<&aggre1_noc MASTER_QUP_0
> +						&mc_virt SLAVE_EBI1>;

Please ignore the 80-char "limit" and write this as:
				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
						<&gem_noc ...>,
						<&aggre1_noc ...>;

Regards,
Bjorn
