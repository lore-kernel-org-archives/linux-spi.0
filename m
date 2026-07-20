Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A403FBB7D
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547805; cv=pass; b=s66XFCS5V0p5Mr2nioVFWhqNmJZgGNnmC/6ao2bb2KyAP8gP61rSreKaBH6JK5HU5UJu6nHOQszLmqDi8lzuQza/ZnZ+QYRpY6bhO0w8SocTz5MQ1/w2W9zcg0VDYQMT/O3nBWsapfYC5QmFsJMDQIFOpfdCMiu4wknfGUOu88g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547805; c=relaxed/simple;
	bh=fdtWv+prESztRJE+/K3wcrpe+upv+fIpI0YZYMbpZeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQH9gEk+fTmpCprBGx7CGds0rfrFPlShJNqIrIhZyy4iquPsV7y7MYuAPZlmXBQ5C7nVH4P9kT27zvdYvlVwk3ChnfPFsAS5XxjEnRx8yV2AAZ/f9V223h605vRHPu0YbWH5Ms4pRdnOLxH0LPHEZt5hcBGgRj9mWtf4edvtvQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipvHfziF; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipvHfziF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495437bb891so29176705e9.1
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 04:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784547800; cv=none;
        d=google.com; s=arc-20260327;
        b=Q+ScVwq3cLLI0McUojKNX0cpnQPczqiNw71avm+dicYSlym33mpMg2s1Ysh1pyyk+Y
         hSSY/4YHEhGogNBLOxNWLREZdI2TglSyCugsFvDrhjiFnK47WMgDZnXJJ8+eIXGC/jHU
         MPB4jfylg8Z+0lxw9t2VG+gLIQHcrYAIjsmyLxpnYEahVoQUIIPUj+OrGXm+a7/lZMLl
         Xe7Vd3Ku32aiwXGQQhCriVxuZZTOYtIpcWXVB8x7sWo0frl8skSXpc878sZSqzJNdRow
         LPV9ZarHypVUp+WQmkrY8HC8uhBb7co2K6GNeJem4Wrholv80ukg/yaWo8L5A4FP9YuO
         tfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fdtWv+prESztRJE+/K3wcrpe+upv+fIpI0YZYMbpZeg=;
        fh=frSp0kUrOvpnEdO7vXe37LM/ZxbhgtWzguMB4HPx5h8=;
        b=YkBvCpxItE6wqk5N1QyzQUyQMU6UJYKV2bFXUIFb3BBgBrQvVuFeYpNMt7UKgUcl4R
         S83UPjGpDG/L+COCY3ey5CtiEEus1a38KE6Eg5V6WwuBlGAbUqhvZV/p+or/KUwrs/23
         zKmUlu8gaiFBuaC6wh+A2Y7XNP7oMY4hJpkaIAFst0yFuq7mN0xLjHBHYhfeaYOnu6TN
         XAdQ7y/H2qVXYsyNhknfo48L+le4dZzmT1TWSUFk8ov6jqBJuPptsC+fZ9Mh4CVNCNQr
         m6GBnCumdR+4Nnwsulhp9L5BhYz4+Pj5AsJU046gXV4YWskLv8tJTycrAsjtjPPX/+IB
         N6eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784547800; x=1785152600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fdtWv+prESztRJE+/K3wcrpe+upv+fIpI0YZYMbpZeg=;
        b=ipvHfziFb88BeNwLCAorVsFn0dU/ZRgXpR9MPnpyblN5Tl4iu1SMIXoAw7/qDQy4Pv
         ZmB2nLONVeAr/OPMJHLw7tBbK+THtvzfN8y79OHvtRWCLi4uyH4wNk40ePx6qw8ZyMfw
         60tX7+OIKd6XbS4yQO+ElGERRqdjX5IAbyuNQLpOSm9BJTMbAQ2GoSAnlY1FuMkLBQXI
         6jIBuKfHXlRh+p7FX8niwZ/kZHE84yKTfx+vWmVIVJSqTzxrjdRpOx/96ihUFG1xaZpL
         0PFF7B7NvhoRpE1OuZu4vuwQk4UzQ2dWx23QeTf4rInyoqBfKqKCuodJFRzKG6VEclPb
         /4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547800; x=1785152600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdtWv+prESztRJE+/K3wcrpe+upv+fIpI0YZYMbpZeg=;
        b=KRETLPTHMRh8vWgPLQX2bH2CL35P5Kt5oGAZxlzkcQUuZU5a6T0WEdJPEfSeQ9BKle
         TBlAbv9inAP4Xlqd2FDhCHj0MXa7RKA3k9iM5rB2EbtuZgyBvcsnsmIkGzj/3ulLernT
         IwmDjNo3v9tjkia2Ouayq7ulmPHLftmIFJlfg8xlvHqbaGzIw40INvgXxpJHdfADLV41
         ffMAGjZ6Uwd2WYjDhBxv6w2jKKni1OU7luQKIUYlLzdiNOpJ4z+AoEKlafXM6uSoHQM2
         t3I7ZO1sqiMIzUFeyabFf9vY86ArpiGHHYZT3lxCvuOKoyFnO5cWh1DaSuhERftXEn4n
         /DiQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFFKMEoZVtqsAZ/KTQOi5U5b89yeLerIXwDC3cw4CDkafyKa5vywuR9vD8JUzT+XMHmYcMHVO+h6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhJ7skr+8BjVe0iltzkJrn6Y7pNEMmF2TjAaiFewIyX9RrO2j
	sDTfw/yIgW/oQlQOACMLRkyBK8g8Hwtx3wo59vubYZasoXVldt/MOauL2M42vVj1rKQfJVwbAo0
	s5aDSX2k7z/4D/i8yuzOqI6vb43oNdgw=
