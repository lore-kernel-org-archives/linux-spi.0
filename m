Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A72857FA
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506382; cv=none; b=CODNlhrIvjJg0schLP/emBttqwbjKhRUGn5PYV6Fk/5ocOI2VRgGfJpHKVGBhVsS3klEiejFU2KVxMu11fgrS2UNixINLjrP1c9arRvR/k9NRJb7rD8Z5LLNpdW/YH5bCq9U1p3njlcKhDAJh/C/BCxiXdQol+haHdeJzuFO+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506382; c=relaxed/simple;
	bh=nd4756Hy+92ohyhREHEr2ehaES7a+HF9kecPSnYoKRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QP4vWggYo17CwbzWHNFGwW2UREP8bISy/QMGBF73vbKrbbqTs+pR+qUfeq1UHNxbx/MyxYFhs5i0ceOwAM2KO6JkqB01ZmtBLFTRy8yKjrGcN52AH0dh8o8PjN6Uh1bVU3weZ/crfQ+TLHaxih4UwM8Z8EBE00+bAURjPjickTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE7CFeis; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE7CFeis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E45CC19425
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 09:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769506382;
	bh=nd4756Hy+92ohyhREHEr2ehaES7a+HF9kecPSnYoKRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YE7CFeisMQEDa4GHg+bPiEJyJ0Q7ZuLklQ1xKzDlSxVWqiTIK4LuhPgwyZM9t/MbT
	 zpRNV0uMDOCX+378B7EuKF9f2mnvmfakHm2//GzQwJXdoMl8rNfcFmGa+XyFaE7iWv
	 ZUFL+WMoHzMWG8anN+w9xJgaNwtF47i0FKeYhP6dc9pc4fZXdNlcDWXONHqlEXcLvd
	 DtzQOSSYfSfxOJBgbFriiVOzkiwJfs9IRcf30SwLbgext1H5mrbbDcU/jP2UYC06XM
	 fbacuZ8rfQl404DIK/J0rIh5Eb9tsa/KJZKD2GrtHT3Ftaoy8oD8DagtzYZIvL2Hpu
	 8hGRZkrI/Eygg==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78fc0f33998so50514127b3.0
        for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 01:33:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/IGgrrDWYjfeZUQ8uFvFaAuZi2RLdMnYcUlRbWYDttSsSVN3K9b4TZxOsshOx318bR4VOFkiO4zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy1ZQ5I4tyuM6lSN5SVumB/aRucfIlNQgRwjTsa1GYemSy1hIs
	YmTCk/SpgigjNa6pWJCgoNWVqBnZzI1CpIdWTlKR538jfnikA32oYRvRRfKvUGbPqSGd+9fjWVO
	mXUVGNOzqhEHbMk9Cd54WabkfzrRVmkk=
X-Received: by 2002:a05:690c:fd1:b0:794:78ad:470d with SMTP id
 00721157ae682-7947ab40c1fmr16169877b3.27.1769506376440; Tue, 27 Jan 2026
 01:32:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115114021.111324-1-robert.marko@sartura.hr> <20260115114021.111324-7-robert.marko@sartura.hr>
In-Reply-To: <20260115114021.111324-7-robert.marko@sartura.hr>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 27 Jan 2026 10:32:45 +0100
X-Gmail-Original-Message-ID: <CAD++jLn3pP4cdB3h5KN04Pn_v+XuvK6ROuxpNfJVhSRJpo2FUQ@mail.gmail.com>
X-Gm-Features: AZwV_QjPaAf4YpNWpzKIxLTu_1dAPvSU-dSWNUWnEkSR0mawzeMGDcKYjAjufcE
Message-ID: <CAD++jLn3pP4cdB3h5KN04Pn_v+XuvK6ROuxpNfJVhSRJpo2FUQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] dt-bindings: pinctrl: pinctrl-microchip-sgpio:
 add LAN969x
To: Robert Marko <robert.marko@sartura.hr>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, herbert@gondor.apana.org.au, davem@davemloft.net, 
	lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Steen.Hegelund@microchip.com, daniel.machon@microchip.com, 
	UNGLinuxDriver@microchip.com, olivia@selenic.com, richard.genoud@bootlin.com, 
	radu_nicolae.pirea@upb.ro, gregkh@linuxfoundation.org, 
	richardcochran@gmail.com, horatiu.vultur@microchip.com, 
	Ryan.Wanner@microchip.com, tudor.ambarus@linaro.org, 
	kavyasree.kotagiri@microchip.com, lars.povlsen@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-serial@vger.kernel.org, luka.perkov@sartura.hr, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 12:41=E2=80=AFPM Robert Marko <robert.marko@sartura=
.hr> wrote:

> Document LAN969x compatibles for SGPIO.
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

This patch 6/11 applied to the pinctrl tree!

Yours,
Linus Walleij
