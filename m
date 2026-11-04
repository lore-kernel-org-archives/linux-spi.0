Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801304;
	b=hxiPcfCvB3S10ECarv5nDKF7Nv4+2JfyEiDzV8ZeQCf+T5Mi9FmFB74KrRZkIiaoGHRr
	 aMvWW2dOtDNkrUVm9xY5RU1DT5L/csXndypkoDWRuDS+hoXv0CqyGN84S2M2SPMR7mCP8
	 i+MuD8uGWEFVd/aPykNjpG1jFBDeuZr16oUZFQa1I6frPMCXS0BqmHhIORMnxeYi2NKmi
	 gaiqNlJ4tEy3tSoT3K/FBzwlfwSDMrucN1sQz7GT2awA1DN7zsi+eIT36rAaLkW0gabHe
	 +DY3S0PSxLAuGCNknbfEwEPIGCWbg7iL55W1M3pRqdQIQSA9dJF6IpISs8+4mZB6N6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=TW/hxeURtpp3wtE8J5o/ixOgIyRnUtxYzzkfTW+2RsA=;
	b=WNbhjHyea/BZbnqwyh/4tQthAvV7IhNu6I7ru5987NDkzEqE/gGM8i9CH9wlE54YLlxV
	 wjpVbxyiVnq/Paoqyx+k3HCsMc/XW6xwl5qdsc5KaXbkIQtNTL46En5mVxlkMauRhsW87
	 WrPgMyYfdTNwMGEnue+yKMz3Yr2FS1BFvvNvcCBTQ2fCKz0M9Z8Xh7JxPCohmMjQY4IUO
	 JoX+pjGy/QPPVBEd8QDmkHOourIN5ycP+Shz/+kZnZxZGo0o7CKho9XRChCokwseczOh8
	 zDfKe1mFwNJkfuAnX8RUAEfGyuWJ4+vq+xR8S0iEBAmkC3WvpiuiDRBcfPy0wEqm8oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShPHvMBB;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C7606A33E
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 14:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 118C7606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShPHvMBB
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a07078200fso317529b3a.2
        for <linux-spi@vger.kernel.org>; Wed, 04 Nov 2026 06:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793801303; x=1794406103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TW/hxeURtpp3wtE8J5o/ixOgIyRnUtxYzzkfTW+2RsA=;
        b=ShPHvMBB3VjtpfJfJTQ8IuHXhIh8yFv13ZLNON+FrvV3va9f1zQfasBz8WdPV8JkeG
         b7OI9urqDkldm1Tk5pVk62B82np9Q0/IY09KPlnNYAh834Tn9RWFSjJGcrwkmk41sy8Z
         NdKZboI7X8+v8ARS1Qe7FBBd5sqgRGBYZspEf9+z0YhTn0xWgEk5ObJjYuk/q+CXL8Gx
         z6mGw2xgmWx/zEEHzro1ZqeVPvVWYb8m3HDRO4A+bpOHNUfLpR95ml0cnTqN9onj8Tc5
         ES1gycGZK1nSsXudjoqam1Ue2HEtmEmSs3s+xJ0qdFHtaso90y2r07MsszrobrdTV0qg
         Uy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801303; x=1794406103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TW/hxeURtpp3wtE8J5o/ixOgIyRnUtxYzzkfTW+2RsA=;
        b=YeCqZW9gj9cdleG/VAMgIg3/ZURarE2evxwdyvz7hKIN1+CxrABpzscWNCxhh23+cN
         F+hiOLen+3QbVaFJhIZMC0OspYRfEBCEOlTA6BYcTWj7XyUMLTFxVCR2uRtbBhC6Fma9
         qA7o0Z/0saSmOqWcmwytkE5U0gZaNv7FKAXrG/A7ZnNBSykCReHRGXxhIpYvOpWSSpKD
         7CzCWah6bngEF4VEtREyZqDvoYgd204+yk3q6xBKfgAuAxf8gjt6h5jJ5aFteoIis3FY
         ONXYWtqeNIBqnS8cMZAA8AnCVNeswq7ILV7FO1g4ZCUy/A8R7zcw6aQoMORR+JKTWDEU
         pWoQ==
