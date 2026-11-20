Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173104;
	b=jDzOT24QAk15YEC4U5c0USJNPmvR2OJUNGwHSLqwHDqFix7OFQRkzuQPO+6YZk5RVuSJ
	 OTOJB7f1jmMmmbVgOaDrdpxWVBCsdEPT9kSl2iJuDnAfswpnHW3ocWlyVUaeC7h/DqneW
	 SMuD776I7OIqOfJRz9vO0xwJD8Idw6tzshDmWIXkXZyG2LijSRmo0hxFgJWUxPfsP1242
	 bcdyEN8vjze37GlRTYuinAEluZEv2nlLFtNXhHqlrJegS6cnveAt6OkR9f2PJN+l4yoed
	 0MbX69fGoD1N3PfumTwBX5LjHY0JYm7hN28Spsi7Ce2gHmI0UIfVhmSCaO/IgyIg7Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=0jM06NNRztaqgkVL9QhRRDLWWSTFLpsaLYwo3oS14jI=;
	b=csqWjdTnTo7c9WEK9od57hv3ZaKycMFL9krrthMvCuby5FeAr/ynIXrDcPE46nAiuSXN
	 Lj21ft0RPNk6z8k493qYDF8eTUGRiBJiCL6MOUhW6qg7hGxjZtQ3AnX6O7Fom2y5ZN9ae
	 WMPmmKu65s597AJ5eT+I4bVtA9/RVj0+N1rCWO3dPs153WbAC1pD+HM8pEANUFbbPHSaC
	 aW83gM7+V9TW2NFx0MY6QIWC8ongZ2YZ35ILCSJfZ5Uq0erSUWC9LzIaFXuP+G5aRSGC1
	 GCQLMjXQwl0nyqECFDsdlzVRiQRTfk5rPqByJRuvetdoenQSyY2m0XXMp/1dJ7SfHfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FXWG6VmM;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05F460A3815
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 11:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A05F460A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FXWG6VmM
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso6885545e9.1
        for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 03:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795173102; x=1795777902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0jM06NNRztaqgkVL9QhRRDLWWSTFLpsaLYwo3oS14jI=;
        b=FXWG6VmMH6OLfTYuEsn55AhkSAojf7dx89V8pe5TRX9Wjj00rrn5NLULxJwXQa4kSj
         mxFgmJrJe7zKxAoV6l/LSg3c/q3sNyAc8cxXxiFfPjrZeBsBizdUMD1dT6pBwY03sNtg
         qTjCLNDlxdJSUBbQGyN2r/I4XpnUrJnrt7AJt1NNICgGtppHYDWOXfJ/VitmHrEU6koD
         JAMWaDTau8aSYx+8vnJmgggnrhWTpX1p0Qc8CmeKFMSlwa1oZj9Q/j55M0Y1W/ygAcCs
         KfX0si+c+pT/qwDkXOh2D2VlInBQKw94eog4/o+iHE7eEVHfU6lEcgQr2ZJbU/KiEkQo
         oNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173102; x=1795777902;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0jM06NNRztaqgkVL9QhRRDLWWSTFLpsaLYwo3oS14jI=;
        b=O/uU4o6366YMeYrvhMSsTUXp0W5etoRbdnd3BvN75v7mxRD0Wl5HPf0nxgYyNnAUyA
         CUgESssOF4JhikyIIbrFRVquUei0EQ4F0gTth25hmotSvM9KBVcHJnnY+sDJhm7siOMK
         YnKspIoAbZRjH5zNsuRTpZ+cyeoij5KnQw2AOE0uEFOxGq1Q+lWgbk++QwjLHLfVOQft
         b9QNB5TSjVxq3uh8IkUb/iMCRkL8R01qy5Lfu+uujYujVHaK9Wu5HAY4KFFqr7VfD1G/
         7NPyu7rY4oaS+JmJwKBuklj0nrIYAdjeq8/HzSFLHpgN2QlU9BYqveFoxmThAybI1D/A
         86HQ==
X-Gm-Message-State: APuU4Z9/IGYc+ts+OaZdqYRQJcyK+4kwQbg5XTwV8Y6PJKyjJHhD8OuP
	IqViKtGUpucola4muDH54O4kgXNC10jvQZsbo/mijBnz7TM99IePTp7xbDkSmuBRD0XyiIW/dpL
	K3GzJ
