Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079947;
	b=Om8StK52N7r6bHhSOJKkzaAt0iwThTAwnf3sy5w/Agg2ihhs+6U3Q+CYTb2PGiv17AYv
	 jY+QZzmo/e9jwXyqxVUmoQUyN0gbYGS4miqmepZ/qxRAxDZ74pRs2HuhpVUQuS0dmLd0G
	 9X44uKH3VIKOg4T2UAkH/9baL7kGT6sQb8M5dXcayYiWMeC59AvIwIX1eXhbU1jRFN3vU
	 zGuGFMB/FNUQKEunEqqQkhL80R4VIADvaIhZHzNLB11rKv+Qdn5PDGYRFkNzJ1BiKTHcr
	 M8VRAQIfNQ+93r1EXKZju13hwO6XCleVJS4kViNbGo1pKZzUaDJuh/WYHhjtbeeBNKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079947;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=biqqkhHSKDLivAE199nWl07d+bH5F/FM2/QeE750Lnc=;
	b=iOCS3GgNR5hGC0sqTJk6VOBwxYLg+sTW9IyIKV4BI6uEoRtxC9z08qQITzrEzz/2SAFk
	 3KvaGj/tp4xX+RGEShHtB2x08fwH1o3vEDbR1XDr97WS6hm0Si+80n+FaJYBQCU+Ij70w
	 XkoUPRdrqbc7Da9XENfvkpBREXUWP4bLtTy5f0eyCVtQkQD3by6ezCyuIEvoilLOoABhM
	 UwO3BdVcsBauklsqfB++57/IukWrPJT474lXGniUK7NPeRuk2o9etgmpcqceurgGUlLEW
	 sVqkIwX6zhJ4c/RKt1bqjFB8iLTwWcFGR7guW3bOcYb6eLFYORGy6o4vwPuAot+WJ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jBv/LfNc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB960A2605;
	Thu, 19 Nov 2026 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBv/LfNc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CB61F000C6;
	Thu, 19 Nov 2026 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079946;
	bh=biqqkhHSKDLivAE199nWl07d+bH5F/FM2/QeE750Lnc=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=jBv/LfNczLlBtatsxgFl4q3x6ZmVxjyuAV8foP80+SHv+AW+H58ZuOSIO+U7CEMJT
	 xDfVtQ3noguQ018XBWt8lMAX1ih1B1QOb0aeqjkjogYfkxgHSOhlUA1tVL+A7upbUW
	 weV0Ut/FBhmDH8UfbqBB8eIdqk2wMjNvuJ8sRILa7hoP3qJcWTHwu67DnQKkROzPsw
	 UaDxQIsNMcXvyxdv0h1dKFMoyGPo9x510Q3VeLE1OX8FbnrqGjVT+n2PRS6MATAQHp
	 myBTh48hMWdWnQ/feztGrzodTY9CxbLU92ni/RW9O+94Ir+omkrvO46hXWMQeSpLLi
	 9i0H0jcgygn9g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Mark Brown <broonie@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Konrad Kociolek <konrad@cadence.com>,
	Jayshri Pawar <jpawar@cadence.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Witold Sadowski <wsadowski@marvell.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] spi: cadence-xspi: Zero the tail word in m_iowriteq()
Date: Thu, 19 Nov 2026 09:17:19 +0000
Message-ID: <20261119091810.3440619-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119091810.3440619-1-lee@kernel.org>
References: <20261119091810.3440619-1-lee@kernel.org>
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

m_iowriteq() writes data which is not 8-byte aligned, as well as any
trailing bytes which do not make up a full 64-bit word, through a stack
temporary.  Only min(len, 8) bytes are copied into that temporary
before all 8 bytes are written to the SDMA FIFO with writeq(), so when
the remaining length is not a multiple of 8, up to 7 bytes of
uninitialised kernel stack are written to the FIFO.

Zero-initialise the temporary so that the padding bytes are always
zero.

Fixes: 75128e2a14a9 ("spi: cadence: Add Marvell SDMA operations")
Closes: https://sashiko.dev/#/bug/linux-a7158f26-3bb5-4ac2-913d-482e746b5a02
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 72852849ba27..c4fcbf5ae091 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1088,7 +1088,7 @@ static void m_iowriteq(void __iomem *addr, const void *buf, int len)
 	}
 
 	while (len) {
-		u64 tmp_buf;
+		u64 tmp_buf = 0;
 
 		memcpy(&tmp_buf, buf, min(len, 8));
 		writeq(tmp_buf, addr);
-- 
2.56.1.708.g77570a6a1d-goog

