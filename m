Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEC563FC2;
	Wed,  9 Sep 2026 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957674; cv=none; b=DRQgXceDKwc+AL7CnnRgOe+2LRzgOdecURWui6r8q6vGn12/gWYHkr1Jhsw6/CiZUV+luyDEeB+jrtr74+Rk4WAro8Kw7CIPRc46uC3ml/DLCwrZdiDWsgDgu8AYIPH9IWDCRumipgS40SrXe1XDN0pEiaj3MuB/53Ela88JlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957674; c=relaxed/simple;
	bh=4lsaT0u9w8XeBJhgopqfdNtYcP8lp4cHeKsKtic3Co4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MYuxUWWcVra7dhh0ZHLOs71uxXQ1LEN5wDH4xnXA8+cxhfpP/0xpGHhI0C+KXdYjIy9OJtUF9I3f/oTMMfoHOJnIpj+YPdDXGjHyOL/Xk5hZo5yjQYezEua62zocY+sOck4Bx+6pWNroMiEN2a/8+2ugASCX1fMDQwXziE9IFM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFQ/xCjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFQ/xCjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66621F00A3A;
	Wed,  9 Sep 2026 12:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957671;
	bh=eea7Tw/rKYWMs597FSDSjSw6xQI7sFewc43KlItmITs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QFQ/xCjJcZHynRxe3uihPCU1hGFQdaAEFbcn76EkIFlJFA8kVhhyoWdulJjY3IoFE
	 xZ4jj/w7RbuvRbZLBkFw0/mRHkJXAoiuxVe/xDqE9KK4IN01NEotAbMFZKy4KAPAB0
	 jrWnZrkPepUsSCHaSlHPheHmMPyGRQxX+uWchWNhcqjIT5IxekaSGKsfjUomRw3dFl
	 24iGdCIz2T/Bs262dY6zyqolUxRwwzr0ocGqL/V5csNNCKucosPq0Ql8v2FVkYoa7x
	 Z6OQaM2oFcFgEV7My2j5vrVyF5BPEaf5nR3i7tXqyoIbdlS/zcnBUa/ZG76gRBWBqn
	 ozsJ5pYXnPSWQ==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Frank Li <Frank.Li@kernel.org>, Jia Wang <wangjia@ultrarisc.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
References: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
Subject: Re: (subset) [PATCH v2 00/10] riscv: Add device tree support for
 UltraRISC DP1000
Message-Id: <178895766221.2174329.15770056766507822412.b4-ty@kernel.org>
Date: Wed, 09 Sep 2026 18:11:02 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 07 Sep 2026 17:54:39 +0800, Jia Wang wrote:
> Add Devicetree support for the UltraRISC DP1000 RISC-V SoC and two
> DP1000-based motherboards: Shenzhen Rongda M0 and Milk-V Titan.
> 
> DP1000 integrates eight UltraRISC CP100 CPU cores.  The SoC description
> includes the CPU and cache topology, CLINT, PLIC, clock controller,
> pinctrl, GPIO, four UARTs, two SPI controllers, four I2C controllers,
> three PCIe root complexes, GMAC, and the DMA controller.
> 
> [...]

Applied, thanks!

[07/10] dt-bindings: dma: snps,dw-axi-dmac: Add UltraRISC DP1000 compatible
        commit: 09149a59a6aef7853a3750e4b303f20637cf7a8a

Best regards,
-- 
~Vinod


