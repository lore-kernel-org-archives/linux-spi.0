Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6D3352C52;
	Sun, 24 May 2026 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624587; cv=none; b=ElxM3N1+Lox+BwCNfh7x3/Z2ZWNmoLJ14Wf6AgJJiDxGg6Ybaiigj5RIn5b3AlaEaIteqnE6xhiFnugKnSROjhQl6NqTRtML4QyzXr/XJ29kqiZ00mFJ7JA1B1Wpbk0pVB8vaCkkPWvyL8ahQDLbe20NPTNp/uDu9mdGmsyUjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624587; c=relaxed/simple;
	bh=Hl9QoSe9XJTLFSgazDj1a8o5f+32uOFaFnhjfznZRGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUpFgGKDvkfcI7LG9ws8H3MpPT9pUGVJROVTxnE8dalD2xm5mMPJcZMYPgdpOagyDmf2LTvP6EKnfJDA+7AmwMZWon21LXLEDH5NmIwNXsgc8kkZPR55rcHk0Lf7T07t7sDslL7nWmt1CVsOch3Jkur++Idhqap537YDeUsdnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqX0/osm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqX0/osm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3361F000E9;
	Sun, 24 May 2026 12:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624585;
	bh=J9BXVb3slJU1Eu9UJPNqqVJ94Fcdm0PgUFuFxcsE4Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TqX0/osm6xnLR3PcaHXIjtkyQfnD2+u6dVeJDHRQt/yG3DrjIoe9SfwCDC8T3a2+e
	 ALkJoyJZy0Y4ssOAymUlc/OhQuRuP4iaGJVJS1iWYxR0dum7pazjbd83mrtX+HcbHB
	 JfvP3mmFQnQPfHPCFJ54sLlOiyg+lJvPSSymunHZifPa/jU1fli77ccUozjumECPLp
	 MHE3v0UinNmNIzjr6t6/J+Z/Nw+JTDojWnn1APovQEi8qJ9bEZavlHZqoNERxmv3FP
	 nB6DddxqiHft5hP4zR2XUnsSQSsx7ZNLLIQbetlRzY8pJoGYINDyAhNZM9U/XbwItu
	 Xjhw+HsDsRf1g==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Fabian Godehardt <fg@emlix.com>,
	Mark Brown <broonie@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: Re: [PATCH 6.6.y] spi: spidev: fix lock inversion between spi_lock and buf_lock
Date: Sun, 24 May 2026 08:09:42 -0400
Message-ID: <20260524-stable-item006-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521061051.31928-1-jetlan9@163.com>
References: <20260521061051.31928-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
