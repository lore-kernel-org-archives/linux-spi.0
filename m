Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBFD17BEBF
	for <linux-spi@vger.kernel.org>; Fri,  5 Jun 2026 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678514; cv=none; b=uTxr68rBzkV3u1DvKyPZpS3aHmDoS/2+8SHqvM5j8EHFlym6U5oXkBA+/C7H/1yusKqKJMb0bmyPEabZiDxbmzh6LtE5XzfXI6nCecuAL/1/OFDfx205TRcpvQ7kLuyL8+cpirs1TdS/1hlaNWyZAeHVTp5siNqCH+9+pM+U34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678514; c=relaxed/simple;
	bh=VQDg/ysUOsAcr851JW4UFD0Y9MDkfUj1C77vlusmwlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LtGS1/cMdorbLqynOm2RANFUip7sZyxARqIux3CvECekZbJyKgXwTipSJ/Fcr+6NY5gEtejJGUH0250TYr7W8gAf9sD1lrst/EX7FP+fwwCziKWDBz8Hhz52sfJ0zHFFxgp/CkbMcWVi24sUePOjAvYgOGFBMhIWFVX78ePaRAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yrLBi1mi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yrLBi1mi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 76EF34E4080E;
	Fri,  5 Jun 2026 16:55:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 395A95FED1;
	Fri,  5 Jun 2026 16:55:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3DDD106A24CC;
	Fri,  5 Jun 2026 18:55:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780678510; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VQDg/ysUOsAcr851JW4UFD0Y9MDkfUj1C77vlusmwlk=;
	b=yrLBi1mi2rwe8UgnCWTg14FCs8780F9FMaLXfP1zYXCjMQ1NBsVuti5VsF9mon/aK7Bd/g
	GmhlElgErRw82XIOuuXDgIbVgIZav5GeLscixodanfzGxczQnvdQhdo68Tfwd1ckascxyP
	J0i2aZH0XqeFV4lWm8d8KUX2LxJAFHDLOMO+6RemMeTL8NUw23tSbq6OrmJdtPmZFlo3+Y
	Uvs3jkatYJNBCG2IULrVCTlHgYiSxMJqolyeA/pJfmJFBmYOLhRvAC+n+b9yJSivwSpqKY
	S2EpGjrH6VkdJVl7GpBlCLrYAVFCRxs41fndMK6MOTznIelYrcUDz50SztR4OQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,  Santhosh Kumar K
 <s-k6@ti.com>,  broonie@kernel.org,  robh@kernel.org,  krzk+dt@kernel.org,
  conor+dt@kernel.org,  richard@nod.at,  vigneshr@ti.com,
  pratyush@kernel.org,  mwalle@kernel.org,  takahiro.kuwano@infineon.com,
  linux-spi@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org,
  praneeth@ti.com,  u-kumar1@ti.com,  a-dutta@ti.com
Subject: Re: [PATCH v3 01/13] spi: dt-bindings: allow spi-max-frequency to
 specify a frequency pair
In-Reply-To: <20260605-cane-duct-a5c740fae417@spud> (Conor Dooley's message of
	"Fri, 5 Jun 2026 16:20:59 +0100")
References: <20260602-aptly-bunkbed-1bd3a8d63d54@spud>
	<875x3zzkji.fsf@bootlin.com> <20260603-neatly-twine-e89b923f5cb6@spud>
	<87o6hry4d4.fsf@bootlin.com>
	<20260603-balance-encounter-94f69e1577f3@spud>
	<87ik7yydyv.fsf@bootlin.com>
	<20260604-shrunk-acclaim-25368d7ad63e@spud>
	<87a4t9wl7r.fsf@bootlin.com>
	<20260605-regulate-crawling-253c6d6bd971@wendy>
	<87tsrh4fe2.fsf@bootlin.com> <20260605-cane-duct-a5c740fae417@spud>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 05 Jun 2026 18:55:04 +0200
Message-ID: <87o6hp3p1z.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>> > I am/was trying to come up with a scenario that would justify the patch
>> > man, stop trying to interpret it as what I want done.
>>=20
>> Ah :-) Sorry the intention was unclear to me. So what is your preferred
>> take in the end?
>
> I think the generic dedicated property makes the most sense to me.

Ok, let's go for it then. Thanks for the feedback!

Miqu=C3=A8l
