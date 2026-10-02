Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7751433E9D
	for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934776; cv=none; b=NF9jMMpJWF06rIG+BEuNpzIeE/gIAfbvyq6EGnUZxQdhqlTt0I1G7iUEJdqy1TIq8pODcWl33sDQtUuv8KxIYTocR9yuqTZxa5ylGMXCKTqOvEkITLIw+J8a9Hzfz8nCo6/dvtUakZymjgWCnHKh+VapjlKi9sacWBLsQIVtQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934776; c=relaxed/simple;
	bh=3QOiB6gfJSPk66j7lgrO3mGEk5KEqMDkIADm3ibJXFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/GET/HxK6AELd4uUmhWnUt60h3eQL9HDlR4HxV24E9B5ReAd6Ebsw9upeVXjfFNipq2bJ1IE1Wqt2pim52dyU2Ujh/iea49hi8lmZCxcm4DeUI1W5n4yZLWxQN370o2E/wifiVFqsVNPv9uwjcbTv+SX/KO0HFmcO0uGioV6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAmkQbIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAmkQbIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4BB1F0089C
	for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2026 09:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790934774;
	bh=3QOiB6gfJSPk66j7lgrO3mGEk5KEqMDkIADm3ibJXFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VAmkQbIf9USBTaGKnf9I2QVnY/iEEGJBP5ivpWudffbfvlrnRcMRiuflSGfVkF2XV
	 2j2FwPkeNDN3jwTDoFaGh7ky0KZ3CH5A/qFeRs2DPeGxFoV6ohxVqOUHoHj00FvxzO
	 Hn7Hr7oZ3s0WSZqzPmw+itKN/s6UWD+KDRmblPhfgUhG8PiSpQOtLqy/5qdngUzxq8
	 QvbhTxrFTOTE7cVSV0em2b6V7sgn9aKKHdQoVpI1L0lQeWlCfCYpYbrzTFKc96XE+f
	 jDfnYlvMbo69XhLauPSjsVpQnJpDQ0ikK0ehxMOOQp3yYYUH68U3dsDMsPJ7bHuNQP
	 IZt33hMbiYudQ==
Received: by mail-lr2-f33.google.com with SMTP id 38308e7fff4ca-3a894300b40so1687901fa.1
        for <linux-spi@vger.kernel.org>; Fri, 02 Oct 2026 02:52:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzzUnlMQjVX8LH9U1azKcFJKNXyTR5lddHtrPblfrxf24cN2kJjFKPsREMsRaavobT00PhnjCNFnvc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMd6RWPD+YlaF0fC9s8KKUALdSGQ3TVNcDxtRIdsbr3thkzGt6
	3OaWPcGjfqARqJ7RJtbofGnCRxSncBIQx+lVkrSSkHN3y7mSxCx8ZezHsrZUz6sDZAcaq/tQK67
	MGQPFm506lkMlrOGQAC0xMxgy/LX97u8=
X-Received: by 2002:a2e:be9c:0:b0:3a7:64cc:1a25 with SMTP id
 38308e7fff4ca-3a87ed1639amr4446421fa.2.1790934773424; Fri, 02 Oct 2026
 02:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925133804.2231004-1-yaojiale02@163.com> <TY3PR01MB11346E0C01A9337A3AF4D97DC868F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <34472b57.1961.1a0dd3dff12.Coremail.19888972804@163.com> <TY3PR01MB113461CE3C9EB4A175879F5BD868D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <1186ef64.63b1.1a0e6e70a59.Coremail.19888972804@163.com> <CAD++jLnVna-E61Z1GiKKX9G0Q+1CMq4GYi8p7vjKzeEtroAFdA@mail.gmail.com>
 <ar9WM0ZtDJD2H5Ii@ashevche-desk.local>
In-Reply-To: <ar9WM0ZtDJD2H5Ii@ashevche-desk.local>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 2 Oct 2026 11:52:41 +0200
X-Gmail-Original-Message-ID: <CAD++jL=eGjhCM8Xa=T08rPSGpH4p5dsajZa569gsObJma3yZ6g@mail.gmail.com>
X-Gm-Features: AclHuK8kPz7TbUoW6CCEvvcfkskp4xrd_nCnGgNqbP_ME_XCkVC5Hbt0cTCRagQ
Message-ID: <CAD++jL=eGjhCM8Xa=T08rPSGpH4p5dsajZa569gsObJma3yZ6g@mail.gmail.com>
Subject: Re: RE: Re:RE: [PATCH] pinctrl: mcp23s08: reject devices without
 match data
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jiale yao <19888972804@163.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 8:59=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> I believe this is the whole design of driver_override like this...
> There is an attempt to allow drivers to forbid that feature.

I guess I don't have the right background to understand
the driver_override feature, it feels someone should explain
its virtues to me because I feel I am getting really angry
at it and it may not deserve that.

The entire name of the thing feels like debugfs-footgun
territory for example.

Yours,
Linus Walleij
