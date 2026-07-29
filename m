Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF8432E65;
	Wed, 29 Jul 2026 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785310867; cv=none; b=K+BM3ZKAC0wt4zG2LkAqGPx6PDJkOnbEzKR63uLg5XhSU2E4RqnzDKOE2bhk65rYyirR2tuc+pMo3NJLCXl+CHxUunvYq/smK3duOWC2sDCOs7GI5iuciOhq+pwg1lctGcGLR4r6z65eYJI7NsJ3WnhbFw8lLjFr2Bso6JJuAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785310867; c=relaxed/simple;
	bh=hE2Ha2ZiGQjrOGDovN/QBZqFu9ljpsNoifwSJ88Vyfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iS2s6G7mFEEEjtOYQKxlJ8Muov/sHu/QPK77FFp4LceqPGNYPzrPklDlQXNrUJVpJfE3ryGMNHm/hL4/SZGp5cDkjtvw4nlH5BmzZeEbCYakt8FHtwhur5dlTZUTO8/BtKe0klpObAte7RBc0B1uxlV0Yi/rhARnXpJwbZx1xeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gj0T2Zqi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gj0T2Zqi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6E6A51A12EC;
	Wed, 29 Jul 2026 07:40:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D2426039A;
	Wed, 29 Jul 2026 07:40:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4835F11C14A49;
	Wed, 29 Jul 2026 09:40:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785310831; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hE2Ha2ZiGQjrOGDovN/QBZqFu9ljpsNoifwSJ88Vyfk=;
	b=gj0T2ZqihuRHkM04gRYJjNy1Juv7BSmKFzqgepYpYKvn/+8dT2rVpWCF8x0R13/+RjFu+X
	SKdw1C/L0O8qa6ZlWTDJuzsuFNEbihbHP0IydOzJatJiMHRSn95I6f1m5LNQjiR17n4UDL
	xIPmnTRWBRIZRkLEfOW0JZlLaVY/m7fAcFxA2XUHF5aPKTpx/WMWHEZJm1de7j0Xvkcax7
	bFcJd20pVhOLoe+LBltdHIGFLpo2eXpYUeSREn3MsX86VBNUZKHQgiimPQjBnDRvp+zPNR
	Zu0NleDpYPdXR3m3m/825zM3ykro4jX41JiVXhVNw4iN4vZ7H2G/TEw4wEP0bw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  praneeth@ti.com,  u-kumar1@ti.com,  p-mantena@ti.com,  a-dutta@ti.com,
  s-k6@ti.com,  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 1/4] spi: spi-mem: Flag DQS capability
In-Reply-To: <9aaeca54-292a-42f7-90d6-a533ff1f5022@sirena.org.uk> (Mark
	Brown's message of "Thu, 5 Feb 2026 19:11:45 +0000")
References: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
	<20260205-winbond-nand-next-phy-tuning-v1-1-5e7d3976f0f1@bootlin.com>
	<9aaeca54-292a-42f7-90d6-a533ff1f5022@sirena.org.uk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 29 Jul 2026 09:40:27 +0200
Message-ID: <87ik5yp7kk.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Mark,

On 05/02/2026 at 19:11:45 GMT, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Feb 05, 2026 at 08:06:58PM +0100, Miquel Raynal wrote:
>> DQS is a typical SPI memory signal used to help with reading the data on
>> the bus at high speeds (especially in DTR mode) by avoiding clock
>> skews. The chip generates a clock signal synchronized with its data
>> output fronts, also called data strobe.
>
> Acked-by: Mark Brown <broonie@kernel.org>
>
> This seems fine if the rest of the series is fine; if people like this
> approach then it's probably sensible to merge along with the MTD patches
> using it and then send me a tag with the SPI bit for me to apply the
> SPI driver changes.

After reviewing again the series from Santhosh, I feel like this will in
the end be needed. Since there has been no negative feedback on it,
would you mind taking just patch 1 of this series (the spi-mem patch)? I
will not apply the rest of the series for this cycle, I will wait for
the next one (and we still need to find an agreement on patch 4/4).

Thanks,
Miqu=C3=A8l
