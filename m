Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7401EEE6
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074548; cv=pass; b=k9zHSJ9R/1DIgXdR82O0yORPHff6S3bX6UIeXirQU2zpr7Ch+8IQaxA7gv/KpSHQWIqinDQYLrzf9H7/mRFlPegSpxwZmlDe54yDdlSllbqcH59w/a2B2cnBUxUJ9boOdsVFRP9SXBbypABIwjr1TtisK28mEAsb0Chki7dR0uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074548; c=relaxed/simple;
	bh=CpowxPIs9WsIvTj4/MuMW1Y5/GmzHzBIUQWzh9qqtsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mt0dPe118CMePcrFe5IitdVxRQAoDRXTHgqwJVS+G4d/nls2G+M9cBQ5h1IB6bY9kZGz8IjVpyJ9w6ytEI4ecXbsPF9EDB10ICEiLU2FAIddAw41qxhtUIj5QB3rLi2jSiLXFNuAewNk6vE/6DHTixfTcFbzm/ZJBCyyvNXoyBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=WMmVf+cD; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="WMmVf+cD"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so1061615a12.3
        for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 01:35:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769074545; cv=none;
        d=google.com; s=arc-20240605;
        b=LPgXku+yeUtbCDd6yx26ZH3VLe1j/ALruF0wMl2y5UDHysUf4Xpw+lU+/PgMMTr1zY
         a3CCymh3407N6C4c3Sd7sSUt8abd2+9UYj0BXxWO48RsWokts468RMSFFU7KpWgEuA01
         jWMqAXPmyYrKJm+v6stshzfRX84QLxtw0cZJf/88ZzBdEoDN0nwT/Ig0yHOMV/oQuG7Q
         43u8KChdAYOTM796PskvRcdd1+fQDVfu0dLbTCAC+CgGGRbCcLsf5MW2WBQRfV0OqRzL
         /27PsZIKuNhAnXBKAWWM6fRib/STwCclf6uXkVb7GRS4bVljhiDgmQTaZAP/+L/RwsIl
         b+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CpowxPIs9WsIvTj4/MuMW1Y5/GmzHzBIUQWzh9qqtsQ=;
        fh=77wUntPItjIft2PRxIwpll0GmlA6liXHUf6DmwQMbfU=;
        b=T3PvMymd2sUKrWWmOZKvtV4c7UKgIzdKJr7R95lsp3S/SBnhd+IqGEeW2biMnPpq+g
         Pkm2c6Q3SWpdgX3sCYrYHrXElQE2fzj8KqhmJcQWA/kA0woK6ncGeQ2bW11G4d8AOJr6
         WMZBq7kmNj1byoaitFPJmliUqW+vx0C32ywlRLh7kZZjw2S8dHdEVAENlliiq+MpQBmN
         etbd0DlMH8IafWk/l+4J+RENBYgbfYUAWYnDLxTuE3IGN1a1SL7nN/eUCf4VIKQMDUPa
         9FGxjPz9I/0R6ksiUE5xod+hHbvUakQr6YXc1VmG36pw8bHkIjlYt/jjWA0jpyt/O9a+
         mD/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1769074545; x=1769679345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpowxPIs9WsIvTj4/MuMW1Y5/GmzHzBIUQWzh9qqtsQ=;
        b=WMmVf+cDPVXyzKm73nlXhVqX/GgwBPysyw+V8fdoMVElEaKbT5iIB+JX6bg1SMgNHp
         BZ/xpZLXmDtL49wkbLH6Qe5t/c1FlVbMBwB35Yj2bfbomiTfVmmlbRHxUoEZR/oQWck+
         Be74nd4grwTHoU8lZrxh7rK5Z11b36UuyBJ2+hjYl8aOJ18c08LpQdSkzjpNZL7dXtFS
         T9v9pdYZUJX2F6R2ZKeQUFJ7x2iA+DdPl0QupDzrrWAwUT1dVBgpkasAEVxZ/M05ccks
         CyBCrEYEw1asEPFNKbUBuBO1ZPFruijEtPlo7DqxHXrUhxmMxMlp5rmrVyWYwRFOfOVs
         sNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769074545; x=1769679345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CpowxPIs9WsIvTj4/MuMW1Y5/GmzHzBIUQWzh9qqtsQ=;
        b=dOsbu+Sb24aXf9Sf5cnrj1573vXWSDqb4oPXqBk2h8D0vmMwLu06BeXjYVVa0dkXOv
         rFcyNNFwnkLaC6d47KXbBbztWr2hlnttVXSwGz2Z1/Gr5eV5WzH3jqKy84ZdU5pMNNoJ
         XJQ7/O7vvEUEe16cCE+fviY7LnT6gxH5aJcjcbvST3Igdg0pHc46Lm1MsHg1VNfkRx6C
         EcON5m6XrbTMgCHjJA9LIs+9WbNRroiQI8kidaqk4geR3KbYWTAVMutUJtAFYOV+jdlZ
         pYoPgx7CIloTQTamuenFEe3fyV9tdn5aDprRDcKpzSQTechI+sVgfP1/dyAMsCGIHD20
         P0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXfou6UpqiDN8EC8N4DlW91ttSpN3uLkTd3tjI3i7jTOWCXMjPEax+f7XrONdvZe4TV3BengjWZYNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZ8RFJKNFwlaK09gyi91FUcNqRcyZ/dhgR9iQcVyjtbTvQwtU
	sI737QaBjQSh9MTKrePoGdKFcdg4v1ViiZM9R4Fzmq5owInaVEwxckqfvAyyZX9DC9TKag0XeKP
	ucQTSCmvmV2frepl6TI1dSZYmbZ5d0zUKwuYbHOGAYw==
