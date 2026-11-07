Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794037256;
	b=UakgnrM7Cw9GcbSot9M5axCj6YLs2kmTX7PNhQknX8By+Hl9+E/oVgnGhlAeD27NFcme
	 eHpHcARaK6YnztJZatl5XeYuyICan1kQ7w+BWeobock+oE4FFVN0OGuR+xj/BwE3Hixez
	 3qp0+r3hCQ8Jr8364lCrOiTJUFVP870L6CVkrktUp2UTUTRyfHyk77DEle6KM4CFcdoR8
	 JC1OvPIyFEUhYmD+0CuiywKa+lNu75r6tVGi8DMZqUV8HzrnHHMhejEkfyRPV5bvL2Stx
	 G6Nkv+kHv2MujsFs2mjQyou3F1cHhPorZd5uco1zefda0ce/E+VtwFsjtz/qfeyzbXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794037256;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dCeBIUUXD1dNPw4xzoG7xVitiNMUeqmqk0TOjv3tV3w=;
	b=VMJSfDInWSds6OZIAZA7Uis87YCZdYJhp1hdpQuCzr+hnQakC+9cw6wg/QxIPxhK9NfG
	 c+mixH2+XiUxYTecPFEfvNeZKmOaVi65y003tyd9BX0JTmS5T6E4z8npDTv+dJRac2li/
	 YZp4PAfEmLaLmibqKUVIHEJcbaz+v1YtBeVLBcaL3kVGdGxbfHXKWpaUo9H03dfSCjwcI
	 rTFVivz2xW6ivL2cjxpzQ+vjDCiMCTKoJQDz9+tNy1ESPAYpFPLNmWHMsilvcob6PR+IF
	 +/BuDorfmN3bh//m+3REfXE+xlbUgKBsC3GNGxWHz7yEGeKPggHo187wTae/W5ALnFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PkeuOKeV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07F606A32C;
	Sat,  7 Nov 2026 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PkeuOKeV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000711F0089F;
	Sat,  7 Nov 2026 07:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794037255;
	bh=dCeBIUUXD1dNPw4xzoG7xVitiNMUeqmqk0TOjv3tV3w=;
	h=From:To:Cc:Subject:Date;
	b=PkeuOKeV6xLK2OIBMgfqJr4Jjj36zNp4iOrGga/IRNfiHI/nqHJHHA+yy7Dk6s1Ur
	 4H6F6wbCTMHdQbGyPoGi9ei8fNW7IF+rgxXyAbcWafZPkMcMVIrz8ZyhGKEB6Z5aL7
	 sVoSmeYYEEwDOUNat0k1kWjtB3BQ082yUf58J8snH2U6MPeziXxs4nFxy4PaqbjI/I
	 34otBZ8B75z2zTAEy0v8R0YV/PJo4A2ZkriNMGnPpWhhNVmIyOqK9bHlOjtxaDxav6
	 ppJXiBpM/SgGLo61Ax+ZLVES1hjEZP8IoAybsxP7gyyB2fwPT/YBVNUUfwBNGijRV3
	 LTsnuR3YJryrA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Fei Xie <fei.xie@horizon.auto>
Subject: [PATCH 0/3] spi: cadence-xspi: add DMA support
Date: Sat,  7 Nov 2026 15:20:41 +0800
Message-ID: <20261107072044.17574-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.55.0
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

This series tries to improve the cadence-xspi cpu usage and potential
performance if the allocated dmaengine is powerful.

But no matter the dmaengine performance is powerful or not, the cpu
usage is reduced a lot.

For example, on a dual CA55 platform, test with looping the following
cmd:
dd if=/dev/mtd0 of=/dev/null bs=8192

Before the patch:
cpu usage is nearly 50%, which means one CA55 is full loaded with
the sdma io copy.

After the patch:
cpu usage is between 0 ~ 1%

patch1 documents the dt-binding
patch2 adds the memcpy dmaengine support 
patch3 uses writel_relaxed for cmd regs.

Jisheng Zhang (3):
  spi: dt-bindings: cdns,xspi: Add DMA properties
  spi: cadence-xspi: Support dmaengine for sdma io copy
  spi: cadence-xspi: Use writel_relaxed() for cmd regs

 .../devicetree/bindings/spi/cdns,xspi.yaml    |  13 ++
 drivers/spi/spi-cadence-xspi.c                | 149 +++++++++++++++++-
 2 files changed, 155 insertions(+), 7 deletions(-)

-- 
2.55.0

