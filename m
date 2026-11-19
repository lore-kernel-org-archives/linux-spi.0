Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115409;
	b=kC4IMA1jozrGmA1y1eKrSDym9LFMLhjOjvXv4D17p9C6SRzzVYgDaKc39ye1hI3D7kJ7
	 ryFNdf2pyj6haqwfbltxXtGJVmRJxsZAmFICcJAA1jwvdNSzt8T7fxzRIFOG9YimiQZ/5
	 XfOc4QZCNTYEQyXTT+KHh6U4BDG/o5E0U4SuV+QrF3jY6BRShxfo10hTS0765ICkDnOpM
	 bJxx/T2if20ghYTc4myK5719gN0P7Myn4XI4Q62pT+mCywBcKLRI18eWAHVTYHqZv25Bi
	 rnO4GFya3vjH3EruHgfw3Oi5lBwOIanuMQ/mDORZweSl32o4F+AVOtmlTP8kO66bbCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OWfWBSws9gh+iPoR7/7oxTfW1366liBJpIftUQNS3TI=;
	b=0SD29jVf98n2BUgep4a44Gl272SaPFnEKTLvKpD//PyRQvKp1moZpWIOUuDZcZ6wS0bF
	 5Jaz4TdZCv8wj7cY6rdBPHbDfqNyOAet7um0ZplOW6CKZUQJsOONhJwTX1mA5+XLZqxpM
	 V9HpmEn/TxSPOwx+9FydgKidaFIEc8hrhql6BGj+XkjWuKLQKHNxDK8ms/AXafH+BbYip
	 mj5Ixi6OSbBES3Btkj7KYTA15O6b5ic8t16X7RWTrBtg1byBv9PTSvCsSpAO632Lv3WLL
	 y77w4KiPm75WhZGjXJ0PFr3isKrRv2c1VXbA/dy/F5tGhPc/Eeg4sX+UH18pB+Cl87A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="g/nsiqsd";
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3CC606A33D
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 19:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC3CC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g/nsiqsd
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cde1479f76fso73364a12.0
        for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 11:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795115408; x=1795720208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWfWBSws9gh+iPoR7/7oxTfW1366liBJpIftUQNS3TI=;
        b=g/nsiqsdt4pH/tzBHE10yBClAItvjaLryQElgWH80JZmkqIvvDL1r10plqAcCXico5
         mOJMbZBqyrQIX5gIDYrNv3ltUPLHCFFKjjq0z7n07DkPSGNT8OSpbx8+8wPGW4mHgpkb
         MxZyFbSHhym0sV7UIudMlWJok1NPjVZIoiWwSNko3m2AMEM1Rufx2lsk/oT+AGXVpkfL
         gv1MZjw9rMmvJSKLSBe4JSYcx+OGP6hzJ20yKs1jfTaQu5LwHJNcluI/H1dTb7cNvsP6
         szl7egJk/kq7eofTpBMsq3hufiD2K1CtZcF+FhKJ/vjfxmADLHMVoF7RaMDFWPQvxtMj
         9bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795115408; x=1795720208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWfWBSws9gh+iPoR7/7oxTfW1366liBJpIftUQNS3TI=;
        b=ZeJbzsa/DNPaV3bO3nYlVR8Md8FnBb9up+fUcABLx/D7uOSVcBrAOohynVRnCbzTrb
         U+RxwlXkeqJAeUBtoUW5eMM6c1haJEiTpJbjRIvImwfpB5l8oHSG9JDslBbAmVAXl5vw
         /3r7C4MtnPVhpl3Fx9sdG6f42predsSj8mvKaNwhSgzLMZAlB3EqjYUxNcxes3t6M2dX
         2UilGuxAIEEahL5jvPVWIBiaAOOU1LipskmuoQ0S6bskN3XRUFhSlyxVkX/nk7eegiRk
         I4Y9NGUtwdhkhjtt23aFodtRr9P3Ae4wNpKVEnv+OpfGNHvLNd6hHN7rsKbcA0Wv9APf
         UxJw==
X-Gm-Message-State: APuU4Z/8u1g9aa1wwy53GsWvrrROQc6fb/4up+g4EYgNN7rPQ0K9TVj0
	DdRtFcQUZxGzSA4rtQ51tKvxjl1zsds/VqlSf5Iq40ozO5MV4y0AUY83
X-Gm-Gg: AZFdTZd7UsBI3CfVTx3hKvxxHfRgGQWzSSs9te0JahoGhPCgYA+OfGdDDUUd4FIFiK+
	VAeEVM/awbOUsSF8mA2RFVA39EBmbdl6Gwzzskwgb8MbrIn9/Xs4UqvjwMZCeFswCbX7xDl/6AQ
	l5mM9Mx8SqJtuMjfWldWoMtFrEnUfUnFsU1Z6O9Mk0Nx8Z1WC/5zPI5mOwPbGF4oCw0a78e7Nck
	OWUGvoYallFoZUJ9PyBxfz+SIXPIPLFVK3iwaBtKpkC/+zUqM/66sOqSFZcY3xU6UF5dTLhNaLJ
	+c4x9ZeeyRHvic+tuACDyM09i7HXSZYo1j3+XyhG/XBaJ/QHgG4hdZ2F0uFNTTIr5APmiXxqXvz
	rDwUyrRpPx2fJ7JoxrfBFaPxSMlsToE6v9knvTjFDXFeONGS9YpqhjDT4T8t9RPvrJu/1aQjF1K
	tyhSRTN7LzmWIP35tbcIq+KStqZqxSB2ajzOkf7ITv49uQgk0jDyH/makrWc4GUmbDhks+gRXB5
	jAER4j/0ssXITLJMQhbwFGJ61vKBt1EEJZ9ZEo4C4R/i5eTJB1hBM+q8CyNBQzmN3KzWcAOymCv
	uI3XwrZfMmrSZaxHre7U86GpQnWKgLtSIepMcXkZXbi9Hg2UZMBmT6yaOHcxmpOccDcJsZC2B1f
	SaLj5V8Wfi4AvDzX0iKHjXgX2XP1/ZrnqYipbUGYzPYD6pGgmUSMG/ku7Wmex2aA7Hi/VbHem/T
	Qev0MXR3RXja3H+7tKNGs/DvfLj7kvZGaXdMhmE8qY6tEPoLE/TIOaseOLWNPABcayiPmGpl9RS
	pl3285MOBifvvU=
X-Received: by 2002:a17:90b:2f8f:b0:3b3:bd07:665b with SMTP id 98e67ed59e1d1-3b41c9325b1mr290487a91.40.1795115408162;
        Thu, 19 Nov 2026 11:10:08 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d1361fsm3678174a91.6.2026.11.19.11.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:10:07 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] spi: spi-ti-qspi: finalize message on transfer error
Date: Thu, 19 Nov 2026 19:10:00 +0000
Message-ID: <20261119191001.878454-2-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119191001.878454-1-jctchan@gmail.com>
References: <20261119191001.878454-1-jctchan@gmail.com>
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
returns -EINVAL directly without writing QSPI_INVAL to QSPI_SPI_CMD_REG,
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
v3: Rebased on spi/for-7.5. Fixed the commit message: the old code returns -EINVAL, not ret.

 drivers/spi/spi-ti-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 7e796aafd2bb..9e270c30d0d2 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -718,8 +718,8 @@ static int ti_qspi_start_transfer_one(struct spi_controller *host,
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
2.56.0.679.gc527c65306-goog

