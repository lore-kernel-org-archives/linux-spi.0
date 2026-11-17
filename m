Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959454;
	b=3+G2wYc3Aw1FGnCK8hBkTfvTZcQYCzNe2vhMeGxouVz2ilg9fwvI8V0qHoQ5WVVSwN1g
	 cdT748fah2gaoDzJhKgVpRVipn3wGqnvxy7BEy/gUnHSW9I264CRyQF9jRfJ/VqvwXJm0
	 uGq41ED90LyzPKeMFz0DBFXfcfBbyMW4ooi5UhI9ga1PqRaQttaJXWkPQtHIKUBvcEym7
	 vuPRNlD+Rh975sSsULmIN92C2wD9RePxKID5XrhNOeXgu3opkEwh3bpIK7rKKHZ4WDk5H
	 bb72OLMIeuWKpGEZXvD2MSN1OW6mP53TsOleg0L+XWvqzkwdmOnQzdKTVBGHVaNSQqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959454;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1L1rnpEa1FMQhHWjQ297g0CVeUw3DnJ6PRrNwvd4eCI=;
	b=XcyMln9Dkqq29xPZbxV3iiKVqAqLYZl12oOpdJZJxxsoXom/UcY6wT5hoA+vdGdN1sAv
	 gHTrurMpGxsWvHfByS6mMnowXHpYjxyOIEKk9nnx7rba/rH6wuGiV4xuiVxD5t0hW+Y8J
	 /O/IrlaYt8prbZm1mc1Ibm0/bTCUQuUu3z4piAOgjqlDxir8lIlA5pxwS1GcTn30OcHU+
	 kTfaJ8FgGj9xARPl4xksRJrOTeF/QapAUpSmQAs7epY6BVHEzpRT8XuUMxklCp/Om8l0P
	 s3/Bm6QHxURz6BQhQkSD/SCmBzquTpvhV8OYZUl2yD+FgE29lASdghybz+IgNSKajuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=X9C5zq4q;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC0606A331
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 23:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DBC0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=X9C5zq4q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=1L1rnpEa1FMQhHWjQ297g0CVeUw3DnJ6PRrNwvd4eCI=; b=X9C5zq4qmzVZbAo9rnBmBh45mj
	J2chf+v2QllC3118joYKv2Hv6rxQFGdQPEnxw3/DdgIgGaDNFSBMDfZbpS4iE2Etcy64/sYhrnz/I
	vVmAnLh4p2KjJBZtd3j804B3HzhO9rfJsL3xmtcTB9e8JzqFMWOavGsWE0b2YDQLK6IAgljk3ZmhT
	FZJJdfooN7EkvfCPC6QKbayNxAMToxfNOOcxKY5ZoXlqH/OW+uGe2SeDOmqAop7Mre2KmLUbGUxTO
	4ScypXDF1/FskYMOqiZYfidP4AD/Yar+q4l49O9yzN9/WXjfZvjzdBYM6oPPHt8srhJS3fE87thsx
	RETxkPjA==;
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
Subject: [PATCH v3 2/7] spi: Allow spi_delay_exec() to be used from atomic contexts
Date: Wed, 18 Nov 2026 00:50:16 +0100
Message-ID: <20261117235021.2013719-3-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117235021.2013719-1-heiko@sntech.de>
References: <20261117235021.2013719-1-heiko@sntech.de>
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

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/spi/spi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3aeee3b11c0c..8a82d7f5b9fa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1714,11 +1714,12 @@ static void _spi_transfer_delay_ns(u32 ns)
 {
 	if (!ns)
 		return;
-	if (ns <= NSEC_PER_USEC) {
+	if (ns <= NSEC_PER_USEC || spi_in_atomic()) {
 		ndelay(ns);
 	} else {
 		u32 us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
 
+		might_sleep();
 		fsleep(us);
 	}
 }
@@ -1766,8 +1767,6 @@ int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer)
 {
 	int delay;
 
-	might_sleep();
-
 	if (!_delay)
 		return -EINVAL;
 
-- 
2.53.0

