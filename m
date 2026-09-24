Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CEB479893;
	Thu, 24 Sep 2026 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249676; cv=none; b=UdfyhGSOU4ImaAGS5euix7rccKpfyTMOTamJGdO181L/bUdVsvuaWBvuCIGGNJCTOUZJNnJSTpl/WYaPNWT5OELquDDfbadRrebdqIEMp8fx7jHTNz4oygavcH30/45pDNc1+3qmr0HwuhVO/eugpmFblEJKgCAyLVKHi/xJllI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249676; c=relaxed/simple;
	bh=U/5jxIvqAMJSzYIFoerpkjY38kslGt38ihMa4APLokI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8AEjFELmZj6PC7nBgnQ6X8Ji1MQFv1Ky5YDevHf2lSOullmZbU3gfqQ0SqvVcYIhBAaHwQkG33TZQkp7KushqwRMby2/x+EsRGXW1Gc9KDQyj7iQOjZ1LAEX3qDWpbRS0kFjAcQfQS6rvK7cXjkiIov9vNNiKVGfBoA1Dq6yTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=E247WkLQ; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="E247WkLQ"
Message-ID: <a2eea40a-fe81-4aac-85f9-d0a85bb99e26@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1790249661;
	bh=U/5jxIvqAMJSzYIFoerpkjY38kslGt38ihMa4APLokI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E247WkLQcQMT1igSWXHSdp3PgpUdBFM1eDSBfaK622ZJKF3cTs8fO8jx4CdLLp6V3
	 GiS5z+d1P2mJLTbU2236srkwHxQjnoyU2iX6leRaEDPITHlZz+5wi/H9OKeBvqm15j
	 JqjKaLKFLPiP1YsDgJf9RG0iiGiS0i/sKwz8PuPE=
Date: Thu, 24 Sep 2026 13:33:04 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 3/3] arm64: dts: amlogic: add T7 peripheral nodes
To: xianwei.zhao@amlogic.com
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260924-t7-node-new-v2-0-319d3c19b4b2@amlogic.com>
 <20260924-t7-node-new-v2-3-319d3c19b4b2@amlogic.com>
Content-Language: en-US
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
In-Reply-To: <20260924-t7-node-new-v2-3-319d3c19b4b2@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 7:51 AM, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add device tree descriptions for the peripherals on the Amlogic T7
> SoC and the T7 A311D2 AN400 board.
> 
> Add support for the T7 Ethernet controller, SPI controllers, I2C
> controllers, UARTs, pinctrl groups, regulators, and reserved memory.
> Also enable the Ethernet controller on the AN400 board.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../boot/dts/amlogic/amlogic-t7-a311d2-an400.dts   | 153 +++++++
>  arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        | 462 +++++++++++++++++++++
>  2 files changed, 615 insertions(+)
>

 --snip--

> +
>  				pwm_a_pins: pwm-a {
>  					mux {
>  						groups = "pwm_a";
> @@ -622,6 +848,51 @@ uart_a: serial@78000 {
>  				status = "disabled";
>  			};
>  
> +			uart_b: serial@7a000 {
> +				compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
> +				reg = <0x0 0x7a000 0x0 0x18>;
> +				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&clkc_periphs CLKID_SYS_UART_B>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
> +
> +			uart_c: serial@7c000 {
> +				compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
> +				reg = <0x0 0x7c000 0x0 0x18>;
> +				interrupts = <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&clkc_periphs CLKID_SYS_UART_C>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
> +
> +			uart_d: serial@7e000 {
> +				compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
> +				reg = <0x0 0x7e000 0x0 0x18>;
> +				interrupts = <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&clkc_periphs CLKID_SYS_UART_D>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
> +
> +			uart_e: serial@80000 {
> +				compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
> +				reg = <0x0 0x80000 0x0 0x18>;
> +				interrupts = <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&clkc_periphs CLKID_SYS_UART_E>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
> +
> +			uart_f: serial@82000 {
> +				compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
> +				reg = <0x0 0x82000 0x0 0x18>;
> +				interrupts = <GIC_SPI 173 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&xtal>, <&clkc_periphs CLKID_SYS_UART_F>, <&xtal>;
> +				clock-names = "xtal", "pclk", "baud";
> +				status = "disabled";
> +			};
> +

Thank you for this change Xianwei.
Can you please move the UARTs in the right place between i2c_ao_a and
i2c_ao_b ?

>  			gp0: clock-controller@8080 {
>  				compatible = "amlogic,t7-gp0-pll";
>  				reg = <0x0 0x8080 0x0 0x20>;
> @@ -688,6 +959,39 @@ sec_ao: ao-secure@10220 {
>  				amlogic,has-chip-id;
>  			};
>  

--snip--

>  			pwm_ab: pwm@58000 {
>  				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
>  				reg = <0x0 0x58000 0x0 0x24>;
> @@ -756,6 +1138,86 @@ pwm_ao_cd: pwm@60000 {
>  				status = "disabled";
>  			};
>  
> +			i2c0: i2c@66000 {
> +				compatible = "amlogic,t7-i2c", "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x66000 0x0 0x48>;
> +				interrupts = <GIC_SPI 160 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_M_A>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@68000 {
> +				compatible = "amlogic,t7-i2c", "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x68000 0x0 0x48>;
> +				interrupts = <GIC_SPI 161 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_M_B>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c@6a000 {
> +				compatible = "amlogic,t7-i2c", "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x6a000 0x0 0x48>;
> +				interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_M_C>;
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c@6c000 {
> +				compatible = "amlogic,t7-i2c", "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x6c000 0x0 0x48>;
> +				interrupts = <GIC_SPI 163 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_M_D>;
> +				status = "disabled";
> +			};
> +
> +			i2c4: i2c@6e000 {
> +				compatible = "amlogic,t7-i2c", "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x6e000 0x0 0x48>;
> +				interrupts = <GIC_SPI 164 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_M_E>;
> +				status = "disabled";
> +			};
> +
> +			i2c5: i2c@70000 {
> +				compatible = "amlogic,t7-i2c", "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x070000 0x0 0x48>;
> +				interrupts = <GIC_SPI 165 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_M_F>;
> +				status = "disabled";
> +			};
> +
> +			i2c_ao_a: i2c@76000 {
> +				compatible = "amlogic,t7-i2c", "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x076000 0x0 0x48>;
> +				interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_AO_A>;
> +				status = "disabled";
> +			};
> +
> +			i2c_ao_b: i2c@86000 {
> +				compatible = "amlogic,t7-i2c", "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x086000 0x0 0x48>;
> +				interrupts = <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_AO_B>;
> +				status = "disabled";
> +			};
> +
>  			sd_emmc_a: mmc@88000 {
>  				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
>  				reg = <0x0 0x88000 0x0 0x800>;
> 


-- 
Best regards,
Ronald
