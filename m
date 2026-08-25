Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340053DD85A;
	Tue, 25 Aug 2026 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645856; cv=none; b=NADFmHFCq/46ZOMiDa8abr9IQApW06awUX6J94CFV2hN88UpJ7yi7T3+YkHXcS2wtM3MyVuzx57vJpqzdqLQGRLE1nZKA1XBHJK8Nl4fjEWb/4tWL6gGSOFXBEDzx++SikEgncTKUhBDoV1AUSdGaK3dXEK6OIT8HKdcHzfa2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645856; c=relaxed/simple;
	bh=0hpWzS3PdWuCRi4RZYRntaKveNrBF4SmvRWcDQCtP3k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=XX5GUMvJ59OI3ShyNEblPwxcbexIgx0hXiQkpUfepHdy+7Rmtda+CIsEGDIj/4+L8H4X51QjbY+/fOEJPfnOq91SwehHH17MDO5cjnIPSYFRda4srbsRYJssotcqzTPaNAEvo98r7eeKZ6PWpqpwkaF3vplfF67BrnYAXyzYmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=LjxcuRYV; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="LjxcuRYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=jKmOi58Wr3b5f+F/9FpwPS2Jg5KNAZPky
	cymvsKAjYQ=; b=LjxcuRYV+4I6VgLE/Jg1XSPthF3bOfnPzSI04oqlaYMduwUzF
	H8i/jO0R9ovfEbi2XsZbHBJyjRe8pY/BtEmN2YDXF+juAUmxSb1aYd9N3x2krlyp
	ubwn1gA/QbIAIqFyYM9T47pPaqDX8jVUzorSsmcQJG67uc6qXm0F8on3b0=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwB3V855T41qhDABAA--.310S2;
	Tue, 25 Aug 2026 16:16:58 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 06/12] spi: dt-bindings: snps,dw-apb-ssi: Add
 compatible for UltraRISC DP1000 SoC
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
In-Reply-To: <20260824-slouchy-displace-c3f65dd5a2d1@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-6-61ab7aebe9e5@ultrarisc.com>
 <20260824-paycheck-luridness-6de48a00a262@spud>
 <20260824-slouchy-displace-c3f65dd5a2d1@spud>
Date: Tue, 25 Aug 2026 16:16:43 +0800
Message-Id: <178764580385.744215.13946157072907729813.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787645804; l=702;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=0hpWzS3PdWuCRi4RZYRntaKveNrBF4SmvRWcDQCtP3k=;
 b=Hvrsvrt29JUGTBu6KLS8IK0cY1rMPmjhr7TUcqlYA9ahnLnnFyvhsZgRwuV92ABGHtof/sETT
 LdV0zz1NV3kCa+JjpnKJscHrcMKqnVTEepOmSB0vtoCYdzm+tl+sOts
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwB3V855T41qhDABAA--.310S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1rXr4kCFy8uw13uF1kAFb_yoWxZFb_ur
	WDJFyIyw4UtFW2gw43AF4YqrZagF4kGr98X3ykXFZagr95JFWkAwnrXr1Svw13XFWYvrya
	kr1Fvw17ur1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb6kYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26rWY6Fy7MxkIecxEwVCm-w
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj4i_HU7UUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAHEWqJFPsACQAss+

On 2026-08-24 18:15 +0100, Conor Dooley wrote:
> On Mon, Aug 24, 2026 at 06:07:07PM +0100, Conor Dooley wrote:
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > pw-bot: not-applicable
> 
> And another case of being too hasty, same applies here. Please add some
> constraints for your device.
>

Thanks for the review.

In the next version, I will add DP1000-specific constraints requiring
each SPI controller to have one register range, two clocks, and the
corresponding clock names.

The num-cs property will remain optional because the native chip-select
count differs between instances and can be detected by the driver. 

> Thanks,
> Conor.

Best regards,
Jia Wang


