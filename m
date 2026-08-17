Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368BF43CEC1;
	Mon, 17 Aug 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980827; cv=none; b=a91Nrm0yxZccu+HHyFAKQvqqxDg5VTWAgxlbWvrcl39bQFSA6bXNOjOzb0hJ6totSaluE1Nlq2N1v8PX5i7hrrdZ1ldmz7dfP2O4Dcrz0zbIEkDnSglKPrISjScMkFMIhkY6C1mErf9/i/GpzOxkLPeWFlqw2oMQpOIzVSNVC0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980827; c=relaxed/simple;
	bh=0kc3SnJwCR7zZWzgespb5hyvhM1PfcghoOT+2JVWFqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNx/rhi7LdQjl/MNiMYLT+q1SYLzoEt8jvbEgY1CkbGLXXSFhJ+MXWXYtYFNDnBT5GhHSH61yGvtnQg+O4LMVBpnLDVJTVJg2mXSwFAJkJOL9onhtTyOdsNV1zmLeCE98T4Z5Og0S2VvoiSFo73J2iJtQMeoixCXl1M32E10AOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwTBkjRU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwTBkjRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936F61F000E9;
	Mon, 17 Aug 2026 15:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786980825;
	bh=ge8phMPWbZ8mkjO8I/rjfbqxL9xXn3e3OcxFan1ILho=;
	h=From:To:Cc:Subject:Date;
	b=TwTBkjRU76poJiTj1AGXoD7XNTMTjz0x0TTiFO9fahwOnc9ljNyu0VcYGP34rW/O6
	 zbMXOViC4FT5cqJsAZCHqjBuGMYZswkxrT23m7epTXw7GJUbOWz0pv/DATjpfXCJpJ
	 XuLAVz5X0xWDuhzGYBJoeLDTWEp02k4kmnzV7DgtRSA6VF+uPCafGVH5XCKa5Vbkzg
	 5L89DDzjK9a1iVsiOomZTTZI61zsCVrHAIAUGYtZzqQaQZfoecRvNpL+wL9M2vdj41
	 9FcdsHjIixz8D8BT5iF71us6405zIxNeBi3AFO0tTrIYJnhDgi2uvthWuxzNs3BZhu
	 RzFdyb33anpsA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] spi: dw: clean ups from "use threaded interrupt"
Date: Mon, 17 Aug 2026 23:14:02 +0800
Message-ID: <20260817151404.28324-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two clean ups from the series "spi: dw: use threaded interrupt"

Hi Mark,

The enhanced spi mode was merged, I'm a bit concerned with potential
bugs with "use threaded interrupt" with it, it's better to let the
threaded interrupt tested with it. But I don't have available HW, so I
will cook new version once v7.3-rc1 is out and ask sifive people help
for test.

But the two clean ups in the "use threaded interrupt" series are ready
so I pull them out of the series and rebase on latest spi-next tree, I
hope they can be merged for v7.3-rc1.

Thanks in advance

Jisheng Zhang (2):
  spi: dw: use DW_SPI_ISR directly
  spi: dw: use DW_SPI_INT_MASK instead of hardcoded 0xff

 drivers/spi/spi-dw-core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.53.0

