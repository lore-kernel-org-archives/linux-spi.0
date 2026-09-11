Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D424BA1E8;
	Fri, 11 Sep 2026 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162676; cv=none; b=bk2EMC164Cv9QVl9RvEVW6M3w39nDnV5pFHr5pZbrzLKbRb4Sa1rCc2yKUf2oQCbAVjy5IDgVh0IC/hyL+VjxOrG54BhPNW6HXmnJ9OKQr4Rnnr6sAQTbUaedvA9ybZYQg/a1R/deYqns2F8NWChotBfbMugjf+otO5PuoYavA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162676; c=relaxed/simple;
	bh=0Jj/ByVxaoBDnjCe3EYpAQ7wyh025tNHIrc5I/uUxV4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jviHbXpDo3ctoA7oNz4hYEiFYBGkpnSCBWGJaLY0/jIP4u47RL5iLV5ydrq4wqZyN//qDP/bhsJxCdVGZpo8focemo3dfakJtEaMOLVL7Q/kNROSDUMbQ8XgAk52gnKfUqLVE5F5+t2P/QWm/qziTrzYqzyoYSEZf0B2gqdCklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu5afF81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu5afF81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93301F000FF;
	Fri, 11 Sep 2026 21:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789162674;
	bh=1E9WK8fMVvtjByWiP36V/jiNQnEiHyXU1UExFYKjkzk=;
	h=From:To:Cc:Subject:Date;
	b=cu5afF81ubUCyN3tTrHoHr/A9Gkl7m8xE0pJDhwf8viMMfHu+huHKKMM94QGyiL0Y
	 nU7VRjGvBmWT/NiLrg2bifXUubJyFnEJfxwmaWr5oumI2xqC0wgrdbvKakzBBVgnR+
	 RvJicrA+KyEvj4mJ69r0cCldd1iFBHg4uhDbsZ5SHVPQtSoE0kPijqEY7PdUnbYYYM
	 +cMNGBPJAVLZGBoU89S44eJGJ5Yz5Jc3QBGDR+150Xdy5Oq2V78lU7yQVdigpI8H72
	 wGU8Lwg5A0JpRrnnz6k5v4nvvDUwdzLhh3pvorCDZL102XMVbn0iMb5LzitrNjerLj
	 fLONvJEgezvrg==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 1B9B2DE8A41; Fri, 11 Sep 2026 22:37:51 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.3-rc2
Date: Fri, 11 Sep 2026 22:22:47 +0100
Message-Id: <20260911213751.1B9B2DE8A41@traversing.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-rc2

for you to fetch changes up to f77de4c33f0edbb33411f92a35d7196965597e6d:

  spi: dt-bindings: snps,dw-apb-ssi: Add compatible for UltraRISC DP1000 SoC (2026-09-08 16:23:17 +0100)

----------------------------------------------------------------
spi: New device ID for v7.3

Update the DesignWare DT binding to say how to describe the UltraRISC
DP1000 instance of the controller.

----------------------------------------------------------------
Jia Wang (1):
      spi: dt-bindings: snps,dw-apb-ssi: Add compatible for UltraRISC DP1000 SoC

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
