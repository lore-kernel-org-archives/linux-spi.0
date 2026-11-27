Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771126;
	b=rRCA5fs754iKfJ7Otx1qnDoYYmAMrd7Ym+RyeItiofX/B21y/UaE/dij+VpR92Lj0gYP
	 82APEcs1vqJtG7Ky5F1W7L7LeMIG9ym8lJZ5U8qUErkjkXPBGXTQ/1on5aIdIO3dkcUcS
	 Rr4UnBaedqdorVyvqXs2IbramkbKlvUCCLD2dc/I2krEjD/eOs+X4DinelAPgdnSCn06N
	 nRDQslLPs9V83mSvfShTFliZoyKiY729sIjXxxWlZfyn0otcKiN3PkqBSoHM3SVIXco7r
	 kCAfYGdu91zUtBW3OTqgrfUjthceA1+2WVzP2m+QobkbHsJaucY7fXR8Gw+3driaV6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771126;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=Qefky8DlOTxPLdU0/wjWVMxmJw9tcsyvpnNkmobea1s=;
	b=ycX8TIGELJjeibx7E+gnGB5GuSPNbflamkEOkZROBmBEmuNE1y3sCd9UbVo9xYsWpzeB
	 2MxSfSi0kokGeUHPsfBX6mHdTHzxn0i97lHHLNvcNjuTS2W2lNV9YeB4H9u/nhlyj72L0
	 4ywwekdw6sVmmSpeUfsXnoYF5k13A+25w0q0Hh6IXbAHSQb4hvTPpYG2v5gffi/d77ssK
	 TwKJ8w9JVgSNYFEbBAyunoQq9K5y1TLBpGux4JRNh+S+3c8O+d6yV4sDf6KFXW8zhXfAq
	 TgcZKmFY6CvULENMjRWSXneBOZzbtnET9UAsO5zkdMmReHzCs/ypbvFnRoOJT+1vA1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=eU5PjGfK;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82F606A31E;
	Fri, 27 Nov 2026 09:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E82F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=eU5PjGfK
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CDA5F4E41787;
	Fri, 27 Nov 2026 09:18:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9DB3C6049C;
	Fri, 27 Nov 2026 09:18:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8576D11E69295;
	Fri, 27 Nov 2026 10:18:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795771121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Qefky8DlOTxPLdU0/wjWVMxmJw9tcsyvpnNkmobea1s=;
	b=eU5PjGfK1Jl0gedKPU+OWMgLDwNMSEJI7XN2PpMliih5+m/3v/15bPtoXKqnsIg1adOG9b
	CX+1sL8sBWMl8FCR2Q1oZXjeuEazaHOJF7d0DBG0D4OK0chVYD9dL3txls4r1kGcE9HATF
	G9eGFbs5Ldi1vJ/asLwHUmi3vbXWtdFbVeGH+JeyOa7gLemLsls7CTjOCUskn3q7I2yp7x
	zDpxxm7HjFc9pvXIJ6jOKHdFsylL0Xww2reWHt31RQuZ65TBRg3s4SFFRHa1kWrHm6/OWp
	oHUl7ffFwhYj/ayjOmKF90LDZzTRdFAyout1I03RP2ifRDoc32vCilMejmHuTw==
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
Subject: Re: [PATCH RFC 01/16] spi: spi-mem: Handle a corner case while
 sanitizing ops
In-Reply-To: <20261127084643.ekeao335mv5n5kow@shlinux89> (Bough Chen's message
	of "Fri, 27 Nov 2026 16:46:43 +0800")
References: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
	<20261125-macronix-upstreaming-spi-mem-cycles-v1-1-fd036402fd37@bootlin.com>
	<20261127084643.ekeao335mv5n5kow@shlinux89>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 27 Nov 2026 10:18:33 +0100
Message-ID: <87bj7avdhy.fsf@bootlin.com>
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

Hello,

> On Wed, Nov 25, 2026 at 06:51:15PM +0100, Miquel Raynal wrote:
>> Some mixed mode operations (such as 1S-xD-yD) will be flagged with
>> op_is_dtr but will not enter the ODTR checks. As a result, the number of
>> command bytes will never be checked.
>>=20
>> Reorganize a little bit this helper:
>> - If the operation contains a DTR phase, sanitize it.
>> - Then sanitize the op, should it be:
>>   - ODTR (8D-8D-8D)
>>   - anything else
>>=20
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>  drivers/spi/spi-mem.c | 28 ++++++++++++++--------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index 8047b7508c8d..c64e906ba919 100644
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -170,6 +170,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
>>  	struct spi_controller *ctlr =3D mem->spi->controller;
>>  	bool op_is_dtr =3D
>>  		op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr;
>> +	bool op_is_odtr =3D op->cmd.dtr && op->cmd.buswidth =3D=3D 8;
>>=20=20
>>  	if (op_is_dtr) {
>>  		if (!spi_mem_controller_is_capable(ctlr, dtr) && !ctlr->dtr_caps)
>> @@ -177,23 +178,22 @@ bool spi_mem_default_supports_op(struct spi_mem *m=
em,
>>=20=20
>>  		if (op->data.swap16 && !spi_mem_controller_is_capable(ctlr, swap16))
>>  			return false;
>> +	}
>>=20=20
>> -		/* Extra 8D-8D-8D limitations */
>> -		if (op->cmd.dtr && op->cmd.buswidth =3D=3D 8) {
>> -			if (op->cmd.nbytes !=3D 2)
>> -				return false;
>> -
>> -			if ((op->addr.nbytes % 2) ||
>> -			    (op->dummy.nbytes % 2) ||
>> -			    (op->data.nbytes % 2)) {
>> -				dev_err(&ctlr->dev,
>> -					"Even byte numbers not allowed in octal DTR operations\n");
>> -				return false;
>> -			}
>> -		}
>> -	} else {
>> +	if (!op_is_odtr) {
>>  		if (op->cmd.nbytes !=3D 1)
>>  			return false;
>
> Hi Miquel,
>
> So this change means no nbytes limitation for mixed mode oparations, such=
 as 1S-1D-8D. Is it correct?
> I go through spi-nor and spi-nand driver, seems for spi-nor, for DTR mode=
, it only support 8D-8D-8D mode,
> but for spi-nand, I notice some winbond W35N chips did support not only 8=
D-8D-8D mode, but also some mixed
> mode, including 1S-1D-8D. Does this 1S-1D-8D mode really has no such limi=
tation for address and data length?
> Address and data are indeed in DTR mode.

That is a very good point. I don't think the sanitizer ever did check
that though. I believe we should in the end have a more "per-phase"
approach, where we check all these individually.

There is also an implicit assumption that buswidth will only increase
(eg not 1-4-1) and DTR capability will not disappear (eg no S-D-S).

I guess we need to add more patches to make all these situations covered
and avoid having drivers checking for them.

Thanks,
Miqu=C3=A8l
