Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746545;
	b=A1LFK2WXk21Yn8o+/E7TtQXulXtksu14W0YrpC8A1ISFZMfYks1WNWJTBWC6nDxvZvkv
	 oAD2wrFg89z4EM+H4givW9/rf0vXq5VogGfrTsNaPRSlhO2Y/4GReBDh76/4ACkDlaCD1
	 8nncQRNMmd+LKO2CKq29g2cmCb2Ki0E6vhqYDd5e+n313l+0YH3i6v2tC338H8GmqT8Rn
	 jqltwcpX9z++agVL0Mfu+IHLwuVXbJELyIqNGkN3X5r6YP/FAI93/q+qBp8ooN2kQDpzi
	 9T8+sLzl0/EXC/E2tWN6iXiCBN7dJ8QtQaKybnCQJTFUw0MezVrCUJY7ZSWS0JWIsvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4w9iJY2tBpeDuWhcypKT2kyrPbZ7GSulIdhrWT81edQ=;
	b=AxuTehgl23vdRG/9kN0QGIZtPy61O1YXBP+cgwYWtTkOwseMlLq9miydoakwOsqvUXi4
	 B9K4WuILEIRE3SKASQ74gRUZ0tqQJxEOFzwsjxYQL558f8cW6zoWt6rS3WeIZiSRdzirR
	 17xPyzGEisWkmKOIh0rw6gB92IsITS67NzRTpdriYvWrDVod0Xh+CNh9JyNZzXT39q08t
	 UK8X18ZORt6Gr24/PNFca+E/SdYQ5pfRYwwFpfqqa1/EUKjToeS1F5VsOt0FwjWhe1AB2
	 S8lgV4lwBoM7a6hqQZHMvJoRPq+UfJ0/DRoRvfdg/cpmmI0EZ2ZoalVFOcgKgxdcxQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d9EOEkAz;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFE606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87EFE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d9EOEkAz
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so107531b3a.0
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746545; x=1794351345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4w9iJY2tBpeDuWhcypKT2kyrPbZ7GSulIdhrWT81edQ=;
        b=d9EOEkAzAjglSYEK+O4/b/CQU9acZYF+86YAP6J+R2NlAPw5KlArBp6NnjssmUCKjL
         zYx1AuTVVO+qL8zkB2kAXzNldHN0QSBGQSqvSZlVA+eH5uNA5l8U7bVq60B4OF3g2iIH
         seYfmjIabY6bZ58ebjPcwfcwMD+jypu5IIIPpciQefB7wLLvZxzBZ5HbAwk7/3SesaF3
         qwvimbUERtkAYVVuaIlYebDIppcdVHn9CmU/qyeAiJ1x9MfInbWKKPDkSdgww1iUjuwB
         7cuwQwNTwhKkWcmsm+1cUESH5lJlrrPJp42hBvXuHJwqA8IsG1lEi+LpAmfRqbxFXliQ
         yfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746545; x=1794351345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4w9iJY2tBpeDuWhcypKT2kyrPbZ7GSulIdhrWT81edQ=;
        b=AzV5N5eVs0/V5NwSoDS/rGtwxlIG64ufNt5Vvy6f4MIh20gg6Cusy1OCrnHgUQoxyA
         3cQ3hA+GcZJUjcuu3TpbZXOE5q0qVN3EdYlVj27ckNEAChxmwTfetxUn9YcmxK41m4uA
         aOFMSti9KwFfqE513Gy05i5RLPP8AUUkj0Rk/J47dtIix+fte71udaPlysElqmnrNksW
         U1gcKU4USu85U2ewSShsfkCMN/fRipQXsDgUjMHcxWq/T7297VCvO43wJVWT8J6tIv2S
         PjF1JjbV5XGngJeFGUXeiCcgM3ldmEXn+yGABQfXdfj5QsJlMbbKVFsr7d4XZmc5Un1P
         eftg==
X-Gm-Message-State: APuU4Z9qNCL+cM76p6SGu/d+A5m6eUcoZqhj9Te6yXKu5EzPhKlkZ5Q9
	58m+iYSvDS1sLYxXkRfosXH1US2UAHCHioz1X9Kw54rZc0ZIvZuGl4KI
