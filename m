Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793575;
	b=OoICRVqySmmL/BYMp2LyY92Flb39ccb+Dc3KlZunKXXXR1CbUFErg5I1Zv4Vrz2Arrai
	 JpN/5Md+80uS+v0lxcaoOS1ipjP/vNpni3XssGvMkTMZYJ1ifagm92TJX7Qs77O8CvtCL
	 MzYNrN/Ji09iZUqB4Y1y98vm4gC9h5ioGIPSlcpX+J932RefyHL6GiEmMwfLn4lxfMpUc
	 47V5DhftagJ2j4Pm41/3NTgbgIxITkhyAQ396HXUHZCuSWpMkPfwThi999fe070Vy/Voq
	 glP9ovJAMFC9VGUpvhscRsSai5XE23ld4gwORYUgXWUbxp4t2sp39L35/VBuRmpfm2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793575;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4GnmWS7cj+SPJjNvHjPWHOZnI/QHt7OEuo3JM8YhyuI=;
	b=WUkHbS2DE6NtxmtpANYU02nI5EMDZIJ5W8NK7bmenFK7G2z+MpOBIc3ysUnvJRgvMFIO
	 MsxH4VlZdxYcKVhvMxHuqof8M4tQkCkvehDugUynwyHwxYKBpnCKhr7onUNSb5bn7Al5l
	 /jVQVrlHCzJn5EDYIMHnTySB4tLuEwHJtm73qwqou9H6NJo07I/YsG32BJ9JdjQiiUd/P
	 cJu34SOI/hh0sePRPxwcHNkFo6v72otlIUaEHKpK+SYxhuYPEwHsuAQRZicC2e583bGTa
	 Ib214dx2vpls3ZQAxFDDRYKYP3HU6EGbNz6qncDeqTcOrqG8YmaDCXIt5fs2YZ2p8hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSzrLpR9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E368606A31C;
	Fri, 27 Nov 2026 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PSzrLpR9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0351F000C1;
	Fri, 27 Nov 2026 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793575;
	bh=4GnmWS7cj+SPJjNvHjPWHOZnI/QHt7OEuo3JM8YhyuI=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=PSzrLpR90cdVRu6DP804p+RFbNes6+lVM8voUMyhv5rjnyJs1R4wBEuXHM5xBctvf
	 fZXaP490T9cEAdc6UWIRlIKPL8h36wfpwIsBQt/fLvlXL9+sJqt52hERXpwXsniKFT
	 fnPDLZiYsZWJNXIAL3uW9iR86eT0rNnjVQVESWrz/E6bLiN+S8vh/Wv6O3b2VcDvGO
	 ZmMK/EnA8bDeyrpByoyvSKf4mSqf5cvNsJRyGmBTgtdXhQYdCnzAE0NlBHrPDLGM9T
	 FLfw7K4N4nX8SMqvI/Kfn1+3EOf+gS44Gv2vqSwfeL0i8MCcQSLoGLx+JyUvtD5T4r
	 N+4MVuiVqmkeA==
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
Subject: [PATCH v2 07/10] spi: cadence-xspi: Zero the tail word in m_iowriteq()
Date: Fri, 27 Nov 2026 15:31:10 +0000
Message-ID: <20261127153158.2969573-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127153158.2969573-1-lee@kernel.org>
References: <20261127153158.2969573-1-lee@kernel.org>
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
v1 => v2:
 - Rebase onto spi/for-next; no functional changes.

 drivers/spi/spi-cadence-xspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 594b46304a6e..f8157757b2f9 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1097,7 +1097,7 @@ static void m_iowriteq(void __iomem *addr, const void *buf, int len)
 	}
 
 	while (len) {
-		u64 tmp_buf;
+		u64 tmp_buf = 0;
 
 		memcpy(&tmp_buf, buf, min(len, 8));
 		writeq(tmp_buf, addr);
-- 
2.56.1.839.g22a8290db9-goog

