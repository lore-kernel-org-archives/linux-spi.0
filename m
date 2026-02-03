Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD2B31B830
	for <linux-spi@vger.kernel.org>; Tue,  3 Feb 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142622; cv=none; b=neWKGtN/D9XBTfIwOQSaIbfZ4xdPYSiM4iLHeuU6afo3xWION/EPH8zFg8moRkrcOGYH/Izh5uWSHQk2qeQyGvBEo1cAiwXyAqSgTvY46KAxe5ooxura4gI7vmSSvMjKZh+tnl8NspYFFOCU9Mb8Vcf5bJE1LOU6KTDfYKlHPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142622; c=relaxed/simple;
	bh=UN47FJfHc7xTLQG5hcvh1Zikbidw8gYJs4hF8/nbHFQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FQfXbBJZegiYlzg9WFbV//eeBrBFhDcOeFUNF5mPwRLM5GyiW0nrRusQxU51TMGazXtWvsfjkXbKc4W1Au/Kv2Am66SRnvyFoYuoS82IbNOx7QW3L7OlNrgXTHZGpn1jxITYEPWWd8MpslwU4MhPap3bknFtkNlZyTj0+nE6Zec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=Qqs1bjMx; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="Qqs1bjMx"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-823210d1d8eso3062916b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Feb 2026 10:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1770142620; x=1770747420; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UN47FJfHc7xTLQG5hcvh1Zikbidw8gYJs4hF8/nbHFQ=;
        b=Qqs1bjMxA2z2NAHbrcM4GgeUBkYVIkBLbQTUl/jX8agaT7LD1+gDCA2Y/2VIBcuHU9
         cre9cu9hopIHAz0lPCSykl1eySyPY7aq+t43nj2VLb3h18+akEP7+0gEXgqKcIKSPqjP
         +aLWfnf+jtMFqlC+XamrjFWQYeuv1zpeSFGSy78iwXzq7cP4XPaIHWr49Al5cOUQ1Bz1
         t3AKo85LLLfPCM2qGiRENTfS5q7be+EhmM7VGVWCvvZU7dSfB03vO/23I1xUtU4pWi3T
         cb6xKsxdlNZ5ffPlccrp+1vrv8QfXwFVAmuvoI5uISB7dxLpjVWPDc+aY4Q4MvxlCAQb
         xj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142620; x=1770747420;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UN47FJfHc7xTLQG5hcvh1Zikbidw8gYJs4hF8/nbHFQ=;
        b=hWIGPMx0Kak1MyAhYzWh4rZi/hk7e7j6iXnD7MoJSSfL8HQ1tm33YB6jg1b1SvY+Fi
         Z4Iie/dvgB2TcHhscpGuOruZjp0QkT9rm7w9cbsj0gG05Ri7vxLVH1T2xNoElz4RYUli
         2PZIMQj2GveA1b6/mVsxo8y30PIxKFISzeewb0HbmRw9pde6JoYByWiMRvR9SEv0XvhI
         TL2d5fObmGAuyQt+QXD8pPRrII3aVSULP3f+y+XYtTBBxiNH4zHMQRHj/VbYHWgUIx6q
         ug5KRgE7qRRhHv2z3WIwp6FjrgWpopWYNs41OyarXufKbx56G/BZGwt68XzJjDy926qj
         YSrA==
X-Forwarded-Encrypted: i=1; AJvYcCVh8RWwsHaHaShHYT4gflfRUayveTRHm77+2/QZOH1AfvHWYz7Xk+OSZ3GhbjnBp32STdUzeLYyK7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjdOAUcw8TS3Pe3FVtO0wzHkYiUNiibgLzOx/yThd2RjgWCGL/
	+RmWAGXd3hoDLaN18XzJExjJkftGioKNXYaMjVjHPSPXWWM1rp9utQR8PCJ6RRmxVh4=
X-Gm-Gg: AZuq6aInuUHypIAxfx/Yvq4TMcCEXpx/0S3VywPmAiY6cjFEjtbCVUwerMs4GNyC9lH
	U62nJQb3fffyxw5xPKees8inpvIFQm3DZnQS73Dg/lMqg67Biz+3AOA7+4kNoRzLlqVe8q4da9Y
	dq2jtE3CroPumruO1B68nd7aEvdHooOp4FI11KfH8Q4B5djdvkd6fNpABjZQq9gbpZWBDXW7EHU
	hXtfUGKLqf9Bruc+zwrF2PXpjTI44yCCTSppIK/qR9yA7DsAEo2EeRADCt47QNr8zZU2a+4zbeC
	D7xdQ6+Xuw56HIy4fu8x2X2CnZusBMe4/x/PywsIQ6k1y50Ldn8ZEgxxcTImZWaZqdQ56kysLpk
	A4gQGOBNp2wf6t1znUr2BybzAxV22+fSFJ8SgGfIuKxHF7iRNbq2hD7tSpFJmca+0WOe8coTRH2
	VhtmGN6AdlpaFe7hKD2tNmywgAw8bKKmjkm7bWCw3wEedttw==
X-Received: by 2002:a05:6a00:4395:b0:80a:fc3c:f839 with SMTP id d2e1a72fcca58-8241c6458f8mr279158b3a.49.1770142620387;
        Tue, 03 Feb 2026 10:17:00 -0800 (PST)
Received: from smtpclient.apple ([2601:602:8701:5361:2dd6:2d53:d593:7d46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d438f1dsm35386b3a.32.2026.02.03.10.16.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2026 10:16:57 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v4] spi: xilinx: use device property accessors.
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <849bf95a-133e-4faa-973c-19342afca327@sirena.org.uk>
Date: Tue, 3 Feb 2026 10:16:46 -0800
Cc: Michal Simek <michal.simek@amd.com>,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1DCB4BC6-372C-432C-A6C1-B089711CF8A0@nexthop.ai>
References: <20260203-spi-xilinx-v4-1-42f7c326061b@nexthop.ai>
 <849bf95a-133e-4faa-973c-19342afca327@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Feb 3, 2026, at 4:48=E2=80=AFAM, Mark Brown <broonie@kernel.org> =
wrote:
>=20
> On Tue, Feb 03, 2026 at 01:55:12AM +0000, Abdurrahman Hussain via B4 =
Relay wrote:
>> ---
>> Changes in v4:
>> - Removed patches making the irq optional.
>> - Link to v3: =
https://lore.kernel.org/r/20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai=

>> ---
>=20
> That was the changelog for v3 as well (and you dropped the changelog =
for
> v3=E2=80=A6).

Sorry, I haven=E2=80=99t realized v3 was the same. Do you want me to =
change anything in this patch?=
