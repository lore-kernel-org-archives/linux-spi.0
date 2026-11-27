Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795812549;
	b=CMKqAzAshX4EEAMk1cxtVVAL80G1x+lDwzemkdh5ePtpiN4f/fKRPhjAhgJQpXf5Kayw
	 VZCpcSAo9wNn4ObYArkIqt377UnTlVwnK9hxBmltUH1UmyUnv2/ydOl1Cmz8FsK+cEaDe
	 rejzJ0OJ7HzkBZOgZrTw4G91RhMsiwsJlpq7O7oheJrvRqlS/n7aO/EwuO18U/I63UVt7
	 xqBwz/CZ72t7W67t8hnAM9GDh/H2uuf2Ki6ucpVCevL1wfXhR3sJGDptRBYSBtfYfcdS5
	 OJrZbypNUmVrnT5Xp7N6/1itdFLipMEc0p19ZgpR7cxdanZFed9A8sTcODsf/Li4PjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795812549;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=I/iQhvx5aQ2OlsCDsvekZbVpxx0QTZL6M0gfbQ11gYw=;
	b=WMZbhVjdRrYH5aQQM46UfoAOhj1pgeFSUIm1w3H5/SRIdQJteh61P5hYYRBFM1U0nh+M
	 7DWgmBx5au6HKT59DR5zVgIOrX1q26+r0D8P65nBDjgZoflQd62T1f4bc3kP4pJ0xqSPr
	 tUZdh4ODI5Nmf5Cx1NVl3QSdRfQ1C+qlbYXSN4+ujrzFE5EiBfY0opxDBKICHG0eH3ljj
	 hnN2l1dBaQi43wQYxazxoSNCUDMEvqqoc6dDDRR2IWqlffpg6/eaWFnR0ROxwVj7mQ6CO
	 iANISkuQDOfAHQWsJ6bgJxUP/gWVCOq80AT4/pvxIwODoK9RpZWepZiPLf6x4wfbFgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=m0JEwn4L;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD9606A31C;
	Fri, 27 Nov 2026 20:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEFD9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=m0JEwn4L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=I/iQhvx5aQ2OlsCDsvekZbVpxx0QTZL6M0gfbQ11gYw=; b=m0JEwn4L/M3iUnEEfvejx4e4uv
	GIV+Egr5ar/2mNGt1Sx1i20zp5BuQKcSYeMK5gSdMoUFTAqrvf1pB62gYa3DdSSQPBek022Zs45Ub
	M4OPsFWa52KC8gIaVdOAU6qe2n8m3iCrLN3V92aka61o5S9DwcTDKLD8TapjYegb5AcUbQGWdOXTq
	ZNlCOvmlZw8XnQwfGm6acLsBHG6/wRn01Jqmn+90W+++BUZsG3hM+64FStI14cm67jnguR3dpL28N
	Rz6Dcj7X4oQB2nR26fnBc1hVUrVeZ6Kh3lYRdKcURJNQsIk9PvVwfPWb7bTIZOvVuRcXOgNulCDd3
	Ro+Jgahw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Mark Brown <broonie@kernel.org>, ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: Frank Li <Frank.Li@nxp.com>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] spi: fsl-lpspi: add atomic transfer support
Date: Fri, 27 Nov 2026 21:49:00 +0100
Message-ID: <r1SUq7cwQAKEFTBObqhYYA@sntech.de>
In-Reply-To: <20261127073454.351296-2-chunyuzhiqiang@yinhe.ht>
References:
 <20261127073454.351296-1-chunyuzhiqiang@yinhe.ht>
 <20261127073454.351296-2-chunyuzhiqiang@yinhe.ht>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Freitag, 27. November 2026, 08:34:54 Mitteleurop=C3=A4ische Normalzeit s=
chrieb ChunYuZhiQiang:

> This patch was prepared with AI assistance; the submitter must review it
> before submission.

This sentence is very confusing.

So an LLM generated this. Did you actually review what was generated?

Because this looks more as an instruction for you as the submitter, so
I would assume this line not "surviving" the review step, if it happens.


Heiko



