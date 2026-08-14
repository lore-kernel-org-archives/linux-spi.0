Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47AB46D550
	for <linux-spi@vger.kernel.org>; Fri, 14 Aug 2026 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711460; cv=none; b=YaGi5svL2zzK9lOs8Iog9nY6lZ65op6rQKepALp1O+WDmhr02E/FJxAE+TkSiKMN0vZBqGgDBPIMiksc0TXVBT+5G50VDnetQkG3n8LQhWMAvzkBi74gUECIQBhieyvdcK5qV4R4m4c/FPfhAz2mGJku5PLx+aKReIWFn31MTDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711460; c=relaxed/simple;
	bh=qoffge+/MYJ0utgU/+Z1rOQLx+fAbgBbBKeGEHPiuJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bXq10H0yfOArV1MKlCxcaLCt5Cl4NQtQEd/yK6bqmYzb76UjLWnQA2JT0A1Uxs/pep+6vQuBwNo7LD6KoYGVjVA8y++qx16x1/gxIpKEwitmVvvGzMKGudobkl223uFX9nJ2oS8cx91GAC3ctxZL8NylYFEzjZh7aF52GmBt7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CvpC1xbS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CvpC1xbS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DA7471A1621;
	Fri, 14 Aug 2026 12:44:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE77D6046D;
	Fri, 14 Aug 2026 12:44:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8329511C4EC8E;
	Fri, 14 Aug 2026 14:44:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786711448; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mODKqQA1sxM7LYMpe2HFGMEJ30+oklZq/tpn4mz1xKk=;
	b=CvpC1xbSgxA3DjiB8rnsoKdyYMvzFFJG56HzS4Z2AqJIiWJXKSiUlQdgXpyr6SZLR5Duq1
	Lgjge1zYALo7BdDIie8Q/fyL2ykeRaZJhicYinF7y9aJ3+VoJonIntjt/tnFAiyH1Qz+6n
	Lw0EF8gCag9XnPD3aJCyK1j6PqthqhpddcMau9SAWFxb7K0VaP3TMPCO35RdoS2hw5GS8r
	sIzYf35HAkTP6gwMKeTCQ5k9RObDdHTtzcPaWN3wLlJSLmUxAWeIYnzwu+Nlh6ou/0POv4
	aJDkipXXAom5E8TuiumE4qIiyynheaudgaZLJwyf6234rYgXVgFRd0TZfiUrCw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,  Shan-Chun Hung
 <schung@nuvoton.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Steam Lin <STLin2@winbond.com>,  linux-arm-kernel@lists.infradead.org,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: ma35d1-qspi: Add DTR support
In-Reply-To: <09c3928f-4b58-4ac6-8e1a-84dfe3ff6b92@sirena.org.uk> (Mark
	Brown's message of "Thu, 13 Aug 2026 22:33:55 +0100")
References: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
	<20260813-perso-ma35d1-upstream-qspi-v1-4-b217b9870eb1@bootlin.com>
	<09c3928f-4b58-4ac6-8e1a-84dfe3ff6b92@sirena.org.uk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 14 Aug 2026 14:44:04 +0200
Message-ID: <87ik5ckh2j.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3


>> -	ret = nuvoton_qspi_configure_bus(spi, buswidth, dir, xfer->speed_hz);
>> +	ret = nuvoton_qspi_configure_bus(spi, buswidth, dir, xfer->speed_hz,
>> +					 xfer->dtr_mode);
>>  	if (ret)
>>  		return ret;
>
> This needs ctlr->dtr_caps configuring, otherwise the validation will
> block it - only the _mem_caps were updated.

Ok, thanks!
