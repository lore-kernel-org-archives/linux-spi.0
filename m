Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771424;
	b=wXiYYy5lea7a8L5bQH404fWX7Pm9x4wxwfZS1WOmoR5H5RgS0HnXvhVvDEvbs4O7RLy3
	 VLk5nVo5rAs8A//Rp0MVeexTsmgWYhr/Bd2NaLLJlzeOxVazOB7P74+rch8jD8voz+8I1
	 sUB+s3bUp5F9bwXMqcE0WjOiRD1gYPtKdA+489YimsadyXXIWxQchWXzsNEuCSy9BmEge
	 0Z2al1hwBy52f7jadK9zsrWnXcFM/rgX2m2+dmegKzqSAALE+9WZSRZ29LzuJYX+ao4VG
	 KLmFA5f/9Hyv4aRgRCivb+Al6oB/nEzDDhXtDC80+jmVJ5wh1b5hyIhNmdqdf0EMOcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771424;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=PH+l0IfQ28b7UEDSOlC/cTnR6aoCEbyBOr2fiW8TlTU=;
	b=o3l5IasBOZV2eM2CY+rgvJVxHf1EsLtU0QJqakPh3/6J5QGwqTonAzboIxk7BoC3MN7p
	 sILgBCoAd13qB877NQ/kbdx/uNeFsJGqXzdMqU51MDVYYjKWcSM4p160mjMJDE9LsW1Gu
	 t8DsJTp0lXSWDfZbrXV3Flwu+XV+6MqkgIJ40A12lY/BqpmX15/OmbUmTFiV7NvC4CeF7
	 zbeCFnq1xIi4ivMHjAW8f7evEGjJWK3PNJaOzjXNsI9tLR/jKAkfBC0t/pTbgskMpU2NR
	 t2v+B1YWQO3OuvbKoiK8PSZ8RJQvw2Hdwq0X5qTvx1MpIPQadGL6WgySicfwjMuu1nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ff2U6hPn;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287C606A326
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 09:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1287C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ff2U6hPn
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F2EB1C62216;
	Fri, 27 Nov 2026 09:23:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3FD5D6049C;
	Fri, 27 Nov 2026 09:23:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 997C311E69295;
	Fri, 27 Nov 2026 10:23:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795771419; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PH+l0IfQ28b7UEDSOlC/cTnR6aoCEbyBOr2fiW8TlTU=;
	b=ff2U6hPnfdWAVrHeE+QURp8p7spbk1dJChI6RpTqx3eZ6Z3NSmqEVqcsrKBWqUpqwxoqWW
	zc/fJA/3RG5rOfbi3GI0F41sSS9iHwSig5LSCGt1aXBDcpRxI3DT8e8RJknK0sQbIl5kfU
	fdQvbBmJgmrJbK1tkN+JTKCuLjWJUt8EV3cO/KgSmj55J+HF2kejPGpxpzQJlPHmgFegnn
	gT98jrBXT2PzOH6AL4wHjqlAbY+tfPkFyNcwy0ZMUmc8pSVOvdPYHQMXQlEU96yCUjPdH1
	ZbVOCf20wWo+PSdFfV0SZC2WzOlKgPtH9tgx0ynelI4M7dV1719v3WkwGWwZmw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bough Chen <haibo.chen@oss.nxp.com>
Cc: Mark Brown <broonie@kernel.org>,  Liang Yang <liang.yang@amlogic.com>,
  Feng Chen <feng.chen@amlogic.com>,  Xianwei Zhao
 <xianwei.zhao@amlogic.com>,  Han Xu <han.xu@nxp.com>,  Conor Dooley
 <conor.dooley@microchip.com>,  Valentina Fernandez
 <valentina.fernandezalanis@microchip.com>,  Daire McNamara
 <daire.mcnamara@microchip.com>,  Haibo Chen <haibo.chen@nxp.com>,  Jyan
 Chou <jyanchou@realtek.com>,  Yu-Chun Lin <eleanor.lin@realtek.com>,
  Maxime Coquelin <mcoquelin.stm32@gmail.com>,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Michael Walle <mwalle@kernel.org>,  Takahiro Kuwano
 <takahiro.kuwano@infineon.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Alvin Zhou <alvinzhou@mxic.com.tw>,
  Cheng Ming Lin <chengminglin@mxic.com.tw>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  imx@lists.linux.dev,  linux-riscv@lists.infradead.org,
  linux-stm32@st-md-mailman.stormreply.com,
  linux-arm-kernel@lists.infradead.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 02/16] spi: spi-mem: Stop checking the dummy
 buswidth against board wiring
In-Reply-To: <20261127085359.euu6z5rydr655ycr@shlinux89> (Bough Chen's message
	of "Fri, 27 Nov 2026 16:53:59 +0800")
References: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
	<20261125-macronix-upstreaming-spi-mem-cycles-v1-2-fd036402fd37@bootlin.com>
	<20261127085359.euu6z5rydr655ycr@shlinux89>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 27 Nov 2026 10:23:30 +0100
Message-ID: <875wxivd9p.fsf@bootlin.com>
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


>> -	if (op->dummy.nbytes &&
>> -	    spi_check_buswidth_req(mem, op->dummy.buswidth, true))
>> -		return false;
>> +	/*
>> +	 * The dummy phase implies no actual transmission nor reception.
>> +	 * Its buswidth therefore does not matter much.
>> +	 */
>>=20=20
> Hi Miquel,
>
> With this change, do you plan to add the linked patch back?
> Setting the dummy buswidth to match the data buswidth is more reasonable.

No I do not. Doing this would only paper over the problem for certain
cases and would for instance break many of the SPI NAND cases. Those
chips currently derive a number of dummy bytes based on the dummy
buswidth, which is the same as in the address phase. So changing this in
spi-mem or drivers would break this assumption. Either your controller
has a cycle oriented dummy phase, in which case there should be no
problem once converted (see the patches below) or it is byte oriented
and the mode should likely be refused.

But maybe if you tell me what you have in mind we can search for a
solution for it.

Thanks,
Miqu=C3=A8l
