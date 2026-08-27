Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FE4369985;
	Thu, 27 Aug 2026 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787797474; cv=none; b=vBH+FO+sFxNh8CsMlE6t6lUcQbqk3eCYNIvfLhA7Dtq6ot8QN6o7OLEh+cOQ6jzlVTIicjbx4EoXQdnOLi/HI8Rza0vSAr2pKoJYwFCcY12d9fFzvG2NE4mzXBKEwBRxCY0Giqk6DkMeYd76s5oHafbUAEV6+dzA3QN+qBZXhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787797474; c=relaxed/simple;
	bh=rOuyynZ/7DqdiTSKwcajrSxvr6DHN0X0uUwNMTAjYXI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ggvbLXpcO8lC7clxAuHUPpkkmN38esdkWSPyORe2KT1KAy0K1hj+JyGdNKoR5fdwJ0sNb8/pPIlPVXYg0LVYopMFNII+tOCwBkq7zCjuTcIW/eiU9DVvv99vMrq2ipniUGmLKqN29LHSBM4BFTIKjKMXlwmL0eso+9Q9jmQ2h3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=VcbfzGWz; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="VcbfzGWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=uTTBr9BYADGrDlvaR72tqo6yyeyYDRVT8
	0MDKdlK22s=; b=VcbfzGWzuQq/vKxPGS7W+rYnq6L+W+vsI79O46UChDKj5ID1d
	GPlv5LxprXMM9c3Q4yFQg0VJEzwz9drpiTYeGg/pXfne+IWw/1br7AFL+GKKQyAo
	qVwyBNn7DzHE9mnb5MN33EHFMoUCW5OimmdRvo4/sVyz+87LpCiDQP3C8o=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwBHds3Wn49qTFgBAA--.47S2;
	Thu, 27 Aug 2026 10:24:23 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 12/12] riscv: dts: ultrarisc: Add Milk-V Titan board
 device tree
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
In-Reply-To: <26430c94-95ee-42a1-bfda-89e0ce24f194@lunn.ch>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-12-61ab7aebe9e5@ultrarisc.com>
 <26430c94-95ee-42a1-bfda-89e0ce24f194@lunn.ch>
Date: Thu, 27 Aug 2026 10:24:09 +0800
Message-Id: <178779744933.1423015.12629307530730828329.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787797449; l=1039;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=rOuyynZ/7DqdiTSKwcajrSxvr6DHN0X0uUwNMTAjYXI=;
 b=fYna5w+fcRvxVgwKTCOlXsgUCDi1WRMO6pggwzsx88z2rGTPBS4y85OGFAC10EDrS0PYQVLZa
 DlYCSEh0o/DD/oIh3qDZLjir9hPrF9rkrYRGHRChc3tLprTz2v5CEUs
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwBHds3Wn49qTFgBAA--.47S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw43WFWkJFyDKr4rZr4fKrg_yoWDWFg_uF
	ZFqF18C3s8AayDAa13tF43Aay3J3Z5AFykA348trWSvr9FyrWkXFykXw1Iv3ZrXr12kr15
	JwnxZrZakwnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWrXVW3AwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRVOJ5UUUUU=
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAMEWqOWvsALAAEsx

On 2026-08-24 15:06 +0200, Andrew Lunn wrote:
> > +&ethernet {
> > +	phy-handle = <&phy0>;
> > +	/*
> > +	 * RTL8211F: board timing uses PHY strap delays; keep plain "rgmii".
> > +	 * Enabling PHY internal delays via "rgmii-id" breaks Ethernet traffic.
> 
> This actually indicates something is wrong.
> 
> When passed PHY_INTERFACE_MODE_RGMII, the PHY driver should change the
> PHY to not add delays, overriding the strapping.
> 
> Given my previous comment, you need to spend some time understanding
> what is going on here. Something is not correct.
> 
> https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287
> 

Thanks for pointing this out. You are right that the RTL8211F driver
disables its internal delays for "rgmii", so the strap-delay explanation
was incorrect.

The same fixed DP1000 TX and RX RGMII clock skew described in my M0 reply
applies here. I will correct the comment in the next version.

> 	Andrew
> 

Best regards,
Jia Wang


