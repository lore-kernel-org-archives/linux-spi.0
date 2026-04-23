Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D73A7F45;
	Thu, 23 Apr 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966031; cv=none; b=g+NjhvH8ImlpClXWoBIFfJepbedTnPLIezSyy82PakmcDTj1jfjy+Ezc8s8W1+Fh9LpYg6kdBOaHB/CeTL9ydI/Jo6U8OKzg8X4e2KB0Dmq6dk7lmE4SLRRJgbCqVkxa7CQ7bogH3B+rJCpST3lg7nDDVG2B2gFmkfS4nivZzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966031; c=relaxed/simple;
	bh=XgrAYH9zyZ8GEDXh9PXMD2SHfz1fhwSBj7apxECq0po=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=k9lhRUOuk8EyK6sIWoO2mifRLpi9KXSElXoHOEBmswkmM7ux6HINkBywpZ0OZwbg7/c9hgJW0er0XFl7wdDjOoUAGdf+yZkA/nNhwGXF2XRKMlQG42fJ15G8+6tL5yuZPPnEkvb6RV2eFHCI/vERku5f9ugDb9+kUvWe7GSiPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kevinmehall.net; spf=pass smtp.mailfrom=kevinmehall.net; dkim=pass (2048-bit key) header.d=kevinmehall.net header.i=@kevinmehall.net header.b=tku6KaFn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=phGDolUi; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kevinmehall.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevinmehall.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kevinmehall.net header.i=@kevinmehall.net header.b="tku6KaFn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="phGDolUi"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7ED2C14000A4;
	Thu, 23 Apr 2026 13:40:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 23 Apr 2026 13:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kevinmehall.net;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1776966026; x=1777052426; bh=01LiWtizoFsYLgbrSHDfC
	bjty9gM6V4P76wUHHJkQZw=; b=tku6KaFneBXtTj8b6/gB170QNGT47snJVk2Va
	SGDTaF9NIgwuZs5k5nhcrQrwBuddfPTT8B91OZ1QR71sgtEoSAX5Ez/CycVq2iKl
	meON4Rfoh2ge/1hU4zQWq+NAO8UIhWznR2TBGmerljau9RnYUO2AZA6BD9W2fK8A
	znATskO3OvsqWMJgbJPIqiuvAxzcMtPiYtgmgyUg2qzXvVlmxLcB9DFeAxYEfPmq
	NN3iwTS/YI4TDo0piMUtydLEGxj8mYyxtuOGo2rm6+rx5Vu018ZG2WkkbL2ANie3
	rgKBfTzWwXAglAi0X/lBAjLdus3xK5sClU0oxvFwTfrakQViQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776966026; x=1777052426; bh=01LiWtizoFsYLgbrSHDfCbjty9gM6V4P76w
	UHHJkQZw=; b=phGDolUioigZJsGUmKx5LQgy/WlWo0BRUG9PM1Hy7GnH0uC55Pw
	oppC7EBmDbDBlKycgAGMYR1OEBb1J5aOsMhmytumFOE4P9Lf7PelAvRGc8A6GYLn
	0CDNo2Igx56EmgMrx0FBu7O6ElCMRRgC7Uw+KNzx50kMD/6/yjsQYDAYfz7HBX5S
	5soaMAsK6rJNx6dHqcaqDJ/ECBSmt8WF4uBmU9QLxMJC0vjBsAeci8R1tvDXssuT
	nMydGei0ERPfYB4M9dIXJbelDHTycbxV2MErRHFUfwXa5jxTpYZrY9cu7ujZKdsF
	W8HbFs9wTG8vzLnTwb07HvnjlpCE3zfwaEA==
X-ME-Sender: <xms:iVnqaVCbKKVT6DjPHsbHyMehSaZ3QQ87grEbmvFLHSx7pOvu74VlKQ>
    <xme:iVnqabsRBh7k5LCgQi8dzMb_PtppwoHXvVRJlg3cqsUtVUsRQhChHw6Obuh_Q44H3
    sEO_nztkyzDilz0F92koPmidRyPsC9utlBFZS9IRShOujy0DJ_BiA>
X-ME-Received: <xmr:iVnqacJQYkhw4C_ETbWQKkMzsnaV7sjcsJUBSdHdjM-Imldjiwz-9M2D8LC1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepmfgvvhhinhcuofgvhhgr
    lhhluceokhhmsehkvghvihhnmhgvhhgrlhhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ejteeludehkeffudegheelkefgleethffgieefffetvdekfeelgeejueeuffehjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkmheskhgvvh
    hinhhmvghhrghllhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopeifvghnsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvrhhnvghjrdhskhhr
    rggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhhuvghlsehshhholhhlrg
    hnugdrohhrghdprhgtphhtthhopehmihhrkhhoqdguvghvkihlihhnuhigsehnrghnlhdr
    uggvpdhrtghpthhtoheprhhstgesrhhunhhtuhigrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtph
    htthhopehlihhnuhigqdhsuhhngihisehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:iVnqaaY0uzf8MaQEk7Y6fOm7YW3jNMEqmZvNgOCyjWRF3ml6Vbrttw>
    <xmx:iVnqaWDSWGBy9RCNlT74hbhBE6HxtRegRYRUIQLhvEXQvpHzKjsWNA>
    <xmx:iVnqacalOPrqjsTwgMRoQ0GlsDOXZ7WrSX-8i3fNg16sONahIQPiOQ>
    <xmx:iVnqaWmUYcUeje8QvJ50XYlxfvBq9xHGAH3g-gNAoj263khJDXVfcA>
    <xmx:ilnqaTUreEHB4w3ngZJ8u52gKs36ylFp6GHUAsjppZT4qoht3ybUlprD>
Feedback-ID: i421842c8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 13:40:24 -0400 (EDT)
From: Kevin Mehall <km@kevinmehall.net>
To: Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Mirko Vogt <mirko-dev|linux@nanl.de>,
	Ralf Schlatterbeck <rsc@runtux.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] spi: sun6i: Fix chip select handling around autosuspend
Date: Thu, 23 Apr 2026 11:39:59 -0600
Message-ID: <20260423174001.2797797-1-km@kevinmehall.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the initialization of the SUN6I_TFR_CTL_REG bits out of
sun6i_spi_transfer_one() into earlier callbacks to fix two bugs:

 - With a native chip select, the setup_delay is not correctly applied to
   the first transfer after autosuspend.
 - With a GPIO chip select, the CS is asserted before SCK is driven to the
   correct initial level per the SPI mode. When the mode is set, it can
   cause an extra SCK transition with CS low and corrupt the transfer.
 
Changes since the previous single patch:
 - Move the line that sets `SUN6I_TFR_CTL_CS_MANUAL` into
  `sun6i_spi_set_cs()` rather than into `sun6i_spi_prepare_message()`.
  This change is now a separate commit.

Kevin Mehall (2):
  spi: sun6i: Honor CS setup delay on the first transfer with native CS
  spi: sun6i: Set SPI mode in prepare_message

 drivers/spi/spi-sun6i.c | 74 +++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 29 deletions(-)


base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.53.0

