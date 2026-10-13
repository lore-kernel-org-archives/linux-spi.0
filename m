Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331754146B
	for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930377; cv=pass; b=G/ez+3wJ/qfK7M+1yk1WNAvieKUToy3HdgPVeuCju2nqzF6AJ5vGbJXuxhRkSs4gXHU3UUE4nH4lj+tRieyVow6VNKMOcWvh/q5RjjAb/cWJWJhnWqpmDqpc6HYhsgzuSSj5i7TSyV5abk7nneiLxGmHhDl9MKeOrNci6bWS4gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930377; c=relaxed/simple;
	bh=LHKyaN6WUugoUSp5MeLqyUxtlolwPgBXkaD5KlRFm9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCtWwfPgcnl/vGY24fIOhLPR9KoBULnqMNVleS6qdcbW4cTMAPgZXxEaPvLgSPPXeCC3hL2LPV8lpFVrF3L60VIUbwqCOIYphkxnzG3udc8AmQrrIJBZIvuxFBX1gzdnP+ur5E++wpN9BE+6jrxiTPrG1L/TGb0jdztQRuIm5iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C4/6EXUW; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C4/6EXUW"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b0a36f1c95so4535797b3.2
        for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 15:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791930374; cv=none;
        d=google.com; s=arc-20260327;
        b=df1kBceXTVls/8xezEzitH0XSAeHxntY0OdkdIbSHvxdNkEAxBOhnOzz7D1SB38Wwu
         2jEj9T5WBEW8gc8U8fI9zd9CG0989rnkewI0+Fn1LW93ZbLoRW+pTFkoOoG6KddBvXkm
         ou+z1qTa3aCkxBKZjYRm3RDEStYsEuXxnRZsTsFyYxBboKH6V6X+aaoFC6PX8FpMeFSu
         CzfbywIdTcREYMJ4mB105vkYn6Nb6rBPoTc1m7kcBWenPEkenYWEHZLcspzy3tj3jnrV
         xGrUS4S5QvaxP+9Q6Scob1TNMkOEQ/kTjhdQPoKcyx03T7HaKHlaHCMKvkzaA2nWQ3zV
         9fLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JGIvE55pEcxzd83xA7rFdHteLp03z04heYvMOT2YxDg=;
        fh=iY8ZCMGzMujTHNiNRAAAckc2aH18h1az4RQAIGyFuMQ=;
        b=SgpsjFl20eVQ8pGO131Yp7cbf+xugO82zEzLLBQv/sJs6JAL6Vj7vHUPsnQqky7dgU
         JZ9qyCFpo4bgbkG+Tsp54Z0FCbhMb9XcBV+tBcUVsPSltuShuEC2L+NvFUYVNVTN5Fra
         6eJXTf/iPG9ZdSEJ6wsv0PT9ZSkAtgjTNkYCYgYhtvG5fh3MD42V3UHjOb+DlxK1Q8C9
         Z6Hradjf7v3a3YdysEKDAXzOxb2MSgGoeVagUiFI+CRXhg9LKRBUPQbk8YmKICeDZuXf
         zlL8b/BLMuu7gztjr5NlnlRXcR1QA7B36VBYFZ8GtdSa+IZyqzGu9Dq//IMxX8IQo61L
         t8nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791930374; x=1792535174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JGIvE55pEcxzd83xA7rFdHteLp03z04heYvMOT2YxDg=;
        b=C4/6EXUWLqwBThAGo1onKkHW2BxZrd15xJmVGIULHYLY1nPFF5hv2mrrYcUkuA7RR8
         IhUjXjBsCxcolz6CV0dg8XhSVmMve/TAn8Iev1d7tXkENPi2R8sDAr89/T1YBI130YKh
         IcS6Ly+tY/cTuvFj2Cbai7MhyVANyndbphs84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930374; x=1792535174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JGIvE55pEcxzd83xA7rFdHteLp03z04heYvMOT2YxDg=;
        b=I8+vO71c6bEYfOHfFkk7omiEZEqZykA/pbfi098qvinAPlFuMMD4chCxaJACeJj1N8
         9roce6qHBojRbi7hukJpFJjjRvGV36wRgajL6Wb+lCe585gBwpX8ofhfjNZeCB6iZawm
         pCmSp5jKH1EwOZ+BMjF60I83QlR9OxpSPCIwKESBB/mSrljtKmP6qU1ckvw0L9q7kK6m
         CahN76i5IDuQd7tlFJUWo8jkyukscweg9uZXuj6jixMPCD7i3LxnzEiWhkWyv8aabk+5
         5WRf+QHG85NEhoVFDkdXwfaJJVkcw71iE3O8JfwRV1CwkYBUpH2TFD7c0adf1W6EvXs5
         nlvg==
