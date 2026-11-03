Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746415;
	b=XR7C02U30e8FUdI0IkhEsdrpzNQjgyA2PcqCrla0VRzzVJyJKITgUf0H2baRqheAvGu2
	 w3OMCRnu/WBDraF7YHlwThnKdEJ4D52DIrMcom9f6DZLPJxWSjy57GOYkRwoVLuNAzK3E
	 iMl3BiGBXquzglp9q/a1txUzVxDqr3A9m/hi0UnqXyo3YCwCm0ObAp6ODWGRVceTzAmVR
	 dNe2df07tLxYhGgk3GZkZUkeMD2HpwZvTXVhgEZFPUUiKBtgVDbcZBUVWWkZC7vlpy+Ur
	 7UYMulKyCLneUg+U6HU5eG4lCrgpYxr43/Oj6I0o4qO8oRTEWyHjRn6aNudi38KnKXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Wc6qCbz7ti0d7DipF9tcPtrqQeE8ZBa7HQpF3/MFEtc=;
	b=HIPavQN1eoDCXdWjf2/b+eQXeJnJTnJc/a/BGAgZ73/fA+0lZ9qxdS/x2EvuQltJ2zWC
	 l1GAzIbk123uzqrwZZu9VCqb0502ZqOBq+wRZg118MHe2Un8AMdyG3DOJMZV+9aSIHCNa
	 kHhX/fOrNUL22wiuqN8hb5quVBg2cQJKy3yYsII1TKihtGPuCRuyakHLosFdJptbxpFbI
	 OxPJPWd8jfodk2CnCNZIpxOcXnFp9rixg9Jag+dCnCLXgVKGrIRCJF3b9FbYfNln0blgi
	 nNkh+x0cxv0Z/H0qeptzANQWMz2+pyC94cjbY/AZYxke+sqGwL0p7Bo8HkhtmjDHVqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwvcyB5C;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73434606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73434606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwvcyB5C
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so42223a12.0
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746415; x=1794351215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wc6qCbz7ti0d7DipF9tcPtrqQeE8ZBa7HQpF3/MFEtc=;
        b=KwvcyB5CjrFjB3AM5JsPGC7/v2MUMFH62wJHwBoSVgdLXAs5oJBp8/c3kiEmmpujOD
         8IH3esGrKg4mI6jNhzCcrwoTuKcDxribhdC51mqS+mIfuID1+vkMMaxsm6OFV3Y0MBvD
         GsF4CNLTV+sFDHY4CdbqKkGFtN/rZJhkhL7a50kTnONXgwSkQr983tQeYbNcNy6a4JQ0
         8VCxCxbjO5ByUbQLs2fglbBcWnZMqv+mUCq1q279QK61eJ93Eyo/64f29+QbCYi7wNLy
         EiqX+RjNsLwN8ESiIb4fcIEJ/akIF/tWy74Nk8dZkHZUn91bbMxajRG0rG/xfJW8E01U
         sfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746415; x=1794351215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wc6qCbz7ti0d7DipF9tcPtrqQeE8ZBa7HQpF3/MFEtc=;
        b=VS/bjN+jmzKc2rDOaf7c7yFa1UyLtLX44Fafx1hpFTURkANgbgpA9gGdUkCk4MUxxZ
         XWZGZk7e2m4SEWaaiB80MW57u4VwPr4Z/dH1oKBcpPhrNHe3Rq8macPjO0TxuDO9cU62
         7a++6a6wM3xiZfxxDykV8AVuHSCX3SEHjOSKVUO7pOMm2dx7Gni5u7fjVnUtG4L02z65
         OefF8o5+F0D+aBqXyd3I7gwRAzvciz0gmwRBwj0DxO9HK94A0/0+dzeJsjf0+e6jzUca
         WymiL+gkF+5s6CHSqIU3hpitSyAhO0JfACfKb3vSjD29/m6fda8SvyHuZAJUu8qPoDUO
         Gu8Q==
X-Gm-Message-State: APuU4Z/xTXJwKqpHsF/Yrwc3Kh4V/8OL0d4+Afyfcin9Ya4AYalvUWBF
	UsEPk4KputYtq1OI5rydDN7wNCHUDGRfgh21w6Pa54Qrdnj1gpQiCCBa
X-Gm-Gg: AYBFou08m/KtyYNfwcTzBGDAO4Q+4damjVugi5MbIPaE56zgyUjBUJrXemrq0V4eVay
	0AL1MDgIgLUch586LWPy6lSpVA6vr5h0plW0ovQfKzz97g1wfJMi0R3PPaV+g5us97K3zpba2Ib
	lsJxb/fUXvIkBwcBoAarmSqJrObaicZE54Udd9upWpEW6OYBcZ4iC+3RfDL5dYyuObN6Xz2XepH
	4Z7UysJHKp9U1eMbC42BKgIrEu+ALHT2/JyVYlwGorRYFOXIVj/uVN0tBPXs4iSiQjeAcmFkafY
	sTMPFueci3J+C+Jt5gI0R8U+V4J3WFgsWjCMiV+thYK3o9yQtOTpuUqD38gMC1AjJsqkkePZhxo
	G/UUsg1UbBCXigrmDHzfv5snkg6VLSKx/qVMrjbaeWlQ/sufTc3GeLI+E/ZwudW2bh4lCoGE0ij
	cHdqNlHEzixIz7yTEwYvWADEY7Oqa+fVElBKSy14+n1fC3PmkBzH5baQQFuluzLXpmFPZ2dYRGB
	VlGVeA3M1NuVdQTxRiHRz5PWvbZPz+mmgUjnSoM8iB5BV4XAgsRuefnkFdgf+EpJB3xyHeEP3YA
	Hy0S82n0ChK2KXQyW4y16cQJjTGZP+SKfO4VVbfnR4Txua2ItDEb53cCDznK3ixRgxeIg/eGgXx
	exX3IgCBbheOHD37I+LquZAITr/LYR1iZcIWGNZIP+EG/urlpVw7RWO+gWVJBAfU5Eckr+a2qo2
	ACIUtGNI40Rd8Q8A6eR/c7hwqPjQ0ycCKTrrDLRNDyfFozJOV3lgvfq0P1otckqoMPw6nlMphZk
	PmTug8GzA2S1dE=
X-Received: by 2002:a17:90b:b14:b0:3b0:92be:ea4a with SMTP id 98e67ed59e1d1-3b092beee8dmr525289a91.45.1793746414486;
        Tue, 03 Nov 2026 14:53:34 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c896cc6sm6096249a91.9.2026.11.03.14.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:53:34 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/5] spi: spi-mux: re-apply settings after child calls spi_setup()
Date: Tue,  3 Nov 2026 22:53:05 +0000
Message-ID: <20261103225308.3633046-3-jctchan@gmail.com>
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

Developed with help from the Claude and Gemini AI assistants.

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
2.56.0.385.gac671c819a-goog

