Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61AF267B89;
	Thu,  8 Oct 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422458; cv=none; b=MT0Sb493UpvPZFmjbO4Kh9hir5w/pYWmW0/mEbdu0npyGrS7dQE23FJw35U8GuWF9sP8SlxwrHC+Xb2smNjXyT2LSLnI1+IZNe6MuJYMWvnr8mXGXxlT1k9f49tYS6M05ujKllUrRgy70xmr84Rh8huJ9Rtf85pgES9He9pjyxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422458; c=relaxed/simple;
	bh=wNhtmn5EHeXHlObtiKn/AYvinr1jhCsyDirYtKxwomw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nRdmAH1alojzxXaGR9gCVG1rUlb+zbc4lnBvk5/2HqoxiZuWdXhfYEXnXh9mNQwsBJapgqdZNIAYHiUmZxRJxAhPGbVCZI1J1P6Lzql2mYhyluuAxV3GDxGcWbZSmlnaSRp2cwsF95Ih4BunmQ039/EZgbfYEn+c+fWi+J3hD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhrgqbF3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhrgqbF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AB11F000FF;
	Thu,  8 Oct 2026 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791422457;
	bh=tjPXzymjP5J3iqnt/GHyQd3zZwGn5PrlI4qHS7CAReU=;
	h=From:To:Cc:Subject:Date;
	b=QhrgqbF3HXmfF+KjT/8v4Q3LiYBAV2MYDJpRZAR4a4gdiTYqbhKZiuwC2URrlrYge
	 XB3psfwNcqzIsw4iR5i6QCTvgOAmgsqNCuGncW4CVHzcw7RHWThIJqxVUAVpxGu+5l
	 qvgyF17ZkLLbriDEu3gfxK+E7fDodgOfNiSFrW4+0pbnGlg762cGB1IpRapTBba6v5
	 +8q3+bedJ29/YhNjDkNSdu32hBGwTLPLL5Fnr4H6hSWkKneB/bSoPty6/szH+uNTHq
	 qi+w15zNWixKjQ+XrjrlIuY4BRJDZMX05ZY9HnKAKBw/KI1+KpH25F5pzsf+3+Jwhz
	 VzZxGiYGnkKAg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3] spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics sl2610 spi
Date: Thu,  8 Oct 2026 09:00:58 +0800
Message-ID: <20261008010058.28382-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the Synaptics SL2610 SoC SPI controllers, which
are compatible with the Synopsys DesignWare APB SSI.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

since v2:
 - rebase on the latest spi for-next
 - collect Acked-by tag

since v1:
 - use sl2610 instead of sl261x
 - send as a separate patch

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index e8d6d5d858b6..41ec69f5dceb 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -77,6 +77,7 @@ properties:
               - mscc,ocelot-spi
               - mscc,jaguar2-spi
               - sophgo,sg2042-spi
+              - syna,sl2610-spi
               - thead,th1520-spi
               - ultrarisc,dp1000-spi
           - const: snps,dw-apb-ssi
-- 
2.53.0

