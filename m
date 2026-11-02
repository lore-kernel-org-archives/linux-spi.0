Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637233;
	b=xcpZPuGVg1QajQzEmUJqHaXUf3GWhWCOFvrqwLkO0P2hWaS1SFDHMWEeGFTPJOFeZB/O
	 Ke+yAo5oT3vVS3AQTaZ1hiizSWgqtKGm8M/QmdVPlu2aBmx+MXcYiKxVNypgTUvx7RCKp
	 xRmBlPZKud47ZSKsG58U9nFhTsBNHgTzQ6VCbr+PKtP9VHJZOeztp7I9NSd3fGBjwJG8r
	 r13JUx68rFBt/eBzY8j5rJE5fEXJxrGUdFEqtySeNfxEyUHrGsmork6osF/JfAss2GWRe
	 SMZE2351xSmb/t7+mbnfvmuOO7H0mBTYdVmIncfDOfUyCp5n6g5zk2UZ4fet1g6llSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GsT7dQdzYb//Tj58M/h2/btkEU3iSa7bdoRYGllPuSQ=;
	b=HbnuSTopzW5bQUYy6sVj6tqlLo2NDXEIbtnE2XhHs8K/oRNBibrV+3jTve5q6PPPZ5gH
	 sX3HwAGmOIlrcubohjfA48xgCiVk9ed/3ZVszSf0/h1bO7HdxuXc51mEVXp64qRqM29+u
	 FzZWn8WUykNruOg04hZdH/vwaB/EmEFRtukx9TOgT9BhJJcf53sctuLrvGQ285bLS0zDa
	 b350uO6Vwr+GJeOw285oR0PuDoMkPjpi4XEozHtmZDy2BUgO4OzUPniV9v9kzjsRKWEdW
	 OZO7nGVx3ODUr3Xoy+ynZ7VJ9mC6bmW1XZ8EBVrNivRb2qHq0VgWhWv8JBta7yfg14A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W6BBKHB9;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B660A0CA0
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E5B660A0CA0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W6BBKHB9
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so1621585b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637233; x=1794242033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsT7dQdzYb//Tj58M/h2/btkEU3iSa7bdoRYGllPuSQ=;
        b=W6BBKHB9vJiG8WxW7k4wtuK2BlOJikkN63ayEZrCL00EuAJDEK2vRV5/MfcLtfngDv
         wRzcTaSTgJ6LLjETkk11WbaZENguMRaSUIuCDw9RJYCgzbFqG2+s1fx0IGh8jZdleSDO
         G4GjASaZL6DjsSw99p+1DAgp/b0sWesBFmyw5Jr2t/1V+G11OnlFA0HsCLa8CvJHa5Ac
         qZLYJ6a5b9kKKgycot19gr2AeIeP6BXj/nvOo7SwDvnHjPvhauotQarx5Sld0F/8YG9t
         lMCovZPk/0KNalCdPgmB/sgH4SW8Edz1zH9i5fQ41N+Zzn9sHhlO5SK+NJfLUZ6PqMaZ
         +Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637233; x=1794242033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GsT7dQdzYb//Tj58M/h2/btkEU3iSa7bdoRYGllPuSQ=;
        b=2dsqtj5DN85IDtXm4OKG7whXRAq3/u/eGiJr6pn4xWzm7ugM9q1mRwwlDA/nXKbNzY
         qZgRzRZFjB0b4ifY/WLVylH7w6kfU0EcO6tOczSpcj23CgWRCfZ8osVdWGn7jH9Ljpf1
         fk7fV4InIN05S7k4KCZbo7zCqhHtyL5yWJ3IObvmcyIDc+HRjnOKTImCiTdkTU+gdDk4
         tSSKNWwSnwnCqrpH4Czfhl3F97XKc96R74E20a3e0YyVj5cT5QjQhN+b620T27r+yB/8
         CWz4EtlecWyhyIP3shdydpSXdvnPMu7f5OC8ISj2KZ4EZDl/22NJVvCWe+V/uXGl8DiP
         5B+w==
X-Forwarded-Encrypted: i=1; AKwUvBzaTX23mKjwKG54BlpzdfS3gglrYsJ4RBm3oxK5sk3fkySguuKxivy8U1KIPLRAzFOLo57as2ZjDYo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+C6OOeyD0PiySoCbwoERPTUZ8X1FcH8nSeLjjUyTZBu+w/xgJ/
	G22SZb6XWGvgaTYy1e9DZALxP8u9t3bZ7egD8iYq/WRsDp5wSbRYdADU
