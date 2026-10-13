Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F73F076C
	for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900917; cv=none; b=DLIjY8Y9fC5BL0TMkzSgTwwkhxmZgg0AQam/6qN6gazP6RxnHblFPK3/8yHuxM+en9+eHA4jBYJ1Qt+c0q/P+iup1E7d1Kz8bLkkqSUMGWqp8IOtg+iE4BwDwSwr4TAIYW+k46RGawN7fmc3WXGw1HP5ERThKWRgrjgFmbsExNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900917; c=relaxed/simple;
	bh=Xa5KuE0BM7GTNG1v9Nxlag9mk1yepK+Jg4rggHJ9fgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1iWCXxOOKynZubleOqvduGvptN/WM6StsMcDpqKLYWRDlM61WfPudlpCKH94GxPCO84ehbB0G+vwkXCCEkMNb1UC7Zc5SZURYdGqO+eBkksJSXBKhEZX2FMGy4IkPSlxHqC9fOJCFVZJeFxBHElQ8o8vZBGsofUYbD5r/4m2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AMSLNhsz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AMSLNhsz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4837B4E4120C;
	Tue, 13 Oct 2026 14:15:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1BBD960362;
	Tue, 13 Oct 2026 14:15:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F153611D716AA;
	Tue, 13 Oct 2026 16:15:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791900912; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=f6TdyDtEfyoB6iXQflOf/1BYBzMzPh/TXy/i0xSF+2A=;
	b=AMSLNhszT8prcemUiikdW+BnXw8LpGnx+xSIjMUe14ooie5PG/aEwFB3DffeMmn2lRs/xu
	LBCv2f9hmaeFSsfFmoubPUaC2T7wha5TitwIxFngkUHGEPNhYFC+NPzZ8hCuaEXfcFmLPm
	WqJUA/+260i8aGOzJypCwBNcKT7V9LpfFfhervrQxp9n7J0w5V9uRrhBrsA9gSh8onZlsj
	fIqtCUIqQ4IV5LI+OPGxn1UNsEpNUrt9Z4kOiOda7wF7FdkGjEEKZ9sggkvZGwLTK/MAsl
	W4QjZj177UJ7taghs7MHPe11nN5pjXQ66o5n+jwPuJ27MCMpsCmaUNmkfRf8tw==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v2 7/7] spi: dt-bindings: cadence: Make XSPI's IRQ line optional
Date: Tue, 13 Oct 2026 16:13:50 +0200
Message-ID: <20261013141350.189996-8-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013141350.189996-1-paul.cercueil@bootlin.com>
References: <20261013141350.189996-1-paul.cercueil@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

The spi-cadence-xspi driver will happily work without an IRQ line
registered, which means that this IRQ line is optional.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---

Notes:
    v2: New patch

 Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index 38a5795589de..dd8d03c07e68 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -43,7 +43,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 allOf:
   - $ref: spi-controller.yaml#
-- 
2.47.3

