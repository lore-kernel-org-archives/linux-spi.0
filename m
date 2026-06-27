Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91565258CE7
	for <linux-spi@vger.kernel.org>; Sat, 27 Jun 2026 05:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782537820; cv=pass; b=T4frgZGRhhz0i3T7E9tYXuED4QQSj66T6b0sTDJcXuH7pWWL1yYsByiaPJa7aPy4vmzBVBDMuXhsHwP7wVx4qu0madS2HYxjvGhRcaxbTIqtZQb2ommMasBAmaTNiXNljHGywicHR1nVZOKEhX5LjKRpiPgrzdefV554S5+7BPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782537820; c=relaxed/simple;
	bh=jsTJV3XTeyptIuiFlh+MCtigFwZrx9dcmVg4Nn0eF9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmzzBPLBhGXn+ffNadLvBgxeCGH0FID+wbs10Jf73sE87G71c0j3eEDYfD+wRXZmq56herqrmhIby/tysmN2kbMs8R2GRRscHK3dn9+RwNp4xbHf4Rx+S6aCNKvnhqblNrkBKk9KkBKdl6zbsMTRUFtQPOJpwmGhk6j0F5B1LzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mi5qKHdF; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi5qKHdF"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-59ebb89109aso1223625e0c.1
        for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 22:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782537818; cv=none;
        d=google.com; s=arc-20260327;
        b=d8/6Clu+KewPJ4hKuUSsUsEkPEh2tPh3pa7vWB2re5jcAXbQDiDeXhZqp1bqcZNpgd
         4v+kaKhW8tjx/2ILUmVUWHzDzOkKfBTST5VNlz6Nc4PRwPAzjUEOscxjL8GAAoOQ8h3x
         EqJUZZF6w9+x8HEID1EWORh9wnbCVDWfubvzqX/wE/4RWhMN7PEX3ojXi/ATwdRbAM9Q
         ln7A9gw8b473GUq6NScECRl9TzJwFA7Gr3Dc64frWf+nr4C8/6H92nCJVMOpVS0dVvIY
         nL/1CskDfsNwRGyuBh2tXOAFHNowtBg9KxVSoeahXbLvAQUGtdx8aOgM23DyC/01L7Jh
         LV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FSvq9cc8NOpYsz4zrDlZ8UdKSCjZyhCkH7GixyxDUTw=;
        fh=bnaUcJK8yA6ESHISnoyjIIk56QuCeJFTcU2tcd3EFes=;
        b=OqHEW1HcqX82VPa1VFsa1JlRR034+E5b/8ntXT1sT9y1RM3f3jXRrZt38JEBtGTaFN
         kuv/zdtYCSx+PMLYYrLrbXPOVfa2RXrfB38rq4+XUAU58hUFNl/h6lgcrHoN1rAx+t+b
         8UoUYkHq+Z7zIjjSvV4WShUD7TF8r7IMVdbNcyPm0xk5Sz75US9MSW1KGOmSHA7TpPNG
         NRW1IuB1DylIy/GEi9avyZrsjAGIUWSyeRLeVpizNsjC7I2vQWHHPLroPKUvYIJ9eI2Q
         QXus1NK0kCowr9+jPxthsqeRvgzM6Vi5UrVREOJgTNk19OtVanDqVv8ICI6xkpP1L5Wd
         o/bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782537818; x=1783142618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSvq9cc8NOpYsz4zrDlZ8UdKSCjZyhCkH7GixyxDUTw=;
        b=mi5qKHdFbfDSLrN3dz260EsRobwuouOVmn13CfyyUbWJxw4axnJ3dFQhC0oW+gQLp4
         ICINy18OFgBkd5WaoWLjoqaANWrJrZ9MbwingrA2OI15ZEkrm+6L3f3UJrG3BkBinRhe
         vAb90FwC7xzl2bMWKnw6Yiyuj/g7seqrRMNTqG4yoPANOdj3oePXuAn/zcP0SyO+3sQI
         OkyBxB3+TVOdS2E9kbGHq09LkD5zRXz7G1O84tAZvRFqLv7OCqCKj8k38Qe2XwAyCrFv
         1OfEhXee52A4pU9Rz6+wTDisdTujZ5vbJUOVjnqSep4OJrAadWNoZcURQxqnpFv6qMxI
         AP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782537818; x=1783142618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FSvq9cc8NOpYsz4zrDlZ8UdKSCjZyhCkH7GixyxDUTw=;
        b=qJ/Ux7Yfh/8FTG2NCBUjrHHdaZ698j0kkZsVc6IMHcTFNT7tCulDAvK0hUguvmoQWW
         xpypbCKbXjKuoJf01pfBFTa9dX6KrKmejawRpq5EGKoROetCCoMuDQ2KM9zC5Nth5j4P
         jxTcdsZ6NtbcJbDVNmif1XyJqE03naPhhZbB7koUGXCnMz1wD4rM3lA8U9iQymwCqZX3
         eFCyEfH3ucwo/Y8K4xAujkDFIFqGhtacPWoo0uq+iCPAkKBDoPnP+pEtrg/2RpcFRL/M
         HrHvnEdk35gSEf21TEiULTP8G/oicK+sezpu5VASfv5gXJM6p6umhned0wI5EZ4MG4L+
         ZkGw==
