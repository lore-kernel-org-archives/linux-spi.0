Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794011609;
	b=NV2KuDzHazffvD2e+3Ewh5kUpbWsaagmE3s40apSOryKB7ojJz+It8s26I+LZ8//TLGs
	 faGdUUb8M8p8CeFrOsGoOZTNdJQQHPE9odFyQjQJIVa5CVIexqFk/LVPFH9y9QCEIfSp4
	 Iy1JKKyVWgeu4YHQVqXAys8azrgbfLnCOVpuXX4Zbq3Gtk7+uvw1rjluc5afiGYeSDl3c
	 RrusvqrKhsdDzxFCRUTsDU/A3pB7FwNgDTm741N6wgwCi2+U6LfTj4FDTFWLA+q6Pv35/
	 SBKexEslFdKdau4HOGRHZCsDuKc+z3EFSrnos25RWnnVbgu5RY+f4DlXLoACsOsjkqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011609;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=WMUy4txGMl5roDNZhY9tu886qliNRol+/oxaNAbU7p0=;
	b=lPuGjYINsfDw7l1eMlKqjiFYpMra0/rLAxPFqAVjJFSkDZLuh8XFYo4Zrm8PjmbTxGf0
	 PKebhS1JYp7P5a9pMPW3NDmF2QsPc1qv3un5A0zRzZ1LilMrbpt+IInixg0CrRM+8DvA9
	 0aBBXh6T1sMuZVsyGxlzjuR1cTeaCmDRkyirujUshZLnYgq8ukM0HU0NpxUup57Cpyld/
	 p+HxSKejDp/hz3QDUq4oLfupecwig3Oz+h+b4s/rE1T27MeYLhS/E6zJEcyyFg/4v2w2s
	 p3CuRvOLWCXMNZtQzeLN3YmvJ5xD/vKJUMh3esHZfuzso3MeOhTaVW6q0Na3WN6Q4dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GN0sAbdZ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650A606A32D
	for <linux-spi@vger.kernel.org>; Sat,  7 Nov 2026 00:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9650A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GN0sAbdZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794011607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMUy4txGMl5roDNZhY9tu886qliNRol+/oxaNAbU7p0=;
	b=GN0sAbdZIqC+bbQKS9wwujWeiiBWGUmhmG2GdeA+Mm7JS2231Z0LGnafs+Q3FxBfG/QDna
	z+ZDrs8kYzCFPj5kaDbSenjQly0idF+GUWSxbrSOS+EoMLrrjWneuGLuIb+Z+zMZoY+5o5
	59EntNS8MsR5Sz9Px6GEuziRzbM7ULc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-Wc-m5XWbPKuF7Tcs9YfDDA-1; Fri, 06 Nov 2026 19:33:26 -0500
X-MC-Unique: Wc-m5XWbPKuF7Tcs9YfDDA-1
X-Mimecast-MFC-AGG-ID: Wc-m5XWbPKuF7Tcs9YfDDA_1794011606
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5383d650f2dso19204701cf.0
        for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 16:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794011606; x=1794616406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WMUy4txGMl5roDNZhY9tu886qliNRol+/oxaNAbU7p0=;
        b=Uv1InwOMQtYBqo3tqvYQdE0PDelGH5Fi3dRynUNa9xHzbpNOsn5+rL8Sjmr2iU/1gK
         tYzarvPA3PSmVRPoVBn8xyt0PAweHNmZQw4eqlwAcww4f4khwNifBhggyF124MXTAZmg
         7C0M9kfyU5h7flFSmkzzwhRkU5o4+9545BG6OqdrQj70HfQ5YkBLPjcR4p0Fs02+2xg1
         74g8MR2lS+O+vVI5G5azHEXjgCPX+UnthGvBt5gs6O4ipbAeu1RmeZ9LuXIjgEzaGUQi
         uIg8DI9Mm+xebB33pQL3vxhfMhNIqrk49KC5/SMoBPzdLQ0hAeBZ5yOyaymdRAa7bjcE
         Omew==
