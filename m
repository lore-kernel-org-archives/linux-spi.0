Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794011611;
	b=VMTl50/CPengQVgisYTewoEbxhUsHZSqlDqUQMWRNl3NHFJNVZt5Vju5sp2FyUIOmIXy
	 h2PybTeBhussXJGhangoVl+IpcraWNjcfG+rChHzrB51KRlvw71q2M/Snxkg8VUH0v0F7
	 Ygd3S4aQ+wkV/EG1w5u9/TqiI6fShPlpRfH5qc84VOs4potd/zuEbNwj7bJ4IUUnVJjUf
	 7DOWZMHN/9ZiFZJFxVM2jWrRSdc6K2+taHh4IryRVb2nbT/f3sjFJOzBDSqkG6mT3bShQ
	 vUoZGCsqsim3vsir902GF0dGNO6VWHMZJHN8sRAvF5G/oVRX0yc3eiSDrZXfZyBwnpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011611;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=9EpZk2mArj9f3PAZHMhYhxIIajV8999GqCaFVZmGcaQ=;
	b=LaiMKEwdPOAvSIcAwyU3kSzvIGU1VbGDkWbLYpgcXK2HmT7NpXOR33aW3MIHof1mLffm
	 4xt/ab85/hFcoLE7KFItL2PMxCOxpDV86lDRlms08PvnjGTE7PUNaeUoEEjKqlqz0dnWI
	 T6Z6C2WX9lFfhlbXCavnjUiTmevTMg/0MN4wUZ5DA22hkUo0IrS8TPUP3PDwYY2lTp6FL
	 qXLLjTlRUieQjLa0LbGTyA5N38jmIh1S6LDBPBqN2uZH4cJwmpqIQXICLn10uMAp7YcRs
	 pn+DU0XTje1dL2AvbhZHXb2VYmcz6t33/PXu+1mDcpbQfyXvLD6uSaivNpyaMTyg9Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jq84orGE;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8E5606A339
	for <linux-spi@vger.kernel.org>; Sat,  7 Nov 2026 00:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F8E5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jq84orGE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794011609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EpZk2mArj9f3PAZHMhYhxIIajV8999GqCaFVZmGcaQ=;
	b=Jq84orGEbv5gemYodNaS/Zkp8XdpfsiR3DASh0ID9xN6e32GiapCeUe7Exlx5zpmP4z1Lu
	qUByevFMA7FPHEBLZ8d4si6IiBXsoaIAdjX9xlOEup0ZQvjpH3h/L7WiQVKqMwGN4UulHx
	Q9GyBcpRqoo+SIauS1CfuaqirdTVM3U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-ZBM6wl9dNWioz_1MdBJyvQ-1; Fri, 06 Nov 2026 19:33:28 -0500
X-MC-Unique: ZBM6wl9dNWioz_1MdBJyvQ-1
X-Mimecast-MFC-AGG-ID: ZBM6wl9dNWioz_1MdBJyvQ_1794011608
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53395d51187so20710261cf.1
        for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 16:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794011608; x=1794616408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9EpZk2mArj9f3PAZHMhYhxIIajV8999GqCaFVZmGcaQ=;
        b=G/U17h4TKi5YgSYBpxvBUuR8zwDlNxFp2JKLHOlCzUBrsYu/HsijqTj+3M2qwkMe7M
         kMuulWlgPsRfQcftoopWjMuHhvoA5p/vreVP3ltmT+p4E7/u8BYS/v3p0IdkT+nzGhtz
         4lWIRi4h/WsPcfT8ZH3ASVCdiBZMeLRL1MbIkksuiblzgpnMq7rBJUViGoHK9qkNJWHl
         5khdJ1Uf2WYbFPtEJIbsPG2P+/p2xSr0lsAl0Bh+o6lCgtE9kRPjwUFcpuo0K+Wk5gIh
         wPfHdIJgXRa3xwr8FjSKderamfQLq+fJhiWzr8MP1YW8az9WfgfUxAJ84yWmauzPq2S4
         +CrQ==
X-Gm-Message-State: APuU4Z/8igiyTNxI/kUhynlcOjl+5nsVg8D6mTiyCj2y2Q3B9NBnahKs
	KKkh2iWem2CHhpdgBmOIomlFiVOIwDOyZgPQ0suhx9ExQI9KYnRtJkr7dH1A0apy+q9JCWunUao
	3zKGOSkXK57gAXf7XdJF3730rjb/qVQqpH9cdZLuemgPZoWustYx/TbUdj0xE8Q==
