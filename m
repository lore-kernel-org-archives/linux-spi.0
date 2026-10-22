Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792665970;
	b=fyY4y71MLcpRcFqusiUT1NItMdaqm5jGVKET1qF8AkIg/DGTHDcG/TVyKU/TJXEMQGAB
	 fzC3+N7Y/Z7sTWqK67xCFDgiizDxbW3lt3nrTBOjbYqPUzbmnek6Bz30QeBz3ByChn5/7
	 lvP178Y9DjP3UpEQm2Yl9AZkqrinClT0oW4fL6yYMBBIQpDtj94J46hBLsN/cbx6C1Qzx
	 Sckx50gUB5amk5842VkgQx4CiVIhR/88rQkwOqjxZ3l/jEk2U4HHze67mDVFtWpUV27Z5
	 vhpak6xYx2a7QIHsboMIEenHr5mEVEITN0NjBMJ3w3IuPiGIrA5fo+QxslWmb+D3TLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665970;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=uytOd5S7nxvQrfDc9PxXqBZPkguyREFdfHpWXeT+neo=;
	b=n4PnhmFaPnV87iLwSYlHFN/i73T+33NGH+DA2Y8anTDS0IDSPZ4AFf/XPqsuIEagnNaK
	 FhlpXDO3xwr0KJk3u+fpBhFbNU1VuVjSpSF8jxqvvwixDF9J7ZiUekK8H9YruKf73xKRt
	 5z9bImR+QzgqapBHp2waOKigxgAuHdB/+fS+rdlG2wo6UNauO2iJmu+41ZXGA/A5UuDWh
	 xK0pjzfGPeSqXD5O7DfFmEo3SyTWDCTonzH9biKoLgeZseBSRolDn5J6bOcy7+a+Z+lS8
	 VkF4BDhG21x0+beyegVcD8neHgpcQ9m3B3EqmAl/5QxyyxjbcscXQjgZFwrWiXV2TJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=znPTKa0j;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0A606A31F;
	Thu, 22 Oct 2026 10:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAD0A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=znPTKa0j
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 573854E4125B;
	Thu, 22 Oct 2026 10:46:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 284A760360;
	Thu, 22 Oct 2026 10:46:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0417C10328E3D;
	Thu, 22 Oct 2026 12:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792665967; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uytOd5S7nxvQrfDc9PxXqBZPkguyREFdfHpWXeT+neo=;
	b=znPTKa0ji9r2gpzA1zBt4X1noMCjJRu2rGiZZEfrJnY+MhfXEfRNJWuM6iZDg4Aol2mJG5
	5QenYglDrfA88d47VcyVjX7bXG5tjomZvhtJLk7OAoCgJ+UMbmFxiCWYehDlXopYX+pV5p
	twlz4wmmHQ2hSCa/C0hHcndpuJxtKU3rZculMgWu99JJvmdPJCJm+4/G5Ksc/alM9Ce1HH
	UA0kNvNs3u+pqoi0Lz3AnRM7DX5V2MK7yGLj/2mIwrFABvNQc1EwYfzck0fbfn4jRfGPAJ
	iB+A00oLsB59U4o+VzPJSXeQWtkE938SmMwXfquuQNtXeNAktofetqLVVg9bFw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Takahiro Kuwano <takahiro.kuwano@infineon.com>,
  Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1 3/4] mtd: spi-nor: debugfs: Correct DTR protocol
 names for 1S-xD-xD modes
In-Reply-To: <20261022102614.75696-4-changhuang.liang@starfivetech.com>
	(Changhuang Liang's message of "Thu, 22 Oct 2026 03:26:13 -0700")
References: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
	<20261022102614.75696-4-changhuang.liang@starfivetech.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 22 Oct 2026 12:46:05 +0200
Message-ID: <87zew6ovwy.fsf@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 22/10/2026 at 03:26:13 -07, Changhuang Liang <changhuang.liang@starfivetech.com> wrote:

> The debugfs protocol names for the mixed DTR modes (1-1-1, 1-2-2,
> 1-4-4, 1-8-8) currently print the command phase as "1D", i.e. dual
> transfer on a single line.  That does not match the protocol
> definition: these modes issue the opcode on a single line in single
> data rate (S), and only the address, dummy and data phases use DTR
> (D).  The "1D" prefix is therefore wrong.
>
> Rename them to "1S-xD-xD" so the names reflect that the first phase
> is single-data-rate on one line, consistent with the "8D-8D-8D"
> naming for SNOR_PROTO_8_8_8_DTR.
>
> This only changes the strings printed by debugfs; no functional
> behavior is affected.
>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---

That's likely correct.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
