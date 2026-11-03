Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746414;
	b=JPDRCNzCnZVoRXIf/+aVQU1Ig/uGztDFEjFQE/STRVjmWJM2jkzhl7jNLeJ4TZh9/i7F
	 whKbpmTXF4ymdQ+g0hAC0Z8HZMpZm/WUR9fpSjcNXEIyXQvR/pYvO7g22FvMPQXs2kAg6
	 owM+xfCFZg2yxv3yiiNkA0WrT8MRV9xZ/kMl13euGSfcQeId9UXg/UwSWm8jrUJxTNIqt
	 hjudd6M12omihMO+apqbBhwI5bz4MOG25Kgpwxy9yInY2TEBZLmIcj808lCQranpMulRG
	 S9CJzyJ9stCvkMYeToLy0SthKOidhnl1IKkaWTulaNUY5n0s28t5kIPC4ZLwq1usxag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/ej9wHg+NEebYYZRQ8OvgGc8M4xhsrwyP622zhe9cFc=;
	b=j2WeQdgwhbCiEXl9/Q49XJHNBmZg//85RfyQoDlaUN10C/h9d0pjiXUF5rDR2IzDY6hs
	 FOpvIUXlrLShEw8D9+A4ujiMZFLSo1yXeT93aShNvxqKoo5Fv2ARug7cetmXixMPJogHV
	 8tFNZKjfcmjcKhtDcHp2Z5Unk8CoejqMbP4AZrLHF1ARrQ9R00vNuoqc4tUD0t5XqKm9/
	 Lu3BYxNFntOgxmYcIRLkw9gnK2RvSJpcMw469h7xV5n5hdMMU6zg4wl+NiE9Jj13g9qJA
	 TkuuLyeJVY+/uI6xfJgkCPEGd4001XUmzcZ14actx/XwQKGIrhIMyXyig6Bj49ezXWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKAN8CYv;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A05606A31B
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62A05606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SKAN8CYv
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so93613a91.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746414; x=1794351214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ej9wHg+NEebYYZRQ8OvgGc8M4xhsrwyP622zhe9cFc=;
        b=SKAN8CYvRpttpa1v1rBN1XEJypbWTH712BPffEjYu9OF9gKHQ9VySqtWKFCkrw3bUc
         I6cdLEx5K4WNxgXljiL4R7SGZwb1nOCvgO5DDC+TuX1wnbJgVF1+5otmFdj6JZltIMrt
         AD4/KJYIL0zRoBDdSSlCXoep7GT6ALAAyYXyJ7InOug+UbTxRA/TXJ7ist/0BmsB678g
         q2Cj8jsUBB8EYGxSF1ffaceetTrmIzFQkOYMXyeOe2IhBLefEgdZ3uG4glrgG49qOqvk
         15o4fWEsyXCWh1NLWbvWNo1GAvR3vx4eRHDXireHPyozd77fbx8r3wnnKQItj2OZcqJs
         QfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746414; x=1794351214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ej9wHg+NEebYYZRQ8OvgGc8M4xhsrwyP622zhe9cFc=;
        b=z9JU4RCw57E/Kip7Bb00jmG+8gnS7wNoieI40F59TL39miPid7qXO6yuqNtpcmypq4
         EUcjeGHpbC7UEHxF/mJbtCsvSZ4f/CqZbGaENxP4O3/Ne474Al8k27KTg8xR9Kq+1PLK
         nK7O7c7igb54Jo7givqL4DZjxx6D7vsX3i43/NOI7biLoOiXu/gbPLyFulyCZjp1e3R0
         fsNKt6PnkbP19+4iQrfFX2bW1QSiKmbXQzAJn6tC//rcjQDgWjLyqkHdAMJxZwxeuJbg
         pJt6GvuCeP1Q/1NziO3jKKSZ46NOEg33MTFKmFuDwToKbcBYgcHYccqd3tWXCbDs6NnX
         ABrw==
X-Gm-Message-State: APuU4Z8EUq53xODsJk+xTUcVtN/Y0kHRLFLvRHPzNfUIVEI3szlfbdT5
	uTo25qxp1jY+z0zsrVbdw71lRWFb7nvgkhFNosg8yUFZIvCIz6OIYX5w
