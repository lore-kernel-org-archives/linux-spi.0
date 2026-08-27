Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A133DB64B;
	Thu, 27 Aug 2026 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818683; cv=none; b=mU7HbzohjpyAgNfK+kwTWx3ai8SWmBosnAMXd/tfrt75K0aycHDf0eRLxDqhBlF28uUt6EVUpRS5IRXGtVD9bCeL9WJ8uAWiKyJPDp8U/rsKEHuyeDMRb4CWTwTMaqPLGPnP8xQZfxsI9lHpQ6itZIKWc3ZU3Oan2eIlxTOgCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818683; c=relaxed/simple;
	bh=5BaBaUpgbE7yZAPVZNeV57kX7ae+OLSMniMswhoEkkw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=NUjJqaotUxOj+UOsX0Ohl9yiG4WIqFp06ZVpspInUM5KueqMsX0dK/gjdoxeKmTEARR78C5lTiaof0UdO7fREn4Snr/HdzLnBdsQbNrMrcAbP1RVONJzVu4LH7waCN1dLkGyURPkGlwkZ5nIL50JqOl7S7q9FwwbY/sYpE6vTpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=qFsXo8DW; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="qFsXo8DW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=qJn7wJbUMWgChHPDDyLMAt32tsdxeqxOd
	//ZEjwgzPE=; b=qFsXo8DW3ymaL/dtk0EINHI7KkhHPMs9yCPEQqLlrzcMnVVGe
	c8QTLOmFyHsjEE1LI8F98ftxeTEGWBoA7YoeRYGyXCkXRT1qx/Gk3PwzAXH6MBoq
	9Ex+LFy66KozxrJg3/r6cCwkZioTmcAoriIgH85uCPgxKCzC2rWy6/M9HU=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwB3V86Z8o9qyloBAA--.426S2;
	Thu, 27 Aug 2026 16:17:29 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/12] dt-bindings: net: snps,dwmac: Add compatible for
 UltraRISC DP1000 SoC
From: Jia Wang <wangjia@ultrarisc.com>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
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
In-Reply-To: <178765275795.744215.4911904858473260204.b4-reply@b4>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-8-61ab7aebe9e5@ultrarisc.com>
 <20260824-bride-food-052b313e4b76@spud>
 <20260824-blimp-spirited-01365897db24@spud>
 <178765275795.744215.4911904858473260204.b4-reply@b4>
Date: Thu, 27 Aug 2026 16:17:16 +0800
Message-Id: <178781863615.2006105.6267469136684218126.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787818636; l=2733;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=5BaBaUpgbE7yZAPVZNeV57kX7ae+OLSMniMswhoEkkw=;
 b=yY3yRewGFr8detGpKXWyntfFHN5tgfDhLwzMiCHKFuFC9QP8BaO4Ra35Xa9Z5GUaqytZylF/o
 TBafhCLJFs0CdSTIHPO0SFPDgpPeTVPXfGX+6IafSoBj78xUPCINNMC
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwB3V86Z8o9qyloBAA--.426S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4DWrykZF13Zr4fWr4rXwb_yoW5Jw13pF
	yrAFWjkF47Jr13Jw1kt3WxGF1jvr4SkrW8Xr4rtr1UKF90gFnYqrsrKw15W3Z5Zr4rGFy2
	vrWUuw13J3WjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWrXVW3AwCY02Avz4vE-s
	yl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pKiifUUUUUU
	=
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAMEWqPrHsAIQAAsP

On 2026-08-25 18:12 +0800, Jia Wang wrote:
> On 2026-08-24 18:13 +0100, Conor Dooley wrote:
> > On Mon, Aug 24, 2026 at 06:09:48PM +0100, Conor Dooley wrote:
> > > On Mon, Aug 24, 2026 at 01:54:21PM +0800, Jia Wang via B4 Relay wrote:
> > > > From: Jia Wang <wangjia@ultrarisc.com>
> > > > 
> > > > Add the SoC-specific compatible string for the UltraRISC DP1000 GMAC
> > > > controller to the DesignWare MAC binding.
> > > > 
> > > > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > > 
> > > The dts may not be right, but I am also a bit concerned here.
> > > 
> > > This binding permits 100s of combinations of properties, of which only
> > > a very limited set can be correct for your device. Just adding the
> > > compatible permits all of this variation.
> > > 
> > > Please add some restrictions.
> > 
> > In fact, it's particularly bad here because you don't even restrict
> > which fallback compatibles are used, so there's no guidance on what
> > version of the IP is even in use!
> > 
> 
> I have rechecked the DTS against the hardware. The controller uses a
> DesignWare GMAC IP from the 5.20 series, with "snps,dwmac-5.20" as its
> version-specific fallback.
> 
> In the next version, I will restrict the fallback compatibles and add
> DP1000-specific constraints for its hardware resources.
> 

Following the discussion in patch 11, I will drop this patch from v2. I
will first submit the dedicated DP1000 GMAC binding and DWMAC glue driver
as a separate series, and then send v2 of this DTS series with that
dependency recorded.

> > > 
> > > pw-bot: changes-requested
> > > 
> > > Thanks,
> > > Conor.
> > >
> 
> Best regards,
> Jia Wang
>  

Best regards,
Jia Wang

> > > > ---
> > > >  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > index 2449311c6d28..2ed4564ae99d 100644
> > > > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > > @@ -119,6 +119,7 @@ properties:
> > > >          - starfive,jh7110-dwmac
> > > >          - tesla,fsd-ethqos
> > > >          - thead,th1520-gmac
> > > > +        - ultrarisc,dp1000-gmac
> > > >  
> > > >    reg:
> > > >      minItems: 1
> > > > 
> > > > -- 
> > > > 2.34.1
> > > > 
> > > > 
> > > > 
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > 
> > 
> 
> 
> 


