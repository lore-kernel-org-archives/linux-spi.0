Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9118FDBD
	for <linux-spi@vger.kernel.org>; Wed,  4 Mar 2026 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628056; cv=pass; b=oKX61l9FZJWw3ygnqRXTb/Zv8/1LFzMvbMo2k4lzgckSW7zuZqsmrtwLMZiTLbPTK5hm6skG9Z2GcsFB+FQ4FGGuJQJQHMjqLNQdWvaSm5LZJKav2Vjlh48uUmLxWuUNiOClpkAe8LYtvXVsIchWBRVDejFVvuDAOjYcr6pTc4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628056; c=relaxed/simple;
	bh=2/WAS/0pzPoroLAGh2PLMGdVZ54HV/z1BsjWlFv4VDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/7KAWdAVF/r8e5/hUD/ymBCx2qKXTMCbRMlZ+Hnj28vpMYLqeIuc/DBPmxDP/+7aOxsB8afZGZARVeEW/CVu2Ty/hnI/xbr09JSO3Km2dNETmu5DzHj2R12wsTjhWnZCOKU9hFavnN3i5qvC8Wc60UVQVWF6DzIQ4q556KRylU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWy3MsYk; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWy3MsYk"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae5423b02aso25040025ad.1
        for <linux-spi@vger.kernel.org>; Wed, 04 Mar 2026 04:40:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772628055; cv=none;
        d=google.com; s=arc-20240605;
        b=flQGjRWgRIV5zu6l14z/X4K2CikPV3rssgBrLoSIOciyvOPSgerh1Nh3Xd+0jLs7AD
         3yLTL8fkmdol/7mIr5z9wo/xAjt8u/VmuBTKG57o9HeNLtZqZ1TS7sn5fR7TO6yohAnB
         FR0YXKZArdGiTgM4G3+OKWXg/KhsGfny+Iq23IOh5dmf3jJaXag/WUyWsUNM/nO3bGmZ
         i8anp1UpEv4pQx64Cal/QV2UURko2qwvc1x03Ms+Yyh+w6mDIN0hN4SiN04CWPKxD9yU
         9ZkCbEtTiFIktaqxN5v1N46zZpJE0QXZLXUTJQF/JAg81FrqFpKR5EZhbUS4TG5XbGHW
         UqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2/WAS/0pzPoroLAGh2PLMGdVZ54HV/z1BsjWlFv4VDw=;
        fh=GB9mur+Vp/v/vYMjvaiKdS1tviS05Q53OHnOwR+r/3g=;
        b=Ix9yI0YdR6jQFWWUqMvyvhGxipDVx3yYblfM2zZmQmsZKrO75T6OLsKy1gFfhiamGp
         oS1mXH9HUxjeWABYb1O96imV4oQTg4s3BB/PIi66faAVUJfya+TaTFWBNadVVdgdPV9O
         xs/p7gNfTqJy40hs3QaTHe4fEIhhuAh2iuyL4/PHBkq/6Yob7kMjo9V6f/FQa/Bjx6RN
         3JtZxQ31ztfRYWdifQmHmlgSGe3XsJTcCE63EkpVskbd0Eer+DvEnXQfiby+TrjMyxCz
         XIdZhdZ2gVZD4pLhcM2mVINuZiOrTGi7eU4cDAh5IIRPYaaBU2aWK99nKEDWA9ReV0yp
         KP5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772628055; x=1773232855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/WAS/0pzPoroLAGh2PLMGdVZ54HV/z1BsjWlFv4VDw=;
        b=BWy3MsYkfspdphXTwX6bQoT6yOLLGeaw8icLCUR9lJpQxfWx0joQIfrk6C3bj4l8E2
         WArJJKI5utT8AOEL1H7SLY9/8t1xXQCSY4NqMLkZ/MVBUbPNouvCXWGWGiOsp82iBKxp
         uzViR9WtmziZ3prarRb9TPvcTsOaO+Gs9VoE0VaV0ocgW6Ex2yv2zAWaVw7xNi38C345
         236IV68IFf4NpFkEzlK/eVK6rByQQvUU3BWdUM2e0hXPFs0sp/Wq4fX8chE+xOxDIQ09
         /ldbPPhs7aRP9i2lk+8nlAS3v0HaU7+9og3JbWAkCBGcooREOwEqjgPNxw5UCZTJAHcj
         6ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772628055; x=1773232855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/WAS/0pzPoroLAGh2PLMGdVZ54HV/z1BsjWlFv4VDw=;
        b=P4ukeImrB1Yu8bUowfuBCemAwNpcZk8SdhSVwCsE9YRMVez/tFUqNNVoKZr84en7n4
         60xnP30colby1cQSf2aJFS0lE8QU5pm4BrS0guML2l2pHSqcLG52WDSH3W7GV1zFNM8e
         POQM9ck07LjMQ7asyCy+UUE4cZQXlcCVyqx8qde1I7LzrwGP3PSIbWrUCulGXyyV92qo
         pJfhxDfxXwciORK34SNQH90vx7bzEQMi/bVaPB2l0r5Bw28RL4NdzO2xPiU5GCvUJVon
         vRW+j8Lerm/ZZ9YRu3J2JdTPw2jIlev0YTJinq8Nt7Xq0NREy5RTuDbO4vT9LwdCHt9l
         oxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVQt9sAJaA7bCG4KM9DbqzAFKhxhelS+A6KsADKhKEeih+No0Caoq5nkAiM/SdfCKP1Lgoe2jaLj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrIol1EqYMXHEQj8KmqZQFVJLht77UoH+X4tKmSRZGAM7gAmxU
	WhpTgUgEB57Xh72hx/nDGefskyhNaKpXpGKwmJ+XqtDivgV6kTgW6VcaMZjGo3c47CanrJWSHV4
	/8pvopKD960lsUJFr9Dq++NFIejPjo14=