X-Gm-Gg: AYBFou2PucuVlApwRIaynt20fRRmEt9T4NqwXX8xJfIOxpzFhMVvhVhyNMzDGIRc0cw
	q/ZzrwiIHROOnk+8K4wTGJX/r4pOCsa1IYQfHbg+sVNuhCq/jQs9q1GmFjSd7xwiS+agYjCmPHr
	xdmMrr4vVDfHcYBAP+BTLUe1gcKTwJ31XpjPtsKA+oRUjohxLMKZiQUmUK7H3k28uN2HEo4TYS6
	0/Gp8cg4ltlW7OiVi2Jo38IVaOoxPmhJEb/Ov9hHGgqD2DQCJ38Jq/R2vH0iKkM+K99TWoKcjq+
	a1TsAjU1lr3NbtIa4hPfDDoudG4TLrTZWDfqAX3dIYZWOdGmOi2r57N3ikUmvQk0ZHxqkhA3rs/
	/RbqJlZ3lIDBmKIzrlzq9/XxrAWGeSeKIV0VBypIZcv6eXA4hcBRRcCvF0OE7iwSeIJYeprFwr6
	rbQSoDJaABjShLbg3FTWjJ577ezLdMKI2wBliEBbIne6se8Sz4v2wydqclJI3Qp+LnfjitcpLFV
	evrXYFaA1272juNCIrA3B3xeIdSkjG1PKlS+BC6MYxprw5RFyDMGCtzRtUDpH79Gr/Q/nWKdptR
	xonbAzB71/Y8zMjvfKkBhrZniLTVVlHiGkxjQJX773U7oBz6s4fZo1gZj9KvIW9cKz0NnA8ijSd
	YYf0yIm5DA8Zl5+Ch
X-Received: by 2002:a05:600c:6749:b0:4a2:d99:3171 with SMTP id 5b1f17b1804b1-4bb8881b52dmr56670455e9.23.1795173102026;
        Fri, 20 Nov 2026 03:11:42 -0800 (PST)
Received: from localhost (p200300f65f19a904be03815e1634e776.dip0.t-ipconnect.de. [2003:f6:5f19:a904:be03:815e:1634:e776])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb853368d3sm110939345e9.1.2026.11.20.03.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:11:41 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Subject: [PATCH v2 06/10] spi: spidev: Allow untainted use of driver_override
Date: Fri, 20 Nov 2026 12:11:07 +0100
Message-ID:  <3821faaf865f1f96b45f6156b577cda57eabc4eb.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=778; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=CLEaCL8mVVGT/tu2tm3t3+NNXITrx9BS73VVnxuQy/g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrACrW7Ko2gtL3uMsLe0fOnLTdMd4UtSFA3HVSk YvjkOd0/pGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawAq1gAKCRCPgPtYfRL+ ToxcCACH8GV78LsnsRKb38ZRWtK7wLH0wnqiOgFIFfFGI2Sr7o/OjjuR4qabinWkSqLlbT0WXQ9 XAXmORYDBURc57PHYYi9CMCuBbEYHixQaxkfLrO0ZyQM/F16nN+W/BnhDHLC20CCglcCF0yB2BB YPoWwj0CfOGSvxv1AJiqoOid22R+3Di7tDqtWcve2dMqpW1STt03++kMx82wolSQ8iU+rYQYCeM TenDhDUSsAXK4svgHLnflRa5qvgkeBNuukxjGO4QlSi6Wz1dSWO0J9oIwuiYdPJupkJjL3iAn+O DCHpGBHOeCxR+wKK0n3NQ3/UT+k1J0Qhvd6ddl+m0CNsWNbN
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The spidev driver is designed to be bound to devices using the
driver_override mechanism. Set .support_driver_override = true to
continue having this mechanism work for it without tainting the kernel.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 15d2aaeb08e9..0b50474ab20b 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -843,6 +843,7 @@ static struct spi_driver spidev_spi_driver = {
 		.name =		"spidev",
 		.of_match_table = spidev_dt_ids,
 		.acpi_match_table = spidev_acpi_ids,
+		.support_driver_override = true,
 	},
 	.probe =	spidev_probe,
 	.remove =	spidev_remove,
-- 
2.56.0.rc1

