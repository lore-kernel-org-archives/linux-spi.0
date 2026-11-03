Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711692;
	b=CNLvP9z7+HZuKgzkzDUI9yAAtOxR4U+uDMimSTMYBCZxM1ugkymXOzz51Bh+6+5no711
	 +RPrfdG87VGQ+tpHNk1OFMgAAEBCKbPjUSkUAuMm5Nh1ttEuRaxFSmjWL2TfX/yHkz2MT
	 Vfj9c1+PIWzn86qAD9cz61226hpTX+z+fyNk2h/+tkaJasDNSnqz/4FKS5aoqY952J8/X
	 MZ4HA0ThLaRY5iUve/ff0L5gJQpjGTjkwZup4pKRhPE4X7gnIN8p/uUHySgf7Na7ep8nz
	 4T5FPAKOMlCyCEV6lOHDCcN4WeovcdS+ShqDaDA3OwxHtkbkB3vfLu9VNvqzxgbGXCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/DdO+c8hhRiuk32rYy7zj2DQMaJ9+qPKp2MrlWUvMn4=;
	b=hGXRMqzXiyacATtwCLTDhcAv5zqSQfsZtM3sFv6hGlX0jXzl92nxYhYDKI/TQJdprNFG
	 aJBdtlCIaYU0sh6QSaEd4GT4VJdzuR7veM9CKA7IqmmwoTyiS2Z55D5agkFMjLfoeho1y
	 PMOFnaB/pk0v6YYc3JfzuWoPlU5qTCktkjuTKgWwB07FDsN5LQsm+T93cryK/KbCGf0uW
	 bvMXhlCiOduXo5TpJi2ZbMu+Yhijq5UA3/w99CPMREnfOfcvcmfjK4kxAzQ2HutVlm2sz
	 2K+GlqkLD+f2DT9hUgpYqlICStmg4woCk7SGs1i5S0YdO95eL1mtowPZZrzT0epobPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=viVoHylw;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9514E606A327
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 13:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9514E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=viVoHylw
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-353804b591eso7190505eec.0
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 05:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793711691; x=1794316491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/DdO+c8hhRiuk32rYy7zj2DQMaJ9+qPKp2MrlWUvMn4=;
        b=viVoHylw3O2xFHrqITHTuVW143bD5XvorRJEgsNje3zvK778fq/JxiCAd0hYnQSmqK
         cR9EDjemET3qN4azii+Cuk4YhfXECn+TXjGbPug1c2iObS7GKW6p8sHPMs8m+zcp/4wx
         ndrdxflaa266irios+ucQKW4NSEhRJIaQ0dM/RDT+UjjziuDK8iNygd4SouqNNSki3Du
         hwM5Z/OzPrRyG6JxKvq0qgUgESFKehUTkliaA4Kc8taBqCu4ttdXPKVA1KQ7P7nB5/hG
         MYsNmBviZ9Jzzz6BBsPxlVs355pApxDzgadbKPJPWbKkve6pteZPTIQe6k8mBOyVmPuH
         9y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711691; x=1794316491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/DdO+c8hhRiuk32rYy7zj2DQMaJ9+qPKp2MrlWUvMn4=;
        b=nYWnBb25fUXjDKnpe8krLA7Vx4XsdSmhu4K0wxrDK9xhsv6YuT4LodMr0WN/mND1r3
         4nFSW8+k6hl8CSuXzDUf1TANLU/56Qg7/QEbuiYw57QhN5ty6rqH0q4CBwC28hqK9NRy
         de/ruxPA4QfkL/kp6/9AM7cH4vPSCAD9OXKmCPTJa1m7I4HsB3V/z8Sxd5bzIhD47Ggn
         i22UWmxHTZlABWNi8bC4KT1cjX1Hp226tTOPdTkrMx7iCiIuEUcjl1uIn3d2WaLi0gAE
         TERO79VU7prAXrRO57EIr/VI51VPN+O8UE8/OaHIr7UVAyKZjIo9NPVENPe7kDmCI+OD
         eHZg==
X-Forwarded-Encrypted: i=1; AKwUvBzoePIMLPpOkh7N/LKU15GGYeZphbwtBC9tKpFyU1dfKLNErm9yBuRcYs+z9BCRZ25ZLoWrhG6yNuk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dAdL6PbkXBV9zpYfxbytgmsbbJFk7MhK+OXhq/o6Ccly8z1DY
	gX2/eUyiCSmd3y3HJEThJu+gQEOPFjobEeDAa4h+L7zHMGNaGusqywNu
