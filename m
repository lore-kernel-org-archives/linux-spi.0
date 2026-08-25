Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA73F54D3;
	Tue, 25 Aug 2026 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660069; cv=none; b=V+j9UYQvDXP3DvDpr3JR8YAl5GMQF9cHCDzfPgH75ozCgF+fHGawTCaSxoimot0CpVuoI9i8l8t5kojlOujmTf09o9YcaljryBUb7l3QzOsG4vqAxOXQqn6AAoDhhIQyLzVLKoDlkpw2n/u2bXlDk4OqHDBjPXozjhEm7BjNoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660069; c=relaxed/simple;
	bh=M/uXNr7j3EAL8/8yZ/kzREcoAyZcPo8n2w4C/nfsU30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZzITyVifsgSAgZVEhKvVkhSOoDjzNOeeBA7ewDDTQ8JAfdQzjIZz6MFmkJWqiHxB2tvb1SL8lj3DBj1ndloJ+xULgTSIk0QgpAvjpADsGiMagV1jfqQjk5AIANOvXWM5Foz4SxYkELJW7ntzN8BkOHdNnBVlAY/skoklyDBBLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VzLWycSv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VzLWycSv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D039B4E412F2;
	Tue, 25 Aug 2026 12:14:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A1CC8604C4;
	Tue, 25 Aug 2026 12:14:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6F1C11C792A0;
	Tue, 25 Aug 2026 14:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787660059; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7Qo5wLWIEWTr/6C+cPa6RtgusYfrnHlrypu6Z2ulQDE=;
	b=VzLWycSvnwVGhYKriL14aDoBiQcJVY3Ha9I1o15T5EhZRM0TNRq9BAIRKhrUZNZhFW8Fda
	UJ4QrqGXplewV56VdqdUOiVwRpal6tPjXfoh7SXifTy1HWcHGSviBiB2I+roOHgTLBClt+
	UbUtjaxL4ZTsmhKW1U+GZMYNFr3ujazqfMT7t6Rv/U71wvr5BidhqoVfi0LiV/szGwfIz8
	7JaINxZfKGYN/nc1AUZAvfqEpBgt6ii98aCX0V93oOjfPeaiiVHWh/Dlhs5iPXnZgi0BFd
	M4sGACutrG4f8yZu1cbLX337chXVmgQFS4Ig3MbdFhLGcJQckdv9GeKoH38tpQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v7 16/18] mtd: spinand: negotiate optimal controller
 operating point before dirmap creation
In-Reply-To: <0a18a8b8-2e93-4375-a2ae-3e7316cbaab8@ti.com> (Santhosh Kumar
	K.'s message of "Tue, 18 Aug 2026 23:43:31 +0530")
References: <20260811183313.1550425-1-s-k6@ti.com>
	<20260811183313.1550425-17-s-k6@ti.com> <87bjb6l8nr.fsf@bootlin.com>
	<0a18a8b8-2e93-4375-a2ae-3e7316cbaab8@ti.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 25 Aug 2026 14:14:07 +0200
Message-ID: <875x0yiei8.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>>> +		if (!ret && spinand->max_read_op.max_freq) {
>>> +			if (iface =3D=3D ODTR)
>>> +				spinand->odtr_op_templates.read_cache =3D best;
>>> +			else
>>> +				spinand->ssdr_op_templates.read_cache =3D best;
>>> +			spinand->cont_read_possible =3D false;
>> Why do you disable continuous reads? I know it is not the same as the
>> read template, but it only differs by a few dummy cycles, so everything
>> should work as expected. I believe without complexifying much the logic
>> we should be able to support it.
>
> Yeah, right! No need to disable continuous read as the only difference
> is the dummy cycle count, my bad!
>
> I've updated the logic to re-pair cont_read_cache with the selected
> read_cache variant based on the protocol shape, while ignoring dummy
> cycles. This keeps continuous read enabled without any unnecessary
> complexity. I'll include this in v8.

Excellent, thanks!

Miqu=C3=A8l
