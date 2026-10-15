Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909DF381B0A
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046613; cv=none; b=cjFJTYin7k9wSmE2WHVxF6XNh0obwpRDjtF5/MDaR764wIBuEZw7mzHp2DHd/HI2ztiYqCGJwIWZS0Ku5j/lK7EGC2cDgNPJEO+SAwJIoGZecWN+4ojLOx14eSXgpvJAWUMFhW1F3YdasOI4iprbgkmZ0kHOsCo30pyvBknyehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046613; c=relaxed/simple;
	bh=qOA/xUacaZA7l0HoyLxMMeKlT+LZBqaY+qyIU4aSfHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FClMrKfzww290Uw/muwYbrFJwE3r0zLVIY+yq5Ask7z0O98UvjW+D4X5r5VgMDwWMAegovQtWKEgVUgeFGhSsHam8e9XepprIalzfE9nO/Mo1l9075lexZMWqo6OFRGzxDvU7wiru+k1fhec7cCF1f6uJbnkEIkFqo982CA1ago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH70Fai6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH70Fai6"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so2186646a12.1
        for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792046612; x=1792651412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qOA/xUacaZA7l0HoyLxMMeKlT+LZBqaY+qyIU4aSfHM=;
        b=SH70Fai6u1lWskNS+lieOfSGENiUkyzZQPeCipCFoRCew6RCZLsRr+KI0zLRczOF5M
         26R22XbyVpmptk39w4u/HslkAGtRy5NTg1GntOvMpWZIvfG2ABDxy5ykzE3ANmxHo20q
         RqgeOgrb1L53Q7CvWPSOOFN8zS7TXQ+2WfC8TYo8aOEb9tGh2t6kDGXe86lD7xMv+x8m
         IQPBj4vUVgK0kPZz2eu7hvTROSWG4WRqFgujlilaYmroyxFDRomiG8XOum78sVyAyZ/1
         STrdYM9MI5XeaBxQEjacY3JM5jny4/hYNUYqNlaVyhbIF7E2HnQAbucxycvfrOfaplzD
         zcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046612; x=1792651412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qOA/xUacaZA7l0HoyLxMMeKlT+LZBqaY+qyIU4aSfHM=;
        b=jV+9eB/CfVdG1b0o/ZWcIXrVhA4iD/Qut6UCegjhc+lfjOMSVBZi1kU/f0zqA6DHnV
         tlQTgaM0/vL5xo1xJmEOiWPh8naUlRNMJGvqBrM4mqd2Ut7psb6jNjMOqrTe1WVfykWN
         EJGrgXyl7aio5g9pbhwVJ1hFY8IRrH4BMlBk2kOwHcPvLyJGyIf2G0DLUUpYsSRaQL74
         trireeMLUp3bQNChyINh/oh7cahrorcsNC+BLDhZqJCtIbL31agD8XoIqtLEHR1+cign
         7Ss7Sel+jLcACp5vJSPQNhMsH3Tjs2WM6hyKF/y67zBPVfdEwM/8O/wfbfp5P983Ps2r
         0sqA==
X-Gm-Message-State: AFq9FYIO5hrdeucn3C84sc8XJc+tGVUuEHWnJPBeRhhPaQG0lNgSmRMX
	bESSarTV+TAe1lSmxhBaJSxK23Y/NSZ0daR3Bnh41oOyo+uGy5/JrUxF
X-Gm-Gg: AYBFou1+FEviBLKeYFI8HinWQhbcgBseIXQ/RQY3sV483JZxnNwP902wAxomg3Dhluv
	JDu8nVEfRlhKq2nzTs+b3EtJaAOE+djm8lfSt2r1qL1YVs5mZjGmAwHF44wUa5Ov2T5NHQ6lzyq
	f6EY625F9zKAPxWN+3uOkqVWnWOXgcjad24naPLjhyLUVu5pFQpXe8p+B9XLuvUqWNvZ4Ps2hDm
	mVMegzrqYxOqd52STawGYx2n2fTgj8MepqBc4JFzE0AOTttSLg5IcJJ0D45qTwl80CJHFLap1SI
	/Ok9OocXPgavRGoshWWSNDUXF4lhofgBGjkz/lLvS81ijEl4gVfqPFPIuFiEkVJe9Jd+tZf5/eK
	v64wnaWmaQ8ZnEoX7+KUPxSmknVZuomjLp1/YUafLEIjzZ6RUHCsNEbtwXpYexd69iNdPfp2Ov8
	DPZRzLvGFnz/a0LsXFFcJQwq+XipgRNm56oGOCNSE/IdW2s1CGzT2zADn/J7NklZwJYv4UZ3Q5c
	jSD9t3+BcsuOm8Kymtr9m0btVhCcMPW
X-Received: by 2002:a17:90a:748:b0:3ab:5758:3757 with SMTP id 98e67ed59e1d1-3ab5758493dmr9838058a91.61.1792046611747;
        Wed, 14 Oct 2026 23:43:31 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([136.226.232.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9437a82esm2966954a91.1.2026.10.14.23.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:43:31 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sahaj Chaudhari <sahaj123.sc@gmail.com>
Subject: Re: [PATCH v2] spi: omap2-mcspi: handle DMA setup failures
Date: Thu, 15 Oct 2026 12:14:11 +0530
Message-ID: <20261015064411.1101418-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <eadae021-6d1f-4b40-a100-2d04503e5c1c@sirena.org.uk>
References: <20261014045617.2894886-1-sahaj123.sc@gmail.com> <eadae021-6d1f-4b40-a100-2d04503e5c1c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 14, 2026 at 01:01:00PM +0000, Mark Brown wrote:
> This doesn't apply against current code (spi for-7.4), please check and
> resend.

Thanks. Rebased onto spi for-7.4 (d947a8049809) and resent as v3:
https://lore.kernel.org/r/20261015064341.1100422-1-sahaj123.sc@gmail.com
