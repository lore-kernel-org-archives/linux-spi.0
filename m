Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365EF3EF640
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371282; cv=none; b=djEwb2WBy6UJto1ht48ugqAA2Giwx9PPVdZ1D1oJSTa5wm2ORAT+DZTEO13C50En0Em8hPmeA0M61pcWpaiLgVmBI/2pJRFlihyfnx1aYFdPjw1W+ZGYUxoOCxly6Ln5imy+tmX74VfO6/6WcCPFCQW1r0PWu3lFeU7kQUxVQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371282; c=relaxed/simple;
	bh=9C+hFacNwZLvnISMeK73Fc5lVhuaZky39s3GFGDIx7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSWPYuYXb+dVx3Ci6AT0H2TVcrStWui0wGmpvoLnxpXF/b2qzGS2qNuu8j1i/jfCz/v4j8O4G2erK3X7DBDDDrvJJiq5r49ZgDcc+JONdHD5YJOBrdPCKxWxutL2a0u9qabh2uCe0OSU3oCsBDfEN/4mVM3dY6kz7ArV5MJ+PF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvS0ok9z; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvS0ok9z"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1042727f8f.0
        for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786371279; x=1786976079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=za0i0XUEXRkUjzBa8+DfiNoHd/qp+XXAbyHUlY7SpcA=;
        b=kvS0ok9zTtvZPoOxXFRQVhBF3j9DvKIBZYW78fHh721En+QqUtOQEaIaxW7z6MmDKT
         UVvMbVrRMTFBZv6cNNeLmi8kppHuaZ1rY111/d4vkFGbm1kfMjCA+98tK4bLyNeEcq06
         SHMeBoRLDWceT4bxVgk0nZ4hGq2+NbSRkbI0q3x/GzXN77YAfpsWAJLJwWK9hZn1b52C
         hK+YEDAnci1KWUGAxJ2mVZOPGIpTChihw3n5QSpVNGZTlLEUd17a2EvILxEPdURmRrwh
         n3fn2AEDnADWDmN5j7xjGhgxlTkq0aGp0Y5wXqvVoAzpDwNXsnyReEnMsYbZAlWZ1LSt
         6fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371279; x=1786976079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=za0i0XUEXRkUjzBa8+DfiNoHd/qp+XXAbyHUlY7SpcA=;
        b=c3zYaW/fQDJxEX9HFForUDw1u5iPZTxtRaRHWiLZT5UsN4ZCpaSvqujAnBaJ4GHBMU
         w0TW/0o7nR8IrQVNBveXH03uZsv5X2hVUzdEPnNJmf6zfyDaN8SaSLVvFPhSmJghQAQL
         IZUsHUNuyOxuDo9XVyeQniLmBhwKvcJKCJQnRcXB5SuL6w+jRw5q5DWYvuR5CTf4zqjL
         AQHeF8qNRG3+TnIUtVZFk6GjARVJRUojnRWGaTT3otGxvJcHxuF3WvbnjJzKimLV/1Uq
         1uFyrGqvhSIMD10Qnq5d2ioAfL4GNX4O9BXgZMI7gKDHRoztmfB/5hY8TwH09S6vI/qQ
         bJqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrLyNy+rhOUQSyMg9ncLPkldQWz1irGiv05dIRKkqZSjkANeb8G1ix3DAxKPwaT2+f5K97d0Eq4VQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SK2boNWyxYxzG52rzzi/feTSl0ArtxoiivObC2JFCCpUGid9
	B/sFn7Aa2+mMPVzx2mpC0A/DVqBPEEJ//Pb9oMA91q0akkuuBEo8s7/opaL/QiBs
X-Gm-Gg: AR+sD10UUlxBj2OJ3mA6TWPtytZUBRYP35FrNqzs8WkBgLsuYmmWL/NwSXG6/q5crkS
	nRtIEEq7de0iSTPTxGPUX2cTMFtRqi0dWgXJRTzXOGrOwhPF/AssUXdSLa5uvutdoHOC75al1h5
	W0LDZXNbLiqqNlAt3jWB561oR1dpB79k22rLnf4KkLSOPz3szAgtP6Ej2CzlNb5u1nVtU+siwTO
	RM467AF3TasXw2RV3Zouj0cFN3koBJ2wCB5LIrU4fazbEUToVo2S/tvKAWs2eduFLvzFiv44p6f
	iWeGju2VCOVCeHK01VBcpvGBemzTC5CkD6wH/786yvl8LgDtyfMoYxY7FaKLBnUANTsorQBEGFY
	axPcv+L3NbxjE31pwDVVsOmORmyrsALDxghOHk0l/YAzjuO0Ou4/XzUkn7ZzThIJ0MLrZHf9ghg
	loCTwyf1YtCgyrAAFGUTk8T1t8h6qRrQDSpp0HcyJ1Vgpd6331A2tz5aFoOPI+RdJoBCCo
X-Received: by 2002:a05:6000:41ed:b0:47f:8d71:210a with SMTP id ffacd0b85a97d-48130ed871emr30408214f8f.15.1786371279186;
        Mon, 10 Aug 2026 07:14:39 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021509a5sm32680580f8f.16.2026.08.10.07.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:14:38 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	James Clark <james.clark@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12.y] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
Date: Mon, 10 Aug 2026 16:14:37 +0200
Message-ID: <20260810141437.2805389-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please consider commit cac7e5054115 ("spi: spi-fsl-dspi: Avoid setup_accel
logic for DMA transfers") for 6.12.y. It is in mainline since v6.17 and
applies cleanly to 6.12.y.

It went in as a cleanup, so it carries neither a Fixes: tag nor a stable
tag, but on vf610 the logic it removes corrupts data in DMA mode, in two
ways:

1. For an odd number of bytes the accel logic packs into 16 bit frames and
   computes the word count as len / 2, so a 5 byte transfer puts 4 bytes in
   the first DMA transfer and leaves the last byte to a second one with
   different timing.

2. With SPI_LSB_FIRST the accel helpers byte swap through cpu_to_be16(),
   which combines with the hardware LSBFE bit and puts multi byte transfers
   on the wire in the wrong byte order.

Both are visible on a Colibri VF50 (vf610, DSPI in DMA mode), and both go
away with this commit, which is what we have been carrying locally against
6.12 to get correct transfers. Every stable tree older than 6.17 is
affected in the same way.

Thanks,
Mehmet
