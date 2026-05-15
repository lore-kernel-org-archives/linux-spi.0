Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FA3E0C40;
	Fri, 15 May 2026 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877339; cv=none; b=Isd4nHNVtbfWqA+T0f3OIR+L616k8r41hZGzAypv6aTinBNkkltgegiqTypZVArEXX0tDOC/CQchzpgBtoexh9UuKiuYfxxNC4nLjZ5jwA8wGo61BnAStRgI8fZ+zBqvYdHyPOmK9rz4u9wpx4J590AC+LjF9UijYAmO9A8X+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877339; c=relaxed/simple;
	bh=DwSirxViRHRCNr2ITXT4CFKU6ZcViHapgtNOdXk1RJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DygiB4hifqrUQpFjmn5QPnr8snCgAY55V3PVCbUkY4LekajEifl9uvfMiFryWSb51jnuApHqrL9dcWL29+AnsiKMmYh33+cF786uk8g6ftrKQkTNMaTecQHJwc+/gDQ/BmgwZ5UT7PNivjK8HoPcIwnHZ1STG17rO685B3+hM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAUqKP6f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAUqKP6f"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2009AC2BCC7;
	Fri, 15 May 2026 20:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778877339;
	bh=DwSirxViRHRCNr2ITXT4CFKU6ZcViHapgtNOdXk1RJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CAUqKP6fWlaz0n0w3K8JHNrxmf3sSkKi2+V6wq3OLA8Dw+jvUu0stOcZmloGW1WRY
	 QLQJUiNdMjdtWYuELfW9Xhx4hRV/neLAw60OoqU7hJOmsUqn+nUL/FqlHFdFCJmG6G
	 JdMTT/uHYKUSmGCXHfpNQgiN9yQQXajwkpd/ggZuYyqhXSCsHOl679mwwLTlzzZOj9
	 nIqQAuNbbxdYRCuyodZ/AlPUxEyy5NBkgQVB12HUGmtTw91eJnTV7XBySVk9KPmlaJ
	 jUR8LdVNALc394HeK9Z3b0CG1IdyDFiSxqTQwbbx9Za5y4dhOdX5Hd/rrSMFItcjFi
	 wTkyLlaBFb4qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F37FCD4F3C;
	Fri, 15 May 2026 20:35:39 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Fri, 15 May 2026 15:35:27 -0500
Subject: [PATCH 1/3] spi: dt-bindings: tegra: Support IOMMU property for
 Tegra194 QSPI
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-tegra194-qspi-iommu-v1-1-57dfb63cd3d6@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778877338; l=874;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Ctj0vZsUccyi2YsBh7ZigPaDzSk51BPiMWEp4e5pg7E=;
 b=ETf8WHKvOVF54Tby8QTiO3pg3xFXtE0sSvz3/FUu76xcn4Z8AsBBghTdraxufAwXpLT7mPe5+
 wbsgXEVb4pRBNfEbhq7ojKO8P1H0my5U+5/vLXBp/EMMdSJ/SZjma+P
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This is supported via an external dma controller

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 909c204b8adf81..62233eb3101aeb 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -78,7 +78,9 @@ allOf:
         compatible:
           not:
             contains:
-              const: nvidia,tegra234-qspi
+              enum:
+                - nvidia,tegra194-qspi
+                - nvidia,tegra234-qspi
     then:
       properties:
         iommus: false

-- 
2.53.0


