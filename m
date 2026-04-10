Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96A29E0F6;
	Fri, 10 Apr 2026 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810077; cv=none; b=BnMopM4D2n/qJ0xzjzmoKcxk+SQhyRj31MrchVelLYtl4sOC80yNQK1a1TLloit5DDaVypEkDLAnzDRGQPdEUlp4BOmZoFSsDljUJL003ANLNmXTDWf0hqwvS4UID2Q52rSj796BVVZu24iEQYiikD1MDbLjQ0NBXxZk1wGjGiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810077; c=relaxed/simple;
	bh=m7rLnUDMUUacBpMAE4VrX0s58USLQ84FUSSXHcio0UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzoQYiE4bbXo8fB3pcKabtbD9eMON39kbIz/W9xFR/weJEtzCUpayOX4B4oX5ZNB7p+03S+ZvAfLNBAs5KOU5xY9ooIT7V0mOg/81Ypgt34IRqvF64AfIvDMn3jPobsySA/jkjZqFbmJ2Q4L3qo7Hsd8FPZMRx4C602cQIIlVGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/D3LVHt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/D3LVHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F835C19421;
	Fri, 10 Apr 2026 08:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775810077;
	bh=m7rLnUDMUUacBpMAE4VrX0s58USLQ84FUSSXHcio0UY=;
	h=From:To:Cc:Subject:Date:From;
	b=L/D3LVHtFU7bolicbQTHDKHDnCe6upxJEObNO1nH+hLiE70NsnOqC81w4FuzjQffw
	 p1i4T80TF16BqxqZcUsxIQX0R13dCZWvWQbXOHhg1a5IA6IooWRfLsLXi0DiSomFZg
	 R1lnUT4g0GXbNNuX+N9WpW8+llAD7PmM4Gzi0eUowccT3gBSUp5ZyATOHaLlC0TuuE
	 G9pcmH9g1i4g+UbH3bOK720q6y06TMCOiacFolDRKten2l7ztzjbaGNgkTELKG3enw
	 Co1+rnuxDfQNfxWYRMkYfTv5W03wn2I5BWpT3v3yEY/NArW73SLC5s9QFLYCYgWBBL
	 L6UpY6otm1lmA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB7Jz-000000027Ic-0638;
	Fri, 10 Apr 2026 10:34:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] MAINTAINERS: update Socionext SPI maintainer addresses
Date: Fri, 10 Apr 2026 10:34:21 +0200
Message-ID: <20260410083423.504695-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linaro addresses of the Socionext SPI maintainers are bouncing.
Update the entries using addresses also found in MAINTAINERS.

Johan


Johan Hovold (2):
  MAINTAINERS: update Socionext SPI maintainer address
  MAINTAINERS: update second Socionext SPI maintainer address

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.52.0

