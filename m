Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C6242D62
	for <linux-spi@vger.kernel.org>; Thu,  5 Feb 2026 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312957; cv=none; b=p/eQEYljC2ilxw+Ax5jySuESWxb2d1g6Pi29riuF8Cyt1lNIVg+a8RH+6ocNnFGYQsTwORD1cUlsaAazwMYkRSgUSfoSgVOzzflMrwC1THAlNVgFDlnbsJ5aZN68ysqSUqddof31q9KG2QevbpJnLT9qBPhD5G1DeOxFYZBwxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312957; c=relaxed/simple;
	bh=sTbcat/+A6pqTkLaPExMkSATvgcyd738Gv6Z0JtLFV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bdHZbhACIr7PXW07f+OP/MZFki4QFfcPZWB+U1AEWydTYP2bmxwuJH1Tj+p7a9fp5Cok035nRAZpTVGLeaXH9f5YMpnhSMnIybUrarRPcd+VmDfX3VkRmBXFY6FptLDUGKmQ64GE8X9Dl6GYFmnrkweFk0NtIvFJdaP2IwAz86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DsmEtDfB; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DsmEtDfB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 506634E42424;
	Thu,  5 Feb 2026 17:35:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 264766074D;
	Thu,  5 Feb 2026 17:35:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B300119D1669;
	Thu,  5 Feb 2026 18:35:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770312954; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sTbcat/+A6pqTkLaPExMkSATvgcyd738Gv6Z0JtLFV8=;
	b=DsmEtDfBzlkSTDMTDA4BperDN1egi5Qee+7H3rX5dPxeDebP7b3hZTsqiSmbvSXsmhwult
	dgz+lqxGKXFQwccpPf1apwYMBBYy0GwoUrmGP1qbHk1+xyRRK6RkmH6Hr3EH/A8ozlfzp6
	Oj9Igv8TTlMXWjllQX9c7Vuu/66YUipW201sVOOE8WE0DblM/Q8tr21ePNk0SNrS5pWnLB
	BOs8FyPJEQNVCwpin6bqKIgeHW2xHy7sVGlweXwPYax1sLXJuNny8eQQ/eTRgNAfhT7OZ6
	zZi1HIdeES6vzV4HmuEzJyIHkIauom7+DApSGVdN4YYSNpSJoW2C+okbNH5AYg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <praneeth@ti.com>,  <u-kumar1@ti.com>,  <p-mantena@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [RFC PATCH v2 08/12] spi: cadence-quadspi: read 'has-dqs' DT
 property
In-Reply-To: <20260113141617.1905039-9-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Tue, 13 Jan 2026 19:46:13 +0530")
References: <20260113141617.1905039-1-s-k6@ti.com>
	<20260113141617.1905039-9-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 05 Feb 2026 18:35:51 +0100
Message-ID: <87h5rvgkjs.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 13/01/2026 at 19:46:13 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Add a boolean field to struct cqspi_flash_pdata to store whether the
> attached flash device supports DQS (Data Strobe) mode. Read this from
> the 'spi-has-dqs' device tree property during flash node parsing.
>
> This is preparatory infrastructure for PHY tuning support. The field
> will be used by subsequent patches to configure read data capture timing
> with DQS enabled for improved margins in high-speed operations.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

As mentioned in my answer to the cover letter, I am not too much in
favour of this property because this is something that is somewhat
related to the chip ID, thus discoverable. I drafted something to get
rid of this property already, I will share it for opening the
discussion.

However, for now I am closing my eyes on the fact that the DQS pin might
not be wired to the controller. In this case we will need some kind of
"dqs-not-wired" DT property, that's true, but also easily manageable at
the core level later, when/if the need arises.

Thanks,
Miqu=C3=A8l
