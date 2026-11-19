Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119099;
	b=jQJKkapBDIabNi5jr4qDozOSR3mRf9n17NcxrYQYpP7tYFLb1PoZShDZn4X/AM9jI98j
	 OsLdnT83l+TTLKq9S7J+4py4rqeEnXyvqn2HRCH65YD5fUPwDXTanWDWUlsxeRTr81Pb8
	 ve2qvy4ITKq5ZY9qJYOrZeCoUBRxO95cGt+RPkLt71WjyVqritwv34zkVnypodSGe60HX
	 nBWq4Tpf051XlGSXyiHs8k5fEUzelmbRZp1I6wVnupN7XjwLPw92LT3iKQsZD9LtMAIoq
	 iGwtwov8id9j418jI4xZWUNf2eqde81QK1FcXFrMW+F1d2lKxSYBI8Ljevaad0mXUQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119099;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wNlWGwIM5iCAEN9ZQKThNv0IwwMhu1mhXHRf6tCI0g8=;
	b=SJOu8MJtQf6EBBaIj56GoGyXqhocDTUGN153iXA24oMxmYh8w8Eaz0R4jKpe52v+QRkX
	 qmW0q1m3eIDdvgvjjz7sDl2dqFrdEDat5XyWq0liW5uj5AYn+n98DFRjDR70XEGInUIqx
	 jLOWFMMqGxMEEFERJik8rzM/noBhSDZwUlUv+qYWnc6mx/RBKD/adoT3V6R+SQAAdNhaM
	 bQi696dxsavT5UgBMQ5AYWEpMqDAS3HaPSuPLxl2LFvYXbTbXEcOAOiShDQ2zeN36/taK
	 Mp5kj5BFRvaP7QaHcsvUMVikPrEogfISt0wqHTJourN2KApDf7NkuFk4vhJTSsSsvcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFmzl0ik;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558960A2612;
	Thu, 19 Nov 2026 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFmzl0ik
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF451F00A03;
	Thu, 19 Nov 2026 20:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119099;
	bh=wNlWGwIM5iCAEN9ZQKThNv0IwwMhu1mhXHRf6tCI0g8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=iFmzl0ikDQ9/MuktrKwJQl0mkVz1Q5mMtUiB//xPfxVmAFXJZiXPsQdnVCPvE0zOQ
	 eYTqYnm57F46VryIuW/DMhGA8d09Ltrv6ngbRhY1gX9iAjjJhzEoLA8XAWZyhspcb7
	 C8B5W+q3KrtkYcPIsAx93+TPT1VTfK0ayJ81JGCmzS9TcC2kMzmGKXUrNMiby8otjI
	 sPsVfVpXOj9ZGqtdLWcW70PJ9wnLdOfKjdHmKrUUrkEA9y7hwSatHpsKxsR6le066F
	 VevM4VOw0SfaPJCSV49Qqtvz/6KOWXwZ0+SmjWFZ4OarjBgk0trI5v2Kmryq6UY8sc
	 eqPHV6X3iA+FA==
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/6] spi: dw-g2: add Synopsys DWC SSI v2.02a controller
 support
From: Mark Brown <broonie@kernel.org>
To: Prakriti Sharma <Prakriti.Sharma@synopsys.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 Siddhant Kumar <Siddhant.Kumar@synopsys.com>
In-Reply-To: <20261119100513.433044-1-prakriti@synopsys.com>
References: <20261119100513.433044-1-prakriti@synopsys.com>
Date: Thu, 19 Nov 2026 20:11:34 +0000
Message-Id: <179511909433.116416.13911856167511769395.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=378; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZeaoiKlWwyGrA4iecHfqTqnz5jD8gW7FpcT8v8CeHlI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+h39vPTuj7EHt89c+rX29+c1hai8Wmkr0rtLKTCxeX
 trQafypo5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABNRZmb4n2q/meWyWuKdrORV
 M//yZFrdnG/vMu3zKSmxvf7fLq6+c4iRYf3Wh86LLZyn15ccDSjReBF95V2Ljp/XGjOO/6wp0mf
 LWQA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Add a driver and DT binding for the Synopsys DesignWare SSI Gen2
> (DWC_ssi v2.02a) controller.

I've sent a few comments on the individual patches, and I had a glance
over the Sashiko output a bunch of which looks valid.  I think the main
thing is that there's a bunch of open coding, a lot of this feels not
entirely Linuxish.

-- 
Mark Brown <broonie@kernel.org>