X-Gm-Gg: AfdE7cmg4Ni/ry4qFgMyWVjwKZVhuAgNl1Y+BkgKORzicxkXz4yo0U4UacPZm1ZnEk8
	c+LXBVlHY0W1+d4Ars9GB/5IHcfIdAkin9DZnhSe8RZoXLOr3+NDzXxJFPoeJJhljKTp+0iMQcZ
	sV8MiJqeIeMBBJwSZgrsFNkHX4NHUnE3Dq9jjkuCcpkJw/OpdOVzYiW3uJJJp63v162O4drvGLq
	xfV5kmBvotaP6sfuOYJR306OeBTVTKEqB14p9KMJsNVoiWeABYjGp2Qss3VksfFY3oF/aWNvdsK
	Y56BKG+ayBJpy8jQb7Ljoy7Q/+kufaTvLLtZJbCqsiiuTMYR/aeYa2oqlw==
X-Received: by 2002:a05:600c:3485:b0:495:6193:c6c0 with SMTP id
 5b1f17b1804b1-49561a30bb3mr23882765e9.18.1784547800422; Mon, 20 Jul 2026
 04:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <d2213a9b-9a12-4ebd-beee-9385ee4e77e7@kernel.org>
In-Reply-To: <d2213a9b-9a12-4ebd-beee-9385ee4e77e7@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 20 Jul 2026 12:42:54 +0100
X-Gm-Features: AUfX_mzY7bY49TGWSRlukzBkDBBtD47hjKyYIuJbD-DXbsbN1rg6kSUis-qm_Hk
Message-ID: <CA+V-a8taF4U7QD7N4gQZWAOC+vSuTpxgk9OJhqd28NtN9SmDLQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] memory: renesas-rpc-if: Optimize transfer overhead
 and implement runtime PM autosuspend
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Sun, Jul 19, 2026 at 3:42=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 16/07/2026 00:24, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Hi all,
> >
> > This patch series optimizes the Renesas RPC-IF driver by significantly
> > reducing software overhead in both the direct memory-mapped (dirmap) an=
d
> > manual transfer paths, maximizing transaction throughput, and introduci=
ng
> > runtime PM autosuspend to prevent aggressive power gating during
> > consecutive flash operations.
>
> Why is spi patch in the middle of the set without any explanation of
> merging dependencies/order?
>
The rpc-if core driver acts as the low-level controller wrapper used
by spi-rpc-if. In this series, autosuspend is enabled in the SPI
driver, while the corresponding pm_runtime_put_autosuspend() calls are
added in the core wrapper driver.

Apologies for missing this explanation in the cover letter. Since
these changes do not break build or runtime bisectability if applied
independently, the rpc-if and spi-rpc-if patches can safely go through
separate maintainer trees.

Mark has already Acked the SPI patch. I will check if he is OK with
the SPI driver changes going via the memory tree. If not, I will
update the cover letter and split the patches up to send them
separately in v2.

Cheers,
Prabhakar