X-Gm-Gg: AYBFou0BVB2M/iuVko9oU0BcyU6VQ1WUpZUf1BL/41Q6zl7U8cFMFQGrlShLBYX3LvF
	k70bcjgkpidyiwafv8DUgNnzMNbvc+CFYcOrOxXwS1l0ZWm0eSvpQCb6yurSVPXD7dHWFLL1b2L
	ZxQ6rhbcWHwH67gMsOZrkASZX4GZAUCTPXpdBaZPXcsy05lpT8tWtknzwnFTHoKy0HPysnnYv3r
	nYmyO1bCBcWyab5mN3boJgaTPaAy0ho6vWIHrWhXIhwN7mJCV445SKXKes4o/6t6xQLjM88WgnS
	SEXxleWV/nHexpyN2y5XS9a5qsRUR3ZQtLu4HN2pdOO/DOIr+9o3He8Hvh+8eyh+GACrKQ2BRXw
	5lWdXkJU6qmiSOuLTfq94unqJaEu0NM08TSi3HzR2v0fG1FBtHrCW2eHneWP84d4FyN36+INhTv
	AQCwiY+TcxzpRDlQRP
X-Received: by 2002:a05:622a:4c1a:b0:536:64c9:b1b0 with SMTP id d75a77b69052e-54e1496d927mr73578461cf.36.1794011607859;
        Fri, 06 Nov 2026 16:33:27 -0800 (PST)
X-Received: by 2002:a05:622a:4c1a:b0:536:64c9:b1b0 with SMTP id d75a77b69052e-54e1496d927mr73578081cf.36.1794011607417;
        Fri, 06 Nov 2026 16:33:27 -0800 (PST)
Received: from bmasney-x1.rmtuswv.csb ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a2c5d9sm32684126d6.10.2026.11.06.16.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:33:26 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 06 Nov 2026 19:33:09 -0500
Subject: [PATCH 2/2] spi: pxa2xx: convert to subsys_platform_driver()
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261106-spi-subsys-v1-2-a51a08f21cf2@redhat.com>
References: <20261106-spi-subsys-v1-0-a51a08f21cf2@redhat.com>
In-Reply-To: <20261106-spi-subsys-v1-0-a51a08f21cf2@redhat.com>
To: Mark Brown <broonie@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.17-dev-d96cb
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=g2ewlZkjpkqGNUKfIKVBhFWyd1ww0rgtdqdUZikqli0=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLeFZ79Gnr8VqxV2xXlxut6DlN2X/yyUWh96xJGle9LF
 nbPUbA51VHKwiDGxSArpsiyJNeoICJ1le29O5osMHNYmUCGMHBxCsBErngyMjzPmXZdcsHZs9/2
 3jzqOjmn+MO0M+ZTSl48PrLIZ6eQvqIdI8OJf/9t3lUfZ6iJl3m6zNZU8EJo/PFFj1fs3Xz9N4d
 mXiYHAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tzUMiUYh9p9rRzqSS_JURnOfBWFNIRZxa53DJaX8WXg_1794011608
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Reduce boilerplate code in this driver and convert it over to use
the macro subsys_platform_driver().

Note that this needs to rename the driver variable to pxa2xx_spi_driver
to avoid a compilation error with the macro.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/spi/spi-pxa2xx-platform.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-platform.c b/drivers/spi/spi-pxa2xx-platform.c
index 849a14cd0343..2151ed168e57 100644
--- a/drivers/spi/spi-pxa2xx-platform.c
+++ b/drivers/spi/spi-pxa2xx-platform.c
@@ -198,7 +198,7 @@ static const struct of_device_id pxa2xx_spi_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
 
-static struct platform_driver driver = {
+static struct platform_driver pxa2xx_spi_driver = {
 	.driver = {
 		.name	= "pxa2xx-spi",
 		.pm	= pm_ptr(&pxa2xx_spi_pm_ops),
@@ -209,17 +209,7 @@ static struct platform_driver driver = {
 	.remove = pxa2xx_spi_platform_remove,
 };
 
-static int __init pxa2xx_spi_init(void)
-{
-	return platform_driver_register(&driver);
-}
-subsys_initcall(pxa2xx_spi_init);
-
-static void __exit pxa2xx_spi_exit(void)
-{
-	platform_driver_unregister(&driver);
-}
-module_exit(pxa2xx_spi_exit);
+subsys_platform_driver(pxa2xx_spi_driver);
 
 MODULE_AUTHOR("Stephen Street");
 MODULE_DESCRIPTION("PXA2xx SSP SPI Controller platform driver");

-- 
2.56.0

