From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH 04/11] dt-bindings: spi: Move and adjust the bindings for
 the fsl-qspi driver
Date: Wed, 30 May 2018 17:14:32 +0200
Message-ID: <f5db2a39-3758-8861-0efa-d49c4e428714@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-5-git-send-email-frieder.schrempf@exceet.de>
 <20180530170648.02c6fc41@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 yogeshnarayan.gaur@nxp.com, richard@nod.at, prabhakar.kushwaha@nxp.com,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-spi@vger.kernel.org, marek.vasut@gmail.com, han.xu@nxp.com,
 broonie@kernel.org, linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
 fabio.estevam@nxp.com, david.wolfe@nxp.com, computersforpeace@gmail.com,
 dwmw2@infradead.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180530170648.02c6fc41@bbrezillon>
Content-Language: en-US
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

Hi Boris,

On 30.05.2018 17:06, Boris Brezillon wrote:
> On Wed, 30 May 2018 15:14:33 +0200
> Frieder Schrempf <frieder.schrempf@exceet.de> wrote:
> 
>> Move the documentation of the old SPI NOR driver to the place of the new
>> SPI memory interface based driver and adjust the content to reflect the
>> new drivers settings.
> 
> Maybe it's better to do that in 2 steps so that people can easily
> identify what has changed in the bindings.

Ok, I can split this.

Thanks,

Frieder

> 
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>> ---
>>   .../devicetree/bindings/mtd/fsl-quadspi.txt     | 65 ------------------
>>   .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 69 ++++++++++++++++++++
>>   2 files changed, 69 insertions(+), 65 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
>> deleted file mode 100644
>> index 483e9cf..0000000
>> --- a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
>> +++ /dev/null
>> @@ -1,65 +0,0 @@
>> -* Freescale Quad Serial Peripheral Interface(QuadSPI)
>> -
>> -Required properties:
>> -  - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
>> -		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
>> -		 "fsl,ls1021a-qspi"
>> -		 or
>> -		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
>> -		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
>> -  - reg : the first contains the register location and length,
>> -          the second contains the memory mapping address and length
>> -  - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
>> -  - interrupts : Should contain the interrupt for the device
>> -  - clocks : The clocks needed by the QuadSPI controller
>> -  - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
>> -
>> -Optional properties:
>> -  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
>> -                              Each bus can be connected with two NOR flashes.
>> -			      Most of the time, each bus only has one NOR flash
>> -			      connected, this is the default case.
>> -			      But if there are two NOR flashes connected to the
>> -			      bus, you should enable this property.
>> -			      (Please check the board's schematic.)
>> -  - big-endian : That means the IP register is big endian
>> -
>> -Example:
>> -
>> -qspi0: quadspi@40044000 {
>> -	compatible = "fsl,vf610-qspi";
>> -	reg = <0x40044000 0x1000>, <0x20000000 0x10000000>;
>> -	reg-names = "QuadSPI", "QuadSPI-memory";
>> -	interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
>> -	clocks = <&clks VF610_CLK_QSPI0_EN>,
>> -		<&clks VF610_CLK_QSPI0>;
>> -	clock-names = "qspi_en", "qspi";
>> -
>> -	flash0: s25fl128s@0 {
>> -		....
>> -	};
>> -};
>> -
>> -Example showing the usage of two SPI NOR devices:
>> -
>> -&qspi2 {
>> -	pinctrl-names = "default";
>> -	pinctrl-0 = <&pinctrl_qspi2>;
>> -	status = "okay";
>> -
>> -	flash0: n25q256a@0 {
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -		compatible = "micron,n25q256a", "jedec,spi-nor";
>> -		spi-max-frequency = <29000000>;
>> -		reg = <0>;
>> -	};
>> -
>> -	flash1: n25q256a@1 {
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -		compatible = "micron,n25q256a", "jedec,spi-nor";
>> -		spi-max-frequency = <29000000>;
>> -		reg = <1>;
>> -	};
>> -};
>> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
>> new file mode 100644
>> index 0000000..0ee9cd8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
>> @@ -0,0 +1,69 @@
>> +* Freescale Quad Serial Peripheral Interface(QuadSPI)
>> +
>> +Required properties:
>> +  - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
>> +		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
>> +		 "fsl,ls1021a-qspi", "fsl,ls2080a-qspi"
>> +		 or
>> +		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
>> +  - reg : the first contains the register location and length,
>> +          the second contains the memory mapping address and length
>> +  - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
>> +  - interrupts : Should contain the interrupt for the device
>> +  - clocks : The clocks needed by the QuadSPI controller
>> +  - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
>> +
>> +Optional properties:
>> +  - big-endian : That means the IP registers format is big endian
>> +
>> +Required SPI slave node properties:
>> +  - reg: There are two buses (A and B) with two chip selects each.
>> +	 This encodes to which bus and CS the flash is connected:
>> +		<0>: Bus A, CS 0
>> +		<1>: Bus A, CS 1
>> +		<2>: Bus B, CS 0
>> +		<3>: Bus B, CS 1
>> +
>> +Example:
>> +
>> +qspi0: quadspi@40044000 {
>> +	compatible = "fsl,vf610-qspi";
>> +	reg = <0x40044000 0x1000>, <0x20000000 0x10000000>;
>> +	reg-names = "QuadSPI", "QuadSPI-memory";
>> +	interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
>> +	clocks = <&clks VF610_CLK_QSPI0_EN>,
>> +		<&clks VF610_CLK_QSPI0>;
>> +	clock-names = "qspi_en", "qspi";
>> +
>> +	flash0: s25fl128s@0 {
>> +		....
>> +	};
>> +};
>> +
>> +Example showing the usage of two SPI NOR devices on bus A:
>> +
>> +&qspi2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_qspi2>;
>> +	status = "okay";
>> +
>> +	flash0: n25q256a@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "micron,n25q256a", "jedec,spi-nor";
>> +		spi-max-frequency = <29000000>;
>> +		spi-rx-bus-width = <4>;
>> +		spi-tx-bus-width = <4>;
>> +		reg = <0>;
>> +	};
>> +
>> +	flash1: n25q256a@1 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "micron,n25q256a", "jedec,spi-nor";
>> +		spi-max-frequency = <29000000>;
>> +		spi-rx-bus-width = <4>;
>> +		spi-tx-bus-width = <4>;
>> +		reg = <1>;
>> +	};
>> +};
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