X-Gm-Gg: AYBFou1pFsfhn6kAK4iZaOR0makO4ixxlLcGUQvBUZxys/dZx0+L6PGK/qGuUUGW2ce
	LvzXcxhLEENO5mBKNwujBvqrsERtSe4IZNj1Tlp0QAA8yDvWFEvingmn9Pp6f7XO+Iw1nSbO+ox
	5tDSEjWkMVIpzSApGYf7y7q5Y91THB9q7/5HEW1zvQQxy+fAj8+EiOBf4t/BlDccpJFPWNFdors
	iOh7uakMxQkhYRu4oLW/GSVYbg2ik5EKXdEliCIdqLIHvlBneSIlhyx4Ug98Iccncf4VRVHIXVk
	CbEWtQ5ZKoK0uEDY6GUbMpORrGET4X9jsvUumK7/dd6sHGwEtfMVBuEEKxTz64sEdAm/SrsbZSV
	n6ZigsriKqLMBFb5tC6y6Kv44FcYYJ7JKZDCN8kPC4J/r4/FKijkFRci5MnZjOyLq5LeRJ7OK17
	m585+iFW3uPYZ6eylGXEGCqlx5mi70LKFMrbYBJ3y1nWRrTBu1kvDcPmw4WNICmQIKxthMkzOhK
	sjZAtfpoBTmCfNpzLAl/BRBiVWX9EC/cJ19pK+Jumw6tOqZ5Sjc51MkvMe7yw83x5C9yWXQRMDW
	XsXPmtOlUSpkRgKs6MVbg5Ia5b3EnLGU+Vu2xVY1rXIpdxGsZMAlEG0uxgqo5m2JeqNdmS0Pjde
	jFGroEj+7aM6dBQj838C8g5jRrTvmMmcfQpks3MkiiT2JjFXDV2rUoKHZ2nw0B/Q+BWd5NAyS0k
	9ZN5ljMTtQn5HzJh/lGTzVsibjFDSoQFuAz0f1CCrR+GYQYnRZiFFDfaZ50wepdnI7Qg==
X-Received: by 2002:a17:90b:4c08:b0:3ac:8741:e2e8 with SMTP id 98e67ed59e1d1-3ae8957cb02mr12193950a91.8.1793746413635;
        Tue, 03 Nov 2026 14:53:33 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c896cc6sm6096249a91.9.2026.11.03.14.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:53:33 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] spi: spi-mux: release mux when parent setup fails
Date: Tue,  3 Nov 2026 22:53:04 +0000
Message-ID: <20261103225308.3633046-2-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225308.3633046-1-jctchan@gmail.com>
References: <20261103225308.3633046-1-jctchan@gmail.com>
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

When spi_mux_select() switches to a different child, it locks the mux
with mux_control_select(), copies the child's settings into the spi-mux
device and calls spi_setup() on the parent controller. If spi_setup()
fails, spi_mux_select() returns the error without calling
mux_control_deselect(), so the mux stays locked. The next message on
any child of this mux then blocks forever in mux_control_select(), and
so does every other user of the same mux control.

spi_mux_select() also records the new chip select in current_cs before
spi_setup() runs. After a failure, the next message for the same child
skips the copy and spi_setup(), and is sent with a parent that was
never set up for it.

On spi_setup() failure, set current_cs to SPI_MUX_NO_CS, so the next
message sets up the parent again, and release the mux. Record the new
chip select only after spi_setup() succeeds.

Tested with KUnit (spi_mux: spi_mux_error_test, added later in this
series) on ARCH=um; that case also needs "spi: spi-mux: finalize
message when forwarding fails" to see the error status. Builds with
W=1 on x86_64. Not tested on hardware.

Developed with help from the Claude and Gemini AI assistants.

Fixes: 5a5fc308418a ("spi: spi-mux: Fix coverity issue, unchecked return value")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-mux.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 08fe1fa32dea..28d7718138a5 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -66,9 +66,16 @@ static int spi_mux_select(struct spi_device *spi)
 	priv->spi->mode = spi->mode;
 	priv->spi->bits_per_word = spi->bits_per_word;
 
+	ret = spi_setup(priv->spi);
+	if (ret) {
+		priv->current_cs = SPI_MUX_NO_CS;
+		mux_control_deselect(priv->mux);
+		return ret;
+	}
+
 	priv->current_cs = spi_get_chipselect(spi, 0);
 
-	return spi_setup(priv->spi);
+	return 0;
 }
 
 static int spi_mux_setup(struct spi_device *spi)
-- 
2.56.0.385.gac671c819a-goog