X-Gm-Gg: AYBFou1AKdn5NHoapsaattkB14/OdKtCcTNNcLN2dfJwMcHAI0OXO/IoJOwxM5Ol/Yb
	iX91iU24e/51fWJXwh7GQ2+Zs198gmOmNIAvpZakT+q/3b6p4r2Q02esoDjm+hGVptOCaf/0yoG
	noFqJZ/cZNdKMWzmysZ9fi1oRaZC0lJ85kqaDAas8lL9JSWzlAlcNvTvBFRGvm5ccADk1vJ6nFU
	RWNFhvG8AQDklH887OUEjyex2gkO87/EySO4P9kr4U1aHk89rFUZLP5mMC2u54kvfpxEubtSokk
	14wtd6Jelt4Vp+Lk7U0lhbAHh+WI2gPzjdc4O0ML749C/eUXoSR5etLhmWwRXhPqZu0r9bxZ7tD
	rLLCDcHb7jYYshqMgwnAp8jN3HzkXt201JyezjZWcrGzz24wjwuTzccAYOLTg001o21T1IX6EPl
	ZxIy7TJIOqwDqT8Phb6dc/wFb+lonXWuuo3kQZmsLvwooxfb2rRp11pax0NGu2ftuf8Q4mTWCl6
	L16ETjDjmRiU0hBWLWm1UPcLITjz9iJ6E/qznOZvkqnQ7w8c4qeLKXH7fCLfsEg5SsXqDQluPPf
	J5fXNpbK2g8boG1wCBbbFDyb/ycuPvdYARVpI0CrmVS8sdOxztApi6VU7zUrFvb89A4w9HpvjTe
	SNh76gTnt/n05nmfleXmwfo+X4UtAr++P3dKlrNr0cu/Yr1f3JlxlF9SZuLAoWSEfzSsvvdCsLz
	rXcpbKw+a7+UD/0zOEt+6jWWDg5ST6emZJa5fIxinkagLnIRJ/Zwocv9QIlIHtn6tBMg2QiBaw4
	mvdahdyXoA3WZ8=
X-Received: by 2002:a05:6a20:9145:b0:3e2:1160:6d20 with SMTP id adf61e73a8af0-3e928a80f31mr13815350637.3.1793746544728;
        Tue, 03 Nov 2026 14:55:44 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb467f6668sm272976a12.8.2026.11.03.14.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:55:43 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 0/5] spi: lock context annotations
Date: Tue,  3 Nov 2026 22:55:17 +0000
Message-ID: <20261103225522.3643901-1-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
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

From: Joseph CT Chan <josephctchan@google.com>

Hi Mark,

These are Bart Van Assche's patches, which I am carrying for him. They
add Clang lock context annotations for the SPI bus_lock_mutex, spi-mem
and microchip-core-qspi, split spi_write_then_read() so its buffer lock
can be checked, and turn on context analysis for drivers/spi and its
KUnit tests.

Tested by building with Clang 23.1.4 (kernel.org prebuilt toolchain)
and CONFIG_WARN_CONTEXT_ANALYSIS=y, with and without the other three
series applied, and running the SPI KUnit tests on ARCH=um. Not tested
on hardware.

Changes in v2:
- Split out of the v1 14-patch series, as David suggested. No code
  changes.

v1: https://lore.kernel.org/all/20261102163023.2574632-1-jctchan@gmail.com/

This series depends on the SPI core series ("spi: unoptimize message
when queuing it fails" v2), because patch 5 touches the KUnit Makefile
that series adds to. It applies before or after the spi-mux and
spi-ti-qspi series.

SPI core series v2: https://lore.kernel.org/linux-spi/20261103224753.3610049-1-jctchan@gmail.com/

Please consider this patch series for the next merge window.

Thanks,
Joseph

Bart Van Assche (5):
  spi: Split spi_write_then_read()
  spi: Add lock context annotations for bus_lock_mutex
  spi: spi-mem: Add lock context annotations
  spi: microchip-core-qspi: Add lock context annotations
  spi: Enable lock context analysis

 drivers/spi/Makefile                  |   2 +
 drivers/spi/spi-mem.c                 |   4 ++
 drivers/spi/spi-microchip-core-qspi.c |   6 ++
 drivers/spi/spi.c                     | 100 +++++++++++++++-----------
 drivers/spi/tests/Makefile            |   2 +
 include/linux/spi/spi.h               |  12 ++--
 6 files changed, 80 insertions(+), 46 deletions(-)


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
prerequisite-patch-id: 6999a3baa2d32de8fa42f2626a845fe3cb63b0b2
prerequisite-patch-id: 686a62b9223209bf1e83740a0874e20d7607f69a
-- 
2.56.0.385.gac671c819a-goog

