Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236946;
	b=FYxStOxFUFojNYFbLx6KtdyqDbHz1mtz5NBKpkIsM2ebAAQ51e7DDUASl44LuAgUK2M+
	 QCAXR6L9PBSG76MjPsD7g+Q+pyv62c5z4ZB4jRnpoYIn+B8mvHoNQOUpvuVHbpXCSufbR
	 Hi0jNkfZLbiVgwNSgGk0xuXcEdYH+/lq3Pb7wl6a7K0ZSQyhNNZ03LYbIALZYBQD5Z3l+
	 wX4N44oet/IacZFHzQPDf7MGfe+RXB7H2cIHFE+EvWiRq4Aif4KjjU51OG3EDyvaLv5yN
	 b+mos1cixdefU73GESmZao8eS3oZeN3ZA/XskrN7Y/P0w+aOs1iH4SaSaeFsn9NGXOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236946;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Last-TLS-Session-Version;
	bh=1pL1k1T5KspZdaSrb0Egar4i/VYbDDo6iV1FmfyhscA=;
	b=2Zi0pswGJdCnUwKFdL0Vj+aZfKHCvH7J7wwD76jT2M1WJ3wu1z78ToWTC+hYH481eLTs
	 ZUUgozJesMIRsDB8Q4puf8tYjT5Tb5fZeMKp58hxETLmFKmkP26nlIMnQKE2zRQstZ33S
	 BdTymhyYPx84C0KlT4nKUOkCPrAdDAu707zKPeloSlnJO7Fxs9B5+BKwY3IxE5AwZZuhL
	 RmeUb+3HDsS3RZamMAccJhCtThJblRnOLlpxO/XKiQMcPpst3lkOUEg7bBjo0Cj+6EdM2
	 yewvsidDA7rBQXarjprVoRo4N8tHrVkTVIH7R6nI3g8lX7JPfH/un4E9vicLsIiBKrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ayTqZ9IA;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD0606EE91
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 15:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDCD0606EE91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ayTqZ9IA
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 02CE51A15E4;
	Mon,  9 Nov 2026 15:09:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BE2D960051;
	Mon,  9 Nov 2026 15:09:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD95D103293DD;
	Mon,  9 Nov 2026 16:08:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794236940; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1pL1k1T5KspZdaSrb0Egar4i/VYbDDo6iV1FmfyhscA=;
	b=ayTqZ9IAU5nGbhAOmdc/ztdO9BeSrQg9JheDVijtCFNzsD7ZMkVA3tWRrM2FYOXMIMLrlj
	T+04iVhXB8I+azL696MIqEQPnetCDvgZDo4L+tTc3NY9hDfTM4Up8dMk0ZfaooCBlK42qu
	6bIC2abe0GP8bAolBCZZM5TmN6Pw6jJ6dEXE2ppRLsNFCoq+8467jn7zsdfNZGnFK/RENX
	DA7/rBYPgqRZeaF5H6jUdOs/mv5mHIYoVFf6pZyOA1PP8c0R2sH11KpvmT8DHfKCUiYjly
	rEsTa/FXR1apa7Tw3YbOseZh6wOKAu9vYfpP7bdYN+s32LzovxW88EXlFhFtVw==
Message-ID: <8fd61964a9a8193e4b4ec386b3f9aee69ff6b75e.camel@bootlin.com>
Subject: Re: [PATCH 1/5] spi: cadence-xspi: Reconfigure to STIG mode before
 SPI message
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni	 <thomas.petazzoni@bootlin.com>, Bharat Bhushan
 <bbhushan2@marvell.com>,  Sunil Kovvuri Goutham	 <sgoutham@marvell.com>,
 Tanmay Jagdale <tanmay@marvell.com>, 	stable@vger.kernel.org
Date: Mon, 09 Nov 2026 16:08:54 +0100
In-Reply-To: <179405331442.3424803.15701905615212408804.b4-review@b4>
References: <20261104100643.162694-1-paul.cercueil@bootlin.com>
	 <20261104100643.162694-2-paul.cercueil@bootlin.com>
	 <179405331442.3424803.15701905615212408804.b4-review@b4>
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
X-Last-TLS-Session-Version: TLSv1.3

Hi Mark,

Le samedi 07 novembre 2026 =C3=A0 12:08 +0000, Mark Brown a =C3=A9crit=C2=
=A0:
> > The .transfer_one_message() function uses the STIG mode, therefore the
> > xSPI needs to be configured to STIG mode before starting any transfer.
> >=20
> > Without this, .transfer_one_message() simply won't work, at least on th=
e
> > CN10K SoC.
>=20
> > @@ -1112,6 +1123,11 @@ static int cdns_xspi_transfer_one_message_b0(str=
uct
> > spi_controller *controller,
> > =C2=A0	int current_transfer_len;
> > =C2=A0	int cs =3D spi_get_chipselect(spi, 0);
> > =C2=A0	int cs_change =3D 0;
> > +	int ret;
> > +
> > +	ret =3D cdns_xspi_set_stig_mode(cdns_xspi);
> > +	if (ret)
> > +		return ret;
>=20
> If we return an error we need to also set m->status otherwise it'll be
> stuck at -EINPROGESS and we will get confused.=C2=A0 This is a preexistin=
g
> bug in other bits of the function :/

ACK.

So I'll fix that first, in the v2.

Cheers,
-Paul
