From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v8 3/5] arm64: dts: lx2160a: add FlexSPI node property
Date: Fri, 1 Feb 2019 10:54:07 +0800
Message-ID: <20190201025405.GA19882@dragon>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547553487-9936-4-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1547553487-9936-4-git-send-email-yogeshnarayan.gaur@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 15, 2019 at 12:00:26PM +0000, Yogesh Narayan Gaur wrote:
> Add fspi node property for LX2160A SoC for FlexSPI driver.
> Property added for the FlexSPI controller and for the connected
> slave device for the LX2160ARDB target.
> This is having two SPI-NOR flash device, mt35xu512aba, connected
> at CS0 and CS1.
> 
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v8:
> - None
> Changes for v7:
> - None
> Changes for v6:
> - None
> Changes for v5:
> - None
> Changes for v4:
> - Incorporated Rob review comments.
> Changes for v3:
> - None.
> Changes for v2:
> - Incorporated Shawn review comments.
> 
>  .../boot/dts/freescale/fsl-lx2160a-rdb.dts    | 22 +++++++++++++++++++
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 13 +++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 6481e5f20e69..70658946fbbe 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -50,6 +50,28 @@
>  	status = "okay";
>  };
>  
> +&fspi {
> +	status = "okay";
> +
> +	mt35xu512aba0: flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "spansion,m25p80";
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +		reg = <0>;
> +	};
> +
> +	mt35xu512aba1: flash@1 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "spansion,m25p80";
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +		reg = <1>;
> +	};
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index a79f5c1ea56d..e3ff86201f73 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -762,5 +762,18 @@
>  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>  			dma-coherent;
>  		};
> +
> +		fspi: spi@20c0000 {

To keep the nodes sorted in unit-address, it should go after
i2c@2070000.

> +			compatible = "nxp,lx2160a-fspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x20c0000 0x0 0x10000>,
> +				<0x0 0x20000000 0x0 0x10000000>;

I would align the indentation with the above.

> +			reg-names = "fspi_base", "fspi_mmap";
> +			interrupts = <0 25 0x4>; /* Level high type */

interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>; so that we can save the
comment there.

I fixed up all these small things and applied the patch.

Shawn

> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "fspi_en", "fspi";
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
