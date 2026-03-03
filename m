Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BA13264C0;
	Tue,  3 Mar 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556124; cv=none; b=Lwwhvii4OYEoxBgDu0kWWSB7IVVWtqCakdXYXXC9ADmnhKH8N186RrUUkBM+Pu5/560Z1pajIpxoeadTR2efijHzBmZ+utcqJvfrLleF+wkQCOmxt/r/VmrDkwzX0xSdh9TQv38U4Cvo5J/7fHt2Yuq0Y4bODJxWvshml7M42ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556124; c=relaxed/simple;
	bh=G4pcMxh0RxEcAEw5zBZ7807yJibB8k2P6xl2tUln7Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0aGT6HIMYYQCXdlkEsm/ht9naeNefL7KNwtNFKyErlgVd5d8Bv/kTA4+H3eOE2F/22P3spuIvtzH/GjFghOBHNLSWBChE1/ikKH7fZNimpPM5+fXjcv/2vX6ytY8WCQ2XZYgnalvLO7roQetKVXbLEzqzGG8q71SFV3pFehpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4gTnvU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4gTnvU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1FEC116C6;
	Tue,  3 Mar 2026 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556123;
	bh=G4pcMxh0RxEcAEw5zBZ7807yJibB8k2P6xl2tUln7Is=;
	h=From:To:Cc:Subject:Date:From;
	b=h4gTnvU9VQoF3yVsRk4bO/PMqK+e9Uf+Zy7tI/YZ2D8D/KXgWnIuQovcptoc9JysS
	 RCDiFyqaWECb1VYKCdKwJfZ3NHpvLLg4jFDLbDh/0cXjD4H0sAb2Q1BYw6dA1MseJA
	 vmpVCpDjckkfM35LArW8onrAdWWCo4JTct/otc8uoNQLpGHv+T4f20iBrfdGoEzk5G
	 /U9CkYvT3IhBAxTih+US8cJI3FLPQlDOf/AWguMrEz1odq/aGt62LDOwnqfQI0VxdF
	 rZ58CSs28jA8iiSfGBPiA0bIEJaYsZ8mWnSe6QvnG5fCSGT62+AfxBgT9DAgWcPin1
	 /UrIFMpjQm+nQ==
From: Conor Dooley <conor@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: dt-bindings: mpfs-spi: permit resets
Date: Tue,  3 Mar 2026 16:41:50 +0000
Message-ID: <20260303-deceiver-rack-82f2b89eac40@spud>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=GS5S3MWIriZDtQzZXlNHQlRdGMI7nMwWi0pnjf8qN6U=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJnL+f3mKKnK39rWMFHno+Ya9tevnk37Yf/3pNfVJ+8vu fSmPFH16ChlYRDjYpAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEInIYGY7KCRVel5H1PsNo LH6Duy7wTsDGyEeeKx/K2LS2H7wj+YCRYdIWGeO/OmYik9+v56lM+c6+4sfVepEPCgl1rU3T8kO iuQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

CoreSPI, CoreQSPI and the hardened versions of them on mpfs and
pic64gx have a reset pin. For the first two, usually this is wired to
a common fabric reset not managed by software and for the latter two
the platform firmware takes them out of reset on first-party boards
(or those using modified versions of the vendor firmware), but not all
boards may take this approach. Permit providing a reset in devicetree
for Linux, or other devicetree-consuming software, to use.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: linux-spi@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index 636338d24bdfb..b7d8acc924be4 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -41,6 +41,9 @@ properties:
   clocks:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
   microchip,apb-datawidth:
     description: APB bus data width in bits.
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.51.0