X-Forwarded-Encrypted: i=1; AKwUvBxGdeDZgmUWzEZAhzQXQpmeTX0VS1so4uKQoH5fAddVXLFNJq9vSooki++t/H7Vntua6laywf+jCWk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTEjyYlFDdRWswsPsNNEvUdLW0qKajehRGxghVpcuPVHc8Ql4K
	gI5FUg3EXcg1TWU3R14LY7N3d/4hhselHMTjCSNERDCSajZKVgsnQy4HoSrLH9MfwWoMK/qmIt5
	RFXAS13MWXrgVEo8dpXEAX9T+K1gEuiIA5h4TpsKs
X-Gm-Gg: AYBFou3XYGyck8d5KIuRJ6RNZkICgh+BPcHCRtjSSBZv3wSXiogviewBmY2/TMpAkFn
	KZfEdIxbDT/yvVq8aQzot66NJU2CL6PBDM5OeU1wErRTBEz9ke6ztUUMQG/Hg3+a2WXaJ/XtosH
	Euh9xTcW/b/t+c1jC5eTsUueOt5JPdPCEw/zjH2+dLFvEbGvUdjikUFXlVl9VBcpcXTqXYg4Ob+
	IBcf90OJASK811f0d0yW9a4ceqDqH8deIdkun9A7h66ctV0/q7jajbgVW16RqLXeFeA88SEMBOl
	X2RnRZx+RIvwon2YYA5bhw/QcW2qMtQXcgkMByrc05YjowcS4HEVoIPSXoaCU7F/DkfXUf7XEGG
	VD6yqZF+RfA==
X-Received: by 2002:a05:690c:39a:b0:8ae:8877:9ef6 with SMTP id
 00721157ae682-8b07edcf6f8mr55863427b3.10.1791930374515; Tue, 13 Oct 2026
 15:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-8-384af01da3ee@chromium.org> <aszWnnc6RR9d5SYw@monoceros>
In-Reply-To: <aszWnnc6RR9d5SYw@monoceros>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 15:26:03 -0700
X-Gm-Features: AclHuK_tyUehVA205WXB_Og5y1P8AMIMPFMlhjQ2Y9FOhmh_U9e-FbL8LEin36M
Message-ID: <CAEe3GZHB_mDcdz3gcoAzOu6mO7ua3muESOJcaZi6Z45Q8J77rQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] HID: spi-hid: add device tree support for HID
 over SPI
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, tfiga@chromium.org, 
	fqwqf@fqwqf.xyz, daleyo@gmail.com, Jarrett Schultz <jaschultz@microsoft.com>, 
	Dmitry Antipov <dmanti@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 5:49=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Fri, Oct 09, 2026 at 10:25:33PM +0000, Jingyuan Liang wrote:
> > +#include <linux/mod_devicetable.h>
> > [...]
> > +#include <linux/spi/spi.h>
>
> Drop <linux/mod_devicetable.h>, the spi header already provides the
> needed *_device_id with less dependencies.

Thank you. I will drop it in v6.

>
> > +static const struct of_device_id spi_hid_of_match[] =3D {
> > +     { .compatible =3D "hid-over-spi", .data =3D &timing_data },
> > +     {}
>
> { } please

Will fix it in v6.

>
> > +};
> > +MODULE_DEVICE_TABLE(of, spi_hid_of_match);
> > +
> > +static const struct spi_device_id spi_hid_of_id_table[] =3D {
> > +     { "hid", 0 },
> > +     { "hid-over-spi", 0 },
> > +     { }
> > +};
>
> Please use named initializers and drop the unused zeros.

Thank you. Will fix it in v6.

>
> > +MODULE_DEVICE_TABLE(spi, spi_hid_of_id_table);
> > +
> > +static struct spi_driver spi_hid_of_driver =3D {
> > +     .driver =3D {
> > +             .name   =3D "spi_hid_of",
> > +             .owner  =3D THIS_MODULE,
> > +             .of_match_table =3D spi_hid_of_match,
> > +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > +             .dev_groups =3D spi_hid_groups,
> > +     },
> > +     .probe          =3D spi_hid_of_probe,
> > +     .remove         =3D spi_hid_core_remove,
> > +     .id_table       =3D spi_hid_of_id_table,
>
> Very inconsistent alignment of =3D, if you ask me, just use a single spac=
e
> before a =3D.

Will do in v6, thanks.

>
> > +};
>
> Best regards
> Uwe