X-Gm-Gg: AYBFou2PDUYCCUcqyks0tdnL4A223+rhz8IaO95NPzUU+8CQdmWA8vD0N1GmQXriZ8g
	vj+GsJT121cN3omyQAY6t5D4IIEY2ZBMPFL/XDO4kg8NHSicHVS0MKSc1BmVY+LlTlxi717J4Qk
	0Urm/9aheF3lz5Q6JHsLkBuFWN7ddIG/r9aK1SLRIvjpqFqCg5S/Wh5YLukB0Ttcp7U7ySmdeRJ
	ax93CHJP/uog2UrLPkyaTIXDIvC6QO6HNIMNg3T6eEXDEjDgRrNEEaqBh5ZIuAXw8W7CDGG/Ee7
	KpbPX90sRbfQWmfx7DmpF6tjl3Emx8Pr5pPeCdUViKaJ8fw9MCq3a5+LBk7IkYt02j2fR2EI+hl
	vdrf71qYOzuL0nlEYbaL0mPHJrN5GFwITr5BeNG+NG6oCWlihwxo6lPPtRom3Saa+TxJIT51pM9
	WY5Ep/mCQ5v6hUnGz6ciKpo3KRqKaiPm2VyV275NWFPA3h/1Gj3TOvflgf+HiqIxUeVW0WdLmpy
	nUpo5biKIMpl7zWe52mrGVkthVv4g9+PkDTt2h/96JdKC1A31gcHEygxK6lyXKa4MzFprPb5nxW
	TL3k8C5+sol3zcFEjynwIEuD6NLnbMp+nPZT7xlT95eG1IK+SnKJtavHEXxTbM0QL8fFdaHq0rf
	akidJZaLyx91pqcn6xaYI7ttaLFzcT0MELu/KNtywtZTN4nqB7LfDL+ykWGB1Qf+mbbxb4L1gq1
	F2nFP6xPzLHN9k4W3kdLN18M/zWRrYYIpToveELYgVwZuoHn6nE+w=
X-Received: by 2002:a05:6a00:f0f:b0:8a9:b07c:7709 with SMTP id d2e1a72fcca58-8a9beb627fbmr6311911b3a.19.1793637232793;
        Mon, 02 Nov 2026 08:33:52 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:52 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 03/14] spi: spi-mux: re-apply settings after child calls spi_setup()
Date: Mon,  2 Nov 2026 16:30:12 +0000
Message-ID: <20261102163023.2574632-4-jctchan@gmail.com>
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

spi_mux_select() copies a child's max_speed_hz, mode and bits_per_word
into the spi-mux device and sets up the parent controller only when
the mux switches to a different child (current_cs differs). If the
child that is already selected changes its settings and calls
spi_setup(), spi_mux_setup() only calls spi_setup() on the spi-mux
device with its old settings, and current_cs still matches. The next
transfers of that child then run with the old speed and mode.

Set current_cs to SPI_MUX_NO_CS in spi_mux_setup(), so the next
transfer copies the child's settings and sets up the parent again.
spi_mux_setup() runs under the spi-mux controller's io_mutex, which the
message pump holds while a message is forwarded, so this does not race
with spi_mux_select(). The cost is one extra parent spi_setup() on the
next transfer.

Tested with KUnit (spi_mux: spi_mux_settings_lifecycle_test, added
later in this series) on ARCH=um; builds with W=1 on x86_64. Not tested
on hardware.

Assisted-by: Claude, Gemini
Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-mux.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 28d7718138a5..a7ea6585b374 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -86,7 +86,13 @@ static int spi_mux_setup(struct spi_device *spi)
 	 * can be called multiple times, won't do a valid setup now but we will
 	 * change the settings when we do a transfer (necessary because we
 	 * can't predict from which device it will be anyway)
+	 *
+	 * The child may have changed its settings, so make the next transfer
+	 * copy them again even if this child is the current one. This runs
+	 * under our io_mutex, so no message is being forwarded right now.
 	 */
+	priv->current_cs = SPI_MUX_NO_CS;
+
 	return spi_setup(priv->spi);
 }
 
-- 
2.56.0.317.g454f8302e1-goog

