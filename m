Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507EC4503EA;
	Mon,  7 Sep 2026 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775106; cv=none; b=lPMrPe7z5BNm6FFWIvFGc+MZk/sJrNZFqE/usDI2LZgWwg1XE+99vw+z2KmXMivCwD6Z679k9Pr1E6oZOlxjys9EJkv9sqMMlcNvZkH0yRqf+5FpjoKjILia93ti1GcRfKTyu+NAtUiMPqjMmTFKJccodhW5Pr9jTII/1YE1Tuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775106; c=relaxed/simple;
	bh=jx8p4XoDCEmHkARz3LvR8mZjbN2RulpuK3cx8pTILlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e6dA37+OIsTbKX2u79aqLbEJk5Y6PLZdAdD1d29EaL5TGiUwQtGVky4OcKgJk+DRx7+wGMI7Py/gM6OrdvM9sQ7ySh2wfnVwaWXv42+5VgJhWuC3VLuGj3JqAek+FMUOZst2W+TjOvw0P3JPQ3QgBFIBJh4DhGEePieWRmbzJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUO6ibPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUO6ibPB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF860C2BCFA;
	Mon,  7 Sep 2026 09:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788775106;
	bh=jx8p4XoDCEmHkARz3LvR8mZjbN2RulpuK3cx8pTILlM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CUO6ibPBnRIJ6br9N1+tglZAtiCQb54P+xFBHtVbEeHzlX7CCIYEohoJJxP2aCOVF
	 rhWyA78DUPUPbC3nqZv25YVRlFygwkTF5HKV9hJ46PPgTlYc+wX3jRITtn2jRUTokB
	 1jhxo/x3/bzHyxynHeE7NA8eVcKOlxGcyFxKjs5FxfIGtDybOkxLB+8UudHOr/P1fB
	 kyUXoE5DfLyeAj5lNm6CyvJorHlvlCSZCEJN1JDlJ/iRsWMEsHA8Jseny5+0tIvPLv
	 9jtDXPQlC7drisbr1plgBltwYk02ojwsytr/REnf07GLVb3xoxh4ObJiqqag8Cnap1
	 LqrQlM99gmGKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECEDC79F89;
	Mon,  7 Sep 2026 09:58:25 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 07 Sep 2026 17:54:40 +0800
Subject: [PATCH v2 01/10] dt-bindings: vendor-prefixes: Add shenrongda
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-ultrarisc-dts-v2-1-5eb4c97477c5@ultrarisc.com>
References: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
In-Reply-To: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Jia Wang <wangjia@ultrarisc.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788775103; l=887;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=e/Kow+cCHmWBpSOP+t1oxwgy4BH4snNIyYRmuufij+E=;
 b=CR9ZckKOmzRgkynMxxjsH9rH+5MRkkuyyO5RWGoWCZBgJ9+mRHevzyy21zSGICPYhWEoToO9w
 2Kmphmkzo25Bfj0HIxEXWJH+ogZkWr5HtF7yOJTdXD+dM6ShhURhDZS
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

Add Shenzhen Rongda Computer Co., Ltd. to the vendor prefixes.

Link: http://www.shenrongda.com/
Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..e100f3993e57 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1507,6 +1507,8 @@ patternProperties:
     description: SGX Sensortech
   "^sharp,.*":
     description: Sharp Corporation
+  "^shenrongda,.*":
+    description: Shenzhen Rongda Computer Co., Ltd.
   "^shift,.*":
     description: SHIFT GmbH
   "^shimafuji,.*":

-- 
2.34.1


