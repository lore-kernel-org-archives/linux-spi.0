Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93386560AC2
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992685; cv=none; b=QQlqnR3+7JFj2g/xcn8dVP8L8xv4ZlKZ2+YWCA86AtXtyst2QxJfAPuIHPgxzVNpR7pO5O2A3Fbp0hQTJmC4YmCDWaPjTEKqlGlNNhqf61fGBx3tb68evisywzZ1cLdyJAdzGK5Q1IUoGU6kEBfCGgpQQxhTFdyLbOGq+4I7sEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992685; c=relaxed/simple;
	bh=QnOrxcAk08eGqU7tCfQQicnhZZrzNiYmByfnW1caBE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwJNArDZI5E8TzpNJ3rLfVsXQMw2C37yGg7+EeMU/KXeIdRngKvYbUL5CO5H8+jLiCq9bV6igLGBJXV5nJpErwMzQLWq29niGGf2+x5yoTtzUVPAuTqDSZLcyeM83y7g+Xh91iu4/TECra4BAYEm75FuBpgIq0iTBX/eV/WrToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NpxY5RkC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NpxY5RkC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 04A511A1230;
	Wed, 14 Oct 2026 15:44:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD75C60368;
	Wed, 14 Oct 2026 15:44:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED58E1032806C;
	Wed, 14 Oct 2026 17:44:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791992680; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=JpGa2J+Yir8NlaoWWrLQkWYYdSPxD080ddpDNAunxZs=;
	b=NpxY5RkCJv4zVUqluSlYSwRk9b0+FUwlK3pf/YrjAGwD54ZxcqtpQb2QONLrJe7bz7TRFN
	+tpOuvaClBjbZygtv59LQnBOabuEPxhzuz4b4uWKJrC0dbZRPeNEBfdfBOEJk7fjmKQLeD
	m0P3xDHJKEbQL/7TB4qEIeRUh314cdOvc3EbfWDrIOfLoPMFpS6k2EAYruhOVkC/fmg0Yv
	ZwX0ZeJTK7kaVnDYGivmPlQ1IDjkVp2KJlrntIXezzHcU4EkDgC6qTEiFFi9VLTSzmqKwr
	O570leonU/rpGNnf/99UWvB4+23jUzCqcUS/2tk+j80iJvvT64jQKJD9fb0bdQ==
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
Subject: [PATCH v3 7/7] spi: dt-bindings: cadence: Make XSPI's IRQ line optional
Date: Wed, 14 Oct 2026 17:43:01 +0200
Message-ID: <20261014154301.157755-8-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014154301.157755-1-paul.cercueil@bootlin.com>
References: <20261014154301.157755-1-paul.cercueil@bootlin.com>
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
    
    v3: No change

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

