Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5F63E8685;
	Tue, 25 Aug 2026 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647564; cv=none; b=N1x/cBtsrqm7WJKJ+OpkyDPsnJdfiSLSTfR/VvoHSzFJXXW20WFvVfXBzxA9k9zKXU3l28QptVhTF3P8uOK7LpSzF2P2q0b+drUZg7HIS/YBwsoxnUPTSgOhAkaQk6SPP6HqomttEcvgO3/1LpEhuYm3J1aDQg1219oAC+9TuF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647564; c=relaxed/simple;
	bh=WrJtVbLSM8GbkbAn64EbEX8lLAe/w4MbK7EWpFSxYw0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QckX1HqQ+KVMKT48AnNPQLZK6W6Cmo0ltC+tU9fhoOgxBgoqdUIkeBXN1Xakle+h9C17PNCWqScZuo8ZEKWx9G12mXBYmV91ilOyLMum+Pm0e4ioMKfUT2AAJu8oHy5lFpoEP7e75cEw5XQCvgIHwyR+AIp/5mqsKTI1dJwAES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=UJLQyy0c; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="UJLQyy0c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=Y5OfRGX5nb3vPgvkisInJ84mcEX6LHgXS
	SdtcBu0E6s=; b=UJLQyy0c/aSzoDyUBvs8rCWvLWp87i51EdbbuFNUUBKMVgsLH
	ULLWeO7vGwcTfLhPQiN9STfKz2hNBdHeZvcYMfCuX/VA1ehYO3QPzAWLJWYIUqDC
	suqelmdwWv8u381pXK3WZnHrA4UHlBhmeteSTB7waVf2RzAXjcEm0svTfk=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwCn1s05Vo1qWzEBAA--.296S2;
	Tue, 25 Aug 2026 16:45:45 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 07/12] dt-bindings: i2c: dw: Add compatible for
 UltraRISC DP1000 SoC
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
In-Reply-To: <20260824-aging-umbilical-8e68cfcea468@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-7-61ab7aebe9e5@ultrarisc.com>
 <20260824-oppressed-jogging-5b055ca274b1@spud>
 <20260824-aging-umbilical-8e68cfcea468@spud>
Date: Tue, 25 Aug 2026 16:45:31 +0800
Message-Id: <178764753153.744215.13628356455140662072.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787647531; l=854;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=WrJtVbLSM8GbkbAn64EbEX8lLAe/w4MbK7EWpFSxYw0=;
 b=h1QFd/geJ3eCnvfmWE8MCcEuTL/3WBAshWGKokJSW5v7Y342aTIZNXVyNJFCAnwmJzvTTSSz4
 VabtmlcOV21DQ+pv1nlrXSy7xqd4zrKSpl7e8nDQc1SjJu3Iax0A8mE
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwCn1s05Vo1qWzEBAA--.296S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF18Aw4Dtry5JFyxuF4rZrb_yoW3uFg_ur
	Z7Ar97AF1UZFy7Kws8AFsIy3sY9F4DWrZxGr45XF4UJ3s5Kry8Wwn2grySvw13JrW8try7
	Cr1Sva4DtrnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb6kYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
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
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRjg43UUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAHEWqJFPsACQAwsi

On 2026-08-24 18:14 +0100, Conor Dooley wrote:
> On Mon, Aug 24, 2026 at 06:07:29PM +0100, Conor Dooley wrote:
> > On Mon, Aug 24, 2026 at 01:54:20PM +0800, Jia Wang via B4 Relay wrote:
> > > From: Jia Wang <wangjia@ultrarisc.com>
> > > 
> > > Add the SoC-specific compatible string and use the generic one as fallback
> > > for the UltraRISC DP1000 I2C controller.
> > > 
> > > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > pw-bot: not-applicable
> 
> Same here, I was too hasty - please add some constraints like clocks
> being required etc.
>

Thanks for the review.

The existing schema already limits each DP1000 I2C controller to one
register range. In the next version, I will require two clocks and the
corresponding clock names.

Best regards,
Jia Wang


