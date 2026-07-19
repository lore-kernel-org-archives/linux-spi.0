Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029BA38E8AC
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784455954; cv=pass; b=AD/mcC2PW/phhsalNjnpeJTF3c14Yu7sLlOk8rvOusyp2KW2P7WQIp+MTiy8Frx+9KVBWztDRExbgs7HiR0xukB1K+YN3P7pb4F5qXDIhBmVY1Za/t3MaI3jt+3HZ8yymXrE2wXeZP3Jm0sgiJNb6UYOZbwK6V556azLVPKw25Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784455954; c=relaxed/simple;
	bh=+SWRgwJpI5208jPonUHKde/p1vpdQPTExC1afsSyq6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtyLKFNrwSI5aBPfCTKGyGuqk0oVTz6y0MRZSvR/PwZ0fgQ9zXgVRQ1v9NlMkfxQRHEsYo/soGRHVTebxpgTzrtj72LzxEd74libcVXRueHt7pbLMdER2sYImIwnpLdfXQKwGQVo/y8hHRP6eeC5wI08Noo0F5bQ2nFilbgwdNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LU/dJn7I; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LU/dJn7I"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso3553684e0c.2
        for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 03:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784455948; cv=none;
        d=google.com; s=arc-20260327;
        b=SBwRKerOxFtDiaLQOEZ9SmuF2J6uxfYCJwnk2fxYewUanvxBOWr43zS8ndkrKbQOVg
         Rs7XvGUASQYLWhTCMXcUibvopKuUqIvYSPmA3nlx9KbFLToootzn5avKo06IseOjl7RU
         UUA+W2lhgwDTkNt1O6bF8HPHTB1Rgo5JY4ekE3lDaUapRtlJGPE8To+hLTyVTcjl5scK
         QGWl5yqZiIfhtHQBFLfd653aTn3ekXzZ3QM2Xg6X9fMweeQM7wARJL03Qf8Dl02bxn9Y
         zUThd28eip6Fp1/mpVP26B1DjZE5uObcbuLOiUu9ZGYCLUchQRIn2hWYK1qUMsI4D3mV
         CC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+SWRgwJpI5208jPonUHKde/p1vpdQPTExC1afsSyq6g=;
        fh=+KGB3hWmNeS0LPQzIzUHaw6yrFkCvZHJF6SOug1sHeQ=;
        b=A/tVXFXp8qBJOIJs0coo82KYPnu/n+2Q5nxmw5s3FNMLVfCnHLdzIXwz5iQgaUpu/D
         w1zd20heUrcg4H8InGNDf+wYfhOY28GmiIX55XBJNqXT+fkjzCtptDXJoHIXz0Vplkxl
         m6R/FFL5oKFUzDjB11p2W1fqBZrcxjciOZIdoLGa2/qD4tvmx0qzLswmTPJEpgl+tlBv
         lqsfO9Lejh9LmFFq7VcflonVT8BVaUDqZFnmKLySJwzs9xYNpQM4DQINUl886uQO5mVH
         z+yy26GZgkNh3H7saIhUiYUaGCDPLTnx1hDT8IbBPfxe35jx45ZWD9NRK5dFyhxhUSyr
         LcRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784455948; x=1785060748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+SWRgwJpI5208jPonUHKde/p1vpdQPTExC1afsSyq6g=;
        b=LU/dJn7IdLOP543F/L5LQJ5HIPwPSv3Z1vdFD3MElAxTb7OgxqJzSJ4WtfQoAwiNxE
         +lg9+HJFxNXoL6EDc8uZyLVa6DiL9ExXkrtr3ec1VNQX/0l3YniQHSQF/RdzwdKDK87P
         3UyyFbR/aUif4Rnmms3VVQMMGJaFEZnj33Qy23LY8QorPj7A6adurLaiQIgqJR63zafX
         1Uirf16AU2iF76/iZcJqph+tZsvLSp5vYB+AGjFU9HkcA4stlcJh2Yax/gR1FfsWxcww
         9oggxmzZjsWdBSUCUz0fBkGSQ6do+mby7KPDJ4ksbRF5q9eCjYSUfObelTnEGIhLVkAW
         A/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784455948; x=1785060748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+SWRgwJpI5208jPonUHKde/p1vpdQPTExC1afsSyq6g=;
        b=nNo573sHs3oRw2USCQe7/Zwz3nsLA4lt6Jvf1BObBaQabY2aDHWCV12RJnDzDh07vt
         gHHyJc7+T4ao7lDLwqszDi8mbzk2d8yqf8eohtdTdJRgHlxNDY9oVOE0RnFesLThFZcD
         JduTVGUWa9t5oTR9i6gP34ZjCo946w1jTGyyrIAJfjgpOr+G2zFm5U+DgjHR9UvYKPFq
         3MCywPY/XhrmFmJvWBYNMnT72z7G/7N1h9Sg2Wrk0AShBabPXjYlDAoFZ7PNyX7U5DTn
         kMcjsc6qPZLVmXQqiyUT2yGR2kwno6RBe5asBCCk+YVWvZI60j9zOKm4IpvxTkQ8ay4E
         EieQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOgOaWBi3imOmMs3Z9BZMbB1a/WIhuvvkROpf5Fq/4SvzHGr8iUhcwTdV7l1KkZzta88xQSYplE2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLpdJK6e8ZzWOw6kd7Nbw4VI2sS6KcJMymbxHjRBcdsQ76d280
	G5LbM6jbI871u0sERZQy3A2qxem4GaJHsUJy3niO9LS/QSyUB7rz8OFek/sLSlt5SWUhRTNnlZ+
	Ac+lYY7z5pdM+piMULJu4Y/OQwwkQ0KM=
