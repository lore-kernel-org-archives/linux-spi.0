Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096707;
	b=0wga8/iNHYz+ZOKg0mh8UnYzeuQR/x1VqlYWBS8ryfh0YK++Ian01Fegq2gfRsvcSebh
	 AUv92eytuTUvTVUHqphjBApLGoChNnU8sRDaxde3N5zPlPumYzwcbrLThOJkUHdBvauFz
	 LV2hixJs4/M+g3Xovze/GIBtHn+fKQ5KsjFa8U4AD4ZswOCmGNhc3/BBN+qnPe7qnqp8V
	 84FeATY67bFS8/MW1zAllB7BDhHO6x5JjBPL/dnz/8pcUEAC34QVzIZOZZHz9FeEwg8gG
	 /hyHZb7/JwvlJe9ADh2ZjQEBfG3tpQ9ZA5e6w7D84BITcTf+TakVcXVZeDJVYMJt9Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096707;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3lTaBCqZF5G8fjlGAlGQP3TalbwWa07a5DbQshXZTOk=;
	b=kFdO1v/WyapfARMhMu/1q0BlEs40voGHzdciUfT3X3+BrenPx4w4LWdjo1CrtJCgzdAD
	 7p2ECREHJ7VV2H7WBWQ/50FbUL7lPxp6oTEf5w5pZ4Wv1/ozfBKlVzo3DLSoim292nTFq
	 tAg67d8g9rBMJR0x+xRtp0gvHTuoHv3MEEIvTedC6EOL3FECLRGrOVz/29isAocLpJ2dF
	 87BIfS4XQeiB47LpY0A4e0gDvTbkzXaBNK//xvZ6ximWIEKBD2eXoGt3XR6vwWv2KuzFT
	 eNJ1bqt6Y72TktFbCD/3Dldb7AKMS831mlzDaLecsHpr+Vx1nhn60ALvp1Lu0VPPrDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=qp2kg4x9;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA6606A326
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 13:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44CA6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=qp2kg4x9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=3lTaBCqZF5G8fjlGAlGQP3TalbwWa07a5DbQshXZTOk=; b=qp2kg4x9gfr3I3leGdIHl9EBeZ
	BcSiihxgJ6LOkQpNKSt1epwz76ydXVYZiqFJjmpVDbgCjw6jGSOTXdEsjW9ft2lJH3m8oRvtUxX9Q
	Y6d/ZqcL6fOZXpwFz0ITmEiCupBVxHqNZaxBdqAKFEYs/pBk5IxYBQdLTGyjhn63OjdIQT1Lrff0O
	5Jydw6VCNNxHzcnIBUCUbLC8FJYgOgwuPQcSusgEI4J2iBqc9uX8MrEHRDJud6CbgBAgy5wiA/Eta
	FvpnB5a1s6buC7AXHvEj0KHcuDDKRIvcsfaN8/b3J73ioeRm4wae4hEpxAWiNIEcvQfsKop+CSPQ7
	5PHQEufg==;
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
Subject: [PATCH v4 2/6] spi: Allow spi_delay_exec() to be used from atomic contexts
Date: Thu, 19 Nov 2026 14:58:04 +0100
Message-ID: <20261119135808.2377849-3-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119135808.2377849-1-heiko@sntech.de>
References: <20261119135808.2377849-1-heiko@sntech.de>
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
index 5e05f2fef12e..ec2074126910 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1730,11 +1730,12 @@ static void _spi_transfer_delay_ns(u32 ns)
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
@@ -1782,8 +1783,6 @@ int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer)
 {
 	int delay;
 
-	might_sleep();
-
 	if (!_delay)
 		return -EINVAL;
 
-- 
2.53.0

