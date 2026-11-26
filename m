Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795651645;
	b=qkZdVHwIFsjOOSoNATlrrP7i96EGauh7/mk22lii2bOZYvxQxrtimTSFvAsZdzXNliIG
	 AsAM2jUyLW5V/MD5PeH45Dr1mstGhlfBhy0atdl2l64RYdDby2xX/sybsX9d9fRPpjV40
	 TuZriZLGDwmNB4lEwv/9ziKAI1BopkSm/bk6GrAxsJ63yzyiScm73ZJvnmfvWMR8Sf+q7
	 L48ObArtCHwKsofwbMKT8Z5mWjJebTbQKb1XSeCdtsPIoAGM7VScC2/UiZ8pqU8pzQGlG
	 3Qkc/irDdCVBfETnOca2NKKB7kDBVJb8SYLoXskllUOdrJyEeNjAcMmYgW0gHTsDseg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651645;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=oT6vSLMWO+jgERuhLwxL1GFaJ+9gw4J6oRotwcUYX4s=;
	b=VFAVITlhv0NSi+R6GvsFir2EsF/XNh0hjAeVdZUKcmLjespdPXXjCOs0mKTomnoyXDLh
	 h8KeVmrUPxENPcQC8rwIJkFkGOVTEfyCj0qj1rv/wNLUkVJZ3bWfZCG21VOqeg3c8O25u
	 mMY/Zn6/3PKXsoPJRPLSrDv82wBLc7/yNSzLVGUlI+vnV2eZsKsps5GFrmusVoS9VrSIo
	 3jaX8YzwxDFo6zAZFl3WFgj7fNIcZP0y6eU4C+aR3mLA64ZUBu86jHmdFkNFSqZiH3VO+
	 CKvv+DJHx7lrVoyPE3OcVGQ4AwgNHDvlkgW5UNzKi6Z5tTs6lyrM4/pWZwadvI5tQMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0zGIyZX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55084606A323;
	Thu, 26 Nov 2026 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0zGIyZX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795651644;
	b=oBrPUDIf5WsaCParskwU6JBcA11fL+AOQWlOugqoPeX5h5fwEBor+HfC8WnwEAE1KDFS
	 dpOhmk7tW+xwMTge03M/BAViHfTkl4sRq7YLKpUQgcEBsRrl3MCQ47sC7zYzNBQq78ANP
	 uBHLqXAyrWwXJjTuT+3TeNpctHdd8wMUuubCGsyUs1qQbESJYAP4CZO4IilHS/Ac5rkNQ
	 dKKtr1pbY5aEaYGZgr63fAVotNAY5hvmcI0foXvGoKLJLVSmuGugRUmXizEGOTTwyvP1m
	 9xT4jo8YMqZ9V338/jAxj052gphNIz4GuNTpLc6Sw71HbJ4SnVwhSd1E2UUgIWV5tow==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795651644;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=oT6vSLMWO+jgERuhLwxL1GFaJ+9gw4J6oRotwcUYX4s=;
	b=sGeSXg01Sc5DkowdSnrKsmUK4mUgbyZ8LhoWU8Set6Iet7h2FE54pmrzXThACsxrpX2C
	 w5XDNv1OQ/4UoyyuNgmojghaA7NOg4M39urOZ9vFCP6OhtOOPmYaWM8g2gcCAUOrRXt5w
	 wqhhvm55SDzHK5Iow0EF5wgR5odpqadqjdglzGwXiQssa/JK5IWeU7xoqf+pAZnoEVd85
	 tIauhqqZb7jbcEn3CwYUJh67KhTwzjKWL24sNhch3ODbCkl0aDKJNqpF2pI36kweinGBS
	 BMGZNOllC7NVMktCIm8U38LvOkqkOyMZj9PlqYi4cvG5XHdax2w8qwlx72egNVhnItA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B340D1F000EE;
	Thu, 26 Nov 2026 00:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795651644;
	bh=oT6vSLMWO+jgERuhLwxL1GFaJ+9gw4J6oRotwcUYX4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=K0zGIyZX8CQ9rio2/vTcnmDk/P2DRaMs3ihWwnluL8Z90+x9ZD7rQa05liPmnREwi
	 lItFDZi0gwxdMRVoMcEA6HAIaVqKkcNYshyobv4QpLI9F5jCJ+9QJ4zYReO/h5QcQk
	 lryBCa+IZXqDtqDNMwlCnMbeBnKa9VsQxVVuEawt2tQDP4obGYxbE9v6DMq0fiiKYL
	 J96OEKWPeI7F3lTQMoJTQPZpUdsMLXFUJdUr3LGDOKlXnDmtDrC409d28MVKLO3R1b
	 PE6rtFEo4fnJ0iMU2YweU2Ue+6/sZR6y9PWVaMPd7sobpKqI2QtFnvgdC+pCKJKiGW
	 WPS4Pv0Hs3R2Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3F6ED4D0E3;
	Thu, 26 Nov 2026 00:07:12 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 broonie@kernel.org
Cc: flora.fu@mediatek.com, amergnat@baylibre.com, leilk.liu@mediatek.com, 
 me@adomerle.pw, devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: soc: mediatek: pwrap: Add compatible
 for MT6789
Date: Thu, 26 Nov 2026 00:07:12 +0000
Message-Id: <20261126000711.16163-2-iasnezhkov@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795651631; l=1071;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=xb5m/UMxmolu0Khi5obeIEz8/HWCSujD/gSfpeukBqM=;
 b=ml3igffOURw8Hhm4RtGemNsfhbaAZrJ8bIMGXnMYpDBt4o9QkW3VPVuf/32Rr5KhUJCZJCCYT
 57FDagUSST/Bvi/lxZpjZzzHCc1XhsXxGPgyexo1n40xEElVDk7A4N7
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com

From: Arseniy Velikanov <me@adomerle.pw>

Add a compatible for the PMIC Wrapper found on the MT6789 SoC.

Rebased onto v7.4-rc4 with Rob Herring's Acked-by from v1 preserved.

Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
 .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
index 79b7558..0c5ebf6 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
@@ -33,6 +33,7 @@ properties:
               - mediatek,mt2701-pwrap
               - mediatek,mt6765-pwrap
               - mediatek,mt6779-pwrap
+              - mediatek,mt6789-pwrap
               - mediatek,mt6795-pwrap
               - mediatek,mt6797-pwrap
               - mediatek,mt6873-pwrap
-- 
2.54.0 (Apple Git-157)