X-Gm-Gg: AYBFou3PgVwEYapQAJvFcA3W1uDys7eSKY/ncATCbMntLTtfQnz93Uszcsr0Bj8ucsf
	0cDv8u330r7jzshs5BB1nlo5QCdfAhFy1+v/fff+2XIQBQGoj0Inc8j4RIBRF0Wqff54dtTeQGg
	o5CeNOwIZlVHnSKCJOIJr66qsVPAD9fxk54f3T1ceX8rIKQX9MwGJMldVpo695cSq34/WLZKlSP
	bminz9iKoyrIL7hKlAV+xDIwSre4NMo3Y8zeU3bYQdskGATuq0tj/q6Ume2Xb8BRgXicJXWNb6i
	9gIJsVU+qoTZc6yGQxNRTAOuBF1Mxc3TA/e5ZvXHY349KWeTso/QKELdUpf2eTTTBxQgrr1HfYX
	PcRQdrS/WgL6wXFPvn8dn4Y0CZhs6+AFUSZFOWOYy03jWhcJo9gik/anpXWO/bedrOLREHQ/RDQ
	+ra5bRBo3N5vxsyoo5zG0Qb4OBmYX/KoGdPgerGuvsHFlZ2WE0+UVaDHTcQUv3zpl1wouYXFl1t
	mmreiNqUxIRkiux5wgkWdaZ59xwi+54Uio4XSvJZWZeNrZXhsOKCqCLluOJMr0+2IApSoLThQGr
	6EOs98bTATMb30eV4GrtSs5Es+Qx1G5J8B2/tgWtoo5yD4ztjxiDx8x1qQNnzRtb7A==
X-Received: by 2002:a05:7301:db8a:b0:36a:279:c93f with SMTP id 5a478bee46e88-36a423fda77mr19551196eec.33.1793711690526;
        Tue, 03 Nov 2026 05:14:50 -0800 (PST)
Received: from arpith-debian ([2402:3a80:40d:48cf:34b0:c816:2853:c60c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a61a0csm55335792eec.22.2026.11.03.05.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:14:48 -0800 (PST)
From: Arpith Alexander <arpith99@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Weibin Liu <liuwb@xiaopeng.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arpith Alexander <arpith99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: ljca: Don't require data in write replies
Date: Tue,  3 Nov 2026 18:44:35 +0530
Message-ID: <20261103131435.21838-1-arpith99@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Commit 0fe4573c822c ("spi: ljca: validate the response length before
copying the data") made ljca_spi_read_write() reject any response whose
payload, as announced by r_packet->len, is not contained in the data
received.

That is right for reads, but the adapter acknowledges a write with only
the packet header: r_packet->len holds the number of bytes written and
no payload follows. The reply is 2 bytes long, so
"ret < sizeof(*r_packet) + r_packet->len" is true and every write fails
with -EIO.

Where the Intel Visual Sensing Controller (IVSC) is connected through
the LJCA, as on the Dell XPS 13 9340, its initialisation fails and the
camera behind it is lost:

  spi_ljca usb_ljca.ljca-spi.0: transfer failed len: 256
  vsc-tp spi-INTC10D0:00: SPI transfer failed: -5
  intel_vsc intel_vsc: error -ENODEV: init hw failed

Only require the payload to be present when there is a receive buffer
to copy it into. Write acks are still checked for a non-zero length that
does not exceed the request.

Fixes: 0fe4573c822c ("spi: ljca: validate the response length before copying the data")
Cc: stable@vger.kernel.org # 6.8+
Signed-off-by: Arpith Alexander <arpith99@gmail.com>
---
Tested on a Dell XPS 13 9340: with this applied the IVSC initialises
again and the camera works.

0fe4573c822c is tagged for stable but has not been backported yet, so
it would be good to get this in before it is.

 drivers/spi/spi-ljca.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ljca.c b/drivers/spi/spi-ljca.c
index 8fd001610f67..b1babd43adda 100644
--- a/drivers/spi/spi-ljca.c
+++ b/drivers/spi/spi-ljca.c
@@ -109,8 +109,9 @@ static int ljca_spi_read_write(struct ljca_spi_dev *ljca_spi, const u8 *w_data,
 	if (ret < sizeof(*r_packet))
 		return -EIO;
 
-	if (!r_packet->len || ret < sizeof(*r_packet) + r_packet->len ||
-	    r_packet->len > len)
+	/* write acks carry no payload */
+	if (!r_packet->len || r_packet->len > len ||
+	    (r_data && ret < sizeof(*r_packet) + r_packet->len))
 		return -EIO;
 
 	if (r_data)

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.55.0

