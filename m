Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06957370D69
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265627; cv=pass; b=XqmDOjm++lPQzy2KiMtLnRNHVw2/oiDI/j1WQPlakT1hQbsH5mQW5Nbi3eZPP/DeRe+GIwR2/uZkaH8jtL8S8WqoM21unDSBVGqsicoJzlC4WzcmI3m8NP7mMNqzYxFbNCC+kEzxWdx+VyhdSi27o4a/wVQo1WACKkuJouonGw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265627; c=relaxed/simple;
	bh=tZ/CJ372O++VGNkJEcYMfrMLPZfurcWAJbtOkanVpSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m46VsVS/zFtJSuEN7Icxck5xxPJCj84Ev8DqpI/eDi1WzXawEjeF68mkGd0ne0zkeZ86WtI3TV1twBbT1gdVGzt3NlPJWgs6yiSqCMfTJJZ9u2o+nJ55UiscDTHt0UopNGDZyF1YfhXo6qFd3pAA8jnSyXLb7dfRAu640r8emyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntMPFZZS; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntMPFZZS"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1323184a12.0
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 04:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774265625; cv=none;
        d=google.com; s=arc-20240605;
        b=O7C/bIW7/3b86bi/sXn1YEeJ6QFhtpa0uvBYBW7FGJGbmUXGDyLolbvlAzgXfLPrcu
         M2XTJ9qda0uBHt33xWlf1wV6xWvUzVDJUbaZwjpnfEtHOpgwUdQ835XlKyPU80yfCM6D
         DtxV3RsHyqTYiqf48EDxfukm1tbLBwHxXWMwFPP6exaHhUo/JKK11F+2lGqTRFkCfnsz
         IRlFNrMUqywj33kNp2BJmguaIRraG7qIVaGdjkrdJ/Hgu71d6xdCnqSlFzoQpBQtbSpQ
         CafaNrAcEjsTPwNGYQlDzx3w+8N97AwoPhTq5bu+WvfX+8CEfoXdZa3YfeGWFyzsZfDR
         43Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tZ/CJ372O++VGNkJEcYMfrMLPZfurcWAJbtOkanVpSg=;
        fh=NNkemtEuXu0bK2dBaN2vYNI4LfoBFLMBcNfQ5e2bO8o=;
        b=OZ8atKxSyproM5V7vujvsUjYL9lo0bkZcd5Vx4WYoYT1wNNa/y3nTuKKuMDpkQFa/I
         MEYbbTNtrG8+hCwoPMvDjhAVDrmei6JV8Aowtr7niv2a9TopGyS/nlPcwrpFhWAzVgXF
         i3wTf1ILqceYUEx1TZdF7gXhaNCuNcDyf4A/NRmm+If+Z68lwsns/1r60MC5y/OaWxka
         Y3QipQhjAUoJF7rHkhj3Ehg4q5uuGz827uA2WsoU+bxq5+S8qXqBhCVjgICwLWQiCoCA
         lZ57z/YUI49SEOyfm8Amfs8VF6ttvqMF6R1CvpEJpm97f0MUBsc8Akat3dWbJGVB3SU4
         S2fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774265625; x=1774870425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ/CJ372O++VGNkJEcYMfrMLPZfurcWAJbtOkanVpSg=;
        b=ntMPFZZSrxXKF9OA6B0BeTNeaUlm9xWQurZQFNXp+5ZXlI5Ct1GgIvkPey/nulBLAK
         rw/SkyfPvDYW8rmqyNEe8vWa5x8yUQHMsnrEOfxGePoNsS7H8+inI7ZtmUsvw+d2O4+S
         KmAmDHQu5/LVxo1G7hzMDAgH05oCaFwQwMLgaePdAf+/nlWFf/AqsehwDWHFbs9ZisOO
         rOsKlR+kk3W+v8MSsBfQkm1s6VR82mGz0e9WxNHEwKhnMplPkAhB9+igtcOPRuN7nCcL
         oVfE50O0nsxMtR91rNZa1mJWsULCVAbYiW/OxAtwY/8SaBDeoLPE5a+vrqRn2n2ZosRv
         9R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774265625; x=1774870425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ/CJ372O++VGNkJEcYMfrMLPZfurcWAJbtOkanVpSg=;
        b=hSSfOHxkVWRHxy3YKaGADWhf1TFEITqc9/3ulVgec9ZAWmRcDuc5oaZx3SlYmsupEz
         dy/F7X0AgwA9nZUNArWws1x/fqUJI2xcYc3sioMDIfU5TE0cp8+wQr4Dm9qqhCUuRPDY
         eClMlM7+AihjV9IAuxrZfNPVwtsMEJ4Kz53vwR1htLE4yT48kpbM59s/Y/49TPnc04nT
         FkVAZ+ej8deEC0IJ/HpNYn7mRsWMY1UHecLabk7B1313pYvbgc/ZismfbUzSCKcgSGMQ
         TTjM2nviXtQbT3ZhHYEXUsFRDqSPsl55VUPhyFLtPxvIsIwE6vI/rz1a89lZ/GXU/C/E
         efAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpPG3Tsb0aOyAW3g41AoGtrByOnsStok0vhy91vIUBqp0xEwluactPKajm4TKl4k690Vu00kGyCAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqafp4CCMqBBNvQRZ0h/w6E/fZf7zyKIZZiUzB8mZcMT842+LT
	TXNZ/rxIwHzfIFJk0he9r2Z2z3AAIaiCsDeKjP/FOEC6dDFCdls9tLJS5PXUd33B6qRAMs78+GN
	1+mbdXTKHR4SjCJDmo5+B2JcEWsZ59cg=
