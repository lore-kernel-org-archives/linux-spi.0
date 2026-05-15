Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FBD389DF0;
	Fri, 15 May 2026 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877339; cv=none; b=eYShz8MfwTqwneQo9qHT4uoq9B38u8LFigYotDAlgwRhWoXOyjq/y7pmjYXUVSg3Gob+4nQNuD4fGDKL/zHB4e/moiA/e0MHOWPf3IzJJOhTVcHfTefNQDqT2D76kKZer3gr0OqdQPVwTUSr1h9msWLBlD7vzUTqgcoDOMKdKuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877339; c=relaxed/simple;
	bh=xu8k2Tny0UUoXY7gTFrIaGYWdgApJVPoczjyUYNo0Xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFMfqqccpNVkQm/jUOnZM4OiLCkCIEMUt06bEvQz5el1H0G1hn0lgMW7gEH7bKlyGEw0WW/RO4Qk7KDcvHPqVUgDrnPUsQ8KCDLjmiMZK3zVJIJfXM0U8zVT6amx9Xb+4z8qkXtq6tw4a51MJE73nJiApScZclrNGq3rPvWDsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnwTTb8Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnwTTb8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32A0BC2BCB3;
	Fri, 15 May 2026 20:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778877339;
	bh=xu8k2Tny0UUoXY7gTFrIaGYWdgApJVPoczjyUYNo0Xs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OnwTTb8ZgJYExEWVeUh8fKu5PEZcKMT0FRMb20A3PrfowlC1DbkdHqfOCYUtMBSOk
	 qPfcavPuh3yQBal2LpxX7pAIcus1J8KBI5ODB29yKQmV0VwG/Niva8+mqHSzYoLuhr
	 2yN+XJNPNGRF58A7qBf+9om9uaatcXfyjSmJ1AQdxTprgREAFRumJfyx6cY+5iyDvd
	 gImXMfMvcfPFN4Rnj+nh39JgF+YPXJsig6+AtUV2yQDxlVE5LqIXkfFTv2fIGKIq8h
	 WRzeAzVKDV5U2NI8VKnfux/8tAzHLy4dPJtPqK9gvWZwK4rV3Fe8k0Wck+9/XUMu1Z
	 Z7ehrRgaU/vfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22449CD4F46;
	Fri, 15 May 2026 20:35:39 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Fri, 15 May 2026 15:35:28 -0500
Subject: [PATCH 2/3] spi: dt-bindings: tegra: Support dma-coherent property
 for QSPI
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-tegra194-qspi-iommu-v1-2-57dfb63cd3d6@gmail.com>
References: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
In-Reply-To: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778877338; l=743;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=m/PPegEGAyaU6wZWkIdDWHDa9uH5hiVYhCovCoKJA0Y=;
 b=/RnOs3EhWYLrIOMwj4LQr3tSmjiZ8qHJBwbDhpw4ZOm+ZZBuMm7/JVKaQ5NNnJ1gAnf7JJwEC
 5FVOPNVa/pzDEF726SKKer/rlKGsQDi3FM1+AtVICt8VxycNlLYfNYx
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

DMA coherency is supported by at least the Tegra194 and Tegra234
controllers.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 62233eb3101aeb..433bca02f86b13 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -47,6 +47,8 @@ properties:
   iommus:
     maxItems: 1
 
+  dma-coherent: true
+
 patternProperties:
   "@[0-9a-f]+$":
     type: object

-- 
2.53.0


