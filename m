Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FFE369203
	for <linux-spi@vger.kernel.org>; Sat, 15 Aug 2026 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786785846; cv=none; b=tv2Ag3tLaaAD0jggrth3+mkejkDU4zbbPQ97/RyXizAgG6sVWkSFzusrEkUTQsdRHhLkXQGwIJql3Mr7981Tj6wW/l9OyfRqvxOB5NQ5JJMc/6wVBu7+Ymy5tIRxs+PW8l9sOJwxinYvR6G0Kl10MY2VTCcPrUZBmnPo6FPPjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786785846; c=relaxed/simple;
	bh=Q69I5kR0I1QwXgOBFOzjho6suHR3Ek6iV/goTrGeyN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bvMLTW0ugRXmeGFSvQTHosJ+Nz18vP/YDOY35gJpYShwIrsk5pHygLk30/imPBivUYQddJvK/WNysEJp3ukvoGTscRAIVL6rLuBr4MhPcON0UAQLsI9uZhlQTNCzwGb03uExUyODv1ToOLvo8arjOmbwIciwot74IcKyOXrc4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2ZhRWxqQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2ZhRWxqQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D43B71A14F6;
	Sat, 15 Aug 2026 09:23:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9323C604AA;
	Sat, 15 Aug 2026 09:23:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCB0411C4F477;
	Sat, 15 Aug 2026 11:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786785830; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Q69I5kR0I1QwXgOBFOzjho6suHR3Ek6iV/goTrGeyN4=;
	b=2ZhRWxqQpKrj1UYWokB3VMcuXHLckjJOdgERbJeii/4ZPLfGYBZOe34qGK/Lxzci9Lt5Nj
	DyAngLI3bJi0WVVRy0q4i3Tbl+WfE5xaMJ+Cmuw5hNzHP23p5Md5vFfmOQ/yhi0lwRFafU
	nszhIxFy/n6ViyKg3z++Uy+qG6jpiDkbLLO1LYzRDGY9ili/RYFU4/behaq+6nddEVpkri
	tiG9SKAhfb4CwcyQbepUc41oyF2yumHbao2WHhMtnpQwxVbBkyeB3CVhHA+0gEfRczdkm0
	OtDs3oBzRiTJpuuylwKGhWPePAWzteYH3r4Zv3kirR/7oL7gWHQwhjYJOHhwXQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,  Shan-Chun Hung
 <schung@nuvoton.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Steam Lin <STLin2@winbond.com>,  linux-arm-kernel@lists.infradead.org,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: ma35d1-qspi: Add DTR support
In-Reply-To: <34412d10-cea1-42ef-a53c-ef515b452793@sirena.org.uk> (Mark
	Brown's message of "Fri, 14 Aug 2026 13:56:10 +0100")
References: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
	<20260813-perso-ma35d1-upstream-qspi-v1-4-b217b9870eb1@bootlin.com>
	<09c3928f-4b58-4ac6-8e1a-84dfe3ff6b92@sirena.org.uk>
	<87ik5ckh2j.fsf@bootlin.com>
	<34412d10-cea1-42ef-a53c-ef515b452793@sirena.org.uk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 15 Aug 2026 11:23:46 +0200
Message-ID: <877blrka8t.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 14/08/2026 at 13:56:10 +01, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Aug 14, 2026 at 02:44:04PM +0200, Miquel Raynal wrote:
>
>> > This needs ctlr->dtr_caps configuring, otherwise the validation will
>> > block it - only the _mem_caps were updated.
>
>> Ok, thanks!
>
> I've queued the existing stuff for CI since it all looks good and we're
> almost at the merge window - please send an incremental change for this.

Ok perfect, I'll send a follow-up patch at -rc1.

Thanks,
Miqu=C3=A8l
