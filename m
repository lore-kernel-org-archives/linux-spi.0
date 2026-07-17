Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B2324B06
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784332091; cv=none; b=XIsL98kSzGW/nlJc6XrepJznWyYNoJUERyzJEFhqyJyEiiNUFBmfuo5R/hddonefFOVpOV0fPz7+GZvDi1U8PeD9iECnBhysXMmy00IJYTR1miyh3jf6yGEqzvoXFrGqOmGgA+WZ/M5Xf6D1e5uCxTIx8FeiVSV7JxRS/QwpP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784332091; c=relaxed/simple;
	bh=TxgWEC5OxJ4YCZu2v2EhY3J3m93CWafpLRaOj8MGYzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tugFeiqiYRPKLmKXrgs1ZmPo5u3PykAGFHosvqf0IsYRCJaEb3rlfG1/ARH0K/mrFsWsp6m/cDLAzMND2hSOSIW9UsxS/DusTfYK+48mz2m16hDm0YoRKIafS4GTxSoLLtCDmA/5wx49gDe3JiUZ6f7bfb5Aa2jCKgfVNTYP1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so4518193a34.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 16:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784332089; x=1784936889;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TxgWEC5OxJ4YCZu2v2EhY3J3m93CWafpLRaOj8MGYzI=;
        b=Lhpey5rRQ1WWL8dBxYxiJpbkA6oxxSf4MSzM4RrFzajoYeHz9HX61jRk5QYepmglp4
         ZnWe2IBy6L+gnabOF/LhT+SXHlip/hEtFzfq2wkqGSc+2AxhXNNxnojKa0WeQ8BKEDkZ
         4/Awpbsvj/1tVjf/AIImFApShIc25glMsHdOGAVecn5HLpB0csLQM+ZesoBWatnTe/Pa
         +w5cwM0UUzQP4nn4FNc9KU+Unw6xU1zMImAnNAN3Ym34t+/hQPY688rAFs/JwKtMgFyM
         NdOAJAObKeuWqh0Bv7HC3qp9bnIgqOvxSspuajMnESiTxpdNs6jSQImeeTzRSTqjQpXo
         dcZw==
X-Gm-Message-State: AOJu0Yy/zGfoCbdBAH+UW9G1WhJq2gCssflCoQ5Pk+pWc+7i4JyblyqC
	jLj44utP8sIqCMQusM7soEjykDJOSmYjI+DcO+0d9j/P5nn8ARewI9KWQCPm
X-Gm-Gg: AfdE7cm9Sr2cWIYlMfs9mbkUFEpXaHgKvT9jnR1zJwYtfVgDgXFkKOVGLVCEpmc8c5t
	Ujydr/sZwCnXlXUhSu2SvYUoS4PUO/CA1sLJJ+tLDex7pGASh4xUDBHAfv3xp6zeO7Lgd01Rs/1
	24WjUXy5z46FerzpG+JLo9YMSglfeU8ChG5USdDKmsRl/zpH5L0Y9DfHoYiFdz/TzcQzH3QDgZu
	Z/KmpMl3o3/Xmdxt2uQ/sRoS6tUPt2Oc9Xg/aOw2toTvX4/cfeWDOD7lbGsaOLa1BZ5cxziSUv8
	rQlmli/M9KWYhWBocF8yYreoD9Gxdx7ZsTX0z6kjXrPu5O2FsrAwX1PGF0V15WD5erIgdzIX6fl
	uR/FyBC5BjDznEmJ0FuceKcYHECYXSl9yyUqfBOLNfTMBOcyd+Go7KHgLSUdYQg4vjFz5Ldf51c
	3Zk+rJtmSwRsHO3hAtamqNYsxsOU/j0HkW+4Kc9pLZn/cwtfVVR7lgS5U32wpl5qz17S9V7Z6y
X-Received: by 2002:a05:6830:81f1:b0:7e9:b4d0:df75 with SMTP id 46e09a7af769-7eda1594647mr2330485a34.29.1784332088953;
        Fri, 17 Jul 2026 16:48:08 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com. [209.85.160.44])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edaf9cd6f4sm2407649a34.23.2026.07.17.16.48.08
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 16:48:08 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-45133d2974fso5066421fac.1
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 16:48:08 -0700 (PDT)
X-Received: by 2002:a05:6870:9a06:b0:44c:3269:4d40 with SMTP id
 586e51a60fabf-456908c1ad0mr2006868fac.7.1784332088156; Fri, 17 Jul 2026
 16:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712162420.7453-1-fourdollars@debian.org> <20260717154646.5854-1-fourdollars@debian.org>
 <51a76c7a-1cec-4d2a-9a78-1ef0da890636@sirena.org.uk>
In-Reply-To: <51a76c7a-1cec-4d2a-9a78-1ef0da890636@sirena.org.uk>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Sat, 18 Jul 2026 07:47:56 +0800
X-Gmail-Original-Message-ID: <CAAT15mPUw6-YRx+bUumybHaQ+6PNyQycsb8BbQyvViC6rA-wLQ@mail.gmail.com>
X-Gm-Features: AUfX_mzOsQ5Wns2xYHxLmzDYk3ukE-3AWDGcrrqW-ynlPVnfvs4NTS6W080LeVU
Message-ID: <CAAT15mPUw6-YRx+bUumybHaQ+6PNyQycsb8BbQyvViC6rA-wLQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume
 state fixes
To: Mark Brown <broonie@debian.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 5:44=E2=80=AFAM Mark Brown <broonie@debian.org> wro=
te:
>
> On Fri, Jul 17, 2026 at 11:46:44PM +0800, Shih-Yuan Lee wrote:
> > Hi Mark,
> >
> > This patch series resolves two issues in the spi-pxa2xx host controller=
 driver
> > related to Intel LPSS SPI controllers.
>
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.

Understood. I will make sure to start a new thread for next time.
