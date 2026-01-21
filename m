Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F912449ED4;
	Wed, 21 Jan 2026 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991843; cv=none; b=Mf5/8BNM4vmvhwrOf8h23kgodEe1xQAcx0ap0bhtsg7oU8E813K1xSiM0xfqb2MLpNGCFwcROVghi9sVjf+cY9WKmWTt/IyJhx3wQYllVwVsijTGLGT/MouLxVJX2c7sL5/YK2dIN7HE3lmjQ6AOw+4Whts3l4Wgi9PytKsUano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991843; c=relaxed/simple;
	bh=WMaAUk1EfI7ooHIwGV6RP5sBlsnh1OcI2KfxvXW3EFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XVuazEJzc6mUmjDsd6Lzg9mjw9fzVXs6fQX+jUV/QplBkn9rqzetmCm4i6LymtcLs/Y9+v6wkSuyM0u8Pf+mI+TjYBHD9Z3rhFygXgBjjw7U2Vs3Lo75szo8KdI2lMr1B7BVj2EFCHPuWAGU2u9+i8C236ftum4jpUbWAu4Ucwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YnETTcoJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YnETTcoJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7794F1A29A3;
	Wed, 21 Jan 2026 10:37:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49A456070A;
	Wed, 21 Jan 2026 10:37:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E1F1119B026D;
	Wed, 21 Jan 2026 11:37:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768991837; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6EsQwF/hwl3IB1yOTfBWqtGUGtEW6jUb20ElOVpjjo8=;
	b=YnETTcoJrRrw/Qrrfn7KIVHLY9isvr2jZOoYs0lh0T8YnAEwQJBsNJ0jwsM6JDS1tYSweI
	1vQ3/WR8okzEhpw36G5gTJuc/JzwmWroTWXq1XWg2xqmpGx765PVFnABVs9VfH3v7M1dtk
	KDWiSv6LjeG0sxE7lfNrpYC0QR9pNtMgRo4fhJAGBKSsWn8RW9nbpp8/RBxzHyxnY0Hrft
	sh34s/ne+4PJDwj8WA+EgsCMLHtIHJTlVGC0YRAtwZdm4W3WT6jgE6I+leVKj5QBF3IyzG
	kQurnmohAuh+NrhuzwZEA+pX+h44jgTo3axrS7ABNT5liGU4t1diQdJxA3D/+A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: "Mark Brown" <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,
  "Krzysztof Kozlowski" <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  "Geert Uytterhoeven" <geert+renesas@glider.be>,
  Magnus Damm <magnus.damm@gmail.com>,  Vaishnav Achath
 <vaishnav.a@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  =?utf-8?Q?Herv=C3=A9?= Codina <herve.codina@bootlin.com>,  Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,  Pascal Eberhard
 <pascal.eberhard@se.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 00/13] spi: cadence-qspi: Add Renesas RZ/N1 support
In-Reply-To: <87cy34s4sg.fsf@bootlin.com> (Miquel Raynal's message of "Tue, 20
	Jan 2026 16:05:35 +0100")
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
	<80e7a578-4636-48bd-b92b-54fa33cc076d@ti.com>
	<87cy34s4sg.fsf@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 21 Jan 2026 11:37:13 +0100
Message-ID: <87sebzqmjq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

>> Thank you for the series! Tested it on TI's AM62A SK with
>> OSPI NAND (Winbond's W35N01JW).
>>
>> Controller fails to probe with the following message:
>>
>> [    1.868863] cadence-qspi fc40000.spi: Cannot claim mandatory QSPI ref
>> clock.
>
> Strange, I was nonetheless careful not to change the existing
> behaviour on other SoCs. I have that board, I will give it a try.

I made a mistake with the clk_bulk_* API data indeed. probe now succeeds
with both my custom board and the AM62a7 LP SK. v3 coming soon.

Thanks,
Miqu=C3=A8l
