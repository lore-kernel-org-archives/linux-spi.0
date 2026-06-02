Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210B3CE088
	for <linux-spi@vger.kernel.org>; Tue,  2 Jun 2026 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402732; cv=none; b=cD/V0GNdS2KBuiupLee5wYnvLYTTt4+zNCnUKyZdFek6ef1g/PGl3VAyEJuRLUnpNfdvS6nNrkY6P8scOmUvCpImQg1qH45zDG/r2EOuBhP1UQuhje151jkcPxdiw/gwDu1A55P1H38mN8HYntaVGYTf033FMbA2TyNXMN88n+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402732; c=relaxed/simple;
	bh=kGsKCEXO0ZUzl+8w3uTBJNuhgkcJWQGWwJRl+g4zDAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GvHeUdCrNenY7JliE/FyI0RyjtGcDh+o1C9asMXNMOX6+QoUY8/WAfyvk17Rl6cWb3Q8gaVOrPwFHy/QOwCxMpPLDlCsCKWg6/m9DtE5dqWPRrqwT8tKmSj35m3ftuMZpsm9JN//rPSLP6URT0eiihtzpGgTTfmm/5BanvF130E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F4ukxueR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F4ukxueR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 789991A37CD;
	Tue,  2 Jun 2026 12:18:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41356603BC;
	Tue,  2 Jun 2026 12:18:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B693110888429;
	Tue,  2 Jun 2026 14:18:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780402729; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LDb4o52DTUweCNoaveunh0r8+3SLZ3VLRjrgEU8ebf0=;
	b=F4ukxueRbcpmWVLMtCyjP8pu5HOz/aIu4z/6QeJu7cdoxhQ7cJDhxIu1oMOrZM1UAFwyob
	aTrZLusfl8KLnYxou0aIsz+BGN9PSb3Pqg3A3ygNJA0a3jXyyT2lXVAFsT9Tv4uNat8J0H
	b8Gc8eB+y6OiTIU8WL1Wk65mX2Bjv02CyJWSbw34U0xrtBn1PDJwVFjiReZfeRbdTeJwMC
	mgtmwgZj422X0cAIdfUxSuvPhljWjKxGy5pzSANENbAISkYtAonhN+xiodHUC0pT7OkQWx
	2ZYqxq58hl545Fg1Jx/v6CsgOfHznY3XwrdzKKvZZ1m6YJ8N6RdCO/99a04X3g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 11/13] mtd: spinand: run PHY tuning after init and
 update dirmap frequencies
In-Reply-To: <2f509130-491c-4a66-9156-39b01b40e65f@ti.com> (Santhosh Kumar
	K.'s message of "Mon, 1 Jun 2026 14:46:44 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-12-s-k6@ti.com> <87mrxjg9zi.fsf@bootlin.com>
	<2f509130-491c-4a66-9156-39b01b40e65f@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 02 Jun 2026 14:18:37 +0200
Message-ID: <87y0gx16g2.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Santhosh,

>>> +	/*
>>> +	 * Dirmaps were set up in spinand_init() before tuning ran; update
>>> +	 * their op templates to use the validated frequency.
>>> +	 */
>>> +	if (!ret) {
>>> +		struct nand_device *nand =3D spinand_to_nand(spinand);
>>> +		int i;
>>> +
>>> +		for (i =3D 0; i < nand->memorg.planes_per_lun; i++) {
>>> +			if (spinand->dirmaps[i].rdesc) {
>>> +				spinand->dirmaps[i].rdesc->info.primary_op_tmpl.max_freq =3D
>>> +					spinand->max_read_op.max_freq;
>>> +				spinand->dirmaps[i].rdesc->info.secondary_op_tmpl.max_freq =3D
>>> +					spinand->max_read_op.max_freq;
>>> +			}
>>> +			if (spinand->dirmaps[i].wdesc)
>>> +				spinand->dirmaps[i].wdesc->info.primary_op_tmpl.max_freq =3D
>>> +					spinand->max_write_op.max_freq;
>>> +		}
>>> +	}
>> Unfortunately, hot fixing the dirmaps is invalid. When we take the
>> best
>> variant, we select a maximum speed that may be lower than the tuned PHY
>> speed. We cannot just overwrite that value without consequence, because
>> depending on the boundaries we cross, extra dummy cycles may be
>> required.
>> I believe spinand_select_op_variant() shall be aware of the different
>> possible speeds. It should look for the max_speed_hz capability and not
>> for the base_speed_hz, and fallback to base_speed_hz in case of
>> issue.
>> Or otherwise, maybe we could go through the whole I/O variant
>> selection again after tuning, with the actual maximum speed set.
>
> Good catch. Updating the dirmap templates after they have already been
> created is indeed not correct, as the operation selection may depend on
> the final frequency and associated parameters such as dummy cycles.
>
> Instead of patching the dirmaps after tuning, I'll move the
> _execute_tuning() call before dirmap creation. This way, the validated
> frequency can be written back into the selected read/write variant, and
> the dirmaps will then be created using the final ops.
>
> I'll rework the flow accordingly and let you know the results once I've
> tested it.

If this is doable, it is clearly the best approach, but on the other
side you might need to know what is the read variant before running the
tuning algorithm, so I am not sure it is feasible. I'll let you dig the
topic and propose the best approach you find!

Thanks,
Miqu=C3=A8l
