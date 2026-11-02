Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637235;
	b=w02UFX6MTnyorAbhWhbXJYiCNxWwWZ38o1pH+bGi4GOeSa0ittXBbLDnzukRb8dWoKVv
	 IZbvqwLItChKw7kxmWqz99FZkR33Lh9dvNLuQfHvEtHUyjdvXRwOVM+LYChv+jJU3ErGp
	 WwRsuHn9TvNAlVnm9GNDmU2cuUPn6ACWD3XiuycDy1gtWG24tWeTYtoL7upGrif73dIyz
	 Dka+xz/l/A4MqmY/1CS5pwlucxt2fOjxEMkxis1izVGJ/bSQlXJZG9JFElQFNmgVpMWsE
	 GayscMXAlenVysnlGQ3y6hf2l/NsOxUR7nA/bnriEm8Djl4GyBcAVkUAvmAZhEs0rlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4Jui1jwEZ6v5nU3mpOAiFTjiS0PcXBHZtIqyyHsg9zQ=;
	b=sTNdV0LdbOQAUVccsTTvmGhR5q+BYfb4SufdNmybXWM3fLn7bkOOCxYwVdizA4N+wXwY
	 HQLUM09wQlweTqqSWignoCe6B8WBbYjcPtUjA6KH0T83gX2OfPXOjyAmXyAGCFEZST4+l
	 QQEtyGgL+qxd70Ik4eonlabsBN1LS6AXXYXiXBoPaX9S1JiLe8RoW3L81BZWrzzEKdv4u
	 1/fF0CnPAtUUFPUagnp8hB8j5UidKfF0NEwkolPzs7knrsLmGSxTQrHwM/gz3AOdjI8mS
	 btcI7ky6rtjyxUM/LC6GX2DrgMJFzaaVys0dE/erCULoaINgGj/1mekysmWj/IzBbMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=My7gCCvP;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8833C60A0C8E
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8833C60A0C8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=My7gCCvP
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1454178b3a.0
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637235; x=1794242035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Jui1jwEZ6v5nU3mpOAiFTjiS0PcXBHZtIqyyHsg9zQ=;
        b=My7gCCvPocIPthUt3ekAhWaXFRB8P7rEuCRKQwOpiR22UXo/BFlfh6n0ARpMz3/7I7
         K97F9n05CWTAhk+0+A7OeVNxz2grnCFrYf0VcbgfslRZIf/WG0dFhGUzdUYiMRXAR4S7
         /WKgfX/mxLfJoDk86tLA+6IMdCGGl5BXSLyzex/0ZQKFj/LZIvHEMEZHsdrJ9ckzVpE5
         7QdPs1srKUg7sYBMOAKrV1Ziym1KZvIxvFgaii16kr2Z6WkaS7qhlOb5kpMDsvF2qmji
         VkVfQhEZKRcuJH9tgFvJtnZl61I4LhPnB8yOIVtkkNyQj+qi1O4RCdHmmXpk6jVOGidR
         v0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637235; x=1794242035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Jui1jwEZ6v5nU3mpOAiFTjiS0PcXBHZtIqyyHsg9zQ=;
        b=2PSHSes1f3tAGT+xy6zLoTZVGyiUa+09/5McZpEUnXX808uDP7XeUdyQinATxCG9gG
         RC6AizKsMCUp0tMlYtil3YuLN1IWBLdO6vbBV27HcYoOZvS+JDIYBOzuzUn46/2DIN/Y
         XiZ00mUjb5sZlU2iAq3jp53QJO3uB+BYe55H6FXH19BbJ/J1MjXUiyacTJvJEdY1nLM4
         f1PV7l2jG7x3pt49J80n7XrJEjBIoVgcbc2MKgNYtISHdFms3sz3wKQV9IpzIAZE1VKU
         1pnUtQ6P+TX0ChTejFS2KiwnQC9TJFxk5YTPLkYWsmFMoHthNX0UKBjzxwd2d8uFtf3r
         /zYw==
X-Forwarded-Encrypted: i=1; AKwUvBxEJmdQzPrD4WMORD+JI6253NvRmM1XndbQ6zZIt65/xOfK6fHFPJvQ7hdv4EyJiCLZvOsqjR/V8Os=@vger.kernel.org
X-Gm-Message-State: AFq9FYIejEoiZ6xg1dqdLHyevHxh/SajhB7vCoYpjX1zp0jHrGrZKpcz
	CsKmG2JFL5Urz0wb9WtTCyBTSj5QvFH8n2siM5dHogF+EjHk9h5PHNo6
