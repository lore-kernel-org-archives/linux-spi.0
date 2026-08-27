Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC2C2D0C7E;
	Thu, 27 Aug 2026 04:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806533; cv=none; b=QUiMsgzcS5HQr0JA+zHzl3YzuxAQd2mjk9n7OGm36MM4sOrcyPUf9Qw4+FsthLoJY1/Btovi8AMlc3Iv7PgQ6Fc/Hjqu8biCfmDdMzx4DLp0S83XC8tPF/9fg9FuH3am2gA6SztQmeBrW3+g6Y8AApkOX9/rq+jfzmJOInuVzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806533; c=relaxed/simple;
	bh=90tsSyDLBX0Cz3GrAAWW/LutBnaIZV2qndroWkPLluk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=BHsr3zs0XtsVQsvcXph1w8ivNnD9Wu4pQsG6yoieYz3Kyolm8U2b4SUOjByWF4Gk0J+ii6WcaxXHTe7v/d7Gh3YVOwJxh/hl1ln49RxgC5FxdNrOAydFkJ2dO570h2MHE4ituHg51XrFXqzqgAfSy9qXnLmn3qTEuu4m3gB0LQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=Wq9KEZpQ; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="Wq9KEZpQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=/vtHaHrw6VqvnjqtqCEIU3jfkZsq9QIio
	bIZuMjLspc=; b=Wq9KEZpQYp4DqLt0IQiwZVH6ErO3Mj9uNJEdMLRLW5R4aaBvo
	mdqXox0mVyR8F//CeNYbjrJgI50P9tMTxirp5DjxFdHUHpQzwyWbOPVOgTZT+sko
	kAzuemtAEl7tFCpZF7K1WQntCHMLsAe0fQkOKSvedgpjUVCqEnk3pD8Po8=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwCXxs0rw49qQFkBAA--.434S2;
	Thu, 27 Aug 2026 12:55:07 +0800 (CST)
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
Cc: Jia Wang <wangjia@ultrarisc.com>, Rob Herring <robh@kernel.org>, 
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
In-Reply-To: <db174bcd-3b21-464f-ab56-439d65e2a064@lunn.ch>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-11-61ab7aebe9e5@ultrarisc.com>
 <d93868e7-00c7-4251-9b23-8b3ed0535185@lunn.ch>
 <178779718359.1423015.16616466921659081322.b4-reply@b4>
 <db174bcd-3b21-464f-ab56-439d65e2a064@lunn.ch>
Date: Thu, 27 Aug 2026 12:54:53 +0800
Message-Id: <178780649385.1608658.14465948095163858225.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787806494; l=2092;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=90tsSyDLBX0Cz3GrAAWW/LutBnaIZV2qndroWkPLluk=;
 b=UNtZghpp8iIE5tWCpGGJhUnNUY4ikL3VrrbizN1JtzpGTGYZP4oq9qfaPCSasOkkUmdlClkG4
 lScRZMeQkt/DZlkXjkc0Jp0wzBPkf16XErs6jp0+2r+I1LEU+z1NUua
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwCXxs0rw49qQFkBAA--.434S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ury8XFyktw4fXryxKF4xtFb_yoW8Zrykpa
	y5G3W7tFZ8tr4xCFn29w4IqasI9ayxGr1jqr1kJ34rA3Z8KF1rtr1Ig3yUuasrGrs5XF1j
	9ay0qa9xGan0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Wrv_ZF1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRJMa0UUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAMEWqPrHsABwAAsp

On 2026-08-27 04:46 +0200, Andrew Lunn wrote:
> On Thu, Aug 27, 2026 at 10:19:43AM +0800, Jia Wang wrote:
> > On 2026-08-24 15:02 +0200, Andrew Lunn wrote:
> > > > +&ethernet {
> > > > +	phy-handle = <&phy0>;
> > > > +	/*
> > > > +	 * YT8531 RGMII timing on this board requires no PHY internal delays.
> > > 
> > > Please extend this sentence with an explanation why it needs no delay?
> > > 
> > > There are times this is correct, but it is also mostly wrong. Without
> > > an explanation, i cannot say if this is correct or not.
> > > 
> > 
> > Thanks for the review.
> > 
> > The DP1000 SoC integration provides the required TX and RX RGMII clock
> > skew, so enabling the YT8531 internal delays would apply the delay twice.
> 
> Please take a read of
> 
> https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287
> 
> You need to make the MAC driver do the correct thing:
> 
> # There are a small number of cases where the MAC has hard coded
> # delays which cannot be disabled. The 'phy-mode' only describes the
> # PCB.  The inability to disable the delays in the MAC does not change
> # the meaning of 'phy-mode'. It does however mean that a 'phy-mode' of
> # 'rgmii' is now invalid, it cannot be supported, since both the PCB
> # and the MAC and PHY adding delays cannot result in a functional
> # link. Thus the MAC should report a fatal error for any modes which
> # cannot be supported. When the MAC implements the delay, it must
> # ensure that the PHY does not also implement the same delay. So it
> # must modify the phy-mode it passes to the PHY, removing the delay it
> # has added. Failure to remove the delay will result in a
> # non-functioning link.
> 

Thanks for the clarification.

I will update the DTS to use "rgmii-id" and add a small DP1000 stmmac
glue driver. The driver will account for the fixed TX and RX MAC delays
using phy_fix_phy_mode_for_mac_delays(), reject unsupported modes, and
pass "rgmii" to the PHY.

>     Andrew
> 

Best regards,
Jia Wang


