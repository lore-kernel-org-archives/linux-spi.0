Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041354;
	b=u9+Ad3T5rg+G4/95W0mDdVMMaFDkSFHrDbMPF5nxjOWZNvhM72bGkhhm6lIowsSYJ2Bx
	 ZJ9GaOjeJEKtcG3bM5xuSZxa9RSaH6ee+BYJpr15wrJF0+Dirq4WTJb79mqv010bYSrWM
	 hjYQdFDBXWS8aoQGU2Oim1a8L3I5cZFp5nE1dqdxTXpjubp2W2O8rJvdSyQcfTG8d17C7
	 X5h5qgmL3jzMkDpjijQgHTObnWaM9H+6Mykbi/cFcEHvDG4EP1e3XJjzpJq6UxL+5n5jg
	 Dhwce4ntznRgkpLDfJ8O2+UFmMSrCjIfP3JwPLzA61WlNv0DYIYom4Z0kBsunKDf0fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041354;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zO9ioRV2psE7UjD3iRTYFl7JKcUPyJGplwhO8UwgMRI=;
	b=bi2WSFH+CxtwLdI9OH1lOZDNDFfihcJnjobdT3Oo6xqurx0OOsN/cDwARUmL6C7IKhhI
	 8iRdAcMaEesMxZStVSbhvLY63zLv8v/AvPigePgynTtcre+nz6BmlCU+KPZoiJj2IefMJ
	 eqKC72Ue+XctJRrxHMOAYDCjImSiVEWsB1Z+ONn2ZBSOFy8yOapDn5j9qA4ZrzIBnyebP
	 O07x9UOlTj3cicFaV6AYX/LDr3m5xwpq4qviUYF9wsNQlyFhQVThnkbxsQ8Y6pquYI6n/
	 IYxeQjaokQzi5oz/zniQA1HsFftVuQUDMP6pCY0UMIaJcObfOAyOM8kf3hbdAG+vh/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfA+8Srv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6A606A31E;
	Mon, 26 Oct 2026 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfA+8Srv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985261F01825;
	Mon, 26 Oct 2026 19:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793041353;
	bh=zO9ioRV2psE7UjD3iRTYFl7JKcUPyJGplwhO8UwgMRI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=HfA+8Srvcoes3Gzvwy5MVlEdZH2sukOdvlFe9VXruVWrVww/s5wBidNYCQooAQ0+J
	 luFCCwfdxJB6L6NRnRcTyzFSrOaxsoxbjDgrXzmka6PdJ7OOsyxDvqSSdIZRFN3lxr
	 hhMMp0leeuygOsDc6yb1yITqHhHJ5LX0sqFKxQCs1epW2+/wo4gwRxUjWkL/cghgfY
	 yN2zmTpuZxNGB+RE+X+xGyzniaJRqhnstiCs7jgayW4uBGzwHighYyH/WziGBw8t64
	 wyouX9BP3nY5jVEo+YtQWjn4zLL/JmFApKr5/DSJgmqSSQDk4f/mVfqKxprIOWHjZT
	 228l3YbSfhGyg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 54D2B1E90DB3;
	Mon, 26 Oct 2026 19:02:19 +0000 (GMT)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] spi: fix zero-length scatterlist entries for vmalloc
 buffers
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?=E5=BC=A0=E6=98=A5=E5=8F=91?= <zcf1810@163.com>
Cc: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <6AD8D2DE.056C35.00008@m16.mail.163.com>
References: <6AD8D2DE.056C35.00008@m16.mail.163.com>
Date: Mon, 26 Oct 2026 19:02:18 +0000
Message-Id: <179304133837.199157.6730550891265304113.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=678; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cRb1aZ5X7nS89RbN/y8pmJP4VILSms3MYrRdF+6rvAI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLuL96ttVV48qoZV6+4Rav/ar23duVu3106+fdlLXtnH
 u7wdtll3FHKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICb3MvwP01kg+/3eQFM803f
 Xbt2wPzl/R0XIm5cCXEVfHZFyvOmlRsjw4QtH6z2KbVf33XnxQk9iTcpNY7/dh0/FazNcPn+e69
 9C5gB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Fix the entry count to match the way the loop consumes the buffer, and skip
> zero length transfers entirely.

> +	if (!len) {
> +		/*
> +		 * Zero-length transfers need no DMA mapping.  Leave an empty
> +		 * table behind so spi_unmap_buf_attrs() sees orig_nents == 0.
> +		 */
> +		memset(sgt, 0, sizeof(*sgt));
> +		return 0;
> +	}

This isn't needed - the rest of the patch changes the call to
sg_alloc_table() so it will fail, and returning success will confuse
things downstream.  The KUnit tests should also be failing with this,
they rely on a zero length transfer to force -EINVAL and get into error
handling.

-- 
Mark Brown <broonie@kernel.org>
