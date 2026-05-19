Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F873FC5C9
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210838; cv=none; b=gjo5Reup/d/9w0wVIVp2aO36PZCzkKzGUZAWuyEH9ly4tPyq/t0mgLZZptFNJ+N0XIVkJ1r0kRflcofIz12JQSxsvPx4afrNtdvvbjZHMR356GqgT2qZutWp8IvgqLrM9jj16VlmpR/OILFTq4A0ku6XGI7MqpePodXsBb03V9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210838; c=relaxed/simple;
	bh=hdghGDABYJZ7ehSJGpw06biVtJ0Re2YwfqESD4NDfqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daFNphZo4NlLjnIa5zf6I6kVmrrvm9cWK679rFVBc68MZKzXcCzk6CtFb+j3DRJeqwwLsInNuIaciPANaEYELUMLWkRUjOD27wIBsF9X0vfzvuACdIET3op5cbSVebZ9BdPK69FS4DwWakNUfcTiU5q5yq4XJqqw29y81cjthlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A54TsmB9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A54TsmB9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so32217275e9.0
        for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779210831; x=1779815631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF0Gc/aWd6ni0YZ6OLz7XyAixJB1h3NVnu0bnzDB350=;
        b=A54TsmB9YMJoCSZm3OzylrlETZRF14saqRfkLBmx7xwkTfep/i2QetZ0EwaI4qcay9
         PcAJ1NcJc1krQMFL6e/45pxlf1GiBHAm7891I1y9iKJZWysDtyo6qWkQMlbHYW0RFPo2
         PhJpBODfP4LkeQ16g73mV8dWNfSI4q+y98Y1aTuogF2EANZXhlnig91o99fGTFx54Fcd
         Cwu9f2QMxii2YWjkyp2TxGOtSagMqo1a07ohbGQdf89CezLaRmg6Puo2fSiyOF+AjjFS
         1tFMg4rYwPoLiz8Al1WdrVdCjpsJfPWj5F+NTqHFClz35/ya3koWK2+RmjsxNal+J/s0
         6Wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779210831; x=1779815631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YF0Gc/aWd6ni0YZ6OLz7XyAixJB1h3NVnu0bnzDB350=;
        b=KWBMmdSK2ZP2OrciN+YPEb+pLQM2fksn87O8XL/owqRyeMSJ8xObdB5w7bofN/idkE
         WWl/xaKBmtRn1E4AUXcx590i4c0o1S0GWDwUw3lto7t42ZaphwUuacMTRJRDjvH4v/W9
         xBwfOLHzyB2MqQ6nr65ucyRsiqjqSV8PM1kfLdWqlfUrl/XE/n4FUSsuL8FwnmcxfOQf
         fY9mOPYNaemRiAYGWkCdFszphUKwzamvdf75pShUrQFYP6rMUTkmIYSPQ9/u4z4FtCgO
         2gCujlsZJHTZYopM7NHnIHRtFk1KxVJIzapTm1oFtuohGM75yoIBQAvdSki2bYlKNjDn
         O0oQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YwyYEfiCH84h6dE1WrvOAmT6ynclsHM7T5qTwHhmr2K+LsSCOE0yc0kb11v4cZtUKWHHTFw4Je8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Y1MMpGkDUZN9kkxQ8Fsey3GX520ttDDoUufdQkjNjdimAMvS
	kSatRORjmpVcMuBnRj+NwqII2HwXfoTsOB7CFvk0ALBgZntTf1jf4XRA
X-Gm-Gg: Acq92OHlg7MyIOp24G/AO6R0FuTWkkojPrq3PhrKhfrgCEIGpQHe8RY2tYZfi0nDQ6A
	GNLBz1OGzL7UrzkNT2jPR8CW2gBV8eAm3fQ4jPlzQdxShQb4DZafIj6HtWUMit9T2u0rL42jDu2
	p7acZ3aD94+zOng2tXdLbrE5XJQiqacnFvBLIVDU/R19EfS3ZY2eNldIiV7fkv43NWYJROFWqSl
	eYgzrF+iBLuAMblqf92Nq8p+EYj2X/z1xEdDddJJcCxrT1lkbXzjJZ8a160X/uYN+DRUO3ZpbFf
	zAWRMr35k28BfWf/a2baq+RbmHPrZClSVsFlCZK1BNrcYRafFEFSg/ZhyT19USuBNJO01tM9/GV
	E0ly1oIu05P/u9i5X94aJJ8E2esV9hlX/FpCj8Nlq4xU1yo4zCg2uzBKuNFaGITdgAIAtyj2dqs
	/YuZd5DfMRketeNDn6MNRszcWF3So0F+zpFF3C1604l9oy7oIVCsB7ypSg4xijS3QP
X-Received: by 2002:a05:600c:4fd4:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-48fe60ed7b7mr287651375e9.10.1779210830786;
        Tue, 19 May 2026 10:13:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45e7c22d8b7sm17989013f8f.6.2026.05.19.10.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:13:50 -0700 (PDT)
Date: Tue, 19 May 2026 18:13:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, clg@kaod.org,
 joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 BMC-SW@aspeedtech.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: aspeed: Replace VLA parameter with flat pointer in
 calibration helper
Message-ID: <20260519181348.777f7dc5@pumpkin>
In-Reply-To: <659a6593-0223-4a26-830b-1390326b84e5@sirena.org.uk>
References: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
	<20260518095708.2502537-3-chin-ting_kuo@aspeedtech.com>
	<659a6593-0223-4a26-830b-1390326b84e5@sirena.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 12:03:51 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Mon, May 18, 2026 at 05:57:08PM +0800, Chin-Ting Kuo wrote:
> 
> > -			while (k < cols && buf[i][k])
> > +			while (k < cols && buf[i * cols + k])  
> 
> This really needs () to make it clear what's going on; the precedence is
> well defined but not everyone is going to know that off the top of their
> head.

Come on, it's multiply and add - everyone is going to get that right.

-- David
