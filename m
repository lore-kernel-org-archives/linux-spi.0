Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795662618;
	b=Vefo1EnzstllpyertgPp+llEeG6mX5A4UvzaxyvsGgcmk97cXW+ZvZU48rdL+yZkYjoy
	 0DhT/oUsZ6q9D8Zrkhah4E7EgmXlqrchb6PkozU8h6M4BT1zJJPZ/H4NNfBaBtUQKV+xD
	 WDAommeX+X9DzJPzU16srNIYeplXfQKbJDmtTiEaoPMd3ssboQYdp+x010+VLIz+0c8+y
	 PgrCuyRUMP8QMQHlStLg4QtGZpqL20QNN4RDdgONU7nLw67L11jq3aNfXmNJi5E5COXia
	 ahcnYE3CVk8cXzyT1y1CsSggTN+eaGVjVhGSCt+MIr/RUP++3UY6Z5iVNkrdOI4DlcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662618;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ObL7qkms1Lrjmbt5Lzf0B1k2VOPxe5HsW6sjzBjmexA=;
	b=0thxuYejSvPnEoHESCnX+qUFixSqczmQYq3XxWp0DviAsE3Be0GNoW1WBf2xDmbd0aXl
	 rqNdBuPAzSu5GNWOnYhhevaxnEvshC4jaaiBGh0XpEUeZtzzUY9EXpQehS5Ah1aVOa+zM
	 JOMWl0Sba0pyLTibW4/2GYHDUurUmcChCUEoMJaD2t8QEvYPmos9B1LQNd+40hPYIvyBL
	 YGPfpFKSS3ItZa4gzl5fRs6xfoa6gI513IjaEqrbjRj3mYIzp61hptQOOKBQgfs9wHyPD
	 YOmRIKUHFylNvTwZx05qxVzCvXp9oVclsiAG/4jHGw8C37dyhOFdG+dINq32Qd5cXMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I43RLY3e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA445606A321;
	Thu, 26 Nov 2026 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I43RLY3e
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795662617;
	b=dtWNbakKg0F/ii1z6qWYkEeyD/Qk5v6YHXsxx7UDPu+vo8ArRWM62AU+G0Ag1miny3RE
	 8NZRwStwoHRVYxAtLQEylJqP7xVoLBGtM0dmFKqjPdrrCgOGKigPZvzqYiuI+8DA1UU3Q
	 PZpGLmbP6xhnUObxdgeqrJi+6eZCVKsQ5ZKuDBW1Vv7/aU2cbgF9kYpf64sGDdyd2HfSM
	 vjQa7GBEjuL9Z7iOEzmULVbqtW9n1+3QuN/vO3tIWT6ZU2xfgpVABs3/BmrSsrv79w4n7
	 WSmbsCmGlDgIdWZVCRMg9QE0zElxWZb0W8bf2f5lqVCSvw/w+QFJQrc0fgGL+Bs65kg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795662617;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ObL7qkms1Lrjmbt5Lzf0B1k2VOPxe5HsW6sjzBjmexA=;
	b=g/c3LUJRa8DKhruPLsW4V+8RVqWvJSOGoSY1E0E9LflI7LOqEdbfz5B00jLj14vhdym9
	 Pj4fXH6hU58nbIy39G8P7MC2nzdmztP6v0Pw0+F76IbvO0rlNsTxfUiUMEpGi2nSfqqGP
	 Vo/r4H25F7llAI1vkkzmLrEDpg9aPAOW5Vd8IByNBC87JyCoI8hKqZJoeOIa0APHhVHpy
	 VoQEHZrbB2pjFAh8jwyZLdQfwXPD1Xcf02XEtcmqwlg9vUw2SAlgW5ZPUISHKrRK2S6ZX
	 obJc29cIPQEt/AXceaPIH7gMLo0EIynP4sEiWK2ZJ6SkRLLmgzJ98SnMIEju1uP+ORA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AB6A51F000D0;
	Thu, 26 Nov 2026 03:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795662617;
	bh=ObL7qkms1Lrjmbt5Lzf0B1k2VOPxe5HsW6sjzBjmexA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=I43RLY3e0Q+FFjcOTpoJO5GeG/DdbIkq4rOOZ39tJG5jjDTHCpOD88zvAxqGSxmYy
	 3jj7139C72fTkc/6wpJnWqYNaP4gL301QC+plSYAkOu6R7kj6W4a3h8ctuwlIVD7CQ
	 l17ca3KBhVugmZWpI4U1BNWKK0k9F1rlcms8A8EVKznYwP1fffzOjk/2tAGEoVoyH8
	 1BRHp8bJhuvizvyhEUfEcDNHwa4wEOHNBg7+6+l5O1oXHsr5Bn3PuEkFVN/dGfPBB2
	 412D8tQ0UGUhatfn5uCipNsdJvON8k5ezcD1jmQEgV7uobJIj3bs9BfmZ+Bkd7jBWD
	 CLY8r+cZobEWQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3825E4D1E6;
	Thu, 26 Nov 2026 03:10:04 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 broonie@kernel.org
Cc: flora.fu@mediatek.com, amergnat@baylibre.com, leilk.liu@mediatek.com, 
 me@adomerle.pw, devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] dt-bindings: spi: mediatek,spi-mt65xx: Add
 compatible for MT6789
Date: Thu, 26 Nov 2026 03:10:05 +0000
Message-Id: <20261126031001.27288-5-iasnezhkov@gmail.com>
In-Reply-To: <20261126031001.27288-1-iasnezhkov@gmail.com>
References: <20261126031001.27288-1-iasnezhkov@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795662602; l=1154;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=V05m+8yF0Wxx4QXUx+4PM5IgqsffZt/x6aXxrp5Z1ew=;
 b=cyrtbIKhBF62/LrJJ8VXUTpKkPx24CbpfjUK0Apof0fUGKsAQgJ/Iqhvq4HDbPgkaU42WO8Am
 o2A7VFHFbC6AIajM9Sn0kLWapBgjXwKIH4wjbbdvRd7xrR0H9xy+yDU
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



