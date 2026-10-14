Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8339D3D0
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953750; cv=none; b=UO0wPomCLQSFHuwpUrWOLqtcHA52xW48mjcCHutAxcW7NoyvkE/t3OB4NOgf31kEBemuMkoLWBORcTO0aIBhDuRn82IakFYw15csujQ8+bfG1ZNyNgkiNqI5IbukGZ0WX+r1mHWg4EvTqegcHll3Eivn6BEkE1wPNwp74Rym8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953750; c=relaxed/simple;
	bh=5Qw4a16lsBulx8wAb5cxpyc0vMifzgzNt21wJOz0sOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oifle5/ZW6NL33hQ33wxCCwsGNZV9Eo19qlmmYyS7jcQBTcej5xkRmMljc/QNKaExIlO783Hu6fShjcRB5OY/wLOdw0MSbLzL+x3YQOaRhAaC5r7LxcVO6tetevCQ9j6w1hQ65Rz686J9hi8Z956IzLUzCQI/ub0Y72KvBQVAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=povT1IDk; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="povT1IDk"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15168a20b47so2399200c88.1
        for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 21:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791953749; x=1792558549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Qw4a16lsBulx8wAb5cxpyc0vMifzgzNt21wJOz0sOk=;
        b=povT1IDk9UlvzUkblm/oSCIVOQ9+5M4QTjJ7/e3xscpl0BYf04br6waKr69tmNxQnF
         wrq3rxN6epwXDwogmW89x5EXAATHg3Wa8jw9QEESxAufaWgU174vkiEJWsasXZxHwCCh
         0+RI6eReszUhsAi16sGdXt1CSA4zvg0yXgyPOhDvGNu8xHOVKwF7z80/tzY/T2qsScIv
         /XYbrGe1aChduYMT+bfsdiPRrcNJOEq2InRxrJMVJRPCHDDMgW2r2jX7mE7QSzk8w+h3
         PkOCULIEuZpmTS4JefA6RiDjlbizfVYXl+k1qtzrYRXIImxhTRX5RAe/mHPb8lXrnw6e
         OhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791953749; x=1792558549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Qw4a16lsBulx8wAb5cxpyc0vMifzgzNt21wJOz0sOk=;
        b=kB+4yOSiLdux/rBV9vewyzLrCsy399D8vCl1QKbCx5e0sRbOS7L8jc2xDNWk67CAna
         SMjcmv+8c+jmCtxrXEuEeBZr96UO+kQNhR8CAhztbgZYGPxrxHPdEXfdf2Phd7BXkyEh
         jtb6GWORrzu8UUV9H5/bKC5l+xXbttBuet8A96sciOdMp02c6Pm8gqCcOeULGbnC+oVI
         pEHS70YI/cFsmrxqrJobcsr+Yx6AK0EXIc9m4PhOsLMRRfunELe+1cH8rdkjNXw7LTFB
         FwPxhZjQWX6VcWe+mmeUpitKRSWzMQaZQIk+g5Ejf37gXuskblHHgCxfP04myMPpMKti
         Ee3A==
X-Gm-Message-State: AFq9FYL5MCUmS1Jfdl/m26tGomzcTHy40xbm2oUPf8HEwHlrg+eTXmeL
	36H4Z1XDhvfpXc0USNCiC1MRQm4cJGy4F4ZgJ7y1p5z6VLzuvQQ7Ciffn0in7D6k
X-Gm-Gg: AYBFou0bPjILII1e2tvuHJjm6Y/jf/bF9d3oqIIvRZM2dSnyZTFZg5IX7bsKfFQPJ3J
	gKnwSsqQPsbmM+cWBV5Xk9L8ljIG55IBymNCQdscSiqBQH2Cal/8kvrmmJ0ki9e1mz8osUa1ChG
	z06sojqMmDP1A5GAfFLJICb34X1SGWeuspozKewU0SrSSjZY/LzVK7tsJ1F8qACMJz7BH0Yk14C
	mZcefHgdAMKFxnsTXrSn/f1jYGSQYKYbh6/Vmb1NQVHnRTZwVP8lvrNPAbY61PtQNnaGyCUWXr4
	wnFIXoCIQH259w41u9gStJRMFpBIGv7Np/ba6jaUicRJVrolIFMGGU3Zc3mp/lNuGVJlqPdEdw5
	5UMOU8lP7G/HYg//zF0csdrjlCvWNT/3/SXurmouXcGsTM3tLpFnrszMEIedPhCNHIbuCvQ8U9b
	vZTbb5luFds8kkGJzmvFjrrkkfhaY4Uz2qN4o8gbPR1h7f2gOavvGWQiltIlcKgmBl0Gj4nZEPD
	OBhOwTwa+WoMUC/LUGIIxUNb0+0k0IqWN7SiA==
X-Received: by 2002:a05:701b:21c5:b0:158:7ea9:4a92 with SMTP id a92af1059eb24-16a5e968c3emr18577460c88.17.1791953748768;
        Tue, 13 Oct 2026 21:55:48 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([167.103.3.1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a2f17feasm55285032c88.9.2026.10.13.21.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 21:55:48 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sahaj Chaudhari <sahaj123.sc@gmail.com>
Subject: Re: [PATCH] spi: omap2-mcspi: handle DMA setup failures
Date: Wed, 14 Oct 2026 10:26:27 +0530
Message-ID: <20261014045627.2895305-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4a20222b-7d60-4763-9833-bc453d26ade8@sirena.org.uk>
References: <20261013142004.1729849-1-sahaj123.sc@gmail.com> <4a20222b-7d60-4763-9833-bc453d26ade8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 04:40:00PM +0100, Mark Brown wrote:
> Do we need to turn off the FIFO here before doing PIO?

Yes, good catch. omap2_mcspi_set_fifo(spi, t, 1) runs before the DMA
attempt, and omap2_mcspi_txrx_pio() polls per-word TXS/RXS without
expecting FIFO mode. v2 disables the FIFO, with the channel off while
its bits change, before falling back.

I injected DMA setup failures on an AM642 with and without this change,
and the PIO fallback completed with no errors or timeouts in both cases.
The bus had no device attached, so that test does not show the FIFO
problem. The change is based on reading the code and not on a
reproduced failure. I have said so in the v2 commit message.

v2: https://lore.kernel.org/r/20261014045617.2894886-1-sahaj123.sc@gmail.com