X-Gm-Message-State: APuU4Z9wDuUbJrz2iZL0s8uXiZ+yffJXW43z4nrOdHqnsEyv0sznzOI/
	CM7xlBvUorz9Qf03MWusH8rgQMnU9IkINc5LLcVBDtQn1ohnO/YU27Wk1rb1lBK2gF/MCCUZAcA
	bBGgsXRHQHV/2/QyMx5YTr3G4WcU0dhoa+xWlGcbPvcZK1onVM8+erlUoTqrahw==
X-Gm-Gg: AYBFou3yvkzI+e/XpV2iWGSYrUtVAk2p/YqfC2BsZ2csWq+oy9QlM6fqBgoAxxwFSP/
	EuciWKUO2njA+c8dH1+sW1TdtNZq8ajC6xjKtFbI35zdzbvOJNNjUfLAE5LXoY6GMq+nrZAqYEv
	o11VhwqLd1jIpiX/TQrvtFs7KWJA9p4Ies+BEysNWWfax/ehSADMlom2xI/BNIas6PckJPvmVqI
	eqC9EBf3Y4DmTm5LHYpR7Uzscmslx7vr0MvPb/FwTayAGuGxflmZCqSX85a4sKQaq4Q584Z1wFt
	8ZbYJiAMO5eqYUsX7jQpfLhVcekckT+/TITG7Mgoh2EOT+bZSibPVcqCvJiyYBG1NvKcZu5o8Ns
	S/hNtJAOpkpCXkENbezDE+3Z6dCDZERp5QY7bRkSFcLMrPiTGI/ajMPRJ/InH+ihxkkAEe24fEq
	Ho9N3pLyDZ21b/9WW9
X-Received: by 2002:ac8:5fc8:0:b0:535:a5fb:6459 with SMTP id d75a77b69052e-54e1576c1f7mr69286671cf.68.1794011606002;
        Fri, 06 Nov 2026 16:33:26 -0800 (PST)
X-Received: by 2002:ac8:5fc8:0:b0:535:a5fb:6459 with SMTP id d75a77b69052e-54e1576c1f7mr69286361cf.68.1794011605554;
        Fri, 06 Nov 2026 16:33:25 -0800 (PST)
Received: from bmasney-x1.rmtuswv.csb ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a2c5d9sm32684126d6.10.2026.11.06.16.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:33:25 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 06 Nov 2026 19:33:08 -0500
Subject: [PATCH 1/2] spi: omap-uwire: convert to subsys_platform_driver()
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261106-spi-subsys-v1-1-a51a08f21cf2@redhat.com>
References: <20261106-spi-subsys-v1-0-a51a08f21cf2@redhat.com>
In-Reply-To: <20261106-spi-subsys-v1-0-a51a08f21cf2@redhat.com>
To: Mark Brown <broonie@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.17-dev-d96cb
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=VXOL6bEGlUlQU4NkQQRQnkjQZinD42MMCclT0CLWHzM=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLeFZ5+bJG4e+VlhwvSB85WtURMW2viyDrty4/6P8+Sg
 9OmW64621HKwiDGxSArpsiyJNeoICJ1le29O5osMHNYmUCGMHBxCsBE2uoZGVoF5vxjPHejLvBj
 6qVNy633+z41zZrMz9QpXS+7XfUzuxcjw7JDNiYOkfEuyipcEwMdnnlcfRJWav7r8IdFnKsKXNi
 K2QE=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CYP4CfNfy1R7aMPD0JwV8vQWdxrQxCgg4JbR3DCSXPA_1794011606
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Reduce boilerplate code in this driver and convert it over to use
the macro subsys_platform_driver().

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/spi/spi-omap-uwire.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 83e263eb6069..91bd733ca15d 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -528,19 +528,7 @@ static struct platform_driver uwire_driver = {
 	// resume ... use ck
 };
 
-static int __init omap_uwire_init(void)
-{
-	return platform_driver_register(&uwire_driver);
-}
-
-static void __exit omap_uwire_exit(void)
-{
-	platform_driver_unregister(&uwire_driver);
-}
-
-subsys_initcall(omap_uwire_init);
-module_exit(omap_uwire_exit);
+subsys_platform_driver(uwire_driver);
 
 MODULE_DESCRIPTION("MicroWire interface driver for OMAP");
 MODULE_LICENSE("GPL");
-

-- 
2.56.0

