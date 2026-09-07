Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631C450409;
	Mon,  7 Sep 2026 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775106; cv=none; b=c8Jg30jOQIPXqwdNBrIFucDHsAlZmZz2cZLD2WG9pVdlO3QsJQWfNXz0teDRv6ZZtd4aWWTGPZFnCbaU0fhJ0tRyJvYoRJcgitbTi4swZ/pBGOpoeGHVz6LMMr9Wm4XKuRtRI2R93iSCPrwrRG3EWDtIHPhxxfM1FGUOq2SjyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775106; c=relaxed/simple;
	bh=UH/9tXjtdEDMWx49kupssMJS31sfLv7FO0+FnXYwDuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNQCl/pwsa2qvbheu/Cky5XIavLu+2AvyT5WMPMrHnl/+7xh+1PgvlnQMN2rd0eHqPqrfdYUjmNSMlfZ7lajtImF/AkakXVVvbmlxeLqUtD4SLOt55OFBVhU9SztqaYKuOmbmvqpD90q5HVmFBrUYj5vyMr9oZ6byDnGp5v81Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOImjtQZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOImjtQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1836C2BCFD;
	Mon,  7 Sep 2026 09:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788775106;
	bh=UH/9tXjtdEDMWx49kupssMJS31sfLv7FO0+FnXYwDuo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lOImjtQZiTPNgO4Q4752FBzubu4AgFranaYsBLYxqgQ/B8Mq28asI1WZxZ3Gms1fb
	 Vnh9kTHcIRY99yjryZomLF9Jin+IsU1yCfpiybxqCb7idbAGx0ZXgmwp5CCYRJUWCj
	 /FzWKbdCRWiYK2YGCbsCYfV892Tlu6CYIoY5niTUJ3ZZoHhyma7HTO7m+Ftnfb9irb
	 xMlh1PjHf3ObD7nDJHrfoEzN9gLdIJErMB1A4HRatunp5RyQqj5foCUVshXnnNAr2H
	 5r08lNQRC79zt//jjiKdK3erv/vA06Qh/gT35a4sjsHxgDoVJTyqfwikH8Z+9uBJKi
	 5gdpWOMNAN57g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D256FC79F9F;
	Mon,  7 Sep 2026 09:58:25 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 07 Sep 2026 17:54:41 +0800
Subject: [PATCH v2 02/10] dt-bindings: riscv: cpus: Add UltraRISC CP100
 compatible
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-ultrarisc-dts-v2-2-5eb4c97477c5@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788775103; l=804;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=4TAyfkBcv/s6Kdb5vlK3fVOCoBkGrwHfHTtS6V/To4w=;
 b=04IAVKJmYQ28f7nAGz0dHm9GO1Vgegc5GElVxIZXoj7fRUuKnABRoMqHm7KL3iCfc2B9IICMH
 gryMZxqSeskCmFYBsg07DsCpnu0Sg1xVQaOwwDeG2iF1Nf/RU9+lFN0
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

Document the UltraRISC CP100 CPU compatible.

The CP100 CPU is used in the UltraRISC DP1000 SoC.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 0da219ae6769..85adf72899c9 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -67,6 +67,7 @@ properties:
               - thead,c908
               - thead,c910
               - thead,c920
+              - ultrarisc,cp100
           - const: riscv
       - items:
           - enum:

-- 
2.34.1


