Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589271;
	b=Ng0Hj0IBQgi5I82pjfswyjX6Zsp3HGVW4E27OvmcJCD4hQ7+66S7tfbXKSTH0Ne8MwD/
	 6viKIH1eyUeA7QES4YDm1wKnB3PIFbKsyL9R1WT+Mn4bIXVcaWjbYmNekma1/O9FpeRsv
	 /4zpOFfE/4+1T/9YUHS1yuv6BC90dhLPS0woKGXVUrR59bpDXAuxjtu8KayPG4WEouimO
	 PtoErr783oqc0fGItwPQVgkPAU4o5mXs5p8xZ1DkabCRdRO0fonej5nadYhPusHXrfmIy
	 CMt/zODKyLkPQzLLHu5W1a9TRn5Wc3onRslV9dhWd9W2TMZmz/OQs9DPTDtWwdd2DZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589271;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=T90is/Fq3M4BakgvweKQlUcFpJnSN8zA7BuLjyvBS8k=;
	b=AKMyIb0/aiiC6HsifQELvIIJMRBwQjzzEGgQbAGEPeKPyIEVVWGEihUKwpYY+5PQAkqw
	 QN5iqXXGr4t7AwATRFJyx4k8aIZ5QyoDx0YDp3vTwSqtJnkJq78DTmn1RshGFdb/rIDDA
	 NIJAoxWfrGsVfZ8IiLNDepYvpVdPWxrawxe56y5wHOuDxPA/J1dTV3ZZACO8RDyvn1RCq
	 5lpFIH27UM559/dsBGmlWS7U50TTOAzcRd7tVsQBzqzk5xFqrHqguhPozrkhxLr9RvKGm
	 AUxPZK6wA8ngy03Dg0E+zaP5200TcPKCXKVZus5Zf0U2KZnuBWf2mzaE0Fn2BrCBJOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=a9lwHeNy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA6606A897;
	Fri, 13 Nov 2026 17:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBCA6606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=a9lwHeNy
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AC49920178E;
	Fri, 13 Nov 2026 18:01:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794589264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T90is/Fq3M4BakgvweKQlUcFpJnSN8zA7BuLjyvBS8k=;
	b=a9lwHeNy45v+GSy0i7P7lcg5FCwWe5piG0RrHc3dWb6NVwS/r+xH7Ih7bpfwAIeUUdGcDA
	QYdMwT/IYT8IkzJZkAmumYF9+LyXwZm4oel6Zoi6Homl9FzjQklghkpz8b82eva9/xSyUH
	FNOc8mkpWa9dhuKVaTZJGo1v81/eoixS3fTa93ofAZCIzyEOx2ior0nbYVwjUXBooMVwLP
	GdXA5lErEHTWO/B7eb1vPWhV0EE1liTLtk7bryPiMjmMA4TQI/LH65Ux5giNU0qRf5Bu0W
	FG4DJqMmUWlUWP72j8XlddGTUbiUyTyiPjltjLgUAhy1do8kv9GdCG8jDL7hGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794589264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T90is/Fq3M4BakgvweKQlUcFpJnSN8zA7BuLjyvBS8k=;
	b=ALoBq9Z0P2HvP3JPZFHXcaMKwzccaDpiMAqhcNHdq+sXxasZ1r1M+2vsrWHOF+VsJaYOtX
	so2azqdz5iqa0NVKpwIfI2LJtLWHOOwu3fUIxTN19oLtqIvhzbd+JlqrjHQmOOdr9Y/73e
	bfm/EyBd7bfwylaJ4ZFt2P9jdkMJDF3K+6wfSKS7Bmfb4rC6qHSFU0Jr+ENjcIEYHQjp+9
	58wanCWHZQGc4UqOTiIqWoMq3yBiD6auiQsEPDI5sjsXi9KAOoJmrLZ759mqPwBN/VnvE3
	1wWFgR9yceHnoRjr7x9cGEDH/8SyXP3+wsmIO6QQ0l8J3Te1CdUnwhHaB7grBw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794589264; a=rsa-sha256;
	cv=none;
	b=a8/Wj0Mzl6hoCdkgHp+sUA49m2DjwNyDekgp5gwYwUSSKDFy8pmU/KQngwuIdvAOUtcp/R
	fc5cWSkozZeWCe0I4BkNQKmA6FAzDsuPPcmLHsUme2OI0YCzNbLcxWEi9Mm3jAZIYw83IS
	q5INuB527bjThuLb8/p4jSeUTCud/G0Xm0xUl0xlyVkdHzo9OZZ4YsW4SCExfGufI8E6zh
	LNnVjt+cM15W5k5U5ZByWek28vDRJLKNCxR6KRgs3XbSGA2ZD1dXEm7eBXGzNJuuTT0Bqj
	jsDRMhE7FCpB4BjHJ1Iv+29szKEUgTd0/At8q617Nl7rLYO8HGmR8PEJdw4//w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <62d7f3ee8119e57375d0038b1b6c3859aef700b5.camel@pengutronix.de>
Subject: Re: [PATCH] spi: sunplus-sp7021: use
 devm_reset_control_get_exclusive_deasserted()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Felix Gu <ustc.gu@gmail.com>, Li-hao Kuo <lhjeff911@gmail.com>, Mark
 Brown	 <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 18:01:04 +0100
In-Reply-To: <20261114-sunplus-reset-cleanup-v1-1-115e32fe8c1a@gmail.com>
References: <20261114-sunplus-reset-cleanup-v1-1-115e32fe8c1a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sa, 2026-11-14 at 00:47 +0800, Felix Gu wrote:
> Use devm_reset_control_get_exclusive_deasserted() to replace the
> explicit reset acquisition, deassertion, and cleanup action registered
> with devm_add_action_or_reset().
>=20
> This simplifies reset handling and removes the custom reset assertion
> callback while preserving reset assertion during cleanup.
>=20
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
