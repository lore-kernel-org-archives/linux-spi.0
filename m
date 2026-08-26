Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAD535975;
	Wed, 26 Aug 2026 05:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787722307; cv=none; b=pODTcl/oCXC7S0DsbOCyq4dEUPqcxa2G0JzKZrGbkiUXwCQ+ppjmus9dMBdyiYuFcVjO11eCcEsjmj5MyaSAUe9eAo2d1fonyqh0VhVvtyarxywxl7yHwmenkbq+OKsPoFMemLZGAI3PVGsgcoTbqEvU7I/+uJu7hhZklMGUDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787722307; c=relaxed/simple;
	bh=KYYT+/PQ4xcJVd8Wmai5v72T0IDhA620QIZm052UeOc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=pzTnHybm3rXDC8wN0u+wZwUVUW3lz97GckfASHPK4a3eo3Now5FUUYGaE2zUSxCflsk/Ph2TYkBbLspgYThJQ8EMM/4uY9jjAmRwZgAAtjqlDuxkXMJL9ZdPgKt+jxh12o87tIAqghkD3RI6TvBCMskISm0CdjsHvPa7017lBDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=R2Jl4SJC; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="R2Jl4SJC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=Qn1K5uZcsjIXg5afIwVEwPEUZMEcJXFBf
	xRn3HuhEcM=; b=R2Jl4SJCzKDArYGiy4rCDXjo0P9VUuAaKL6vbdPLl+cVY6evq
	llUgG+RQePIqOYJo8Cdc2IsurArNLyODjRrqe2dPFjinC7du8A5Tbf9abbiCbCzl
	IdTMS92ZQZcdhSPGKTa4fLUFei7p4asIjevCHQOwWDQ9tNktwsldTboYJ8=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwCn1s0teo5qc04BAA--.336S2;
	Wed, 26 Aug 2026 13:31:26 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 09/12] dt-bindings: dma: snps,dw-axi-dmac: Add
 UltraRISC DP1000 compatible
From: Jia Wang <wangjia@ultrarisc.com>
To: Conor Dooley <conor@kernel.org>
Cc: wangjia@ultrarisc.com, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org, 
 netdev@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260824-throat-arguably-779a75446a81@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-9-61ab7aebe9e5@ultrarisc.com>
 <20260824-moneywise-magician-50d8e6ff79ea@spud>
 <20260824-throat-arguably-779a75446a81@spud>
Date: Wed, 26 Aug 2026 13:31:12 +0800
Message-Id: <178772227234.2049162.4715674009458678447.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787722272; l=492;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=KYYT+/PQ4xcJVd8Wmai5v72T0IDhA620QIZm052UeOc=;
 b=ZF4bncxtlyzP5EpRsjS7n7l91oiZzzea5cJ3tGDPIYOG5k7bhC2NAKb/MHRfByrSQ9QA2oNC0
 96SjQtEw5x1Co0DN6ydYssZfQRyPQVOf7uP3tEi0o2lguU/blniQRpL
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwCn1s0teo5qc04BAA--.336S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYX7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aV
	CY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAqzxv26x
	kF7I0En4kS14v26rWY6Fy7MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU
	=
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQALEWqOWvsABAABsb

On 2026-08-24 18:11 +0100, Conor Dooley wrote:
> On Mon, Aug 24, 2026 at 06:03:21PM +0100, Conor Dooley wrote:
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > pw-bot: not-applicable
> 
> Actually no, please add constraints for your device.

In the next version, I will add DP1000-specific constraints for the
controller resources and hardware configuration, including its channel
and AXI master counts, data width, and per-channel properties.

Best regards,
Jia Wang


