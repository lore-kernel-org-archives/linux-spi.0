Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252435A93E;
	Tue, 10 Feb 2026 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719073; cv=none; b=NJ+I3u0JROjebTpi2bbzyCQGAkqFPVQJ3mc+a2XoR6ekZsfQBQDiXVg9d19xD5Mq8oCs95tdBn+L1cHAR0NPfRoayvSncmkL0aBdL8zDlg+7yd3hCvq0Yew9cBYD3dSxW45mYGIZluuGQLKIc2e2G+/mNojcj1udNUWyFRCOnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719073; c=relaxed/simple;
	bh=qh+wDKC9DtNaunvrhzUg8ZvWzc8AGSkQY6EeH4VI1pk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n0rt0ekTGwLPURmf66grYuTjsxoSIFC0QA/N1KI8HeI5nuIiTIjU244FtAo5J35WWUCp8l/r94ykKVVDla4ZZ58CGtQqy82wFrf3Ylv8oLojX0sUfiHgaUNPWoW7mGH6KOQsC8A9Qh6Pn8RN53KHbP+bLsWpHGZDITyMIuSrae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NUGOt2qj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NUGOt2qj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 195EA1A0BD7;
	Tue, 10 Feb 2026 10:23:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D4852606BD;
	Tue, 10 Feb 2026 10:23:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5266F119D10AB;
	Tue, 10 Feb 2026 11:23:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770719038; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/Imw93ygjLS91BX1TYQywEnwPobZLvvLSfN2yGVqTa8=;
	b=NUGOt2qjI0L9+6HoPSM4LgZhESsfIeMdnzahBizANCDctJp73VqtmCphDg2+KQak+ZT4c9
	1BXOkH3PiXfSer7FuJ3PKRSSkLm7hkUNi3ehN2clm1j/fRMDaM9M09VyC/IYllnwi9bjvx
	0NE5el19DmMVvEtLAhC3a6nocVh6Mse3BVG8AERs0viJ7HfRu35w4bMiiHqeYuIA7/CeXe
	k3T5OeAda+fYO526blJDuaSKAqqg+bfb0fsTH0UkdPIZxssWnv3ui1Iy8JdHiJVRLLKLRQ
	ivt6MhCoP6ncTBQ8VbPzM8f62ifHQ/X9MJqwXa/438gYFKkpebEEkgBIJOQwJg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  "Vignesh Raghavendra" <vigneshr@ti.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <p-mantena@ti.com>,  <a-dutta@ti.com>,  <linux-spi@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH RFC 0/4] mtd/spi-mem: Enable DQS support
In-Reply-To: <41f49187-e68b-4731-ac86-7c346de63173@ti.com> (Santhosh Kumar
	K.'s message of "Sat, 7 Feb 2026 01:02:12 +0530")
References: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
	<41f49187-e68b-4731-ac86-7c346de63173@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 10 Feb 2026 11:23:55 +0100
Message-ID: <87pl6czykk.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 07/02/2026 at 01:02:12 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Hello Miquel,
>
> On 06/02/26 00:36, Miquel Raynal wrote:
>> For his PHY tuning series on the Cadence QSPI controller embedded in TI
>> SoCs, Santhosh needs to access the availability of the DQS (data strobe)
>> signal. This is a chip dependent capability, which may sometimes be
>> enabled.
>> Create a SPI memory flag for it, let the SPI NAND core set this flag
>> when it knows about the capability, and show how to use it from a SPI
>> controller driver.
>> This is an alternative at needing a DT property. Please note that
>> there
>> are a few blind spots:
>> - the line may not be wired (this would be surprising, but can be
>>    flagged this time by a DT property)
>> - manufacturer drivers must enable the feature if it is
>>    available (especially for high speed DTR modes)
>> - this implementation is proposed for SPI NANDs only, if this proposal
>>    is accepted the same approach must be taken in SPI NOR.
>
> Thank you for the series!
>
> As mentioned in the tuning series, in addition to the flash advertising
> its DQS capability, we also need a DT property to describe whether DQS
> is physically connected to the controller. This can be represented using
> either a "dqs-wired" or "dqs-not-wired" property; the exact naming can
> be chosen based on the majority case.
>
> With this series, the controller will enable or disable DQS by logically
> AND-ing both pieces of information.

Do we really need this?

My expectation is that someone wiring an octal DTR SPI chip for high
speed octal DTR use **will** route the DQS signal. If this signal is not
wired, I want to consider this as a hardware bug.

As a result, the default case should be "if there is a DQS signal, use
it".

If, however people come up with non correctly routed chips but still
want high frequency support, the burden will be on them to ask for a DT
property describing a non compliant hardware layout, eg. the "no-dqs"
property. You can take this on your shoulders if you want, but I would
recommend not to, because this will require more patches and another
round of review from DT maintainers which, I believe, we do not need at
the moment. This DT property would be orthogonal and could very easily
be added in a second step, keeping this series "small".

Thanks,
Miqu=C3=A8l