X-Gm-Gg: ATEYQzyV0sppT5cUUlJ69zYFCO0vLNQpKy2FvutPd85Xe11ULjghnPILvK1fR2DYBwa
	cH/naNJmVwTqOlE/QOvTOMWwnCejTDzMGThKpmiI4N1co2g6EfXqEFsJ26R1F1sJncvKBqoqS/Q
	LvV9QhoornOz205AGSr/rX12BCgHrezdJwMQKEumANXp67mxaNdC5Alc8uyXMMEnF/rc/yX2jL0
	TxNunXaitE9031KdMK3RjbU4xJtHGcrR9JRVa27kuowVDUIYa8nOBv1hpGrBPSINnxHlBiQMRK0
	cZ36T0WnOCpY5BgvdIU=
X-Received: by 2002:a17:902:ce8e:b0:2ae:4a4e:1e25 with SMTP id
 d9443c01a7336-2ae6aa649dcmr19233535ad.25.1772628054893; Wed, 04 Mar 2026
 04:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-spi-nxp-v1-1-b78570db28ce@gmail.com> <DU4PR04MB12275755ABE75588FF75BF65C907CA@DU4PR04MB12275.eurprd04.prod.outlook.com>
In-Reply-To: <DU4PR04MB12275755ABE75588FF75BF65C907CA@DU4PR04MB12275.eurprd04.prod.outlook.com>
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 4 Mar 2026 20:40:43 +0800
X-Gm-Features: AaiRm519fMWevOrxACIjx0JfN7SzPZoQPXxnqjFQdS-XzmfkrSmDhriX6o8zRcM
Message-ID: <CAN4SLj2P3qzN-N4dsjzo-0bF9NPLG_-Ad5YWkL97rOrGo-gW5w@mail.gmail.com>
Subject: Re: [PATCH] spi: nxp-xspi: Use reinit_completion() for repeated operations
To: Bough Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, Frank Li <frank.li@nxp.com>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 3:23=E2=80=AFPM Bough Chen <haibo.chen@nxp.com> wrot=
e:
>
> > -----Original Message-----
> > From: Felix Gu <ustc.gu@gmail.com>
> > Sent: 2026=E5=B9=B43=E6=9C=883=E6=97=A5 21:21
> > To: Han Xu <han.xu@nxp.com>; Bough Chen <haibo.chen@nxp.com>; Mark
> > Brown <broonie@kernel.org>; Frank Li <frank.li@nxp.com>
> > Cc: linux-spi@vger.kernel.org; imx@lists.linux.dev; linux-kernel@vger.k=
ernel.org;
> > Felix Gu <ustc.gu@gmail.com>
> > Subject: [PATCH] spi: nxp-xspi: Use reinit_completion() for repeated op=
erations
> >
> > The driver currently calls init_completion() during every spi_mem_op.
> > Tchnically it may work, but it's not the recommended pattern.
> >
> > According to the kernel documentation: Calling init_completion() on the=
 same
> > completion object twice is most likely a bug as it re-initializes the q=
ueue to an
> > empty queue and enqueued tasks could get "lost" - use reinit_completion=
() in
> > that case, but be aware of other races.
> >
> > So moves the initial initialization to probe function and uses
> > reinit_completion() for subsequent perations.
>
> Hi Felix,
>
> Good catch, I think spi-nxp-fspi.c and spi-fsl-qspi.c also have the same =
issue, can you help fix?
>
> As Frank's comment, there is one typo: perations -> operations, please fi=
x it and feel free to add my tag in next version.
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
>
> Regards
> Haibo Chen
Hi Bough and Frank,
Thanks for review, I will send V2 for this.

Best regards,
Felix
