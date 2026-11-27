Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765240;
	b=m2nx4+6nWIxBfTRoBSjZMQ4QfN6gGsNQjKODRcl8oG7qI9hBKrO9cpbTnL//wmgHhTKu
	 A1MyAfyMfe4Y5pfifGo3pvGFTpZzzn1FCB4rwE+nL7P1ODfYT8cY7MjpsZMH4B4HcY/R2
	 4RhgR8PSh61cXqs+Bs9iBnRYB/LieEmduaN6EDChM3J6YKDHtomtmB3+cPrz1dK1sQ7g6
	 ukBJe+Qku6vxPler4tTQzkUubD8qm+rLLduWyd+cqxxvYfZ5q7Rkf1WqlubWOmzi/klvP
	 5hzxv1fdJAF5EqCf19Pmg2K7jcmzuzs5u68Pz/om8qy5QiYWyvKg1SPWA46eT0QAQeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765240;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oenDQMvJtH5OqPTegmH1kUWnZC5MSKR44tXNrTurGmg=;
	b=OvaOAasL9TojRTjdvj0eNc/B59mnouzL2ozYUc3Hb/B0nAl+MXaFk9wY0NtgKhFhhE3Z
	 mODNJ+g23FQH5llFXXeiTrUNK4yrfO/y3drkkkJcJn251Hw2uOZdfAANRhAUkfIXBRX0R
	 +t9swE16fvtyySdtWqCiTPtiYYgbsGjpq8TJGab57G5hVzgWmQBUM2nWXtaKTCn0vxBx+
	 lgBCHc5dOLJM/YoZd+Qv3/n+K5t0EeDSQCmgwJ9Lfk/udqtNaWgZgRdPELRVKqqcPLPsv
	 36RGNAe1xp8qBxL0/bJOUU3HAk+lGYz7ojE1MKMzp49rApF80Gid8bx+oIcx+DStPkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=NgJPiXe7;
	arc=none smtp.remote-ip=115.124.28.77
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD443606A31E;
	Fri, 27 Nov 2026 07:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD443606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=NgJPiXe7
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1795765229; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oenDQMvJtH5OqPTegmH1kUWnZC5MSKR44tXNrTurGmg=;
	b=NgJPiXe7ZafG28COehdLdvfEl5PnvZSYFVt00MbejVLsfekPjiEOr1IHpPUGCUSM8uCDTIBNnWKTt+eKuciDCdS+kQePFWhyh9orCY7eMLZ97u/nID/87zpoGkxDZ7llwGBy3Y1/ws7jJPD3n+IlXp/Qp+1QLNRlSosxydm/qJdSJKS+3YJ3KTN9bjd9oczUEJKvA/q/I9mC93sE7kEGvEKHuzkCKEHlQGuAtG0YGsrioZGu7ek4OI6dPef0WLdW8a1Loi6xTte5CQSGH07X1QJgBsPF0vqZ25sk+tjeZ5S5MPJ0jYKCxAzVOIz4v/dK1cFFOa1LZp1RiooXXQR27g==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09006236|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.134249-0.0353024-0.830449;FP=2663912962208220567|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.kBFougz_1795765228;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.kBFougz_1795765228 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 15:40:29 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Subject: [RFC PATCH v2 0/1] spi: fsl-lpspi: add atomic transfer support
Date: Fri, 27 Nov 2026 15:34:53 +0800
Message-ID: <20261127073454.351296-1-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a resend of the fsl_lpspi follow-up to Heiko Stuebner's "spi:
Implement a atomic transfer as a last resort" series.  v1 was based on an
earlier revision of that series and no longer applied; this version is
based on current broonie/spi for-next, where Heiko's v4 is applied
(for-next 63083539d2bf).

The panic entry point and its pstore/NVMEM user are split into a
follow-up series, so this one only adds a second transfer_atomic()
implementation next to Rockchip's.

The callback uses PIO polling with DMA and interrupts disabled, resets the
controller before the message, handles chip select and delays through the
core helpers, and caches the per-clock rate because clk_get_rate() takes
the clock prepare lock.  Poweroff and restart prepare handlers
runtime-resume the controller before shutdown, matching Rockchip.

Only host mode registers the callback.

Changes in v2:
- rebased onto current for-next with Heiko's v4 applied;
- split spi_sync_atomic() and the pstore/NVMEM user into a separate
  series to keep this controller-only.

Testing: compile-tested on x86 with COMPILE_TEST and on arm64, including
against the for-next version of the driver.  Hardware validation on
i.MX8QXP is still pending.

This cover letter and the patch were prepared with AI assistance; the
submitter must review them before submission.

Thanks,
ChunYuZhiQiang

Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>

ChunYuZhiQiang (1):
  spi: fsl-lpspi: add atomic transfer support

 drivers/spi/spi-fsl-lpspi.c | 171 ++++++++++++++++++++++++++++++++++--
 1 file changed, 163 insertions(+), 8 deletions(-)

base-commit: 63083539d2bf955ccf84042d4b044d1133752bed
-- 
2.47.3

