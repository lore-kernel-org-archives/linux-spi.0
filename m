Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95E3033F8
	for <linux-spi@vger.kernel.org>; Sun, 12 Jul 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783872326; cv=none; b=JlDGkYIQCR8sNERUzuRj9PjG1Ockq63ZjUrWs/XGCtOs4tXSskBrFgiXtlo59lHN7R1x0uqZPpxn4KCoxgDHVd8zGPt/h554/kiw5LLudu86UDpdqULY2WS1MZGkfi6/PNN/14PwdvWf+txlvIubTewjVAGIMywoJKp/PzDkkZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783872326; c=relaxed/simple;
	bh=HYdCz1xlLgU2B4rg61F8c5q4VwIZtY9jojDIygIHVSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g4DjaY5CC2EdRl9f6V/h91hkftXYb8Mnoj6NwfesMiK3UJFwCuxony7WcwmnVSNKrOvDmyoYCPCPB9NrwhDjLDF151FcGjHJlAAw83H7v9MEzWEB0IOhBOComgd+eAMgrYLn/sQ8nCeLWCaUpgoeu/P/zjCOSZGL1mbxFWbV98Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1355017a12.2
        for <linux-spi@vger.kernel.org>; Sun, 12 Jul 2026 09:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783872324; x=1784477124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGY7taiLnmCSVR1KjiFJzcvjfx5XvByeFDnx9S/k8nE=;
        b=ZxeuhbUCKrZGTxiQtM/suxL/O625Qpym1WpAEEFFuP75hwVkt8l9kQlwS8ou2Qx0UX
         1YI8tgQun06QsCJHG1Puv0ai0qRy0BNA5SVJaUTBuoXqjV0lOmQTS2Y89cw03ypc7hoy
         Gfct+jm4/0eGpndJ1PdlMniL4sXjwcohOIhCR/HXQ3PTpKZa5cTeNWDPE5I9qKUu7fSO
         353J9gNsysAFivqAXqsaQHySt0voX+r4hiO79gWZFCrvuZBeyaGwAP77GdWQe8RdXA+R
         O38UaQo7dl0xFBvxb3JBCbkmmdaSPaMBQhCJsJffpZhLiodoXuxe0eubZIC1czpciH8k
         lBrg==
X-Forwarded-Encrypted: i=1; AHgh+RpeR+IdA2grq2hfHAjglAuOpqYq7tWY7bdZ9lFrqebdcgxEaX12d7YB80uze1L12sKE6WOrjIAsbNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoqa+sI/mzCWq/5w39OF99LSihCCBCqczXDXEZ5KG4Ot8sdsvS
	Nn0IGj7TqxQZrzZamSYytXfW6CeSdScbmNmCHQuRBo5w7sPTELhqaE7kXfteJ3U=
X-Gm-Gg: AfdE7ck/fp0m3T1XIhHrvB68+XRnZtmeCW0fsqZCFkzH+qi5exJv3yAyd+EFxILXkI5
	6b4n4bQ7s3JGvB0y4+xCZ9VdK/1fzB1nlsT0xal+7uFpqCZGpV+NiO2hiynLoFb023InEPx9Ip4
	Sw7R0dUlY0XMWEeHJMxzBAMCGR3hwYPkvwOhtyx8/jjxMeWXQhD9QWngLnWPRz/VYNGxRD/T7f2
	a8RWCuFigKI4z4PMo26rcW1mDwHnLg9WbLz8Iha/AF8V2xE3vY/P5wIEUz3x2xI16QgAyC5NndX
	kXNwitCTIeskF4G4PLnjErHZKgC3VWuHARwB5BDseQ915OerMDDEAL8gV+nimhcEN0wioYFH7sb
	IdtUPTlvAa7uv+3jem87+bx5CVZRLj7te7OPBB8wYTyH/gAmBmiwD+lD+pGfasIMp5wCW51U1wt
	QgPuT34oh6dpY3Nag6vGUbZrMufYtkh9OtjIPrqqpxrHBG6N8KGI6xUnj83LLulng9NN6qVAsd4
	YtOFluaMJ38fJf/EwqwY0nOfINuLwjffkDQ3bFC8iEwC1S0Vg==
X-Received: by 2002:a05:6a21:4cca:b0:3b4:8a40:85ed with SMTP id adf61e73a8af0-3c11077686bmr6203955637.7.1783872324462;
        Sun, 12 Jul 2026 09:05:24 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-44-142.dynamic-ip.hinet.net. [61.228.44.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162a49sm7156667a12.15.2026.07.12.09.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:05:23 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: Re: [PATCH v5 0/3] Input/SPI: fixes for MacBook8,1 DMA timeout, UAF, and NULL pointer dereference
Date: Mon, 13 Jul 2026 00:05:16 +0800
Message-Id: <20260712160516.7265-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711055247.5412-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry, Mark, and the linux-input/linux-spi community,

Thank you for all the feedback across v1 through v5 of this series.

During further testing on the MacBook8,1 hardware, I discovered two
additional issues that change the scope of the fix:

1. The LPSS SPI controller (00:15.4) loses all private register state
   across S3 suspend/resume.  Restoring only the SSP clock on resume,
   without de-asserting LPSS_PRIV_RESETS (0x204) first, causes a PCIe
   Completion Timeout and a watchdog-triggered system reset.  Additionally,
   the IDMA block (which shares the SPI interrupt line) needs its registers
   restored to prevent spurious interrupts from masking real SPI transfers.
   This is a generic LPSS fix in spi-pxa2xx.c, not specific to MacBook8,1.

2. The applespi_remove() teardown has a use-after-free race between the
   drain_writes/drain_reads calls and the GPE handler removal.

Given these changes, the patch series has grown and now spans two
subsystems more cleanly than before:

  [input] Input: applespi - register touchpad device synchronously in probe
  [input] Input: applespi - fix use-after-free in applespi_remove()
  [spi]   spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
  [spi]   spi: pxa2xx: restore LPSS private and IDMA registers on S3 resume

I will submit these as two separate series to linux-input and linux-spi
respectively rather than continuing this thread, to keep subsystem
boundaries clean.

Thanks again for your patience and review.

Shih-Yuan Lee

-- 
2.39.5

