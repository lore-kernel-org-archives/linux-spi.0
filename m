Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CA13C8728
	for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775510; cv=none; b=ig6/ALJV9qzxW0xcN26pTnHJrp0RPVeT/8Ii5U+P73lnMRqYEYOoSH22iTtp9lxcrswRB+OSEuClmeM0yoQobQnon9ttj24hyZKzYjgQTjp4MIHjKeOSONvD78/SYvkilEg2Vzg9ufoh8SwWlG1JfEihiy5tOD0nS2nZfQ/zRm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775510; c=relaxed/simple;
	bh=o2Hiy84rnP/9UMKURCEIhcD7/nHJlcIAPilhOK3M2oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=La0zmBT/dDiYn0eIQ6D43Vzl3y/b9UGSpTWAJhQW32bsdY8TCrEXO35uCiW7VCtCYfOL4VDtXLLwpGN5p6garlTIBCR13jvfM3YwQk94ASueowqrm4oi7RPMqeJ0H29RHbaWCFGEipHDbn1f0008zmbnoJvXssH1Kg7ajabKxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccf2360620so15530655ad.3
        for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 06:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783775508; x=1784380308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kJ53oWqRjCNjVlROCxKHTEOJ8pLHHBllpxRR0nGEHyI=;
        b=FR6ArQ6MpcGGXCb7aqvrTrBvQerYVpjf9D3vb4oqUS03euhxQ+y9o0E1vp59v6nnDV
         xBWLemOOBiylWE4X/XAmiZiuO/nNFu7XtLN2knNHuqD3OyPDwT5IqZBpqxRaDxD3z+nF
         arfBy3gm70W7CApp6alnweKOGfVRqZYRt7K7ef+aWo3StkFWDD0ZJ7gAbo/inbISQIkW
         zj7ful9a5kO+k2S6jAGnpKfBD0/vatlfMFYrK3CeC9tY9WvQa4KJBnRGBVty0wMqJVdM
         llY+53ZdXvFPms0i/zoyK8LO7p1VFq10e6AP3ytj0XD9JhfSqnkM59EELK7ymI/I4Ueu
         LrKA==
X-Forwarded-Encrypted: i=1; AHgh+RovZ1BDKql6C4vsRGcCzQQ5mdHqN89UQLL5Lwxc5/uNjAzLmC59lGevczlxP9xwl3VNt5qG9OFt8wE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2wP6lWez8lIpx856MEU/OjEAKws6eQI3YAsqXnR6QJ5ze4sz
	qr7nHgiZ0u8j7ABKEvHGLFGr+MEpXozG7bb2YInyoatTKB3Vkv24L3Y=
X-Gm-Gg: AfdE7cn08KaVdOzBLIbCojVodOp+kW3qZYjk63yXsX6zOWFFBrxjJNaqgSJslTnavvK
	p+W4hYHc4JdCQ1MGBT+kp7a7muzT/xzo5JU/uWhjtBn+FpvQ6p8/aiS580Xs+bA5Z6DwgLUuO/E
	W8BmIHuiZsaumX7uAZLaRkigOBJrlXNkFvR9pG3snBYmDyXMGlebgtV0FPfQp6UfTyG6Xn1w3XE
	ldJ4YnkkgWRQbSOiQ94o34LFfAE1JHeW/oC1aCZOJo5gjqetfi5yKBRqdcQL1CMVXkRBw8l0jK6
	fCvnmrq6nEEa5iGPaycvdlVsClzgUGzj1hgm3PWqG6YJ7M7HZGvkDMsClUF6KNo4AcdHLjPZLbC
	8gWP08hYShq5GM+zfCv29SbHqz+MYoRVFZ9jHkDI9lz6BxjZj8voMS63EolzvEQCH4LevDLQkTJ
	0SGdGTS4RxECxq/tFqEkEHMQhk8YrK2ZULTIv408Bmxo/MszSo1czxJHwZURw3TTF7Y4bzybKs9
	is+tCDvOyUPaKBYtyaRZhcJog==
X-Received: by 2002:a17:90b:224c:b0:381:b64b:5a28 with SMTP id 98e67ed59e1d1-38dc779eb0bmr2445869a91.30.1783775508217;
        Sat, 11 Jul 2026 06:11:48 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55557f25sm4136221a91.5.2026.07.11.06.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:11:47 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v5 1/3] Input: applespi - cancel pending work on driver remove
Date: Sat, 11 Jul 2026 21:11:38 +0800
Message-Id: <20260711131140.18777-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711131140.18777-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711131140.18777-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During driver removal in applespi_remove(), the managed private data
structure is freed by devres. However, the driver does not cancel the
asynchronous work applespi->work, which registers the touchpad input
device.

This creates a use-after-free (UAF) vulnerability if a pending or
running worker thread attempts to access the private data after the
remove function returns.

Fix this by explicitly calling cancel_work_sync(&applespi->work) in
applespi_remove() before cleanups.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a70..3bdb9e7cfb8b 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1822,6 +1822,8 @@ static void applespi_remove(struct spi_device *spi)
 
 	applespi_drain_reads(applespi);
 
+	cancel_work_sync(&applespi->work);
+
 	debugfs_remove_recursive(applespi->debugfs_root);
 }
 
-- 
2.39.5

