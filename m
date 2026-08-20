Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02131400987;
	Thu, 20 Aug 2026 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219328; cv=none; b=csqUBuIuwYRY3AJ07V1iXC6uCz3YHCWg6sKORBB59mVlrMJueb54ikmn2Fzbo8A3+NrMKgygf3RwXE2lnHGwqoh/b2a77qyaBK5fTiYuijUXLAHS73ndnT0YRcVFwAMz8RJ6A5SnXuJa3I749u4clvMcXEeMsklJTuXacO1OLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219328; c=relaxed/simple;
	bh=a18KyH6H01sOl1bzKlwrYL1Mn9ZU9a1itJplFHKILKs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QhtZMZIf8gnuAxqNbF3q/K5VYfuZA3LV96X1u8WtjqdO3ufTcwtMbF5Lnnp31bCaqysfUFEobKzPeh0T2IRPJ0UqZNGeXScqaUUeNrpiVRtcAR7CpCSDu58nvBeojVHaKX6EEZD7RGA0bUWpdanu+1YFauwhKA4p/zX64XuSW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kHavTfqu; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kHavTfqu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787219311; x=1787824111; i=markus.elfring@web.de;
	bh=a18KyH6H01sOl1bzKlwrYL1Mn9ZU9a1itJplFHKILKs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kHavTfqurZDTKRP7nX6ae1iMNZpZQlc4vV2Ygkqk9rgCRcH8zFcAEcxoZG/yqOMH
	 FTHl0slBPId2rUdx+LdKIBnMsSdPc3KUCQ4OTWSRIP1Yo3WvcN7tHDj1Q6DFITUYV
	 UAEZgIB+TqtNliV2YwzcUMqPjPF5wVq1fYY1Wl+efCEPypI0kGXY4eVCXj8OAsCIi
	 iF1f0kxM1Ic8eKhqUJDop9ylm88U4oGxzoYBriR3iYJvG2+dy0xjRLwVBIZqIsGYX
	 BGB9JYtSxzgww+bpQx82Q9Z1wP8Qortr/gIsvGGh7t/ka2IlIYfbidmMzh2Rao7og
	 2zkEXTavjImGYoWrMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1wkgjL1dHg-015YM2; Thu, 20
 Aug 2026 11:48:31 +0200
Message-ID: <077cb359-2da0-448e-8d89-2fefdb89ecc7@web.de>
Date: Thu, 20 Aug 2026 11:48:29 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: 1298662399@qq.com, linux-spi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <tencent_DD16C0EEDFEF4ACAFAB5A23EC8235D462707@qq.com>
Subject: Re: [PATCH] spi: rockchip-sfc: disable runtime PM in remove
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_DD16C0EEDFEF4ACAFAB5A23EC8235D462707@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gen+E7yeMdFUfJ9mPCYVDm1AnZ8HoY/s1Z7Pe26sNtyYyX8mJcc
 07wSsbKQA3Lb537B5Gq9/Ggti7wQ9DZwamtObL86zMs0FDrgnfocx/OghoL55OqOnVt+8qd
 prOFHiH8QYcC4coP1xduAEJG0dQFhDSpWwAe/sSJM4BAnSMLBXzLdBJ63fu8A/YzIJKYw35
 zO8XLM4wboV9uMeziGXWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YEk+TwUSoRY=;uRBTq8oqPi2GzpIkQ+eJOAiqH8b
 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
 UQ8jeVDdtGY=

=E2=80=A6
> Add the missing runtime PM teardown in rockchip_sfc_remove to balance
> the probe's enable and get_noresume calls.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n145
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n792

Regards,
Markus
