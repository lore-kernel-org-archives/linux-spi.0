Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795515975;
	b=LxU6TJdnvXo+GLmcEBMmjCGu5Oo16uU6CRBb9tui0LAuEikPwhMSW6WG68Hj3YRyis1Z
	 xyOSpBDXXoDQfOfDVSwmYj3t02XdsJ7TZjgDZuQ8We7qxHMi1MWdajUa4DIcKdgl0mfV/
	 wzCTP8i8z37Sluu/wBAH6ry+C+dI3j5/4HuEikTxoHy1SQwVMZwzef9Z8fyxXfDYJ/sZl
	 qLj4zPmPrBgVvDV0RV4hMKNMQ81U22XAgdR730jjDSmXspenpG7M87S/xaddIPiK/2Whr
	 6hUy3gw+ZpnCz6Ux30uAEkCGWv9LGGv39HACg2Wx8QPPx/Yq59gApfz7kFDVtHiJ7Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515975;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=UoCrI4A7Hlf20jxhBPJOheOwVhrEFPq+18YbW/SpkGs=;
	b=T3uDpty1kzNtppsm2ZkmARbkqZOnURXjnoVOGfpvJOo01sPgBr6qlITxL+69RsjKtE1D
	 am7Nj8wAVKmslr93neW1oDzJRtOrjsoGQNTxYIG1wsZY8DHWMlVaOnfyMmdggoAS2A5aM
	 tUpgLYYa3mbxQb2dQ019PhhhNXOD66yWxM7Um2dL/REGupxUz76E6YSiii+X5gRsqjGq8
	 GiPPUf36xJ43F3KREzi0P5OsdFIOXBNbXt3Iaqg7n3f+9b1npNGwyEvzmkEQrPnElx42T
	 gDq2vKXHb9BtUUeIYCfmEFLiW3em1Q3ybcV8zm2XlucVvVOVsTXyQf+rb4Xecti9Uhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bJYtdM0n;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E8D606A32D
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 10:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E8D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=bJYtdM0n
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9A79E4E41755;
	Tue, 24 Nov 2026 10:26:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6F05F601E1;
	Tue, 24 Nov 2026 10:26:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DFA1411E69B4F;
	Tue, 24 Nov 2026 11:26:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795515968; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UoCrI4A7Hlf20jxhBPJOheOwVhrEFPq+18YbW/SpkGs=;
	b=bJYtdM0nd0zscJzwMib6gs+d/tH1oQ4iS0FdZefiInpKNrIBCF9Kr3j1ZrTLB44Yw4v2Iz
	y3R9sA8etT7hAVTffx/md6s9HhwcTr+zXTirk+pP6RrmvCC3TmZ3FOyqbfoab5LoxutBk2
	ObUnzIcjjzvQVhJvcnegg+7tFG10ZAd8BWewOKiCIJ/R1EBuvVAm4h5V/mu5ABcE9aTJRf
	fxB/QzDLuQ4gHFXHadLXeF/R0roEZgq5w/zOtTV8m1aOWcO73HQVeDA/DtTc4alo4tonzh
	DpqpO2gjb5vRTPTA7nyDYphvh5RVeuFQlVvCjRdn800y9sUKsAb/J5sHn7TDNA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Takahiro
 Kuwano <takahiro.kuwano@infineon.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  praneeth@ti.com,  u-kumar1@ti.com,
  p-mantena@ti.com,  a-dutta@ti.com,  s-k6@ti.com,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  devicetree@vger.kernel.org
Subject: Re: [PATCH v4 00/11] mtd/spi-mem: Enable DQS control
In-Reply-To: <164905f5-2857-4b8e-8d99-26939b45cde4@sirena.org.uk> (Mark
	Brown's message of "Fri, 20 Nov 2026 17:51:41 +0000")
References: <20261120-winbond-nand-next-phy-tuning-v4-0-8c21e1f71f41@bootlin.com>
	<164905f5-2857-4b8e-8d99-26939b45cde4@sirena.org.uk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 24 Nov 2026 11:26:04 +0100
Message-ID: <875wxmttj7.fsf@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 20/11/2026 at 17:51:41 GMT, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Nov 20, 2026 at 06:14:26PM +0100, Miquel Raynal wrote:
>
>> This series applies on top of v7.4-rc2 and Santhosh's PHY tuning series.
>
> Please don't send patches that depend on other in flight serieses, it
> just makes things much harder to manage.

I understand, just wanted to let Santhosh et. al. know about this
publicly.

What is your plan with Santhosh's series? If his series will make it
this round I will respin once applied. Otherwise I can just respin the
independent spi-mem bits.

Thanks,
Miqu=C3=A8l
