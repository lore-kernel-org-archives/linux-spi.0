Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBB3DF001;
	Thu,  3 Sep 2026 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423399; cv=none; b=kDpBOsamRDzaUYANpMMK8lHTMDvtODXagsnolhswqpifh+M0DsrQVc3aFjltL7t3d7Uz/AjOqk3+FVRQebJb9vBvY7pPgn2aLPMeCVW44z9QQ5qh5FHJgq6IhpvvzBsdPeNe+Vx7VkHeZB+BqcEM4s7qfy0C5tTcRmrLpj8Rz5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423399; c=relaxed/simple;
	bh=YLfdgrdlzJj/pA2hZxsG9Y8cox2mPc65rtCPL4VHF9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fl1Frmsw5upd6PlXeFRSl8SW/eJL9QQEW8dYMXJ+u0o1AxFSPaTLpPHHxAVIwXkKkE8YUu8GooUffuixq+mXkD+hGnpY5d94IZya7erGlbVOPSzVndpbCNknLjrgN+8kRKLRRUR8Hwk+os61LuIdiJS+WTWG9Osx4luQAM/byAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QaeMTs0Y; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QaeMTs0Y"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C728D4E414EA;
	Thu,  3 Sep 2026 08:16:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8C227602B8;
	Thu,  3 Sep 2026 08:16:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4259511C79B6F;
	Thu,  3 Sep 2026 10:16:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788423391; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YLfdgrdlzJj/pA2hZxsG9Y8cox2mPc65rtCPL4VHF9o=;
	b=QaeMTs0YKnXkCj5NgrK/CQd21t8R3DVdCU9qx6WjgKS1bKEHNSM++I2MzZI4MJKbrTaxP+
	16ZmiVnbkjmkEPiOWLs5bwMoOxAMF1bwkIwtqyKIbXGuQpk37Ru7JfsJZuv554AhEn1XZ2
	EUfoKHh+cAh9PgfqWHbkJ9im/nNtw3fawjw4jwCYpt+rMPICSqwFdTvzelW+jwtMgJWMTz
	K7JhWC16MA2GhcGwtwBQHF2HlExG0HGlgj03PGIqAGReKEW2yZzk7hkLBO/ErRQHio5Vdu
	Tyi9aybLxs5VMNO+ppG94q3zUXl3xb+C7SHCpt+m3YGJpkWE6dWrIsQMDNrToA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: Mark Brown <broonie@kernel.org>,  <robh@kernel.org>,
  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,  <richard@nod.at>,
  <vigneshr@ti.com>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,
  <sebin.francis@ti.com>,  <u-kumar1@ti.com>,  <a-dutta@ti.com>
Subject: Re: [PATCH v9 08/18] spi: cadence-quadspi: add PHY tuning support
In-Reply-To: <ebf61988-9fe6-495b-b1e2-eaeba9f6b98f@ti.com> (Santhosh Kumar
	K.'s message of "Wed, 2 Sep 2026 15:15:24 +0530")
References: <20260825171737.776052-1-s-k6@ti.com>
	<20260825171737.776052-9-s-k6@ti.com>
	<8aac0c42-fad5-4146-a2a3-b60bdab71a20@sirena.org.uk>
	<ebf61988-9fe6-495b-b1e2-eaeba9f6b98f@ti.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 03 Sep 2026 10:16:28 +0200
Message-ID: <875x0m7ns3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Santhosh,

> The DQS bit in CQSPI_REG_READCAPTURE is used for read data capture and
> it's not consulted during writes.

In the end, how do you know you can expect a DQS signal during reads?
Will that work if the chip does not enable it? I still do not understand
how this can work.

Thanks,
Miqu=C3=A8l