X-Gm-Message-State: APuU4Z9D3C0n9E1bv/meIILUvbIAk/R8R9mHL8+6mjFqXDaqMyi/4fNh
	sQb68wAo3bKsR22Bf8OTUckKD/bi9iPhW1yowNw75M0fh+vpdOwbQiZk9uGG5CDm
X-Gm-Gg: AYBFou205+veLfXyrhYJO9HXCIXjTSBclzbm/liPBW+WVy4zMnXbIclMAVqLzQO0hqA
	tDp8bNJdnhidrl9uMLPDVZwHfzb0Z3yRydujakKytoMOpa+On2JECrj6oTblnQNif3N1BsRnwTi
	ELWv0+HO3RbWNTAuvYpM4k2Z6BpJT1lmO0Vpf3apGESLevyw0nUHvMnqDPR8LVHVKGCw3vYvYOj
	4RSgycaFr7vDxTimOZ9GQWQ9aSu5ZFuvAfN3jc21d+OFChDntWgGPfg4HVFpTP+Y/HOxFuiNty6
	jefBXTIYNs0zFhh90g7On9e81Qn/xW2QyXxbAjhIKJ938CQsTZgHjMqcIRQgKkZIW5WDTPYkc/I
	Q+uOxd6bsgG6pYUysIN00tNA957SeDB8B76Zl0cFvxVmWLu51ZogMuZjhDM7o8/hDPEtpVWbOe3
	Gspod4LS4c1q2hlBYIkqTBgxhJEhufRP93SCxP1wbiafWzFfw8JKI2VkYLdfPluwfIC0TSBpkor
	YACJzB6krZ86duLt2gzwMrAryLB8pmAeKBQs9+mLVKJPIgrboO6ovaUDluRClNOebfm0eJsGT93
	wLeRW+ZGizX+dwJRc1XBXyAI1PxyBrWqiA9jL+tJSJ0A73NAmRFY8x49i606v6OReTd/Exn3PcI
	o6BmTKoEtWQjrwz5dR08oN20=
X-Received: by 2002:a05:6a00:3987:b0:886:a737:e0fe with SMTP id d2e1a72fcca58-8a9bea67183mr12951149b3a.23.1793801303196;
        Wed, 04 Nov 2026 06:08:23 -0800 (PST)
Received: from junjungu-PC.localdomain ([223.167.147.108])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8b09ba508fasm990259b3a.48.2026.11.04.06.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:08:22 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 04 Nov 2026 22:08:10 +0800
Subject: [PATCH 1/3] spi: ti-qspi: Remove unbalanced runtime PM put on
 removal
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ti-qspi-v1-1-c286943c22c3@gmail.com>
References: <20261104-ti-qspi-v1-0-c286943c22c3@gmail.com>
In-Reply-To: <20261104-ti-qspi-v1-0-c286943c22c3@gmail.com>
To: Mark Brown <broonie@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@linaro.org>, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793801296; l=745;
 i=ustc.gu@gmail.com; s=20261030; h=from:subject:message-id;
 bh=rUZ7lB9Diy8GMB+evfnbtdI5k01dQ9R1OHte5qzvqtQ=;
 b=UbAF4Ylfdn+C9/aGfW5/nYX4rzwIsUGVlbiVyB2b2DstMfkY5rGmk5BOkok+gZah58kCTRxI5
 c9uU6vc/HZ0BzzzQ6o0z2NTr/oz5epG130rTHbwQ53PHf3ogrTSq1xm
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjDJtbnSeysEBjmOfNYqYUUDS6g7Tfov9W5oGngTBfo=

The driver holds no runtime PM reference to release in remove().
Drop the extra pm_runtime_put_sync() to avoid usage counter underflow.

Fixes: e6b5140b7066 ("spi: ti-qspi: improve ->remove() callback")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-ti-qspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 6908dc3621fd..0cc8c2d52226 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -913,7 +913,6 @@ static void ti_qspi_remove(struct platform_device *pdev)
 
 	spi_unregister_controller(qspi->host);
 
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	ti_qspi_dma_cleanup(qspi);

-- 
2.53.0

