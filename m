Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01116382373;
	Tue, 29 Sep 2026 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669513; cv=none; b=Wc23drCZqN4W9EOjsg2wlLvwVau/HhjcBP13rybzm0wyhl5UoZf1yR5JILBN7x1Q++liXjYg1EUB4zvSWGhnxauJ/CTAxKGkGEp6GWSw6vjbke0ntmmPksfZQqUqmQksXpepxZdGdQI0+jBDqkfOst7mQgITah8Rd1C1SLfiJ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669513; c=relaxed/simple;
	bh=hgQ+dzDIQhZsnBqjosCTcJwVHBYYqKt5d5R1NESwKHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PsMZdyG0SLdXcQVmpLNTUcyMjcGpf4PShiO4VVnQp27uPk8uiW6drNjV1oMedRpZwTzvmAi+iiktKfShX+G3mGZlyqOlm4G0oU7dp8RYyOswS3yJgD90jOZCJOgt39ihMlOvzUeGrUP/TOoxwol2qeL2UHP64wCD0GD2S3DPOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=DaqmFp/2; arc=none smtp.client-ip=115.124.28.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="DaqmFp/2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1790669507; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Wcn+dXPoMK+KQPIjigerI6AfzrefmSlJgiFsa8dV06A=;
	b=DaqmFp/2XTEZwWOsP5xubmE0Qm9xmHFGbc7/5QApQo+Sas9IllJjn3JV/cI4QPEL9H1Icy4aEYJxsFVbXp3DqjRKQ0icpl2EnrmAszKGpNOSf7VRObZLUI6zX8y76WqNqEVhSpo9RNLazJHnWHlTvRy6mWWJRboDSLnlEYtwoeA=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2205138|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0408689-0.000941119-0.95819;FP=7126500390344377835|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jRBNq0m_1790669506;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jRBNq0m_1790669506 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 16:11:46 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: broonie@kernel.org
Cc: pthombar@cadence.com,
	wsadowski@marvell.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] spi: cadence-xspi: two memory-safety fixes in the slave-DMA paths
Date: Tue, 29 Sep 2026 16:11:43 +0800
Message-ID: <20260929081146.41041-1-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reviewing the slave-DMA handling of the Cadence XSPI driver I
found two ways in which memory the SPI core handed to the driver can be
overrun:

  1/2 both SDMA handlers copy the byte count reported by SDMA_SIZE_REG
      without checking it against the requested transfer length; a
      device reporting more bytes than were programmed makes the
      handlers walk past the end of the transfer buffers

  2/2 the Marvell b0 transfer path points the SDMA buffers at a
      10-byte stack scratch area for transfers without TX data;
      transfers longer than that overflow it in both directions and
      clock out uninitialized stack bytes to the attached device

The two patches are independent of each other and each carries its own
Fixes: tag, so they can be queued separately.

Tested on x86_64: with both patches applied the driver builds, loads
and unloads cleanly; no xSPI controller is available in this
environment to exercise the slave-DMA paths on hardware. Details are
in the notes of the individual patches.

Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
Weibin Liu (2):
  spi: cadence-xspi: reject SDMA transfers larger than the requested
    length
  spi: cadence-xspi: fix stack buffer overflow in the Marvell b0 path

 drivers/spi/spi-cadence-xspi.c | 52 +++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 10 deletions(-)

-- 
2.50.1