X-Gm-Gg: AYBFou0tCkpwwF5o5E7DdGiPpN4wJrcShBJM/D+HWTsl2BeZt2gNEVdjyrAq8dAxb4G
	UF9PwwORM6s3ZYW7qmZjn39jgd/V0FU+akgA4u3D7EvE5CIOa5mQC6LcJAwToIJyzpZqmjLzTsU
	ZfQAxOPTk6fH68s/SFT3MtMaMtPLDzsPpOVyAo3J/E/WqskEUACMtRWPa0YBkQ2HUtTE5dWKqT2
	MQ6R+6UNXWvaB4YnBn/FZbIN7C+P2zt9ft4XTW62MRHzC52z/HJp5Gq9ZDFAGlHzrDs/7lyT4x5
	jiPbRthK7Wo5MbdvfgfrVfckPyiipNcuYF5Efpr/K0mXeOn8wFIfkYxTftCjDZhAylUIATScbyD
	MalNG5QrYJhmo6IwaCCr6UKMtxy9gVpvW+19crSYiEOG56t+wS1R+JfDQ/xnP2P7Rx4WcilKwgq
	CILqM3BHwT92XkYkc/FdTEUqyaB/jDQWpGNBwRzWKmAPN7kE9HAHjaDKtjk1lX8RJg0aANwg84k
	EOaF5p0tI/3xgr7QME/9kJNiN/LI1/Aw4ONXtpUaB83h8LcyzOcz/BpolTSBjGQaMt+UDDkiEkp
	jiincn9tac7fDNS20CLHJb0biKt94pNTzqtzlxvwxqtap/9hrf+Fm4zVqtbV/iNRQyjBlcic1iS
	3FVAKUbbvERbujmueu/pw9JIzeRwocYuZcHgRILVW1VgscbN1LORNmSHUuZQ7CVsoDaBWeNwUhk
	tGapCHGlw1BhP3oeBvwLYnOCldQL9/HgdYk4N8JfWQCPJGUOR+N7A=
X-Received: by 2002:a05:6a21:6190:b0:3e2:4162:f1e4 with SMTP id adf61e73a8af0-3e928dfb0eemr9573750637.61.1793637234800;
        Mon, 02 Nov 2026 08:33:54 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:54 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/14] spi: spi-ti-qspi: finalize message on transfer error
Date: Mon,  2 Nov 2026 16:30:14 +0000
Message-ID: <20261102163023.2574632-6-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261102163023.2574632-1-jctchan@gmail.com>
References: <20261102163023.2574632-1-jctchan@gmail.com>
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

When ti_qspi_start_transfer_one() hits an error in qspi_transfer_msg(),
such as a transfer timeout (-ETIMEDOUT), it unlocks qspi->list_lock and
returns ret directly without writing QSPI_INVAL to QSPI_SPI_CMD_REG,
setting m->status, or calling spi_finalize_current_message(host).
Because the message is never finalized, spi_sync() or the spi_async()
callback waits forever on queued transfers. If spi_sync() took the
no-queue path, it returns -EINPROGRESS instead of the error, and the
message's optimize state is never released. The frame is also left
open, because the QSPI_INVAL write that ends it is skipped.

Set status to the transfer error and leave the transfer loop, so the
error goes through the existing tail: unlock list_lock, write
QSPI_INVAL, set m->status, and finalize the message. This fixes both
paths, and the caller now gets the error from qspi_transfer_msg()
instead of -EINVAL or -EINPROGRESS.

Tested at runtime with KUnit (spi_ti_qspi, ti_qspi_test, added later in
this series) by injecting a QSPI_SPI_STATUS_REG WC poll timeout
(-ETIMEDOUT) via logic_iomem emulated MMIO on ARCH=um.

Assisted-by: Claude, Gemini
Fixes: 505a14954e2d ("spi/qspi: Add qspi flash controller")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-ti-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 091a8b8842f5..7360ee6bd122 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -708,8 +708,8 @@ static int ti_qspi_start_transfer_one(struct spi_controller *host,
 		ret = qspi_transfer_msg(qspi, t, transfer_len_words * wlen);
 		if (ret) {
 			dev_dbg(qspi->dev, "transfer message failed\n");
-			mutex_unlock(&qspi->list_lock);
-			return -EINVAL;
+			status = ret;
+			break;
 		}
 
 		m->actual_length += transfer_len_words * wlen;
-- 
2.56.0.317.g454f8302e1-goog

