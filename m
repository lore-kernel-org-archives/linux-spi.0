Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91D3655CE
	for <linux-spi@vger.kernel.org>; Mon, 13 Jul 2026 06:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922891; cv=none; b=qJbZ1IKT3fSkcSyKjME/jU9rMYoQQ3seCu09Uzbrz/NrMGdd7iyfEeAIuER42/JENyjqvHl8ijNJshAo3RTpzNapZd+1K9bXKn+YU5h6/Y57avmD+zPUiIOu1M4x3l2bxQ4oOPJ6gPXytLPFlAo7P4i+23oJ0NSvXTwW8cgHmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922891; c=relaxed/simple;
	bh=HDD6MOY/a6TR3gaTIoCre0KRPfakn/CZHN1rFYXjIf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS3zHKNCx/NLDJ4N02pQu1OB6HcwPj3M2lus9JH5WgsPRazaQ94giLcG/hnWP4kPsi5n/OuhgHpbcvNjX+YLwS0cI3D7CwAhtn9yMKz0dw81XSEEgNLVlYviG7qlXLb8SQG+IZMfpIFRjXYH0HAhC3wxbRcfp9EYPJN1gsdCtmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0lPw2pJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0lPw2pJ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so2006973b3a.3
        for <linux-spi@vger.kernel.org>; Sun, 12 Jul 2026 23:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783922890; x=1784527690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S5DuBYLMmVuyNVqyuWFYcjB12jP9JwOPGMRdlqI4bM0=;
        b=X0lPw2pJY3EAS+JM5rn0KTdIQ+LI2ueotJZhHF22YVfS1zsGbIwkOmJOZ5qnbNfKE8
         RQYJbn4zkA8o1EzRc20kobrFwndubWbvwVdj6FvAL92DAJQh9s1y/cfTY+3GTORZ0LxP
         BuZi2GiBiC6r8S593NIqszRos5FTC17wNFqpa3ooI4rwJB7w+Y+15sOC1oDgcBA8ubg5
         CO6ltKF+4H1JfXzY0QmFSQqZjTEF3Zh9cv3gGnhBN7gAO2AH1Na7tmGTMM3EEJ6CP3Ox
         Hyp2ic1KgcWOlZ2ndDpEe86OrhKzOvNJP8ctCPKpD0DcW/+93CAs3HOhJcAkPx7uQ5M2
         ZEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783922890; x=1784527690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S5DuBYLMmVuyNVqyuWFYcjB12jP9JwOPGMRdlqI4bM0=;
        b=G6pCNk18rczUtXvyH50UrWl1nrj0mt17YTbmvbIfboFDq1Tc0w0taG4QviDsNudC8Y
         FJ9ReznwN/RYTUM2+Kezj4I2miG0Bsdp5LZn2lwX1cbABEwlfHP3IBe/DLeVMLIOoyNJ
         Dl0k4HHbT1b8w7MNkRrpF8mt+VW1tSRvqJV+Qt5Re21Z3bbsda8I1DpSiwFExfhdLe1x
         CMFmO1hgVoBuMOf76uGS/fnc8U1uK/Vk2YCZDN6WpPu2q97H+Tjd7K1P25Z3IxQx2yTO
         ajXZnBRD8SthPCR23FiTQUbGpW9KeXikHEjNnHe0KFYOavOOij+pao6frX5OhluTj63V
         hLsg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7pracNLg6N4+C9zCpTUbK4LymDvDQCEwTxa9kTngLhKA8YMnYny/lE58rPxyhMpiYClVe6efNhjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeR3wPprt7M49A3uGxJBwYKvlEvEA7heTL3N945vvb7oGTleb2
	oDbyYaHTo2FtkP9dspKY+r88qg4BGM0oe/f1S5nPuW1MM6jGH14LAfr6
X-Gm-Gg: AfdE7clFWX45OkvyRz1W9yaE9hlDa5bMxEVisRb63HHYt5FneXuB21xPBJ8wNyp7FE2
	1Bgwe6yGBUkpS/WpA3Xxs5PFuY36zcBb/1kO/WGz+AdUOExHudVZcacdWdB1UfY88aoJUgGiRXU
	2pdwKDE0WTix7eo0tsZYI4u2T3FTKHq+RbX23SlQyTYt2/P6uVxPRHnet10Vk4oskLcM4hUar+7
	Vm39/R4xJ9IRE7s+HeC0I/WmI4wUVY09lsQTZi2lZVs+x08P0UoF6HNtlExWeYYj3KlUmvYNhWM
	Zql7H/9nwpg4mY2ESpLQKm7w7UnbAfSdRbv0EP3cAvovepmf+kjPQpdeJ48/SspL+y4AkF05CTk
	HHyZkakMMwCxorjiywrS+WkGQvw9kmU0q4YmUlwz3AjMbt0ENJxdm7nJ1xG0YALQl10+OIN+/30
	3uXbXsCVfzQXMA
X-Received: by 2002:a05:6a00:3d4a:b0:848:2f74:1d5d with SMTP id d2e1a72fcca58-8488971cb6dmr7128041b3a.67.1783922889853;
        Sun, 12 Jul 2026 23:08:09 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a3c16d1adsm771795b3a.38.2026.07.12.23.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 23:08:09 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Swark Yang <syang@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Karthikeyan Mitran <kmitran@axiado.com>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH 1/2] spi: axiado: merge identical if/else branches in ax_transfer_one()
Date: Mon, 13 Jul 2026 06:08:06 +0000
Message-ID: <20260713060807.7-2-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713060807.7-1-bbnpreetsingh@gmail.com>
References: <20260713060807.7-1-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The else-if arm taken for RX-only and full-duplex transfers and the
trailing else arm in the RX bookkeeping setup of ax_transfer_one()
have identical bodies, so the second condition has no effect:

  drivers/spi/spi-axiado.c:433:8-10: WARNING: possible condition with
  no effect (if == else)

The trailing else arm (neither TX nor RX buffer) is also unreachable:
the SPI core only calls the ->transfer_one() callback for transfers
that carry at least one buffer, see spi_transfer_one_message().

Merge the two arms into a single else branch and fold their comments.
No functional change. The redundant condition has been present since
the driver was added in commit e75a6b00ad79 ("spi: axiado: Add driver
for Axiado SPI DB controller").

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202607121827.djB0zLAj-lkp@intel.com/
Assisted-by: Claude:claude-fable-5 [coccinelle]
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/spi/spi-axiado.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index 649f149617ce..c4bc7a50d6c9 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -430,15 +430,11 @@ static int ax_transfer_one(struct spi_controller *ctlr,
 		/* TX mode: discard all received data */
 		xspi->rx_discard = transfer->len;
 		xspi->rx_copy_remaining = 0;
-	} else if ((!transfer->tx_buf && transfer->rx_buf) ||
-		   (transfer->tx_buf && transfer->rx_buf)) {
-		/* RX mode: generate clock by filling TX FIFO with dummy bytes
-		 * Full-duplex mode: generate clock by filling TX FIFO
-		 */
-		xspi->rx_discard = 0;
-		xspi->rx_copy_remaining = transfer->len;
 	} else {
-		/* No TX and RX */
+		/* RX-only or full-duplex mode: copy received data, with the
+		 * clock generated by filling the TX FIFO (with dummy bytes
+		 * in RX-only mode)
+		 */
 		xspi->rx_discard = 0;
 		xspi->rx_copy_remaining = transfer->len;
 	}

base-commit: 5f1b513690edf51727e6928b97705b6437f9a98e
-- 
2.43.0