X-Gm-Gg: AfdE7cnuv33NiMQZkCiiOTIpjL2XV89QRNmeEIgxkKVmsVxhNX/4tuKCMcPt+qx+7L7
	hZlAXM5GYA3w00KALhu9jIEdm+9ZetTOAClVlh8rufi1mZaSPSkuwcfAtE3oG6rAniITy0/4+Lg
	GQGxkklCc8USbTPYFCCcKl931uUYnHQoU63EaB9djFf6Sisb/P8JqgNNeObkLqqpqjVEEpY7PRm
	pUNaw7Myx7NW9W1eJMjdbIUZgVb+mhnTKK2chzoax2c0Lt2AmJ4MuBYUqwpi2cRDq1Wz71HF7Bm
	qpwgjmkE2ePXBpnRoA==
X-Received: by 2002:a05:6102:3751:b0:73f:7bca:217d with SMTP id
 ada2fe7eead31-747536f091bmr2060442137.20.1784455948074; Sun, 19 Jul 2026
 03:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616122605.668908-1-mitltlatltl@gmail.com> <77953dc6-a7a9-4d74-be14-0424d019b8fb@sirena.org.uk>
In-Reply-To: <77953dc6-a7a9-4d74-be14-0424d019b8fb@sirena.org.uk>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Sun, 19 Jul 2026 18:10:50 +0800
X-Gm-Features: AUfX_myK2M84Hx7_NX8fCV8CD5e4weA3q6bfbwaUlyBWXK9agR3ne4npIEk94H8
Message-ID: <CAH2e8h6wrK0ZbXJqJ6Lix9FNgtE98tGKPxmOnqd0Kn7hpzrJFA@mail.gmail.com>
Subject: Re: [PATCH v2] spi: qcom-geni: Use GSI mode if DMA channels are available
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 8:27=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Jun 16, 2026 at 08:26:05PM +0800, Pengyu Luo wrote:
> > Some devices (such as gaokun3) do not disable FIFO mode, causing the
> > driver to fallback to FIFO mode by default. However, these platforms
> > also support GSI mode, which is highly preferred for certain
> > peripherals like SPI touchscreens to improve performance.
>
> This needs a rebase against my current branch.

Please ignore this patch. After discussion[1], let us keep using the
fifo_disabled variable to determine the mode.

[1]: https://lore.kernel.org/linux-arm-msm/94956a19-153f-4bce-a824-7608bbff=
c98a@oss.qualcomm.com

Best wishes,
Pengyu
