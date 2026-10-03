Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC4B3264DD;
	Sat,  3 Oct 2026 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791037526; cv=none; b=QL4RyNs+ejMi87iKB1CnxcDfKxCwzUjDacUGMxQAPv7oSNj80HaDN79YhBLy4HcR4XOPy9OO+dcxroCLH25F++eGa/LTfvx1HYvh17xBBBjCwnR8IYmxEFsbUNvIUmY0NuiOSMND0f+BqK4Xca6Swlc610uHdAVsQlUM2zWlDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791037526; c=relaxed/simple;
	bh=T89/h7SPkioBe2Cwy06aCg2kDoZSQ8S6tLZH1JSWAvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etiZ8aeMyOpoUnNPRMCTjI1Uz6/A5hqr15hw7n66Q/1THj9NrtBU3hEYJ9LD8VA5/ts8SyvZCHggzDcWTTP1CsD5QvU9oeTL45IC4Mks4pVxrJB4wPUTYR3qKyUmlTSMYOh2019TvxAPZFDNDrnbGwzgam6wY/rqtO00H0uvdvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHo6pYql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHo6pYql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CA61F0089B;
	Sat,  3 Oct 2026 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791037524;
	bh=oMEyZY83mtOf98Y87sETCEyUJVbj7dvZ+NURWwy5N3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NHo6pYqliX0+vL+QohnXX/giy7sbKAGQFfZ7psJ1t0iNtAJCNHZjWMOx9qFUYy6Eu
	 lmKTKVwGGe1fznnkHQFp+ITSLz0bdrlPkufCWnFxHxoqhKV6P0TBsYS3wFNk6JR+Dm
	 5A8OCHv8w+pJVKMDB+L0k0BuKcX77OYJmNU5ByIawM00JvFI7MzbCnCVguc4b1FjSW
	 dc/RcjuKIvDBJHg+m1EzPVxGXLIo8f6KScvqkl3TROpoiuEy/ZUr0N/m5e/AIhe+vw
	 oivzL7MmWh4WycM+wtW88TrzYk1yosBV2WZmZHh6Sa3mPoJGGjNrrIFI4654JPzdQm
	 3kWwhvNfaPljQ==
Date: Sat, 3 Oct 2026 16:25:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: nuvoton,ma35d1-qspi: Add MA35D1
 SPI controller
Message-ID: <20261003-innocent-placid-markhor-e7c6ec@quoll>
References: <20261001131818.110028-1-cwweng.linux@gmail.com>
 <20261001131818.110028-2-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001131818.110028-2-cwweng.linux@gmail.com>

On Thu, Oct 01, 2026 at 09:18:16PM +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Extend the existing MA35D1 QSPI binding to also describe the MA35D1 SPI
> controller.
> 
> The SPI and QSPI controllers are separate hardware IPs. QSPI additionally
> supports dual, quad and DTR transfers and a target-mode timeout function,
> but these differences do not require additional controller-specific
> Devicetree properties.
> 
> Both controllers expose the same Devicetree-visible resources and provide
> up to two native chip-select signals. GPIO chip selects are supported
> through the generic SPI controller binding. Since the MA35D1 QSPI driver
> now supports GPIO chip selects, also remove the existing restriction
> on cs-gpios for the QSPI compatible.

This has to be a separate commit.

> 
> Add the nuvoton,ma35d1-spi compatible and update the binding description
> and examples to cover both controllers.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> ---
>  .../bindings/spi/nuvoton,ma35d1-qspi.yaml     | 41 +++++++++++++++++--
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
> index 40965ec5163b..72f2e1e1219a 100644
> --- a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
> @@ -4,7 +4,17 @@
>  $id: http://devicetree.org/schemas/spi/nuvoton,ma35d1-qspi.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Nuvoton MA35D1 Quad SPI Controller
> +title: Nuvoton MA35D1 SPI and Quad SPI Controllers
> +
> +description: |
> +  The Nuvoton MA35D1 SoC contains separate SPI and QSPI controller IPs.
> +  Both controllers expose the same Devicetree-visible resources and provide
> +  two native chip-select signals. GPIO chip selects are supported through the
> +  generic SPI controller binding.
> +
> +  The QSPI controller additionally supports dual, quad and DTR transfers and
> +  a target-mode timeout function. These capability differences do not require
> +  additional controller properties.
>  
>  maintainers:
>    - Chi-Wen Weng <cwweng@nuvoton.com>
> @@ -14,7 +24,9 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: nuvoton,ma35d1-qspi
> +    enum:
> +      - nuvoton,ma35d1-spi
> +      - nuvoton,ma35d1-qspi
>  
>    reg:
>      maxItems: 1
> @@ -33,8 +45,6 @@ properties:
>      maximum: 2
>      default: 2
>  
> -  cs-gpios: false
> -
>  required:
>    - compatible
>    - reg
> @@ -59,7 +69,30 @@ examples:
>              interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>              clocks = <&clk QSPI0_GATE>;
>              resets = <&sys MA35D1_RESET_QSPI0>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +

No need for a new example, for exactly the same node. Difference in
value of a property does not justify it.

Best regards,
Krzysztof

