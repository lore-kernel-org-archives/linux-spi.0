Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50F569F0F;
	Wed,  9 Sep 2026 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972903; cv=none; b=UEMQFoDXINjrdoOrsfIGT4FinSuMqHQlaYGy4/rJewv5tYZFAlUU7N5z7yBv8FdYua2MYA97bbMgIbpVJ/t9xJc+pHzFInf2YjMreUIzDQrh48gaMgLJ0SHh94Qgwot1G8sfSl6K2At4M26tEfDQJ/4cNLTmHXLpA/Sxr14xvaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972903; c=relaxed/simple;
	bh=nqpDu2o3hK3qr20tvru4ckpxujP1K23ZlO4JGYYlMdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIhpdVXVOigigZueeAtQIkG5Gh7rOerz/pW+bnQC+VrXGiUZwo76nK0Vq+3O2hy3rzJU5HHwuOX31bBAeiA0jmVQ2vqWC4rAxkjDTst1Cb4nQdimQ3rSkS2Tw/ePcC7tN7RX8lflVZzEn7kGgeqwNMRR/Kz8gG/QBBcjQuFUQRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBayZFm0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBayZFm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C401F000FF;
	Wed,  9 Sep 2026 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972901;
	bh=xrZiWkO/Cig928w3Hg0lcA4NQRdYMH+CxvejqzEbOxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jBayZFm0zOZtOV/v6V/j6XvGE/wtPFLdi3lhON81fWBU5akr3AmKRrbF+wFpvFRiN
	 otWfZbXcUpKbpH8HJyQj2s1imtaqHlKCdXs38ur0R8US9enl32LAU4a0qPiWw/Tach
	 HNqNB3KObm3DaMxItwekuERLPTFf6I1ViX5eni75KKQ2tevrSdH5CkSCAgG9Up4qrE
	 X/uXCSH0sVRMNWIWAhH4uzv2+Y9H0+w2fNviIGzldWpiLDTGMw+RI4GzqiX0bIWrpq
	 fg+tbFAf82bSYRVS+b+YF7JsD4vaYYnwpnzp4pJWfILi5jNFO1HfKCNi17jfxoQ5hq
	 xTJpYrRVFYsTA==
Date: Wed, 9 Sep 2026 18:54:54 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: wangjia@ultrarisc.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, 
	Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 06/10] dt-bindings: i2c: dw: Add compatible for
 UltraRISC DP1000 SoC
Message-ID: <aqGOXnv2meGnCKzh@zenone.zhora.eu>
References: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
 <20260907-ultrarisc-dts-v2-6-5eb4c97477c5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-ultrarisc-dts-v2-6-5eb4c97477c5@ultrarisc.com>

Hi Jia,

On Mon, Sep 07, 2026 at 05:54:45PM +0800, Jia Wang via B4 Relay wrote:
> From: Jia Wang <wangjia@ultrarisc.com>
> 
> The DP1000 integrates four DesignWare APB I2C controllers. I2C1 supports
> SMBus, while I2C0, I2C2, and I2C3 support standard I2C transfers. Each
> controller has one register range and uses separate reference and APB
> interface clocks.
> 
> Add the DP1000-specific compatible string with the generic one as a
> fallback.
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Just this patch, pushed to i2c/i2c.

Thanks,
Andi
