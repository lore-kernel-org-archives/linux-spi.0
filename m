Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571415;
	b=2PQGZuyVL0gNItwxQIK6CTXYw0+MryyPL+YGOPBAGNmewga9BEr7ndLWgi+ij0+O2SCR
	 eJSx2CJ9UfShBqLLs6WyLJcftHRnCXq3BEXuhjBg5uposw+/J6gPdcjI05xb7KrB2nHnt
	 uAQ350rlSQBJCEzVxBoPIFsOurHwnRHm0CkD/m5P5eHpHJyALgA/SGAdhBNbOUlV4upVQ
	 nPrvfl3g1llxRdlTWNjrSQwJ2CFVXZIX52JqxwqPsaZkngkGQrkzhG/wVpJgjC0VW14xh
	 Ppjqp+SgisfxVf8PlDaFQMrmsWaIHDYJSz8xV5cE2pULJjNvwkRT9xyvlMGe8YwtExw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571415;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=HltbMUNV2mL7CmzUNbC48/jDW0dqtweL2/SgQbNH2V0=;
	b=Cmt5OoIthRbEx7XnF+GpVJx+77kjPMSilsyAqBvhiEUCfUsx7KWyQx9rPiv8IpkDSC3D
	 oGZbS5Q2yMRMbeBp7BfNGuj3qKwJJJgo0vKPu5ywiWXRlMhIWKzfSEyBaTlU+NxX+AXLt
	 TN6O1mxSR5gTwQbEgsoX18CH2eqoBqdd5I8aAVtD3EPpMrZbx2VJkQptVfK46mVU/p5bk
	 +Hhnw1fGZ6SpiUSIHh9xP7tsXZkF4Q5ab/izdN95gDKUcOsPIojsROGp4M8Hy74k0iIbA
	 gl0mHEdWcRlQ/99MroKi2Q6YQUoaVPfGPcGf34rsD2OwdL4RcHxI5VtLmzLTa45fkHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sw2wvSa9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D406072B07;
	Sun,  1 Nov 2026 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sw2wvSa9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BBD1F00A1A;
	Sun,  1 Nov 2026 22:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571414;
	bh=HltbMUNV2mL7CmzUNbC48/jDW0dqtweL2/SgQbNH2V0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Sw2wvSa9SHk+5nIAcZtroRIwKn3V8PzpfgbTLlVEV2B7Xsn//R4odyY0lpJuvkfxl
	 NUZRIwvOhsHBhiPm4aKwcK/KKj3SJoyTiRkThQXKWOCyMxiNH0czjnItiMBrcqFga7
	 uuczREcVU5lBB+gyieVoJQUbYjoYHae2v3rLcILiOpCvWoFXuRaWQn0K5Q/kHvzBTZ
	 7pABNP2hcIomqaTsjurf04sAXjbEbAJtS5ik2OrgzBtbk8OsoUZ/jXIyzmR7cCJIyQ
	 383vUSbItJnXYvFwIhgBanuA94ScjhOdY/FSt2V66ReLpmbDYJ9lM4+t4c4cA36L5q
	 FvbztgSLAHKsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA53838003B8;
	Sun,  1 Nov 2026 22:16:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/10] riscv: Add device tree support for UltraRISC
 DP1000
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357141329.2624073.10814218023350815293.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:53 +0000
References: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
In-Reply-To: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: linux-riscv@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, daniel.lezcano@kernel.org,
 tglx@kernel.org, samuel.holland@sifive.com, anup@brainfault.org,
 broonie@kernel.org, andi.shyti@kernel.org, mika.westerberg@linux.intel.com,
 Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org, Frank.Li@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@sifive.com, conor@kernel.org,
 linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
 dmaengine@vger.kernel.org, conor.dooley@microchip.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Vinod Koul <vkoul@kernel.org>:

On Mon, 07 Sep 2026 17:54:39 +0800 you wrote:
> Add Devicetree support for the UltraRISC DP1000 RISC-V SoC and two
> DP1000-based motherboards: Shenzhen Rongda M0 and Milk-V Titan.
> 
> DP1000 integrates eight UltraRISC CP100 CPU cores.  The SoC description
> includes the CPU and cache topology, CLINT, PLIC, clock controller,
> pinctrl, GPIO, four UARTs, two SPI controllers, four I2C controllers,
> three PCIe root complexes, GMAC, and the DMA controller.
> 
> [...]

Here is the summary with links:
  - [v2,01/10] dt-bindings: vendor-prefixes: Add shenrongda
    (no matching commit)
  - [v2,02/10] dt-bindings: riscv: cpus: Add UltraRISC CP100 compatible
    (no matching commit)
  - [v2,03/10] dt-bindings: riscv: Add UltraRISC DP1000 board compatibles
    (no matching commit)
  - [v2,04/10] dt-bindings: timer: Add UltraRISC DP1000 CLINT
    (no matching commit)
  - [v2,05/10] spi: dt-bindings: snps,dw-apb-ssi: Add compatible for UltraRISC DP1000 SoC
    (no matching commit)
  - [v2,06/10] dt-bindings: i2c: dw: Add compatible for UltraRISC DP1000 SoC
    https://git.kernel.org/riscv/c/3d067add1281
  - [v2,07/10] dt-bindings: dma: snps,dw-axi-dmac: Add UltraRISC DP1000 compatible
    https://git.kernel.org/riscv/c/58a66a560aa1
  - [v2,08/10] riscv: dts: ultrarisc: Add initial device tree for UltraRISC DP1000
    (no matching commit)
  - [v2,09/10] riscv: dts: ultrarisc: Add Shenzhen Rongda M0 board device tree
    (no matching commit)
  - [v2,10/10] riscv: dts: ultrarisc: Add Milk-V Titan board device tree
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