X-Gm-Gg: AZuq6aKE3IvVwcwh48sj5+zg96AhVSCTGPK2t/MRG6mOlbKlTH3o/4XAP87nHBzzFbw
	EGdSLLCvmBGhXFariUaG2x/+g3W48+Pvy+suqSbQastxlN0Y43SjIjxc/fGK81s6pp4CgXPIEg/
	hxJbMk18eC34SPjbqNZaWgGeic0S5f8DzGInDmNEtsIj+VNXv5tpdbppgRfRsm4FqDbpzT9wIs8
	BTfSI8Lv3rf+kX+mCNW1FUPd01JeNudirVWp/ddvqeo8XS9h10GckXem3H7CmAfvTRZXvtNkrY2
	zrPZm9AtTX/Z26ymDg0/PdoXqGfUHLvDdjAUa/imMH5knRM5/FmtPxYQ8RSadQ==
X-Received: by 2002:a05:6402:f02:b0:658:1304:b68b with SMTP id
 4fb4d7f45d1cf-6581304b771mr3388171a12.15.1769074544348; Thu, 22 Jan 2026
 01:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115114021.111324-1-robert.marko@sartura.hr>
 <20260115114021.111324-7-robert.marko@sartura.hr> <CAD++jLmitNVhWmUf9BBqLR2_WsAR7V-+ykVJsLK3MuOSUKQF0A@mail.gmail.com>
In-Reply-To: <CAD++jLmitNVhWmUf9BBqLR2_WsAR7V-+ykVJsLK3MuOSUKQF0A@mail.gmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 22 Jan 2026 10:35:33 +0100
X-Gm-Features: AZwV_QgGcZewelkI3QjoxNf_Rdp39oV_bH_54mEjrqvn-sBMKJLuqze3gq5di5o
Message-ID: <CA+HBbNEw_9FNOFxx8Mo63Aq49MxWvvuQ4Sc75mXFYpwtMmETiw@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] dt-bindings: pinctrl: pinctrl-microchip-sgpio:
 add LAN969x
To: Linus Walleij <linusw@kernel.org>
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

On Wed, Jan 21, 2026 at 1:44=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Hi Robert,
>
> On Thu, Jan 15, 2026 at 12:41=E2=80=AFPM Robert Marko <robert.marko@sartu=
ra.hr> wrote:
>
> > Document LAN969x compatibles for SGPIO.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>
> Should I just merge this one patch to the pinctrl tree?

That would be great as other bindings are slowly being picked into
their respective trees.

Regards,
Robert
> Looks good to me.
>
> Yours,
> Linus Walleij



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
