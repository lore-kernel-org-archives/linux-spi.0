Received: from spam01.horizon.auto (spam01.horizon.auto [42.62.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26E53B42FB;
	Mon, 21 Sep 2026 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986513; cv=none; b=Gj902c9waHX5MOvj27EVmzgyADuiWKsuJq9yjEXRgRh1Gz/k42PRBBO20umxUgyze0b11Xe95L3QjKnN5EPDHemDw167dk0U5tc0DdZCBYjwxa2n4+NiIq1mbNptY8w1xuQAm6KELdUucamrqGXXLRmI6wMm2dmjq+whAbNsErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986513; c=relaxed/simple;
	bh=pmpN+0+1w1dzWGzHsryR0vhVnLvScL6Pb0G5/lASwR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtocazl0HabM5rPLA0iIi7VZWjDR3pAvOATv6CH/QKQL/czhC8Y6AmxZc4NhHINGFcqanHTUnuotLdzeYkFlgmD+cz/DJT4N/9m7cuNh/PzgbsGcenK/Gn1smN4NAXjVxAPHSBXQs8UCJ/2g4rtXxlNTrhfkPNu/K9iLciaMN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=fail (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=ex9GAswm reason="signature verification failed"; arc=none smtp.client-ip=42.62.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="ex9GAswm"
Received: from spam01.horizon.auto (localhost [127.0.0.2] (may be forged))
	by spam01.horizon.auto with ESMTP id 68L9csok069411;
	Mon, 21 Sep 2026 17:38:54 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from spam01.horizon.auto (exchange003.hobot.cc [10.69.1.10])
	by spam01.horizon.auto with ESMTPS id 68L9c19D068819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
	Mon, 21 Sep 2026 17:38:01 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from server227.horizon.auto (10.9.0.252) by exchange003.hobot.cc
 (10.69.1.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27; Mon, 21 Sep 2026
 17:38:00 +0800
From: Fei Xie <fei.xie@horizon.auto>
To: Mark Brown <broonie@kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger
	<richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Parshuram Thombare <pthombar@cadence.com>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "fei.xie"
	<fei.xie@horizon.auto>
Subject: [RFC PATCH 1/4] dt-bindings: spi: cdns,xspi: add SPI NAND compatible
Date: Mon, 21 Sep 2026 17:36:58 +0800
Message-ID: <20260921093701.1341766-2-fei.xie@horizon.auto>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921093701.1341766-1-fei.xie@horizon.auto>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange004.hobot.cc (10.9.15.112) To exchange003.hobot.cc
 (10.69.1.10)
X-DKIM-Results: exchange003.hobot.cc; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam01.horizon.auto 68L9csok069411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horizon.auto;
	s=auto; t=1789983488;
	bh=SDAOlAC7vrik7PAuqLK16OWJ52qpC4QqixrLeIZyURc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ex9GAswmCgLRF5NDcgpinB+OXxMVKNfrg34uOzVtsFC0UDg3QYk7wHesTylkTmjEw
	 YSTxxR1v/QTFwBhm/wsQNeFgxvL1lSdk1M4iFOfoBo0xYOJvQbovufHTO6640e6XZk
	 9CHBNeXA9F949GpK6dUA4EPsQAtiBZC3EqOpG8E7lLD2thCW+U71YeN1b8Ff/C0YH+
	 TyatVmcR3Wu+5QCRA0Xx9YJtKjQP7r32OX5VraB6ITNqziKwzrOP4H+ZtlRfdSQm04
	 yeqKj4sfJGjRxDHJbaSXx+kkx+e9AybrQk3Q3E1MLEsZ5Tw6fvuNankwbVU6lPmvV+
	 RlBcH76o6hWZw==

From: "fei.xie" <fei.xie@horizon.auto>

Document the Cadence XSPI controller compatible used with SPI NAND.

Signed-off-by: fei.xie <fei.xie@horizon.auto>
---
 Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index 38a5795589de2..3decf45d1b484 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -13,11 +13,12 @@ maintainers:
 description: |
   The XSPI controller allows SPI protocol communication in
   single, dual, quad or octal wire transmission modes for
-  read/write access to slaves such as SPI-NOR flash.
+  read/write access to slaves such as SPI-NOR and SPI-NAND flash.
 
 properties:
   compatible:
     enum:
+      - cdns,xspi-nand
       - cdns,xspi-nor
       - marvell,cn10-xspi-nor
 
-- 
2.34.1

