Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDFE37A834;
	Thu, 27 Aug 2026 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787797229; cv=none; b=Ohv3TPBVKS4hzhAK+IhCYgDHYOssIPmjkTcBa+a8a/t6FJqBZjTpYiwl9hVbg4zriJgs1u37f3s0GWzInCfxAyFAfrUIsvulSIIvJ7Z7zvBkLRsfV/jYpkDyUtudARv8IU4l4lvxr/COn70EVFmnKwfVYUYUwB+pIY/EI5eiBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787797229; c=relaxed/simple;
	bh=5OqQzlbqYVr45HuP8CzJ8xK1/ImXnbxc1gUkVx1yUQ8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=B7QKwq/pZKJFvZBPpqeLx6PkKJFGYgXfoMDE5CcrbawZ/w8WEGAdxql+XhzHx+57mah7Pcy5seyUZahqicySmb0oc7X3MawtElfQGv86TM6Z1XExSGL7N+R5i1txhvAX2ju+2CMjZbbubgIqEbJcDNV+E1t2XfHPdQQlt2r9UmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=TY2z6cPv; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="TY2z6cPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=w0EtslnP22yBs3lOjrkCV+37dpn1xRuqk
	llSuzAy1I0=; b=TY2z6cPvsxabnuBwCtD79vWosmMoAH64x/bTx6yM5WNZY925K
	tl7vL0ZviE4zkOgeIb2zeGGKrl6GlU9i+B8D00CIbbAbR1oh4NG6WpXwZ83AnY0N
	jzKYvQMjNZgjMef2oKGiTm8RRXrucabW3P2evT9MlUjiD7Bu5SdjQg3Oag=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwB3V87Nno9qO1gBAA--.420S2;
	Thu, 27 Aug 2026 10:19:57 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 11/12] riscv: dts: ultrarisc: Add Shenzhen Rongda M0
 board device tree
From: Jia Wang <wangjia@ultrarisc.com>
To: Andrew Lunn <andrew@lunn.ch>
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
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org, 
 dmaengine@vger.kernel.org
In-Reply-To: <d93868e7-00c7-4251-9b23-8b3ed0535185@lunn.ch>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-11-61ab7aebe9e5@ultrarisc.com>
 <d93868e7-00c7-4251-9b23-8b3ed0535185@lunn.ch>
Date: Thu, 27 Aug 2026 10:19:43 +0800
Message-Id: <178779718359.1423015.16616466921659081322.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787797183; l=664;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=5OqQzlbqYVr45HuP8CzJ8xK1/ImXnbxc1gUkVx1yUQ8=;
 b=yHT5l7woiE13ali+aRwkhOVLsiVN7IAmPwkjvoIIymR9DjgUi8sK31AQOcIJn4H0uEettZWdH
 43IbNZ6ebeQDn1/w+88/c3jZgTi80yZISTvM4ZaeSb9AU293MCOB4aG
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwB3V87Nno9qO1gBAA--.420S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYX7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aV
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
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAMEWqOWvsALAABs0

On 2026-08-24 15:02 +0200, Andrew Lunn wrote:
> > +&ethernet {
> > +	phy-handle = <&phy0>;
> > +	/*
> > +	 * YT8531 RGMII timing on this board requires no PHY internal delays.
> 
> Please extend this sentence with an explanation why it needs no delay?
> 
> There are times this is correct, but it is also mostly wrong. Without
> an explanation, i cannot say if this is correct or not.
> 

Thanks for the review.

The DP1000 SoC integration provides the required TX and RX RGMII clock
skew, so enabling the YT8531 internal delays would apply the delay twice.

I will clarify this in the next version.

>    Andrew
> 

Best regards,
Jia Wang


