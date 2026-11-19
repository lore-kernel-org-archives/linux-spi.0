Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100129;
	b=WXIxhiYmTj4WbNdueGLRYEcRVbDl1Z9OHpk56Bjfz2kSu4e642uFcelWOECveWp8+FR3
	 CYOCvY1MRuU/Fwj10s1a/k/KpPdzPN5FdZ9W9dETFAt4qJGXzNZS/VaUB+wP82/vmmith
	 Z+UT4zIN8giIA1xYnr6JyNY9ZiP0cyDOWz4/AQTAg0KzwOPC0zawfPMdnx/fB+fIPSjcF
	 cWnzs0TqE0ZMc2NYgtejLjNyiylwhyHOQVYcVRZo5L/VEN8iWp1CmUtCrPJeu7PwuvAnP
	 frx/31uzo05gizz7Hp+WlhdoLF63pVCB4XIpwCDeX3kJ9YJe0kVI33t3tohIS7CTnng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100129;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=aKrzxSz3hLhQkNDEUiWgUXoAj4YRodSBySP8V/h8luw=;
	b=Vlw3hn6fme+x5wIJN5078a9fu5xzPyIPGoT/wm18HwxcDUZW7mFtupikyFoe3epp8+4M
	 fW3cA+S+N3mOCal0cD1/xMSn4mw4v6PH27O5ols/m4uNU/sDt5mffJRW9pVfj04sWEkMP
	 bOxWguxs/K345r8b0ZvAoW7tVjXbFZGGIH9+55ly1+/BWR2hXnyUwpOUYDhbpWFKh+t+7
	 HvExE5eBsNURxrD6XFWaEgB8iyExramjmZRHVcn1BvmY3iqWR+J3862WfyYzKxZiQHNZh
	 ejpJ7p1Aii81oc7KBwrN72PWGUJjhWWGtW4VoGYSHsQgFB2hPW/n+A1EIx885SuRF9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HTrfOzxM;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB98606A324;
	Thu, 19 Nov 2026 14:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDB98606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HTrfOzxM
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 48675C4CBF5;
	Thu, 19 Nov 2026 14:55:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6FF2D60237;
	Thu, 19 Nov 2026 14:55:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E98211BC0B70;
	Thu, 19 Nov 2026 15:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795100109; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aKrzxSz3hLhQkNDEUiWgUXoAj4YRodSBySP8V/h8luw=;
	b=HTrfOzxM13WZ7n9aAmFcRFr5pAcxHA3ZqJL0kywhahRXAf//gq+yRoV22ahT0GZ4QXv3xj
	BLpPtTSNqmnKjV5bmUeNef4QhBKJigTonGXBxBIcK1WgU0enyEOnE6EnelZ1Fmm5IWwK/1
	SpfKUcqu7WpwkVJk/1T1UYw5FLOhcDLEc+3bS6Owx3vIcae0dPgxFt5z9Vi+kLiXvGbjUw
	7rD0CUDgx0PmaaQZpLPfXBXBv3K5yVeS20MNsRC5kNbvbcKqRkhSrCTrTMHTFtv6oyRun6
	YTvMF40qjQVWsvoIQUtXICu8ojYSQnzBNoDrXj197T8GqbUf16nvR4tScqBWSw==
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 15:55:04 +0100
Message-Id: <DMZ9VNGP6GSZ.15VHI64APKAQR@bootlin.com>
Subject: Re: [PATCH 06/10] spi: cadence-quadspi: Bound chip select against
 f_pdata array size
Cc: "Mark Brown" <broonie@kernel.org>, "Foon Tan" <lftan@altera.com>,
 "Graham Moore" <grmoore@opensource.altera.com>, "Murugan R"
 <vadivel.muruganx.ramuthevar@intel.com>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Pratyush Yadav" <p.yadav@ti.com>, "Dhruva Gole"
 <d-gole@ti.com>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Miqu=C3=A8l_Raynal?=
 <miquel.raynal@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <stable@vger.kernel.org>
To: "Lee Jones" <lee@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261119091810.3440619-1-lee@kernel.org>
 <20261119091810.3440619-7-lee@kernel.org>
 <DMZ3XW6ZEFDF.2WJ1XU4UKTRAH@bootlin.com>
 <20261119143347.GS98456@joneslee-macbookpro.roam.internal>
In-Reply-To: <20261119143347.GS98456@joneslee-macbookpro.roam.internal>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Nov 19, 2026 at 3:33 PM CET, Lee Jones wrote:
> On Thu, 19 Nov 2026, Th=C3=A9o Lebrun wrote:
>> On Thu Nov 19, 2026 at 10:17 AM CET, Lee Jones wrote:
>> > @@ -1761,8 +1762,9 @@ static int cqspi_setup_flash(struct cqspi_st *cq=
spi)
>> > -		if (cs >=3D cqspi->num_chipselect) {
>> > -			dev_err(dev, "Chip select %d out of range.\n", cs);
>> > +		if (cs >=3D cqspi->num_chipselect ||
>> > +		    cs >=3D CQSPI_MAX_CHIPSELECT) {
>> > +			dev_err(dev, "Chip select %u out of range.\n", cs);
>> >  			return -EINVAL;
>> >  		}
>>=20
>> OK this does fix the bug. Here is another proposal though:
>> ensure at probe that cqspi->num_chipselect <=3D CQSPI_MAX_CHIPSELECT.
>
> One slight hesitation with this.
>
> In cqspi_of_get_pdata(), CQSPI_MAX_CHIPSELECT used to be 16 prior to:
>
> 7cc3522aedb5 ("spi: cadence-qspi: set maximum chip-select to 4")
>
> ... and cqspi_setup_flash() overwrites cqspi->num_chipselect with max_cs
> + 1 at the end anyway.
>
> Thus if an older or out-of-tree DTB (e.g. with cdns,is-decoded-cs) still
> has `num-cs =3D <16>` while only populating flash@0, failing probe in
> cqspi_of_get_pdata() would break a working board, whereas clamping
> num_chipselect or checking cs against CQSPI_MAX_CHIPSELECT only rejects
> child nodes that would actually overflow f_pdata[].
>
> That said, no in-tree DTS hits this, so if you prefer rejecting
> (cqspi->num_chipselect > CQSPI_MAX_CHIPSELECT) or clamping it, let me
> know and I will happily make it so.

I still prefer the clamping or erroring from probe. A devicetree (ie
hardware description) which tells us this controller has 16 CS has, is
and will always be wrong. I don't see why we'd want to bother with this
edge-case.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

