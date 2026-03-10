Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD742DFFD;
	Tue, 10 Mar 2026 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135243; cv=none; b=LNbjxYctgmWInfd/WKFphbUoEhHnnWH1HZ9qHAYXJ9L1fDiHgtAJ9AUW2g5Ab6LHMA5l7JkWoz4ty9VCg8yWjNnH99JDcPlo96fxGJ5BHvNiNfljPmdxVbwUt2vV+WHCUwAXKrBq4VjdbMYqRVj3QMznURjKnPWRljtG3nkhh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135243; c=relaxed/simple;
	bh=9P2r8/eYz/c5QV4sFMCbhYWSs0OMh7V/WsQ9lQNNiiE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=d26/W6s3CDfjuu1WFT3iRdrmlK368/YIIP902SyVpBqcUf4IMRmlg2bbgKrRIS1PggasGFmZyNHMOscifBeGwX9eBaDBdq10j+F3OEzcerftpq+ePNjdOwTOjxikdlZzdL445cnqxqpzYbyoioR49GWD2rIaoqPNeLFwsMPI75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BcrJO7Nx; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BcrJO7Nx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773135215; x=1773740015; i=markus.elfring@web.de;
	bh=gtAKY3v431qqeWUjD++I1TP6i0kJW8buNjRiUxF1sy8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BcrJO7NxugS6+JlLp8RC2uNTv9AbjXnIdRlIoIeJ2t/Yk9uqSFLFi1UdtG5ri9tg
	 fc7MxPiHIPkT1oDx6GkYz0Wk8DP13AP0SA0rq1IjdOby4hmpN9yPNB+0iyV7m9Shl
	 GI3iX05ekUYJQjaxTd6fqr40nY9N4c6qpZn5AiY3JOExf+Do1zqMvQo1IOspyg+qN
	 c/DAJFb4PYKSrmD5AgIWHH75OtwQjvkhu9sLwFwP1CSbBUq9nivjaDHxxGHBdBmZA
	 tV26DlezGxxJTWY6+U3cqcOn8DUHS82fLAJdLUIEvO1muzNR7RK7XHxaY4YDCpfLw
	 m5a4QGbdbbPWXsq8Ng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtyA4-1venFC3sXE-012FPH; Tue, 10
 Mar 2026 10:33:34 +0100
Message-ID: <6af3368d-cf12-437e-adba-3e8a56dc19ee@web.de>
Date: Tue, 10 Mar 2026 10:33:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Felix Gu <ustc.gu@gmail.com>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alejandro Colomar <alx@kernel.org>,
 Harshit Shah <hshah@axiado.com>, Mark Brown <broonie@kernel.org>,
 Prasad Bolisetty <pbolisetty@axiado.com>, Swark Yang <syang@axiado.com>,
 Tzu-Hao Wei <twei@axiado.com>, Vladimir Moravcevic <vmoravcevic@axiado.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260307-axiado-1-v1-1-e90aa1b6dd9b@gmail.com>
Subject: Re: [PATCH] spi: axiado: Remove redundant pm_runtime_mark_last_busy()
 call
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260307-axiado-1-v1-1-e90aa1b6dd9b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Li34vvZ8XoqBbYAtYckdDrAi3TlFD/bPuIhMK3UnW4JnMVVTcP
 zLKg/BakcxsxB3M6SlPgdhy6xt2PWAjFkAnJMDQEyHwIq5lyOP6/Ts+45fxVypbOZQjggCk
 sugMZyYmsprVv+2Q46MkrIl5eI2wjDnaZShDUyaJPxrMVp0d/4Zek+yW94NKqTIvCoxAJJj
 QcILqiRgVPDGDSfDyy+hw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c9hesAzB+0c=;OqexhA+RSNFUGHlYTTdUwEwMKqz
 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

=E2=80=A6
> +++ b/drivers/spi/spi-axiado.c
> @@ -850,7 +850,6 @@ static int ax_spi_probe(struct platform_device *pdev=
)
> =20
>  	ctlr->bits_per_word_mask =3D SPI_BPW_MASK(8);
> =20
> -	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
> =20
>  	ctlr->mem_ops =3D &ax_spi_mem_ops;

How do you think about to construct another coccicheck script
for such a source code transformation pattern?
https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/pm_runtime.=
h#L579-L603

Regards,
Markus
