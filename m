Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3BC40DFC5
	for <linux-spi@vger.kernel.org>; Wed, 22 Apr 2026 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846430; cv=none; b=TPDMWKRKtf5UUtc7x7gQb2UFTqTfTM5nNLk4POnb72Rwbg2XbM65S5GW3iYSqb0IYcqNUG114oH15XRjuE7dlG6tlXZpYLASH10xy53v1xh6+FvBdcNugnPOgZmdVxTVny+jktgMJ3fQ8sZl4yUIbrtRyBgAeKtD7vNtzMvaiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846430; c=relaxed/simple;
	bh=8a1uwxbP+LJMfY9lNLmas8PKtcFqF6itOJmh8LA40qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=quJbKYr9CxKdahpZYU5+dA4rGjbVLVO1epwoB3Gj7+pxquYTvbpYagBcLk3l6qccltLerla+/2czgMIBVZmzWiRHQM/UJtlYEyMHlaRiSIeon3l5Z5G4YA7ulSWOjeeErCLuumMVtXgIhg7h7u/CzbmYzKhf3fppex8w9JfN0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VKFKUix/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VKFKUix/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 86525C5C9BA;
	Wed, 22 Apr 2026 08:27:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C33D3600DD;
	Wed, 22 Apr 2026 08:27:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7436D10460B55;
	Wed, 22 Apr 2026 10:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776846426; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d6DEoIeAIIFpKrk0/9dUHqk04CZJNIFHlbHvTeJ1r2Y=;
	b=VKFKUix/MyVqXEPXHEqLF5GDl20pqZGof11WsF1CtQ2ZMox5iXMONaf9Z4EVCX5oKB1VAk
	G6Ju8lT8eLzGhjtdg6irVAKw+R9Y/lynwfLaDLQLd2Vm1/0TwGnumj/lIWxRLu38AScN3j
	0RVb5P+zVArB9XeE6027R786caDRD+ruuXDp1awOXL4YjpnsfsYHmcFZaabmVVyJ0kSt2c
	aD5iE5NePX3rvmYgRjK4aaqy9Dh64H9rVjANAnnKCHjIwRa/WcG6RIyouLwBsYl1/rsgX/
	blkvoxN2sbRK/ZtD9yXosaZZtuWzOKuMMGr49BGQZMzpcgOVlV45+nIWAsEU0A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,  Anurag Dutta <a-dutta@ti.com>,  Apurva
 Nandan <a-nandan@ti.com>,  Dhruva Gole <d-gole@ti.com>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH 1/6] spi: cadence-quadspi: fix runtime pm disable
 imbalance on probe failure
In-Reply-To: <20260421125354.1534871-2-johan@kernel.org> (Johan Hovold's
	message of "Tue, 21 Apr 2026 14:53:49 +0200")
References: <20260421125354.1534871-1-johan@kernel.org>
	<20260421125354.1534871-2-johan@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 22 Apr 2026 10:27:03 +0200
Message-ID: <874il35rjc.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 21/04/2026 at 14:53:49 +02, Johan Hovold <johan@kernel.org> wrote:

> A recent attempt to fix the probe error handling introduced a runtime PM
> disable depth imbalance by incorrectly disabling runtime PM on early
> failures (e.g. probe deferral).
>
> Fixes: f18c8cfa4f1a ("spi: cadence-qspi: Fix probe error path and remove")
> Cc: stable@vger.kernel.org	# 7.0
> Cc: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reading it again, I probably got confused by the impact of
pm_runtime_set_active(), what you propose looks correct.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
