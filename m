Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D0336E46F
	for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789110; cv=none; b=JHfpH5m2r589CI+ZLCMRQt67aWS+ynibJUL+TGT3sVsUl0Bo7iDDCuwQX1/qIkdG1mNQ4KXiiBJ+qAawj670k36x8nQrog/IPTkrkT258lLmgkIwxPh3XNOmB6CXnEcAwdOLwGFpqqU+KvLWsBeNQVpIFfBZELcLvUjl50/oA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789110; c=relaxed/simple;
	bh=RBC5GxO6F5suUqCq8w4WYm8YQ4Tf53aE1zRPpsXfF2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUU/Xf8as5eM6cbvbC7NFMs28T6ZmFoHxStucI2E98rG2O//Wy5em+cArW7qcdVTXJMeDE6yFghaUebwbkWw3PIRwvqDgE/yg2ddTGYs/Op6K9aiRu9P7HuyKZ1QGwxBbr7zzzKNA6nuw09O/ENJQAwNi5afao7V6r8J04o2S/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=WndLfhm3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="WndLfhm3"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso28429275e9.3
        for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1774789105; x=1775393905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=inofcFwjL2pXLFDjLTfYp+79qm9f/pucKjLePX2HrbY=;
        b=WndLfhm3t698Dvlk0s1uqp0IpR+Y/h5Re6F2IKT6qxQ9+BwtQZ8iIs8wzcTnLRBp/R
         Kfc3KRoOVMhQhjKcenu/peODHm9S9420ub/QC7EYM6jf3EGqCQpIhJuWQCXjnCIKPnfn
         wX/ohwFiAlo4HAxdXBhOkmtjXXhuRGfgowprWrinG3d70MKfy1iM8NeJRxlNvcbuX3kW
         eH0vtaYdp7v4PCSqjgwbGRbZ70JXegsM2axJWd3Pt96FQvUFdw5ilR4603aHs1gak9z5
         nzUm9eRf0CnAxWiLvBOPiJ2FQ2gLeblHDRf9xZBHU9s6BAuODLELtmGxaqPvACCm3vam
         DRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774789105; x=1775393905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inofcFwjL2pXLFDjLTfYp+79qm9f/pucKjLePX2HrbY=;
        b=hOmc9/nOuy3dudXWXs0foEEX3eX9iXJOOhDsmnXK4dSSfBu2U4Yo6/sPdCP+VMCLmR
         9dj0eQzOHzx3yubHsLv4n76PJhBYVw8DLYrywjkYqkCBmEXpvN7YI+Ly3oCwXWwjW4I6
         08LhY5OQbfvlcALhoSmgoUwcEcARgscua/E38OfCdCW93V9rQLgkPVz0V8EmP4QS4dM9
         Z8T575/q3nVUSzNGlMLpKCGhsR6GR/sHI3PXdTSBzxFr2zRRgurgyId6q67YpjEYT8mJ
         C66JZrue/6Fs2ecfslxLIZJs1lbhsQN85+gf82aokE5w8qVUrKqMKagzWtMKwDXuu35W
         jTYg==
X-Gm-Message-State: AOJu0YwaskwSMQlcZCkg4NL6rSNQaUoTqGovGF4HprXYLrNy7UXQjmDd
	XfkxTyomjodDFeHIoKKpcVx2Yw+9LbOQNbweQj7xuZlElLUmtOlfmsXXSDDtdyJw1I+Km/6XU0/
	2zTTG
X-Gm-Gg: ATEYQzyJHMzNl391GPYEkwCqiDp6WhqtpiB6tU16Apx7gKHHYwFy44Ffb/FBU8I8Mad
	9loNEdqE67FN0AgdQO/TW4SFNv7pDwn9auMmkitNtht06HktNiB1RtgHoezuq182iyt03X0rQr7
	UzMGPMxr/Ke1T8p3wPTHnLSbvBt/QT+9I542JuvwII8DsBekPsSiD9DRblrr4DarWdfIannWy06
	4CkOJX2nTb/yhaKFrdbpKeBWcOyLPCC7uTHs/pcQyobekJ4WqiSTJ/U0e+yQEb61BZ1C/UjqYci
	7a2mBjGtHIQ57iueabUgMVNaErXAafCi6dFOC/hynvTqempVc5h6mg+2UHUhbu8xP+LMS/JDhx6
	6xrsTUIEJ3UbXhMh9ZyLYJTzVVylvPf4L5Gg+4hhow8f8q+6dX5Vmga8iCnCL9LZ2NvxVAtb3Or
	r1ZgZUZNkyRkRIjLpeYdFCjdY6XHqu92ymdnr69a4snOmgX1MDIs0UKg==
X-Received: by 2002:a05:600d:1c:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-48727ec7681mr117472845e9.21.1774789105432;
        Sun, 29 Mar 2026 05:58:25 -0700 (PDT)
Received: from Jimmy.fritz.box ([2a02:578:85c6:1101:1ab9:445:1169:11e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48730629033sm105579845e9.6.2026.03.29.05.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:58:25 -0700 (PDT)
From: charles-antoine.couret@mind.be
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Charles-Antoine Couret <charles-antoine.couret@mind.be>
Subject: [PATCH 1/2 v2] spi: add SPI_MOSI_IDLE_LOW support from device tree
Date: Sun, 29 Mar 2026 14:57:25 +0200
Message-ID: <20260329125725.2984756-1-charles-antoine.couret@mind.be>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles-Antoine Couret <charles-antoine.couret@mind.be>

This flag was introduced but was not added as device tree property which is
limiting the possibility to use this flag on real devices.

This flag can be configured as done for other flags.

Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@mind.be>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9b1125556d29..489a64e20305 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2363,6 +2363,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi->mode |= SPI_LSB_FIRST;
 	if (of_property_read_bool(nc, "spi-cs-high"))
 		spi->mode |= SPI_CS_HIGH;
+	if (of_property_read_bool(nc, "spi-mosi-idle-low"))
+		spi->mode |= SPI_MOSI_IDLE_LOW;
 
 	/* Device DUAL/QUAD mode */
 
-- 
2.53.0