X-Forwarded-Encrypted: i=1; AHgh+Rqqa3DziUYe9NrL+u83i2raeugC5CFGTS6mLFsyAX+GlWqQxJWnk9I6ZMERWo1uU0epRuwyJ1ZENqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNW3x2Fxss48Pk6J6WRafwrRA9islpIjjA74x1y19/8frSg8Il
	troPSRjOyD3h6hkJqppWd7SvYNAE7JRWE6Eg6SQKedWRf8RY//yVu3To6L0zy9E2eIOaB2QJ7vx
	JpfeEOT9T4j5tSAbHdNo7din6rVvIe/g=
X-Gm-Gg: AfdE7ckr9c0NO33Ce4dZsTdKDqQR0C9eNPjp21Hqovok5DDK5pnPZ580jX8a313GiUb
	77msoX6FvdhFYrmNGftPPKVxfQcjd+Q+v6WM80yVE/wufP3wpSIDfczuIxIMZg6imQQzKaKVpF3
	2oUK0MRAh7Z/u8X+jq6OeQ8eq12qFegMAB1ndWgUg4b9blgzVEDyLviUyUvtnKLKpU65j9yFk8u
	PynWcGqVGljxrPaXUa9J/9sywf2mzNShtA80M7F+msVExdshxremuCQSy2ExXd0M4ajWFtsDAM/
	109clJtmQfzZtrpTwDzZSDIVx3DM
X-Received: by 2002:a05:6122:1d0c:b0:59b:7fbd:39f8 with SMTP id
 71dfb90a1353d-5bd69d7d046mr4605137e0c.10.1782537818557; Fri, 26 Jun 2026
 22:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
 <20260614083424.464132-2-mitltlatltl@gmail.com> <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
 <CAH2e8h5Swn2mWoz+t_nrSw1=hQttwi1Hx=dg=cd9S3QRnHjpSQ@mail.gmail.com>
 <3451facc-4a2e-43bf-ba13-944488bce437@oss.qualcomm.com> <14491fd8-f785-4404-878b-5764bb8fd593@oss.qualcomm.com>
 <c22f82e1-65a8-4472-924d-91908f4d6104@oss.qualcomm.com>
In-Reply-To: <c22f82e1-65a8-4472-924d-91908f4d6104@oss.qualcomm.com>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Sat, 27 Jun 2026 13:22:12 +0800
X-Gm-Features: AVVi8CfrwkCaZZLoTfnJoyzeKn04AJD8vvCiej82z8jd-tcuH5ak3SMX7LH55bc
Message-ID: <CAH2e8h52YaKNHvX11HheFAK9XJT9KREQrQ115AOEOJS22UWV9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 11:34=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 6/25/26 11:06 AM, Mukesh Savaliya wrote:
> > Hi Konrad, sorry for late response.
> >
> > On 6/15/2026 5:12 PM, Konrad Dybcio wrote:
> >> On 6/15/26 6:25 AM, Pengyu Luo wrote:
> >>> On Mon, Jun 15, 2026 at 5:18=E2=80=AFAM Dmitry Baryshkov
> >>> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >>>>
> >>>> On Sun, Jun 14, 2026 at 04:34:24PM +0800, Pengyu Luo wrote:
> >>>>> Some devices (such as gaokun3) do not disable FIFO mode, causing th=
e
> >>>>> driver to fallback to FIFO mode by default. However, these platform=
s
> >>>>> also support GSI mode, which is highly preferred for certain
> >>>>> peripherals like SPI touchscreens to improve performance.
> >>>>>
> >>>>> Introduce the "qcom,force-gsi-mode" device property to hint and for=
ce
> >>>>> the controller into GSI mode during initialization.
> >>>>
> >>>> Ideally, this should be decided by the SPI controller based on the
> >>>> requirements. Another option would be to prefer GSI for all transfer=
s if
> >>>> it is available, ignoring the FIFO even if it is not disabled.
> >>>>
> >>>
> >>> I have read reviews. Can we check if the compatible
> >>> "qcom,sm6350-gpi-dma" is in DT? If the gpi dma controller is
> >>> presented, then we enable GSI mode.
> >>
> >>
> >> This hunk is very odd:
> >>
> >> /*
> >>   * in case of failure to get gpi dma channel, we can still do the
> >>   * FIFO mode, so fallthrough
> >>   */
> >> dev_warn(mas->dev, "FIFO mode disabled, but couldn't get DMA, fall bac=
k to FIFO mode\n");
> >>
> >> In my understanding, GSI DMA mode is always preferable. +Mukesh, do
> >> you have any insights?
> >>
> > GSI mode is preferable but if for some reason it fails, we try to conti=
nue with the FIFO mode. Just fallback mechanism.
>
> So, would making GSI the default and FIFO the fallback option
> sound good?
>

Yes, I have sent v2, please check here
https://lore.kernel.org/linux-arm-msm/20260616122605.668908-1-mitltlatltl@g=
mail.com

Best wishes,
Pengyu

> Konrad
>
