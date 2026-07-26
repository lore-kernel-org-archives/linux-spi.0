Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2796C3859F4
	for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065028; cv=none; b=lqYAPH3FDbth39QYKFv5Yo509ZlAcmaN7uEPFUHxQSYpvFvbX9FwMXuVyuKTkkwtab0OwvSYWtj9JVEqJkKrtYIxNQIrtTLZJ381mKBKhItrfZxkLWQ7NLVbivJWgPBYC9+43e2ccVS5d/A5VMRRRHQxzLCRKdXEs4x0+JLs2uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065028; c=relaxed/simple;
	bh=msgew1ysgPiViXJb501fpHVo5cSnGRcQrQI7SElt2Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVoYTBz2JZf98/cMDzMI0K/FvVGI2M+rpWSoVwB+CJIkxNAW3jUaU7mR5DqyjiwC/xGVSRlI1/pc+iLpdBnw/WrSkUNr+eccz35w4476JOwVizGa7LOr927q/5IjJVy48BvVYhiMj+FxQ1SS1IKQL9siSyIu9ZRtT7sJJBnpCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43b7e186a0cso706930fac.0
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 04:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065026; x=1785669826;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msgew1ysgPiViXJb501fpHVo5cSnGRcQrQI7SElt2Ww=;
        b=P+Z1vCgzFp6Tb0CFCyFv0W41oQw9vcLzWAMGBISzvjA3MiZ87cUXNDvB8HLcOupBa4
         nP980KZ4ohA+PeLu+xIpdvEM2JKtsIPkwD26Xtn32pPpg/k6E1a7+JmtgNyRyQz3WAom
         klkwJXZH+Sa7Ds8mY4IuJo+UhtUTSsWTOnFXV+rt2zgkh6uBetTDWF0bEQu5Kvc/UrBt
         2S0/b7EAIOELR/7eIoTGaiA4p9nWjnnxtn8MpQzc9QJ1+rSQY/OFKqnhnAhU0wAKFe0c
         e/njqUQ/r9BmeORja1ETtNuuelARjtzuM1s9D2dVBo+aCiiFMD3sXqZy1KOhfJ+SD9AR
         Fbew==
X-Forwarded-Encrypted: i=1; AHgh+RodmlBUD6zI793NnNWREfcwNK4m29uQcIqanYW8TS6RhDMKfS4w+At8SG8T+J/RhZ5wQLcCTfnSmxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+/IyN9ILJE+elrLpVJOXPgAjLthovDFeOS3OFjebOUHaVXZ4
	YwdEytba44re7pOJBZlPBMVPzbDZn19rJxvkAaYTdJsU6xB/WkDTzLgiNNWe+Dr/KQ==
X-Gm-Gg: AR+sD105BL63du+YSwdDBL9HMScy0AOq7IOt6gtn3KSs16NAdUtg9qTbBprFHcsrxlx
	6HigoWxBN/FkryQKJLpGB1fOvLWCuEAFISYFqzVOcfid09UdhtmjPo7V8fQi36jrXbKe5Aa/FNg
	FxXd4mEcYuCj7aZge1pNms/cws+TBTibKfnQAfvCE/V5qU1GgP7PTuUb7g7ijCLLJYVVvRLIXV7
	JtpdXFOzhcMXWgPQ370MGVvYEuNTSQOqYQixL4fLbSQma8RFkq8xeE9hMaabjhLYcKDpXIrieKC
	oVYMrPMH5QlIZ8l/iVTfaqFrdzzPhpx4sliRE9tUKdH3NwQka9hyaDlE9AwLKsk1sWn9RnNzU+/
	3yrEIbGvuPyaBS9tjPz6sttF35JnCjyp0mgHICVaNHeLEpoFJ6BWEFVAjq0DXvkTKWdSG4qnA1S
	3IKQNZmS7qaDti/9zPgoNoIfbEmDi9V+WEid9Al5oCRHU4ZErjsmjORjy1vZ4fJBuPGMtjAjkDF
	oK9/3AH2NQ=
X-Received: by 2002:a05:6870:e450:20b0:455:e6ea:bd8f with SMTP id 586e51a60fabf-457f246e9c2mr2716403fac.16.1785065025773;
        Sun, 26 Jul 2026 04:23:45 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com. [209.85.160.44])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766e7c9d7sm12456715fac.2.2026.07.26.04.23.44
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 04:23:45 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4472500e25fso990591fac.1
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 04:23:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqoxmM+CzpfOx2hKAdL5coSoC1w489nKoxrAzB3oMA7pTfHuaPJF24smKY+shSZT9P8WsQZ6DH/R0Y=@vger.kernel.org
X-Received: by 2002:a05:6870:5254:b0:44c:e350:a0b7 with SMTP id
 586e51a60fabf-457f26c5cdamr4287252fac.27.1785065024643; Sun, 26 Jul 2026
 04:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-8-fourdollars@debian.org> <al59d-zgEV0KCPIp@ashevche-desk.local>
In-Reply-To: <al59d-zgEV0KCPIp@ashevche-desk.local>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Sun, 26 Jul 2026 19:23:33 +0800
X-Gmail-Original-Message-ID: <CAAT15mNfnXh4CDAwQjtH8ktLuah4r+LBgUfm8m-6p-fMOkp2Kg@mail.gmail.com>
X-Gm-Features: AUfX_my8CtrOnBHu50rHPfcv1-YAcfTginQh2XY_p16uaufWTkXh2Yz8qHzk07o
Message-ID: <CAAT15mNfnXh4CDAwQjtH8ktLuah4r+LBgUfm8m-6p-fMOkp2Kg@mail.gmail.com>
Subject: Re: [PATCH v16 7/7] spi: pxa2xx: rename local status variable to ret
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:56=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Jul 21, 2026 at 12:21:16AM +0800, Shih-Yuan Lee wrote:
> > Rename the return value variable name from 'status' to 'ret' in the
> > pxa2xx_spi_probe(), pxa2xx_spi_suspend(), pxa2xx_spi_resume(), and
> > pxa2xx_spi_runtime_resume() functions to conform to standard Linux kern=
el
> > coding conventions.
>
Hi Andy,
> It makes a ping-pong style of changes: Previous patches add more status u=
ses
> and moves, and so on. Instead, this patch should go before all that.
Agreed. I have reordered the patch series for the next version so that
"spi: pxa2xx: rename local status variable to ret" is placed near the
front, eliminating all ping-pong diff churn.

Thanks,
Shih-Yuan
