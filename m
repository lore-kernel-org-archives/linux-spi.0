Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BD6312829;
	Fri, 13 Feb 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770972862; cv=none; b=FAcnGIyLPfoYnS6MlUquNl2i9Ug3ABrrawLihMzMGJA06/NDmDQ5IlJQ6g8FIFsUomYI6AfxWqx1JfXXG+4jZb3Mu81CmO8+MfYiTWsSsHAsxUl4Lgr175LmDYC/gSQww2TauoPrFp5K09Wd0St6hzVoG+j1M9ufsHZtJ99zgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770972862; c=relaxed/simple;
	bh=WfkDXFYmwC97kaq9x3OO67fq+4W/dySLiI/MkGDH91U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=eLcSDV/eKwf9/KcxK2UTtPhkeqO6L5k8lpwGd0DNrs06v3/mnGIwgWB7DenyzBto8AobHspK8+I8uTvABSwzbkH7nFWMHh+YnGogvvOEML3yiVOshts1a3cfIzRTmMR4nUDmqiFkTrIdfVLfXiwM7jTqJSMYSlxP6S9p+VglpFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=k+kxciou; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="k+kxciou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770972852; x=1771577652; i=markus.elfring@web.de;
	bh=WfkDXFYmwC97kaq9x3OO67fq+4W/dySLiI/MkGDH91U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k+kxcioumU45J2+58p83N9NN+YPfoP+x0rciR3fXGFSYWv/ywYJSrmgImM0bQPRP
	 o3YheHulBg5EWVvsaNWVfoZqkP4Mf7+eFggQpq15mBXvroFZ7lInKf73iYQzjuL82
	 shLy0WZFgRjWxL1PIUWs+zbXvx92tFgK/us0fpeetf/DGXRmj5HD6dyj6YTfeIFub
	 N6ToQqxi3bWOY+nRSRic2cVU3B09hrCJ8TKfCDATS0lBxeO33KB/ao3iSS0yJt58+
	 H6yJzkpsd4uAW4TNEJWfQafuF1q4XTulE5ARUeuxCXpGmsqZp35KsvWGF/Y8Av7S8
	 XHVyQ8vnsB7QC3g5qQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.207]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6K1l-1vkHX843XF-00wavz; Fri, 13
 Feb 2026 09:54:12 +0100
Message-ID: <c4db3d6a-b683-4b5b-943d-c0be91caad1d@web.de>
Date: Fri, 13 Feb 2026 09:54:09 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Felix Gu <ustc.gu@gmail.com>, linux-spi@vger.kernel.org,
 openbmc@lists.ozlabs.org, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>, Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260212-wpcm-v1-1-5b7c4f526aac@gmail.com>
Subject: Re: [PATCH] spi: wpcm-fiu: Fix potential NULL pointer dereference in
 wpcm_fiu_probe()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260212-wpcm-v1-1-5b7c4f526aac@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HfWVrsW+IWR2QlxFK2Pl8zGVTnNAWL/CUi9X5L1uhbrwOLPgz0F
 BcDXQ7mrl58YsDVeMpFLIiHcGPvMhiNzFnReSxLk0mHAFSxdPHR/486hBnOgjfHyRDHZ+ZZ
 /3Qsj/EiZfw1ZnSzzkFAnxdIkZnl2iXUMa54SRm9mJ/sty25/Y3zJZO1zHZkvbdR0s2BdpJ
 JBSser5ygTmGOlC96V11A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2dNkOfrNNfU=;LaBNwfhcuUnFxN/l6W4hOSGTSn1
 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
 IgmkDGCY=

> platform_get_resource_byname() can return NULL, which would cause a cras=
h
> when passed the pointer to resource_size().
>=20
> Move the fiu->memory_size assignment after the error check for
> devm_ioremap_resource() to prevent the potential NULL pointer dereferenc=
e.

Were any source code analysis tools involved here?

Regards,
Markus
