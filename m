Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E772A47A0A9
	for <linux-spi@vger.kernel.org>; Fri, 16 Oct 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146617; cv=none; b=RQrtuVHL1aj517Qw78WV8AqX+Mgh1nIFr7BkDGK40pYyz7EYztXbFuWRmUJ4YbwN+v4wgZqpA5usNkvK5w5udykRC3PWzREA3n9P5UDQCED1+uXsQmMr4XIVdm3S8MWyeBovquVuk+1eenrVYMUvm+LDa+4Ea6X6fOD8XAJsdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146617; c=relaxed/simple;
	bh=2Neo9mhTDuektY3S6P3dVsyudNkpt/uvzriZWp9WPjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9hxhHeXoatv1uBjfoUTGj2X9TamU0jAvs4V8jf0sYsXHuGwUShgFGm25hLTxzyIuShyvCpu/09i6JlGiYmJHlDzuD4v/dxBzdmIc67OZq8/II5FsuBL8QHFlMG1d0B3ckVjRetJVI5rCJ3Yp6yo1xYXAtT6v7Ni96nnhHpDRKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L56aDfUd; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L56aDfUd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 36DC24E41255;
	Fri, 16 Oct 2026 10:30:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C0446075D;
	Fri, 16 Oct 2026 10:30:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92594103287B0;
	Fri, 16 Oct 2026 12:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792146613; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=f7epGr6oXn9dxoPvGFbGkoqT9TRKCPd2Tc+a83xsefM=;
	b=L56aDfUdkrAO4pMh8FcMdQhmGuwXf+R5exG5nFIKl0MF76R+oaR41vWQz8SQFDb7EL6WTb
	l/8iX+s1qPbFTDf+EWN+XVaCNlsGTFaSwUYfwVRdS6rVMyTcQxZ4emoSKaaNqTPJ5Fxyje
	picGVLGRLts+1MhvKoh0gLS8t0xyMxmAgAHy2PIFIutbqnz0OyRUkydDeC3b9khqRV2ALn
	7S1d5ABrecXtvR6rVjY4ukwoWsOSK19vuXqGvbVKDy3m8Q9UX9F46TQ2iUPOPfvO7wtXtj
	5P3WAkRSG2Xvuz+/px4r6I9v6zjgBKXk8/QAhfH3SJLrUTr/xBs0BCRXnr3tjQ==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v4 7/7] spi: dt-bindings: cadence: Make XSPI's IRQ line optional
Date: Fri, 16 Oct 2026 12:29:17 +0200
Message-ID: <20261016102917.171095-8-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016102917.171095-1-paul.cercueil@bootlin.com>
References: <20261016102917.171095-1-paul.cercueil@bootlin.com>
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
    
    v3-v4: No change

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

