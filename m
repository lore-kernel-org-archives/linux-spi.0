Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F536604E;
	Thu, 23 Apr 2026 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969806; cv=none; b=deEOXbX1Bnhsu4c10RkFIbY9xIdHJdXpe9kai5UXlrMSXDH0HErF3HZWHekHdlE6mY7x4bDmvcK2iexmoim4tRlLg1Ghpu4lIXG+Go30PeO6nno56w8mbZnWYl/C8bsS1nyvHL29Fn2m+emNUdClC/4y5aFiWp7+Hi0aHqfDnHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969806; c=relaxed/simple;
	bh=+8OlnfIQ6DaoOFXqEFv4KaZ+j1lhQuHlCxjm4TTzoe8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nJucIQMjZxwYzIzviSbhTsKJFb/paIhd2bUmbHaCmIADeskfrZ9Q+JJgCiaZxJeoti5mxYCHDFxw49OKq/P3RLXuA1Tag3zeJ+X716oQLpee77c7TTEgwdDHMK0iRaIHa1s2ScBLhcVoSfplyzKtAw4lKmooNpJnX/yUZ/g1ieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kevinmehall.net; spf=pass smtp.mailfrom=kevinmehall.net; dkim=pass (2048-bit key) header.d=kevinmehall.net header.i=@kevinmehall.net header.b=UuJ3GWYI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OEKyQRkp; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kevinmehall.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevinmehall.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kevinmehall.net header.i=@kevinmehall.net header.b="UuJ3GWYI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OEKyQRkp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 258AB1D000BB;
	Thu, 23 Apr 2026 14:43:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 23 Apr 2026 14:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kevinmehall.net;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776969802;
	 x=1777056202; bh=+8OlnfIQ6DaoOFXqEFv4KaZ+j1lhQuHlCxjm4TTzoe8=; b=
	UuJ3GWYI/vEoO8/n2VwjlhLFGi8m2FzBfK34GUG+vSwe/o1bWVG3OWDI27v4jhtm
	Yys7mwU7OZWdOWwPtiBsVRhqYO1gD7hfMPZcYLJ7Jn2MmdUvq65RRNjBS1D4rkeI
	tWjMHD6loTHRokL8rCGWrHoG0SjiMKCY7Fyl5y1IdJm1WY7tES9p+/lKTE7lRqZ8
	fWS4pDDSJZk2PiZ4cX6Rxo1P/ym76AxgbSQ8IVoYQMH92TQsUG4FEYKn66vh3zx/
	Qyrz9b60RI6ybJ8ezckhar0toZnJKeLndfg93vM6bWFJxOo1MYKwwaXxFXOxNqSJ
	ur01+qEPSGHW/MajBb9UiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1776969802; x=1777056202; bh=+
	8OlnfIQ6DaoOFXqEFv4KaZ+j1lhQuHlCxjm4TTzoe8=; b=OEKyQRkpuXRjBFVLT
	2UDjIEJ4x6Z9l79sjc6h50wuIqBGYCoop/fKyzmx9vJHpZ1WxY11e0T8ZSZktKzd
	xUnS4MxcUwZvn+yqlM9mWid0FhfD2OzZCn8l4kKLGQHOL7FIDqeqX0DZvEQMaekW
	HDH6vZXRtFkcWqotcm9uVzkX0dvh3wL2oOpizuoquj51M+4QhsBZ8ZPl64qarV0O
	QStbcbRFUCNO83NdzDVY8cZt4So7RujEQygVIGRRz861F7o6tyvd+c5r9ijc8o+R
	6thSoBvbSWmLIIFOMsp2/dqsRruxUNBtZL2b8Q0FW7bOT7OTOIfVNp1ngdA+mYD9
	9rsqw==
X-ME-Sender: <xms:SmjqaZxU4NZx2tziwcznkcxv4xUg70wEAvQDbN3tfbSe0gtM1VlAnQ>
    <xme:SmjqaUEC5yzwi0um-GQQ1wLGU7Aep4Nvrzr-r7zXTjSYNnU3kd2qznYq5bWOsBAQg
    RORipk7ypRhh63s-bj-auP2PbBHRM3ywtWQY8VOwENvYbGML0yVAwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfgvvhhinhcu
    ofgvhhgrlhhlfdcuoehkmheskhgvvhhinhhmvghhrghllhdrnhgvtheqnecuggftrfgrth
    htvghrnhephfetkedtgfffgeelfedtteetffelffehffegueeuueeuudefvdegfeffffet
    ffetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkmheskhgvvhhinhhmvghhrghllhdrnhgv
    thdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopegsrhho
    ohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifvghnsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqshhunhigiheslhhish
    htshdrlhhinhhugidruggvvhdprhgtphhtthhopehmihhrkhhoqdguvghvkihlihhnuhig
    sehnrghnlhdruggvpdhrtghpthhtoheprhhstgesrhhunhhtuhigrdgtohhmpdhrtghpth
    htohepshgrmhhuvghlsehshhholhhlrghnugdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SmjqaQ-6urYPgsDOLcAicbp_1ZGnER3UxE1h4scnEgZkG6LMBBtv_g>
    <xmx:SmjqaW8493rN-YaEdWfugKX-HwEeJNU1I5_nyT71oxVaidLxkTfAqg>
    <xmx:SmjqafUEmbd6lzL0jgWSXFiGULmX-lTYQJX37Irt3O2ohxJWerSR9g>
    <xmx:SmjqaTcNXKUVgvChzfTmPfg-MS0d7J0sKpiDEjHygXc8_M3c6Z0NXA>
    <xmx:SmjqaYFRzbHeyhvU7IVeD_-0oF6aKyoSmm8Mz2dZucRwh6gDUTnV4G5x>
Feedback-ID: i421842c8:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 06D0D700065; Thu, 23 Apr 2026 14:43:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 Apr 2026 12:40:34 -0600
From: "Kevin Mehall" <km@kevinmehall.net>
To: "Mark Brown" <broonie@kernel.org>, "Chen-Yu Tsai" <wens@kernel.org>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Samuel Holland" <samuel@sholland.org>,
 "Mirko Vogt" <mirko-dev|linux@nanl.de>,
 "Ralf Schlatterbeck" <rsc@runtux.com>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <53c2d366-2d76-4a6d-a72b-99544026ee27@app.fastmail.com>
In-Reply-To: <20260423174001.2797797-2-km@kevinmehall.net>
References: <20260423174001.2797797-1-km@kevinmehall.net>
 <20260423174001.2797797-2-km@kevinmehall.net>
Subject: Re: [PATCH v2 1/2] spi: sun6i: Honor CS setup delay on the first transfer with
 native CS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I realized this is incorrect. With a GPIO chip select, sun6i_spi_set_cs() is not called,
thus CS_MANUAL would not be set, and the hardware would then automatically
assert native CS 0 during the transfer. My testing was with native CS 1 and a second GPIO chip select,
so I didn't see this because native CS 0 is not used on the Orange Pi Zero 3.

Therefore, I think the best place to set CS_MANUAL is in sun6i_spi_prepare_message
as I had in my original patch [1], unless you think it should be duplicated in both places
or have a better suggestion of where to set it. sun6i_spi_prepare_message() is still called
before set_cs(), so it still fixes the skipped delay.

[1]: https://lore.kernel.org/linux-spi/20260420164755.1131645-1-km@kevinmehall.net/
