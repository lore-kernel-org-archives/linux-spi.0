Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746303;
	b=hg+hRZSw2zN8Igv5JYoIqBS1EJE4nMnKH3Z0c/eNtofGh+x+RY0M7biRMiUZ+1XMtY6/
	 MrYb2YvjhwrsyqSvD4i+QzBC5+bL+fyAfmw0GvNMjUByt/F2y3mbXAGVVs08EXAcjI1Zw
	 FRKqFKwZYCWoNranK0Ml2L9+Ka6AY4WqsNVjaFUdxgJciSv7gE1D9FEmbycv1s6jLEDL7
	 FSJz8eOTYCc+Q5Clk04VU+++JyGNxnkGKRxuxNfkjxIe0bNRaTRGiH2IB0lQB8qN4vVea
	 bK+Xv+JcLZE/AFos9SVeCjh141/Fm8dOitIDjlLQYtp+PEj6HGrWycKrcT1Pev9BEUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GfempdcGORpTCoUvUOwY2J8rsww1WHgZWB8tQ8C/C8s=;
	b=W4ByUwm/nptYUWEfwOS/3IU8ycORSMHmKIhlvN7KhB1WkchVo4Mv8MHSKiMeCKQhbxHL
	 ghQXjYqwwJ3zOBfoyb4rb5EpvfQO49egZN/cpqR+w5DEgKvZZ5u3PIHg/Bj9Je6YmXdM2
	 kQt9ZHRe/Di9GU5rXpHZ3FJVZQV7+D0WsWI53bJ34zN7Zuu84HszFs7xnZRs09DlSGwQO
	 bgfnOdrdDXWGzx7dl0im8NnDGKrlUNhoHGoJuzA+5gOlrT5IsMCb7m1MHHiO9wFXVvXpJ
	 XvYl8S9O4sVHNTVUl+ovIYl9a2pg+5Au36jdnJQoo8NN34pz5o9zp9D00yKaSroeaMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K5OoO+mP;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CFC606A31B
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2CFC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K5OoO+mP
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso108042a91.0
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746302; x=1794351102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GfempdcGORpTCoUvUOwY2J8rsww1WHgZWB8tQ8C/C8s=;
        b=K5OoO+mPeQIgJ0QvWq0G5ftnB/gmSZRUeQyCu9SwbTEeL0zej/U2UClWjE3au2JQrZ
         RYqK4LUYzsrc0Fcikmk9sLQAChktZRhTFmZl01JeLkB7nMSI1vWVeYxWgFVkmCgcr+j2
         ghymHACfpqROaD/jSkvgCz7Do3q/VNL551svFkodhcbtl/epNp4azusQUA0PeQMG8smK
         1r7AkvOrbesT1sydLZOOnBrxZDyZvwc5J4MeOs6NFp266gNh1ZyTDJrZKLY8Ljcvd9fR
         sdlWfqwj1J557RMqX3rUX0hRWVT4jHWdVVkI9PSkvZu2+yoU5PDflDm6JiJiIBtuYet0
         eFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746302; x=1794351102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GfempdcGORpTCoUvUOwY2J8rsww1WHgZWB8tQ8C/C8s=;
        b=1X9CwLE2rxC/dNlFdHQlgcfbHdLin6GzPI80WbgfmTUETGYvpD/99KHshw8+r6Fe2q
         mySQ5B+p/6wztL1satf127sdqMFFdYhSc550sahfRGmJXfnERMPb/uDzuhYY/vKK01VZ
         9M9oyrJGKfT0nbnrYp+Fjvu7bLcDSZND6PFdkIpMx7LrQN3nU5UjZaHmH/0PGQvRrwwc
         TdlSIAFBNbZzpGzCYg34WlaUKnIdwDBcRNMcxe3fHGWLfKXSTD91RMSQdvWtFBN91khp
         8oF81hnM0Z+JhtuAkRthuxxVqxs8JxTyeCG2duG7NTm7aN29/sgJbnMoYV2nVB3U1chl
         wWKg==
X-Gm-Message-State: APuU4Z9C/JGT1Oo9jSQdZY5MbDZI3LzOtuxZT+p4zgaZCdyTQVJOvwZ4
	zb1jHRC552ca2X2OxZ+Vp7G8a5ASXkyiUXiyodK9Wt/KJhBpSj7PJWZz
X-Gm-Gg: AYBFou0CtBJNAEfHNhPZF0AO2Y6XjHUdm5uLFp3/5bf5URs+B19AeilYPeVn1irWi2K
	HOCIfCAGLxJtmhos1I5mwaiuLlaw63hxdBzKtuxnyFar4d5p5C33qYWLGF20D/WHbbap6oQ/CaM
	Y4hPe1Ou8IXfClO8rFLQe0WyUyLHZS0meF1vjuAHLM9XpY728VIcD92SBL7sgeAFQVCW0dyEYoE
	dUISYsQTzYUfmPL1rJv96ozOWjP34almfv2kBL36Reqe+qm1T+3xLJTAUSoxzy0WK3bnHpTWye7
	WcwQER5nYVXPNLBqmWWkbq3INndoDMuL5h3Rej5HOcSjsr39+Q61VCJzc7hx971B48h+K/iUNJj
	PX0oGVX4OnWwfiBxSqh/jaKi94UZitVwNUJbfC127oRRBWXbz1PYjH9lDkAZ7+MiLCTorncz6bG
	uoVnQAL3NR/a15aMKem+WHtYZp8aRkdvjbGYBlPL48JorCGt2SOoaVeeyH96+DcCRNEm/olSJ5J
	uAQ91596QAkp2XF53+QtqwmOgddvZ4zdvnxVqRa0r6nCGzfzlDQEahX0s98tIMHT65EbTTN8cm+
	oxg7gfWzcaPkCOI1YcMJDb4rr9BXO+6r+7LvkEtDnuROJwpLkPeIw/TG5k/O7R88ilUmczIWSbt
	vVxumop9DJFzKlljERaXwklJ9yJXVKZ4yYDsOrQPIp3QvnFjZ/syqmKCjRuDc4PiYcLvRZCIBYT
	G57DgoPM2/5kuQz9dgDFhrlnD9Uk2Pg5Q8xRw0ws0YnNrKIDborPkxlvDcglDVvAPtiA==
X-Received: by 2002:a17:90b:17d1:b0:3b0:9941:8d41 with SMTP id 98e67ed59e1d1-3b09941917emr50243a91.28.1793746301998;
        Tue, 03 Nov 2026 14:51:41 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09449bff2sm913217a91.9.2026.11.03.14.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:51:41 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] spi: spi-ti-qspi: finalize message on transfer error
Date: Tue,  3 Nov 2026 22:51:15 +0000
Message-ID: <20261103225116.3624270-2-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225116.3624270-1-jctchan@gmail.com>
References: <20261103225116.3624270-1-jctchan@gmail.com>
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

Developed with help from the Claude and Gemini AI assistants.

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
2.56.0.385.gac671c819a-goog

