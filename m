Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE41436379
	for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380244; cv=none; b=mWqJKtDntqRvZiodR65L9thW2ghdcv1vgeviwAKsu8AXluynq2jvR3wflxJrF1aVEDMn7vo4hMNJSqz6KtoZmOxkLrXJ9ZuWPcwtsw/1Zdwdk9rHxAP2Y2SUFIKP/qZqVQSMVttLfBb9t9W+FhZ2UqPJ50VxoREY9EI5JPrq0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380244; c=relaxed/simple;
	bh=yIR/5wMNb5m9ObXQ8WEcXxxZo2e8BCiuRwzacZ2x92c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bLFDubsoXrRkSWSMsnvErTK1VIXYGpaK6s69V0wpzhrU4TQm1lQIAbNB1xI6gm206i1tRy39P/LEu8HB1SNmQ0Pntj5MSQVNIezjSSvufkmzrpZmCcUDEmx+gd9jtlYRVjFx62yWlJzA7QDKSBt+N+6wOGO7RkMKH6SfXDi/a2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=exG6GYdk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="exG6GYdk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 526631A346F
	for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 12:43:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 19D0D601D0;
	Tue, 28 Apr 2026 12:43:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A698910728B18;
	Tue, 28 Apr 2026 14:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777380231; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TdR1HYk3d/Fr+1mCeaDpInPFnpJNLODZo+R0m3widHg=;
	b=exG6GYdk3/cy3kCb6B3lmo4CF3dXcrWlCMw8gHZHazw1ytHpRBa5r4Z0690iVPlge42aMQ
	OW1IHRsEzTpFQXjdsjswhxr2hR8S3nLuMDUp4riTrvHeye2b9OXps+X6QhSstKQptWe0fm
	52kHJjj/Tb9wkcE0M1oW2xbHZltoKKUrAHaQkG2SvOeUj7x9P9jLYK89YWtB2qUSEs4DLa
	4idVExCaMLeDekf3T+X5uA1RZVr4FRcgeJsVLl8++eRG8o/P4AC4Sot9Hk8N2W+SdX0GSE
	Lbieqk2rY+0sGPwyK5+I3pE6wkyKd4SJfpgle7XwYb7Xr7++fQ8+f+Elc7/RcQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Michael Walle <mwalle@kernel.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Steam Lin <STLin2@winbond.com>,  Santhosh Kumar K <s-k6@ti.com>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 00/11] mtd: spinand: Winbond continuous read support
In-Reply-To: <20260326-winbond-v6-18-rc1-cont-read-v2-0-643de97a68a3@bootlin.com>
	(Miquel Raynal's message of "Thu, 26 Mar 2026 17:25:47 +0100")
References: <20260326-winbond-v6-18-rc1-cont-read-v2-0-643de97a68a3@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 28 Apr 2026 14:43:48 +0200
Message-ID: <87ecjzdzln.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 26/03/2026 at 17:25:47 +01, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hello,
>
> SPI NAND continuous read support has already been added a few releases
> ago, but only Macronix chips were benefiting from this support. Winbond
> chips also have a continuous read feature, which is slightly more
> complex to use in the scope of the Linux kernel, because they these
> chips expect a different read from cache operation once in continuous
> mode.
>
> In order to be more flexible, this series changes the logic behind
> dirmaps. Direct mappings used to be very static, not flexible. I am
> proposing to change this and turn them in to slightly more dynamic
> interfaces, where for instance we can:
> - Enable/disable the correction (was previously handled by creating yet
>   another pair of direct mappings per target).
> - Select one or another variant for the cache operations.
>
> I propose to name the variants available in a direct mapping "primary"
> and "secondary", and let the upper layer (SPI NOR or SPI NAND) point to
> the one that needs to be used for the operation. Controller drivers
> should not really care about this change, expect the fact that they
> should not keep a static representation of the template on their
> side. Because of that, I am creating a capability boolean to flag
> drivers that support this capability (the flag is ignored in the
> nodirmap case).
>

Applied to nand/next.