X-Gm-Gg: ATEYQzzTaS5fbUSIqwxnYjuyrhiGtDGSNcvbykduvrWMVpkoDc+0H9PP9lDGD8ePj/u
	Jc0kg+hqByZYkocz/Wuf+e+pWUh47JYc4dnLJv5uj1tNRQSOAgHmb0BWUauNSI4PDVU96hviCF9
	aFtVk4uJb9PrpMgg/QmTZPLOy6Xn4PqDNECzf3ZJ6g7T5OfLaL4WzHY1yM40QepLlwIpzAKoZHC
	aHxgMXauQwpWOtvpRPptBK6XlpMdsEXVAwlUC9uCK+aLgSR9wNidcYszgVPW9udD+emkPq/Qf2u
	eZsuC9gD
X-Received: by 2002:a05:6a21:4ec4:10b0:39b:d9f1:6ce8 with SMTP id
 adf61e73a8af0-39bd9f17360mr7025738637.59.1774265625133; Mon, 23 Mar 2026
 04:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322-rockchip-v1-1-fac3f0c6dad8@gmail.com> <acEcJJgoaaOdBz70@hovoldconsulting.com>
In-Reply-To: <acEcJJgoaaOdBz70@hovoldconsulting.com>
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 23 Mar 2026 19:33:34 +0800
X-Gm-Features: AaiRm51fMHcHwpQ2lYhMbJk1jYvV2u3krU4fRyFnpLfPmI3k8CiscRrZsq0Trqk
Message-ID: <CAN4SLj0P1pAAMBbuWhbnjfwqd-5bwsNroeMzghv0P0Y_myUSqg@mail.gmail.com>
Subject: Re: [PATCH] spi: meson-spicc: Fix double-put in remove path
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Dongliang Mu <mudongliangabcd@gmail.com>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Indeed it does:
>
> Reviewed-by: Johan Hovold <johan@kernel.org>
>
> > Fixes: 8311ee2164c5 ("spi: meson-spicc: fix memory leak in meson_spicc_remove")
>
> While only root can trigger this it should probably still go stable:
>
> Cc: stable@vger.kernel.org
>
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
>
> How did you find this one? Are you using some kind of static analysis
> tool or LLM?
>
> Johan
Hi Johan,
Just code review, I have fixed a similar one before.

Best regards,
Felix
