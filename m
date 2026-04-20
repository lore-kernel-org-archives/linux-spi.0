Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642FE39C008;
	Mon, 20 Apr 2026 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685561; cv=none; b=doo4MfFOkG+Skvk84WJ9fNU1aaA07LJmQ30SyEzrofJOEXVyXWR513W5BkutepIpOuGQuoGzsk4ZfP9KrAfeYjtGgm0C8EE/DLMwyM0YFgy6nUbtyBrNfJnSIlKGq5ygFd2tAQZ6uevsPJBGfkMVJXwXgxBKTQD/WdFrsm5l6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685561; c=relaxed/simple;
	bh=6+8ztpBvW0SmkNNBsYFtl+tFv50QFcSZtRGui3YpWEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRxUvp7XLmNSJ1sL0mlx7CEupFeXAVR43xf4Bbo8SpC2KTZk9nlKm3cw8U09ouke7vd6RAx6aJisQarmTKY+6cpGK4ahIKfVKglP9zCL2UgTfl9pOj3M041KTyR01BASaaMiQwUc+q4eEh6j9JcdZVkVPIhEZSXIQv0djJgF/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=u+AbkmXq; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="u+AbkmXq"
Received: from francesco-nb.. (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id E8D5C1FCF0;
	Mon, 20 Apr 2026 13:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1776685549;
	bh=QRaxp2u1Z/wpw5MjAmCSXTsAW0bnoQf2guR6EiD40n4=; h=From:To:Subject;
	b=u+AbkmXqSzN9gNkR9uVT4wmss+1qmZZ8iBvS1820IhADeJpcPqUilkbjnTYqkbJIu
	 ynWI0C9iPBbSYtC90nZ4GBedTMDbJkQixNgo5toCkymaxSq3Qjss1FViZGt1MHxTxM
	 HSQPz0rOBBxwtWahfzz0Ghd4mEw307SLaxP9mx5d4jm68eS8q609t6D0VPNhLv27Hj
	 NPz679KyX7vE+gB6f3+cGkP94QjnuPBLBfzpBFB+tyodAzkCZKNLmAQhoorgJ0JLw1
	 UZp1AYF+bphvWNEalmP8I0+1iP9mwds9WFb33mgUz7NKQKxworaYERjbkHriIrZd9D
	 foWxAkdKm7SVQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: trivial-devices: add toradex,lava-hat-spi
Date: Mon, 20 Apr 2026 13:45:35 +0200
Message-ID: <20260420114537.78160-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420114537.78160-1-francesco@dolcini.it>
References: <20260420114537.78160-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add a compatible string for the SPI loopback device present on the
Toradex LAVA HAT test fixture.

The Toradex LAVA HAT is a board used for automated hardware-in-the-loop
(HIL) testing, it provides several test-related functionalities, and
exists in multiple variants depending on the board it is mated with. The
SPI function is implemented with a loopback on the MISO/MOSI signals.

As the device can be fully described using only "compatible" and "reg",
it is appropriate to list it under trivial-devices.yaml rather than
introducing a dedicated binding.

The SPI implementation is identical across all Toradex LAVA HAT
variants, so a single compatible string is sufficient.

Link: https://lore.kernel.org/all/20260310133254.GA51497@francesco-nb/
Link: https://lore.kernel.org/all/20260316073547.11437-3-francesco@dolcini.it/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 23fd4513933a..95e78ff804af 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -519,6 +519,8 @@ properties:
           - ti,tps546d24
             # I2C Touch-Screen Controller
           - ti,tsc2003
+            # Toradex Lava Hat SPI
+          - toradex,lava-hat-spi
             # Winbond/Nuvoton H/W Monitor
           - winbond,w83793
 
-- 
2.47.3

