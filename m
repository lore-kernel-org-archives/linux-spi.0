Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B330BB94;
	Mon, 23 Mar 2026 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291482; cv=none; b=IQFGmQvPLWSBNCsFCnSMvpPd8TFm9LttabsXYEY9vyYC5/8PeFoPLjqZPKnuyv2SIGUkOuPSTsSApg6rqjIjuOOysKM9e+wc9p9dm6ulzgnbhENK6TCABQuGWxbTg8WTKRipIhni4GPeZpbvbMdOCjzfA+DY1hIt8ClLZZdu/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291482; c=relaxed/simple;
	bh=Dn5+X9swRHxo2TC8jXDasPdbY30DmJ38OgWWE9nMB2g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=enOqXn6ZFkD6zTZcOscQp7WnDs2pyaD990v52GN02CfVUz2Q67OYwUdFcHC4WnkHzamdoG8i3T07MRlxzg6YZbGZ9j0p16g8pEmVxjyijk94FAqCwXiCtUuM9ZDYsHiSveRPKlZSxTeMQ8eJXW/my0HzU8W2RRUHM1HUyipQiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=keknuT9z; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="keknuT9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774291464; x=1774896264; i=markus.elfring@web.de;
	bh=Dn5+X9swRHxo2TC8jXDasPdbY30DmJ38OgWWE9nMB2g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=keknuT9zrHgyJy6sjxCov97a1NJC6r4bT8VRwkLh88eo/7qACNJoAMSRLkXB31fE
	 oaqaj/KY6/6wPh99LVeZA//Rw+fhRTDLCLG6KAFAKIOnIT67zTGSaXdNUnemR3iZZ
	 JKVu2sSLucxNGX65cE4o5bv8GX+VCF5V1X6D9BiPpVUnJOvaQXzYnoZ1svFPOD1Ne
	 NQ8Ax4kAEz5m1XSPlbvPTZUcdlro8oVlvk7NepQGJqV6R06o/bjcE84wuAhdUy4tM
	 xfytAcMtbTBJmlOVqVmzSr67mQLrzGF79rWf0Ndag3LkCSsMFWZvNrmB3+ig+oZM/
	 9WzmhOrWDqebJ4SXrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McIgY-1vYhpU10Em-00hqMJ; Mon, 23
 Mar 2026 19:44:24 +0100
Message-ID: <47bd50c8-28ce-45a5-ac88-2167b8ec2baf@web.de>
Date: Mon, 23 Mar 2026 19:44:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Felix Gu <ustc.gu@gmail.com>, linux-spi@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dongliang Mu <mudongliangabcd@gmail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Johan Hovold <johan@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <CAN4SLj0P1pAAMBbuWhbnjfwqd-5bwsNroeMzghv0P0Y_myUSqg@mail.gmail.com>
Subject: Re: spi: meson-spicc: Fix double-put in remove path
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAN4SLj0P1pAAMBbuWhbnjfwqd-5bwsNroeMzghv0P0Y_myUSqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LCd0RfB9vhASNvEySLwNRXlv7ilsszIhvFlAnXEhbvoJnw/QGt2
 gLNqMUXt3ChWpjksa94mzvUW2vtYrkPad+vx/qqqVYtkQogeJDZGg+nJEWmHUkyo4C34dsN
 6TTPIfoHYj82SHb1mmcH0vB2UX3uY1VpopeTBWj6uHYZIpasUAADr3iHnks1YIyBDkGySeb
 DY+TiBi1/yXMMYIcf4H6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AFnFgveWxtY=;3S98WRLlftMIIQyByrRv/qCTczu
 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

> Just code review, I have fixed a similar one before.

Can such information mean also that any source code search approaches
would be involved here?
https://en.wikipedia.org/wiki/Code_review

Regards,
Markus
