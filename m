Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04B2F7F0E;
	Sat, 25 Jul 2026 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784985308; cv=none; b=OYhH2e5eLR3IeupvCqW9CNZ8MaWyMLQ75gmbkguvt3QdHNdaHupseYpvhyLtViZknhsc/eOm1HWdzgsholqIqGqNrdejDaU/p9aEEl40wHUEWEZttM7OX4aJMX1cmxs/UJXJ/1PpHVoonke37nsZmHGtTkr4X8tojxaAHwjLduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784985308; c=relaxed/simple;
	bh=rxFuc29Y5KFiHxW+VzfqS+/6YGn6zTAeEXi1N0+nxYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ6foox899eM73eCzajFXFtKz1tTcKIYrinc94dh6E/fW6j/nzUAH+9HQWTuOr/YrJdEw9cssKmloaxv5rz/4ktylLlC6rvWw+XsCcn4M6cxWoeSPD5LY+2fhj7TiEef9A+bfUwPKRQZwrdA6x/ZAr01DbTZn6KHI+MHidRUYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VACC1jKB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VACC1jKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F57B1F000E9;
	Sat, 25 Jul 2026 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784985307;
	bh=PDBeDRga6CAJFTofuPKkM0gbfdY9oTzTYuyONSr4uz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VACC1jKBV5JMuNmUzYmDkvuhh8bR/cLWP92Y+28v4dKzBJYI8z9T8NNa2VLt1Zd/c
	 4MR3UI4lkqZDVRHQF5XhjaQOBxOlGLmrcCUirt5apPlUR4oYyiZkUbUjgBcnlf+wcd
	 h9x0+RGbO6CILjBHqfoq3lF/kvh7LX+sTqQ7nA33V8vh7HLuCy5PyiZnvOqzMwpdR7
	 oEjyEzhOZwytQL8GktqAnMHk29C82yLPdHaX0S4NNo0czf6jOXYq0yvY8vuLwfNxD2
	 MzE+x86j+a3MKuQ2uF8fpNWFIBzQmE/B3dS11qmNx9SHYsmuvNRKsap81A+EiLjHFb
	 3LINK9MgaPnIg==
Date: Sat, 25 Jul 2026 13:15:04 +0000
From: Yixun Lan <dlan@kernel.org>
To: Zhengyu He <hezhy472013@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Mark Brown <broonie@kernel.org>, Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, wefu@redhat.com,
	Cody Kang <cody.kang.hk@outlook.com>
Subject: Re: [PATCH 3/4] riscv: dts: spacemit: add SPI controllers for K3
Message-ID: <20260725131504-GKE77545@kernel.org>
References: <20260717-k3-com260-spi-v7-2-rc2-b4-preview-20260716-v1-0-969a1b0f783f@gmail.com>
 <20260717-k3-com260-spi-v7-2-rc2-b4-preview-20260716-v1-3-969a1b0f783f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717-k3-com260-spi-v7-2-rc2-b4-preview-20260716-v1-3-969a1b0f783f@gmail.com>

On 07:45 Fri 17 Jul     , Zhengyu He wrote:
> Add the SPI controller nodes for K3.
> 
> Signed-off-by: Cody Kang <cody.kang.hk@outlook.com>
> Signed-off-by: Zhengyu He <hezhy472013@gmail.com>

Reviewed-by: Yixun Lan <dlan@kernel.org>

> ---
>  arch/riscv/boot/dts/spacemit/k3.dtsi | 49 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
> index 19fc9b49668e..dc44b5c77d41 100644
> --- a/arch/riscv/boot/dts/spacemit/k3.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> @@ -5,8 +5,10 @@
>   */
>  
>  #include <dt-bindings/clock/spacemit,k3-clocks.h>
> -#include <dt-bindings/reset/spacemit,k3-resets.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/reset/spacemit,k3-resets.h>
> +
> +#include "k3-pdma.h"
>  
>  /dts-v1/;
>  
> @@ -927,6 +929,21 @@ pwm7: pwm@d401bc00 {
>  			status = "disabled";
>  		};
>  
> +		spi3: spi@d401c000 {
> +			compatible = "spacemit,k3-spi", "spacemit,k1-spi";
> +			reg = <0x0 0xd401c000 0x0 0x30>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&syscon_apbc CLK_APBC_SPI3>,
> +				 <&syscon_apbc CLK_APBC_SPI3_BUS>;
> +			clock-names = "core", "bus";
> +			resets = <&syscon_apbc RESET_APBC_SPI3>;
> +			interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&pdma K3_PDMA_SSP3_RX>, <&pdma K3_PDMA_SSP3_TX>;
> +			dma-names = "rx", "tx";
> +			status = "disabled";
> +		};
> +
>  		pwm8: pwm@d4020000 {
>  			compatible = "spacemit,k3-pwm", "marvell,pxa910-pwm";
>  			reg = <0x0 0xd4020000 0x0 0x10>;
> @@ -1081,6 +1098,36 @@ uart10: serial@d401f000 {
>  			status = "disabled";
>  		};
>  
> +		spi0: spi@d4040000 {
> +			compatible = "spacemit,k3-spi", "spacemit,k1-spi";
> +			reg = <0x0 0xd4040000 0x0 0x30>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&syscon_apbc CLK_APBC_SPI0>,
> +				 <&syscon_apbc CLK_APBC_SPI0_BUS>;
> +			clock-names = "core", "bus";
> +			resets = <&syscon_apbc RESET_APBC_SPI0>;
> +			interrupts = <283 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&pdma K3_PDMA_SSP0_RX>, <&pdma K3_PDMA_SSP0_TX>;
> +			dma-names = "rx", "tx";
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@d4040800 {
> +			compatible = "spacemit,k3-spi", "spacemit,k1-spi";
> +			reg = <0x0 0xd4040800 0x0 0x30>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&syscon_apbc CLK_APBC_SPI1>,
> +				 <&syscon_apbc CLK_APBC_SPI1_BUS>;
> +			clock-names = "core", "bus";
> +			resets = <&syscon_apbc RESET_APBC_SPI1>;
> +			interrupts = <282 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&pdma K3_PDMA_SSP1_RX>, <&pdma K3_PDMA_SSP1_TX>;
> +			dma-names = "rx", "tx";
> +			status = "disabled";
> +		};
> +
>  		syscon_mpmu: system-controller@d4050000 {
>  			compatible = "spacemit,k3-syscon-mpmu";
>  			reg = <0x0 0xd4050000 0x0 0x10000>;
> 
> -- 
> 2.53.0
> 

-- 
Yixun Lan (dlan)
