Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C6497B79
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010004; cv=none; b=tct5IAQQ9oGFNvem4F3d0lWMWVwsQ0IfpwtIybpl6MwXUl1Wd6/rhZgQ1rRIARGx0EouYFcHncN/KPvS+5hStg7SPkYqp/AgF3o6w23TQd/6NSy/CeQcOBzqnZ+AAumG2SqMPePSwcS/dUzsJ74v1Hem5HaPKmnQZT8Ltq1yRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010004; c=relaxed/simple;
	bh=XedB3bQ5TD8tLMEqewVYT3GzFLRum5kV4+kJPLmxAzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Brjibvq6G4BNigMxA7s2knHGplDC3sqtPUh9w/AGoaR0dcDakUmlZwEcFaz9hQJNe1QzVS9LN3yh50FzFJPSmcNQqoaY74RO8wgi2UlCgLQKK9YupQ85gEPGrKL7ly9p5z+IQtJLfZrD8s+JxmHj8A1XNTOY2Qen8xeHw+7uZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfLHLq+E; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfLHLq+E"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d05d51553so9311285e9.2
        for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792010001; x=1792614801; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QMDqN9lUNJYAv7hFugtzWfD8cPTp+VesYYa39/Jkf94=;
        b=NfLHLq+E8XQ6i7lXw2OmVWvy5wdyXWmUgI9ByJZPD2R8FL2sCJNyN7YmVVwY5lJ0Ak
         XFO2Ytby+P2nPgKzh444fZNBFaE9wukjD+lrBMflhpPWJg+0uLf8H0aGBWOko8Jnlibu
         ooFAsvH0VsjCtum41RpB3pukwnEcT70wJpoxfVCoYz7TYcUmpwVXPRPV1bjEt1/ggQWA
         isqhCWmYyy9lEqWh8iIiriz+xnRv6zF76n4oQJpxIqQqJ6wwzsIuoBqUuYXPoresKKRH
         p2JFUQFF6PiVRZitmYP6lHHNQQ9tSg10qnBl763LoMzzUGJwan0sDixgl35Bzvt3FPG1
         jleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010001; x=1792614801;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QMDqN9lUNJYAv7hFugtzWfD8cPTp+VesYYa39/Jkf94=;
        b=kQFkB4JD4uXs9IcDlRYc025LN+gc8PVXagn45JfAaFM7X6wbC8RtByZH8XYzd8OVaT
         BGdcgcwEZo9lo0e1Ytxb4GQn+xD6stm1EvpzXE4zG5Mr0DOsBP5ABkPOaxdmFzURCLQZ
         cyAgKO62aMNUI6OqIL7vMOxT9FVwvlFc/MrYPDvo/UgAgEGydsNtjtRd9phjzGF2XSGo
         w51V6a2FgkUGfo+ZBaj5YaIU9xS3TTAZ6Mulg45Nacxl4agYcw3AkezvoZztbuIm+Ef2
         Za8wNJtdN8ZpnevfV1ob8DEu5py8+yjrKG8ySKJPrLq+BKtFPKOHFII+B4Q6xsLSH6IT
         SyyQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3jlst1ByzvYlRjjNLUoie/7v1qnKMWVi2fkL9WPfSfb+JKyPiILvftXl1BoOpKklqQ4SQBdiLrTo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgzR9WMLJsqb1rt0G+6Hhp+GyLSQ123YND9CNAYHtELJlklVPT
	0wQswxkpNSDZaR5ZwPLPp9MyVdDzf8nVU4cu9XCKtbMgrNK3BNzDGzxz
X-Gm-Gg: AYBFou3SQbuGfmyQ16hODh0GHZDmtI3+nryqa9Aj7SLF6qfCJ5ocDOrKc7bYs5OH9H5
	iMm3vlngMx12ZbGLc3Clbbfu8AIRFyzKXyQOtWahwsNICGNuIuP8DGbrcvvsuG7PCHl67sYEznR
	+hV8IFfNUJiDV6Mqb/jtyx9yK59S/4vqA9H3Ng0FhpjVMuTAzMEMvU4H9DHT7E0iWA1w+EUNALo
	bnd7K7SiEIZpeMDNljIuklDh/Sw0o2ElzlpNrYEI4Qm1c0XX2QpYDIBNJXN1KTiMvnxMRxrgDhc
	HPWzdXbnGS+NBR8kFAs8ex+D6gWrn3ao/liBGNwVO3VSMMqZn5xwJT0jzjkMjyrW4YdMYRAjMs7
	J50loueg1HIFE9WbS6jhJIaOR4ytS4Z7SOtlmINtgrzQ7q6SvdgwGUQGAoA1A6WdOPbuDid8ZAo
	j/HWpUIo+L6+OQBqo4/+Me0MEzXblMauzmbo5Iy/k8rtJNzEa77mOT1SdhWxhdT3j1k6/4XmsN5
	OC2YdcCbfZ7frh93B6L4Y2ZgenQ9vFHSd/0G/fF1IsSCQXh0Xc=
