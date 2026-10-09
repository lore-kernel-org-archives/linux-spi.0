Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96A36B92F
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539266; cv=none; b=F3Stl5mjRinn+CWyiZO6b2x7JyQKlCv9UXYg+57uLgzuhiYPn3PbLeK8e5NP8C4qSUr4oEsEz6ZapwEVNl7zRZwK/+RUNQfqbE6L9CfplYL/pA//H2D+UjQ0ZW8RP63esSUP1HlTEpVSy158Q+Y16GzOJrExR9VJj5LntKBa+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539266; c=relaxed/simple;
	bh=B4rpVl4mptJjkcyRtvFrb+ksh0rsTg1kk1VMkeNJfyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W67lW5/fpEo7mifPp1aho1sXPzU8bC5XwP2hg/96qsZGmqyNKLv5Bp6i4BwL7bVFJVSrbXTRKNdf6uhEmYpYtiQK9fBFynOYy+ssn3xl5AvW/XjQhwSJPchLDVUApfh4rdeuEy1+iBx7ixqCz0/jRpOTgy2oxtAl9Uf36x2HHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6+nEOuq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6+nEOuq"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e82462a3f1so8006095ad.3
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 02:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791539265; x=1792144065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TrPTdcZ/njH2i3/j2LZUGAT14iJIsacuNVj54+laGas=;
        b=k6+nEOuqK4IAjrktw65AHdhSink7++M5Nr8mckpwX6roTe1dztn07+ax0krKldOFL0
         mCRaCZmMPqBms3gApgkoP1VORum0AVBhyZp1k8yxcxhn/un8X//bB7CnxcCgTV3wc2Go
         rZnx2EHEAf3KjY/tqlmDa0k4xFPI91A/xdB5JIcMgMcmDVZCGoWk1ZmuOvAgHxvyAnOk
         tpTKbUXMzLfOcVNGP9utuwbY7JeuE1/U2T4hvWVZnFh+OuanX0u7CHKSIwL0duGvgPN5
         BiGLfOMOFvI6se2lERN9/9KiUuT5EgjLYfXFlp3HFgvCK8fvS2zNq7U9cGAwWUr/g326
         T8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791539265; x=1792144065;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TrPTdcZ/njH2i3/j2LZUGAT14iJIsacuNVj54+laGas=;
        b=n/7u0evwp1UXvEAYvvH8dA+tpwdnJH8SLOZ8zPqinNDqH7xvwKYNUDmnTYoeDV0+5M
         +EylyJZ0K+j0IAznGs+4faHWMoyqD/4fb9ETOfpGcDeITwWSILSQrqUXH3EZRKQq6LoT
         GUXoM97rVLa6ovU7anfixdjCvexShGjsSJ2Jr8HKH8NmKkxun77pCq3HmOASX0LEkb+a
         naiL/hBjbJbEaweEQAQB/LfvNsscFzRHSvRftPYv3Dm0BDLCZ860xFGxo5kxV9yDhQAx
         ySiaWJf+ropNW1KBFKHl3flbvj1V1durde30AA+zI0atsQefxbY2JUyK4wuQuSQC6wGn
         u3jQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTlYrcHXqj2oufgZCRK9/nYqUXYMtXjirvGee+Rb1k2w2javxEdrCl5T8v3TwfqFm4jBN0umq59G8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQt6IDJwlbkhnA7AuyL9KrcF7v3bhTgg0PWKXxyPj7iddjLWa8
	XIMaHGmU3zpNRQQ5Jt8aXJO59SXp3rkr+/Dkyot5BGDZTcqUmUky1YVR
X-Gm-Gg: AYBFou19sWxo+3liTBjra6bK9IXRCntOpI82GyBon1GLE43CiUXoWfjHKNQ1iDhVYzw
	K6k7LSx1/wedapEd0f8rW0Gy36Lp9pUiDQ88TdwF6xWc9lGkLVAYkE5hM3EqTQ05NRWWUO4jQ+b
	sngk/jTUezPSJI0hVTTKHtaw+QwakyDttiR+uUE3iBIz683OJfxpXe5vNtgdo1Tuv0fAmZVabih
	1F3cGZyiurjl9wrgIHq+piqGveXsYoleJpfY/5YHo539R/KsIWrBZv7Bd5IJW+YEsljYybyiYja
	qB68b8V5ItIvLjBY8YQFTctYQfF15jCgmeMY5993XIewYsfs7vmm3RHocw/9vWdEre/YdOSgRmD
	IAQTSMy87uPTIWBKUYajWd03kZRYE6esZct+PsT2nOHTi0oyAP5yt6LL43OLotptlrPrTO7UgAs
	YBiEqFO2R4Q3aCIJWANwurAjfnCJGlDyTkSE5QE0R6RYDGgyCGzuDf1RP2/CQCXowt3/oK
X-Received: by 2002:a17:90b:224c:b0:3aa:faf6:a951 with SMTP id 98e67ed59e1d1-3ab3a9a93b8mr1318325a91.37.1791539265069;
        Fri, 09 Oct 2026 02:47:45 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38b981b9sm2638018a91.5.2026.10.09.02.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 02:47:44 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Longbin Li <looong.bin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <chen.wang@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Han Gao <gaohan@iscas.ac.cn>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Hangfan Li <lihangfan@iscas.ac.cn>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/4] spi: sophgo: Fix SPI NOR errors and clock limits
Date: Fri,  9 Oct 2026 17:47:08 +0800
Message-ID: <179153921379.259252.17749060045138037060.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261001-fix-sg204xspi-v2-0-014dbaf22b5e@iscas.ac.cn>
References: <20261001-fix-sg204xspi-v2-0-014dbaf22b5e@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 01 Oct 2026 02:22:49 +0800, Han Gao wrote:
> The SG204x SPI NOR driver ignores transfer errors and clock limits.
> Fix both, enable SPI NOR on SRD3-10, and use 12.5 MHz on SRD3-10 and
> SG2042 to match EDK2 and the vendor kernel, respectively.
> 
> Tested on SRD3-12 at 12.5 MHz: both flashes identify correctly, SFDP
> reads succeed, and two full 64 MiB reads per flash match.
> 
> [...]

Applied to for-next, thanks!

[3/4] riscv: dts: sophgo: Enable SPI NOR on SRD3-10
      https://github.com/sophgo/linux/commit/0fe449e8ff7b383a8375e85ebca40133a02f3348
[4/4] riscv: dts: sophgo: Limit SG2042 SPI NOR to 12.5 MHz
      https://github.com/sophgo/linux/commit/a3a8c25c59f8024eb70a460767ff0d7bcb213338

Thanks,
Inochi

