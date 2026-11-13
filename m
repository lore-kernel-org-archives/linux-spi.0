Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577832;
	b=hM2GcKpsxbmEYWLS+Mm8vOitm9fYd7oWNjjN/8ms0EKQqdHtaaZeIHc9axDcG3TcAVL0
	 SVO5NqChOsXag/K6piL2PwMa+sOi/KFXMYLnaNW+iVLUYWCql1nsKuGsqZNFiwKID7Dvg
	 phL4n1BhACaYGFKvR30hXGdOWOlS5A5CQT5kBv7U3Lc53KIO/eCrPDeAxxVBIFrQDFnFU
	 eL0HaTLtn0LMixFOjD3jxNc4P/9s4CQSlo7DtzzX0d0yYwlih7rAYlc9FAZp9Mah0Z7vL
	 TqMXJO7/mG9ggWq1dh1zfgkCKxWD9XjAkRO3SIx8Yp0YM9MoMYyFNNgd2BAG+asRCtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577832;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=an70ig7dAEwpGArUZ6IJueFBhswwSw/pstiiDjbFBS8=;
	b=URGAPblYxSwn6uLuC0P/PosoSydH8CKM+8sQvVzjO0YTDwUaRq8yq1SkzK0szUT0TRr8
	 wFuyInJPT1lY7NvfF6RDX6UqJlr1zilUE2QsvHx1empXewB6CwFnLIh/4CXFyWJHB+Te1
	 W0dNILfjYQFkDvy83V2mmTWRd+IbFoPhA65b3bkyjdJUDaqD75hJwC2ctlD5jcBlAJ8Lu
	 W9dCn8pKOAkOpE5EKPmhZW6R6R6Alstct1+8uiPGhmYZVpV2k4QsaWh0nIvcAIb+znhjJ
	 hfWLqqMx2z1vGCKwwjuIFS49CZrHUXmZiyhVMJnmcRhJGrTuyRlBod0xvm2vF68Q2bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=CuZhwzYl;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3C60A3818
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 13:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4B3C60A3818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=CuZhwzYl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=an70ig7dAEwpGArUZ6IJueFBhswwSw/pstiiDjbFBS8=; b=CuZhwzYlzuHWQ4UCTTUy0ZkzvV
	xnQzjRAEtjIb1wzaxFOXXYoLHosClMw+j7RLDWKCnsvEtBxIxlfLztM8z3NkH2wDCSYCSnyYQfoSh
	v5rlqKbOtLszR47s2bUaZgSNTApyVw++jOgOwYVQ3lRYET6CDriE4TUgyd81TgRRO7pR4f+SsaUmE
	V3abAWyXsIhyqr4VxBUKUZo09njnagyaNDjtSHW9EL9Dk4EFyZC6+nkIxgNc50YREAwcPJB5a8ggn
	crHdRy7jxgqDumoisEsb2sDfdurBvMEIIpym1H6sYZcNqtYyWKSFV2ZgIpOGQY/UV40rlLNavevP8
	e++v95eA==;
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 1/6] spi: Allow spi_delay_exec() to be used from atomic contexts
Date: Fri, 13 Nov 2026 14:50:12 +0100
Message-ID: <20261113135017.1047959-2-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113135017.1047959-1-heiko@sntech.de>
References: <20261113135017.1047959-1-heiko@sntech.de>
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

From: Heiko Stuebner <heiko.stuebner@cherry.de>

When using spi_delay_exec() only the fsleep in the subsequent
_spi_transfer_delay_ns() can actually sleep.

As we might want to use spi_delay_exec() from atomic contexts in the
future, move the might_sleep() up to the actual place that matters
and fall back to the existing ndelay if called from an atomic context.

This also introduces a helper spi_in_atomic_mode() to determine when
that is the case. As this should really only be used in very special
occasions, it really restricts things to late system states.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/spi/spi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 40cda0037ea5..e79f16aca1a3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1700,15 +1700,27 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 	return 0;
 }
 
+/*
+ * We only allow atomic transfers for very late communication, e.g. to access a
+ * PMIC when powering down. Atomic transfers are a corner case and not for
+ * generic use!
+ */
+static inline bool spi_in_atomic_mode(void)
+{
+	return system_state > SYSTEM_RUNNING &&
+	       (IS_ENABLED(CONFIG_PREEMPT_COUNT) ? !preemptible() : irqs_disabled());
+}
+
 static void _spi_transfer_delay_ns(u32 ns)
 {
 	if (!ns)
 		return;
-	if (ns <= NSEC_PER_USEC) {
+	if (ns <= NSEC_PER_USEC || spi_in_atomic_mode()) {
 		ndelay(ns);
 	} else {
 		u32 us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
 
+		might_sleep();
 		fsleep(us);
 	}
 }
@@ -1756,8 +1768,6 @@ int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer)
 {
 	int delay;
 
-	might_sleep();
-
 	if (!_delay)
 		return -EINVAL;
 
-- 
2.53.0