X-Received: by 2002:a05:600c:8105:b0:4a1:714d:eed with SMTP id 5b1f17b1804b1-4a18e4841c1mr348140235e9.14.1792010001180;
        Wed, 14 Oct 2026 13:33:21 -0700 (PDT)
Received: from silicon.doe.home (91.141.74.240.wireless.dyn.drei.com. [91.141.74.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd6834dasm16939225e9.4.2026.10.14.13.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:33:20 -0700 (PDT)
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
 Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: arnd@arndb.de, krzk@kernel.org,
 Navid Ghahremani <ghahramani.navid@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 19/24] dt-bindings: spi: Add ZTE ZX family SPI flash controller
 binding
Date: Wed, 14 Oct 2026 22:33:01 +0200
Message-ID: <0hKeGS29RSCCKJETWWv9dA@gmail.com>
In-Reply-To: <20261014072109.1759502-20-ghahramani.navid@gmail.com>
References:
 <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-20-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextParttwTE2U3XQbmQGd0wk4ry0w";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextParttwTE2U3XQbmQGd0wk4ry0w
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
Date: Wed, 14 Oct 2026 22:33:01 +0200
Message-ID: <0hKeGS29RSCCKJETWWv9dA@gmail.com>
In-Reply-To: <20261014072109.1759502-20-ghahramani.navid@gmail.com>
MIME-Version: 1.0

Am Mittwoch, 14. Oktober 2026, 09:20:59 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb=20
Navid Ghahremani:

> +      - zte,zx29-qspi
> +      - zte,zx279128s-spifc

Unless there is a hardware difference that matters to the driver I think on=
e=20
compatible should be enough. Probably zte,zx-qspi. Although since this=20
controller is very specific for flash chips zte,zx-spifc or zte,spifc are w=
orthy=20
considerations too. As far as I can see this controller only has flash memo=
ry=20
ops and can't even send a generic byte stream.

Note that at least my board, and probably yours too, has a "normal" SPI=20
controller too. In my case it can talk to SPI displays or a SLIC analog pho=
ne=20
controller. It has a different hardware interface and needs a separate driv=
er.

> +
> +  clocks:
> +    items:
> +      - description: work clock, the source of the SPI clock
> +      - description: register (APB) clock
> +
> +  clock-names:
> +    items:
> +      - const: wclk
> +      - const: pclk
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names

I think the interrupt should be required by the binding too. The driver is=
=20
still free to ignore it, but the binding is supposed to describe the hardwa=
re,=20
not the driver.

My hardware has two DMA lines too. I don't know if they are always there. F=
or=20
pragmatic reasons (the DMA controller is its own beast and for usability le=
ss=20
important than the flash controller) I'd make the DMA properties optional.

--nextParttwTE2U3XQbmQGd0wk4ry0w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEQxb0tqoFWyeVMl1sPRO8yFRPGiIFAmrP5v0bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMywyAAoJED0TvMhUTxoi2R4QAJrkefuQh8NSuzy0O/W9
qb5I7KRk0N26kgWskLDtuWqXqefXm6Oskjmc8yQ9+nzbWVXGn79+aGItk3ttv1a0
nBkSRSt3U9zm5+vo5A7oOKaCEo3cjOEsMTDmu8Z5lJ66EAuNNIds3AM+/YR1nYuC
IdIUYdWcK0HlBqoq66pAD6/3xjRyVzlT7t4LBRmk+hC3cl+TrJM8O7weNidq7RiW
FGst++ElWV1RmZVgZTDmlBlf1ThJLV9v27LzOonW4u9hg2U3GOtobvV70QyFEVen
/ixuJyOsuo8lxFwl9SA9Xl7JNOMImNQ1tPFAPh2WiVW065ovdTUZ/3ElEz5AVOlZ
BjvU+eNAmGhWHsi9Ubwl8o08Bj45MVDaA4OONRzpzi3CyllYUuZr5UqS0aPRRk75
382FFCDCd+vW+K4sfgwqhxSV5X7BYnynfPuHWr6d0e97zg2tzXBbXHlP0XJEvozs
xS2pl76i+xFzPjQPyhtU0LFiYpGxYJwJg9oxjLa2IesafouvmcR7X18kp2VwfsjX
ZWsvHLrr80HevR6I1FXyt+qVO+WnaTiFoj2/Rw9mPSg5HT/EWkrUCgINZ+iwiVIS
TbFGV3QGFtV04PpdSY8i+hvcQBlE2Yyv/StywaqZEB0P65ZykVfI6JvDUFnkDzkL
utvIuPk6/MSMNwQBQIOwV7Bp
=7T89
-----END PGP SIGNATURE-----

--nextParttwTE2U3XQbmQGd0wk4ry0w--



