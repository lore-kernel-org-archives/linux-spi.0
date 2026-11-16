Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794808731;
	b=PUITQpLfymI7V6jUQmlgHYl6k/jo2vnBlnbiD/e/4d1cEcASWMGquCD0wIJB+BCDoLw6
	 HvQtFF6K3ICDn5V9jvctg9D/7eH6a9wf3/0sYDe6JtlLlVEYX+gK2OoeQxlwDLp9VXKjX
	 CEd+zzNjq0SYgbHDBtdKRwrWOFzHVocVR+kpxiNDLqnAODv7BonH2a0oX9Aj8h8BJJE4l
	 R9/CnfzM8krxpTmeUDA4bV1L8Ag5TxCYAUMrD6KlY1M9Z3whIa2r8KKmM+/Fd7R8WB5P7
	 Pn0iodfs8ty8m3YwChO9OJMiBH2Jc+qElHCsQNfIs9Jw9RO20/5Ze1/ohcBYaYL1JRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HKC6wftTAfwgm7hfDMXB92AtkaDOnYKFMImjf+ok55c=;
	b=iO6+SSFUffXZynfWA8UjG4KBcfjDlSvZVTd1cctw1NkWWquf32wWdNNFpyVDdC6Eiy/j
	 OIwH55bs/PbLs046Z32wjCC6dCbgqveU2zWtp89r/lJiSmzf9btjYSaQIaD8D3HGjaRWY
	 074sT2xIdExn9rfZEWUhJ+LUi5mncnKuGM45mMTorFNkU72UPYDHgcW7cQSIZQHawkLOU
	 yvnIvGay8Gm+xbxT5oTRbAVwb+Rgz20RDrNKEtW8FpeZfZ0eabaokCqXBqOWZJlMdoCPD
	 oeRiDMbUweGFxcdz2xno+v0uS/f1xIL84BnbMJQ9gCfYL49jvGJFop/o1kz2ZWgoQSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B8RwwSB5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D01606A329
	for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2026 05:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0D01606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B8RwwSB5
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be4b29df8cso212253e87.2
        for <linux-spi@vger.kernel.org>; Sun, 15 Nov 2026 21:58:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794808729; cv=none;
        d=google.com; s=arc-20260327;
        b=VbRhnu2gBE9qoSVbQeJKEcbHtvBblTX5lZBCezJf4wzRzc/zGjyGQHWiIFcXna/PAq
         TJ2hadSpZvgotS9g+GYGJJNi62s+Dkm+vRo5mXxGt5MlUJJevEkpsoJOpJZxlGRg3bib
         YrBqaPGTKXeKvSfI/xlbDxvqniSGz/mpog+a8k2IigWvdC+Zj3EI90iw/x8QimfSbj9e
         ZaZteCf10OaW50qAAh4wZEx43AKi0dUDlamRljZ0Vy/mbOTPlZCCxTeJnMF1CQT8VIO9
         LSEOPujybOAAYChwr1pjYPLltwAhPo5b1o8VUI7V8eUk16Y9GaaOpTF930syfGCqw9xE
         ZcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HKC6wftTAfwgm7hfDMXB92AtkaDOnYKFMImjf+ok55c=;
        fh=gdZ7lPllkJcNbGsR2I+2v181XHNizHA/G64Ntxfdjgc=;
        b=gu4q0k7ZHB33frgBxaVRH8caGowxXdl234itjK8JH+QqDnrf/4LpXE6ky+h/9rLNzx
         VYe/rPti0sw8ZrUDXEfXu1TGOWmhxHt2RXYupc/jZ2THh9fwwn7xqkXu52nsAlrPhycZ
         hh5okeTWrvLrICR5StDvfzTT/IrYt4KBUTIL4Ydy8buhzyn0PKL/Rb2xFBJMaONUf7B4
         XxfNJ4DHQUj1iRuAgNpCGuf97ySRDNP3uZGFuS0YGZYnR10JcKedAt11OdTtXpWENFBB
         CMExvE41TmYzRRue3ceHV120L3Wq++AhITDj4DPz1HiS9fUNbXJfzHHo3sujO88mVeir
         fKOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808729; x=1795413529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HKC6wftTAfwgm7hfDMXB92AtkaDOnYKFMImjf+ok55c=;
        b=B8RwwSB5A8LtO7UHvVXYnc07E6WmdiR3wJH5UDhSfLEJYiSbn1KPdAvI7qSEiQcF+v
         dzhLPdOx5WKVfMeGZCKOfeQSpLuuALPljF/mSTa675n7PNiLn99rEMntSbky+gmNtjUm
         T6gAdR/uYaaTWkFflhg46Lbuf3gd9b91nKEHWCoFEuXucwm1KohflJ6pw7xmBdnkEl5Y
         0kmhlsNtW+zkCvkOT8MyAxmLpLeiAJmdNtB/EC6V0CWcS7tUZI8fJ8voMqYsJdIvxsZK
         rxh0HEyXhdqsAlYkmkFB9/PPUEjPgYVPhXctXJe2TI/mopCKAbH8EO2nulVKEiFFty2z
         Gb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808729; x=1795413529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HKC6wftTAfwgm7hfDMXB92AtkaDOnYKFMImjf+ok55c=;
        b=CX1FVxYSokFYqw/DXUZV7g1KZCv6CPCNl9xGlrpchUQ4LHYMAeVA/AgDa38f10kcyD
         mnQrKkZoNY1BAdRqZUAOYNCgTCDgD31pNLDfpqF0BSibSl9TzDkjS1d1QsBEpspxndtS
         HswUt3D2YTnQU1YMgCYb0k0VbZ/pQATbcHatgfAOEFSpDGfJrpym/9+xQvDXjL8nPonK
         vzGDKXwMCW+3zsiLoeABVfOBwkpnrwscL3ZM5ifDtfO+cTh2Y+JHGjlhRWhFdkoeLPQj
         VKNmwv5wG8+GJr+Y7rUNo1NmVSEfVVlHav8g9aXvnSsbQFpCw56N9g5iosL07nNf1hYR
         dfmQ==
