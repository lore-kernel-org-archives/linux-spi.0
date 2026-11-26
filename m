Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795651649;
	b=BuscN+DtXInxzbAn86MOOCIgmSZIgtc5HfSiy6Qr9YO04MpJmuZHnaWinX+gVlOli0UC
	 eLW7wfl/Z4VThvYRLEFM/Q3C+hfR117IFoEi8r93j4NR27EyZqghX70/jwyt39pileDHU
	 mC4TmBusFAzj88F7e1QjC0BfSB8xOaMFi6fRIlQ9R4ddpL0SZGj1UNPzmh1CkYtmtXC00
	 7MA2nE5lEPn06tRV8CiAGTSilpSM5SCxZF7DNtoMqeBhtmOPKliMwrT5TpZ1R56jqMHrn
	 XfJL/hUoNSx0zHV3V7NNwLv+QAEo7tmMhEduvCH94SZiJCMBkodPcmOeIej5Kl7z7cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651649;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ObL7qkms1Lrjmbt5Lzf0B1k2VOPxe5HsW6sjzBjmexA=;
	b=xS4NW8AixbrtJW5EUWBV/qZ3evPVex3Jn0x/6W0bLZG2xy3eY490caUWyPY1gIJwaIYw
	 cl2xKB3GQccSXmeZd1qrjEuUUlig96L308G0kmY6ZisSJGjiQSUXN/k214G1/Tv78yVvh
	 ogsAIFhygBXn0EQioAE27+qtnq03P7OWkTYkApULnI/n3YQOIXsUI3g9dMLcaE12K2s9V
	 qBcVqRWagAq0gTa92KpMA5CRZA6VVsxDTdNHF4AiSbi29WO0Klmt0oTK1IJVcTNZT+Wh5
	 YAlzbs7Ak09ByEkyxUqc4eYtQRGiGIeGS7CCN9hsw/IMq0jPZm5SwNymJIYvXuT9Wwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HdbvsjmF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56986606A681;
	Thu, 26 Nov 2026 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HdbvsjmF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795651649;
	b=OLBFJqnyiAq4VZP7MzWQXFOnE7QN3V7nqHRe+RSx7/I1V28vRCPQ5tAPBXdRzq2Jv8qd
	 dpSoTuM8axa77fbjVK4sNdrhLL/nLl2D5oMGt4jRhFI3acNrOcXB4iBOjce3v2OJxdceE
	 MqU7fiIOKBXMwz9k78AwdfogVOLHbDMhfmQFyXmDpyQxQXvK1V8WoyNeQnSWyn2w7Kd8m
	 HPt/C7U1HZX+IEVZNcwmpeA9V9MbMLzBImroqbF2hpq7D2qConBwEyDdYikeQcF5CUS7c
	 xgkpUg5LzCbClXkkFakRCElnz9sjvH0U8RPj1gG7XOf6JNW1TC6y8RtKi6PFSGtnZiw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795651649;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ObL7qkms1Lrjmbt5Lzf0B1k2VOPxe5HsW6sjzBjmexA=;
	b=vQU6J6kHBhnFvUYwKLYhojMFcPSgLIldnlesDmuY5iXwqGwoOuX+xEtOV5+i/mTjDBuy
	 T9J5+Rv3xclEfxjdYJY1zVazk1aCztZYZdqVNYXhBBuE+uMiPvylCdYKLq3v3eGrdK+2f
	 6937/8a1gWjd3eQCQDLBJAna4qXM8D4WbXC2JjFTTO2+/F4hzXM62V0Gk59SAUKuwg/Ea
	 SUiiEAiXRRxkq5myGTkAuYBjl6QCG+2ubW0bSyrSxbNQSSFsRio2x25aRSSRfpA2RtSRl
	 k8k1KLwOUUKMcXQazEe/2Ze8KL5RDmwnDV6ZhGutSkoq7nZXwpoSwyz7DhRRXfO1F8A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AE21F1F000CA;
	Thu, 26 Nov 2026 00:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795651649;
	bh=ObL7qkms1Lrjmbt5Lzf0B1k2VOPxe5HsW6sjzBjmexA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=HdbvsjmFLf2ieillUX2Gq8I6S3IrI0jfvuEX3uciFwnDvK0xNhq/IOTOSOJb2eCug
	 fzc+sE5O2UtVipTuPCTlqXiiocvq14H/T6dC96c1wJ/QGu3p3ilx/KlUEWSKi2Kl/p
	 Vv7ayBkbcY4MgcXbzKBcxK5GUofboi7iEnTG8TWrprTGwMQrBNuHgyprwkS3RdDIyL
	 Qo2F61x1Mm1zxJyaEJ1NgCZW8Au2xN08TcCOBJFaGYWsjaxmkQ8IwcSFkYc82aWuno
	 0TiQYJT3tLJFLbjfQZCc+lqofBL1i+Miluy5hyCqtlBWMbIeR0ET4bBA6wMsO522aS
	 ZpsHnuY850ebw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7F2DA4D0F6;
	Thu, 26 Nov 2026 00:07:12 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 broonie@kernel.org
Cc: flora.fu@mediatek.com, amergnat@baylibre.com, leilk.liu@mediatek.com, 
 me@adomerle.pw, devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: spi: mediatek,spi-mt65xx: Add
 compatible for MT6789
Date: Thu, 26 Nov 2026 00:07:14 +0000
Message-Id: <20261126000711.16163-4-iasnezhkov@gmail.com>
In-Reply-To: <20261126000711.16163-1-iasnezhkov@gmail.com>
References: <20261126000711.16163-1-iasnezhkov@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795651631; l=1154;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=V05m+8yF0Wxx4QXUx+4PM5IgqsffZt/x6aXxrp5Z1ew=;
 b=FlKE24zOWLr4KgLWaciPdna+6VFGJLGSaPgHPx8jDrL2p+sV1qICbgSAYGSd/ewv0RmWAriEH
 w16ZRglq/4sDeewna2FSUy3uzxmclhf8kcOoHvt8aPELZY6jzHOJ99p
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com

From: Arseniy Velikanov <me@adomerle.pw>

Add the SPI controller compatible for the MediaTek MT6789 SoC with
mediatek,mt6893-spi as its fallback compatible, addressing v1 review
feedback that MT6789 SPI is programming-model compatible with MT6893
without requiring a driver change.

Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
 .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index 3bf3eb1..7d82369 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -39,6 +39,10 @@ properties:
               - mediatek,mt7988-spi-single
               - mediatek,mt8188-spi-ipm
           - const: mediatek,spi-ipm
+      - items:
+          - enum:
+              - mediatek,mt6789-spi
+          - const: mediatek,mt6893-spi
       - items:
           - enum:
               - mediatek,mt8196-spi
-- 
2.54.0 (Apple Git-157)