X-Forwarded-Encrypted: i=1; AL+hErGQT5huanZd60EX+rGvDvLoVRU/CNxyygKUZD2HQ5e1VRG1YDNvU8FM6phi1Fhb9aJf/ngXF1m6+qI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BYIoqKf4PP9VJ+vYQjFCBsbBCG5OCkjrTfz5OTzMKeNfUvJ8L
	X2EBfCS4oTroGDHrfvHJS1pDajBADBqsv/sNC3KwS6Zb8jz1qB5ERyrfXKeikrQLHW3SGCZI6L0
	z5kmEB6hyn0EFyQDMm6tOJpietA+sst0=
X-Gm-Gg: AYBFou0e3M35D6GSCb6qipMXgWOq7pzlLMcLVQpMxE5/k4lMM07OBR+Kqzj6/9ZWkDa
	xXgUw2toIeSsFXQpPzuV3wWmsLO+5EVLusBhuS+ImbTVVZPfZYiUimZdFCraOTjPZAiz3z16a15
	b6fOVeLgZ/CC62sA7XWRwW0hcC+AtfQcXmjA0NPoPEl5BpojAuioOXChVHiYt9HJFvBo2cZtOH2
	XQKfR9a9M4oxZVcKw8yvXR+dw1cPmHRyfvTJUSWA+coJSzn96nTiXnv2lPCZTBmFMCh3T2sQsFA
	Tn+rBiHADGa42ri0GrcBW1jE02DRzmyX2bRFAvws6B/qRLx8XU53MM9rLRA7xj//W3AGgP1Lo+0
	zO/0318CqhuBWeJvCUJ42+JSofLfFA6BwYNZqH1MXYNZ0LBS6H8jDFB6Ojp+iy+bVn9dBpU4=
X-Received: by 2002:a05:6512:3e0d:b0:5bf:a66f:e5e with SMTP id
 2adb3069b0e04-5c17058b108mr3973537e87.0.1794808728737; Sun, 15 Nov 2026
 21:58:48 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-spi-sun6i-h616-dual-read-v1-1-59bea5a897d4@gmail.com>
 <179461167656.590303.12402709871115244251.b4-review@b4> <CAEy9hNUgWgO_tzV=3=X82A3kOYBxhukOvqRzaq+-YC18=RZW-A@mail.gmail.com>
In-Reply-To: <CAEy9hNUgWgO_tzV=3=X82A3kOYBxhukOvqRzaq+-YC18=RZW-A@mail.gmail.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Sun, 15 Nov 2026 21:58:37 -0800
X-Gm-Features: Aa3M54oyNaHJcBkKzqdmGmOePaHsPjod2sYjt6MjOSlPfYgCgkl8Fvj4W_J60DU
Message-ID: <CAEy9hNXFw1Fr81p=27vHR4HbNOA2ni4srU1RyP3W8wxoas6Ztw@mail.gmail.com>
Subject: Re: [PATCH] spi: sun6i: Add dual read support for the H616
To: Mark Brown <broonie@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This new compatible needs a corresponding DT binding update.

You were right and my earlier reply was wrong: the binding limits the
H616 to single-line bus widths, so a dual-read flash node fails the DT
check. v2 adds the binding change as patch 1.

Arun

On Fri, Nov 13, 2026 at 5:13=E2=80=AFPM Arun Iyengar <aiyengar1990@gmail.co=
m> wrote:
>
> > This new compatible needs a corresponding DT binding update.
>
> The binding already has it: allwinner,sun6i-a31-spi.yaml lists
> "allwinner,sun50i-h616-spi" with the "allwinner,sun8i-h3-spi" fallback,
> and sun50i-h616.dtsi uses that pair. The patch only makes the driver
> match the specific compatible before the fallback.
>
> I'll say so in the commit message if a v2 is needed.
>
> Arun
