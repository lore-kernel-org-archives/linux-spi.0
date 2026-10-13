Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9F5293F7
	for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930516; cv=pass; b=GL+LbOPEZFg+bOEBA0wGFtK12NGEJSXnHR03kM9qUZ/4pFav7YiQz7M6/YHJcidpoxkfhzjrJvaBy7IJMz8ATWHDl7JuIJ1Zkd8e5Gsn+vwupQXYzJ+AWLwIwm/UbP523eyKqVU+Gm0nZBYxxVTR31dae9W6YLq75y+SdMxkC1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930516; c=relaxed/simple;
	bh=LbWPDwQYb1MNttmrZiIyG9Roqv9R3ER6b8JaxbDgP4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpxJJvz/39tlH4ZwVP3w0Dq9I3mH9+l/cGSXx72TRS3Yxg183pszQGVZPFomCBfhO2S3wzWWBobsLbwDjvzwA3pUvd3LmRcY25dDPhiiOFYhIKE33UQoCNScjyo9/LOJSDx0F4MiZAiyVF6rFsbP2N0Xo5l0EPFS4ZqQteuoGdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DUSXHq6a; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DUSXHq6a"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-677d35fd1d2so3425169d50.1
        for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 15:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791930513; cv=none;
        d=google.com; s=arc-20260327;
        b=WoQI11xYBGPDEgJO7UOu6qGoWSWIG3gu7KhGRrFvuc9CpVbI05cAV+5QFbhggsGJXj
         xtcBBtv1wBr8wkx1MRQVkfQVKVyIitDGJxwCKnz1ICty4ToIPjAHz5PQr/1arKrscPZl
         5IbEdP0226GnAlpY2J2ObUCFMbrG0/T0wHZmLgLunuyhk3yNfux29DXbFTx0gFgtVaXH
         EHfFL4QcPNJd+j6amzAP82nKqLyvkH8NOdpZ8/teA9vggZBCkenWnjfz5mEtI4EMRF+B
         OfmdYPoWq6j0U9fPfGr7Ak3YafQf5yAukQE/FxTYaGfsl4eroIifnyhW5+XFCcq7sPa2
         jFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LbWPDwQYb1MNttmrZiIyG9Roqv9R3ER6b8JaxbDgP4I=;
        fh=5eimt3R4de4XDsIAp95J2w2Z01ylhlTOSa0TpS8UKKI=;
        b=SaYLjUQN6kpfWrSUWxNF9HOCzvvnkRgr/qFbZl8IpJuLgQXoLvsaTxRiDZeSVTv+tW
         utsrdfecKIqm7/Ujqc1uEDnJJvIybeaV9cTIC+k9zrhsYQu/ch8pF6jduaEXROH5iFe0
         tyWSaH6xEkZsyIuaPJXXm7xadB3q+trybmFbcRLqImPp8ej2gPFJ5HSHTdK77mS29kUU
         4iQ2LrFD9ueT1jGDzykeBG6GFuBgMwsR2SRdQo6Gxgc4Dv3VWspiSMbWkTxsfpNWz0bE
         t+a4YLNked8Qk/OR2c/Kn9mxGBMq3Wr6FWqxt5xAR253l1EL1wcFRTa335mYXKtkWOuB
         2B/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791930513; x=1792535313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LbWPDwQYb1MNttmrZiIyG9Roqv9R3ER6b8JaxbDgP4I=;
        b=DUSXHq6awOXCzmeM9lLEMtkMS1ys4ectWQNADf/Wr89M6R/5Ao9JRiZUqGyXDjy5T2
         JOT088ik4rp9/uXTDrLqf6AkzM5NhYBRpFSq6CIRt5rO/4hPnJUQfk3MHN3eJIe9KuAR
         U8PSiCTpeTfIdCGG8YfydaxD3paJQX36Q3vqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930513; x=1792535313;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbWPDwQYb1MNttmrZiIyG9Roqv9R3ER6b8JaxbDgP4I=;
        b=bXOSx2ASLVS5e1B/D3odoXhz6XetwAN8iLhcAD5gN1A+JY3DbfZrLsiR0D325qZ9H7
         AdR7t7VDA13X/EjUvhlQz07lQ2x6rIgwmf8Up1XYDsmkWiQ2EOaiFkHay7SwsX9DIEMI
         eoAk0F8BWrxPUYNk449P0h5waCspbUWxibtX75gXVGcvdLCwu/3iQrEIbLyAdo+bWeco
         xBMmVybsLZNTA1pvaQ180+yT0eo/gO4yJriOdmDA6G8ynfw2SuGUgI7tdosaNRhRPqJD
         +TUZSv7CGXGMx++CtwMqtnRYT2/MC0pvqEE9S9xfau9nfWrw1a3WlL3wp4ZWtDUG7/cq
         C3/g==
X-Forwarded-Encrypted: i=1; AKwUvByeirbB243JmQySjNwaJRUQlBE/Mf+h5UMpBf59aIyrPcmnU2ygI9Rn34cMkOpt+scHwD+biRlHl8Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKj/Cwf9U88IVkTRT+36jgQ/tIRG4O+aw0ILahd2+WS11Aw1YMY
	/excEU+0PF1gBFKCWep5tJpOirZN0gskiSdYab+Jdws1qg/n+uQH37SShK1dbDsuTT/D6R/LEmL
	ILxKALFnlfRNplF2Pz3Hxq6jtYuLk7ZX2P/69WB4v
X-Gm-Gg: AYBFou27gxMYCp/mAdp09AQlqo5PqBMPgErrphq4A3DXFq/hviu5F7uzxr4C7/HagmK
	wB1IKvfour8of1GkqgLiu45GzZiCUCXg1VVj0mWUZvoobiBvLawhpPuaKdST5auxchHjYKXHRat
	7/MzdIU83owHA55NpwKBXbQMVIqZvK+nBPRCXTWnifR924vgXdRz7aIwGwgn4JEt8ktKjfoK3MO
	Ub8LngyEbkIAAT7d0QDIlD9vWMo11uTAA+f8Fkg4PlB5bCt/unfGki7aZGhkJw9Cn5yARkr0ezF
	xgqFPjYIL4TzEEVmFfpnVGPYxyBq9YoSkq10dNv78EqKUMJKT7qEBJyL7swU9mqLV6+zIHKIhXI
	Q/8YUHZE89gwnv2zOZqbk
X-Received: by 2002:a05:690c:6603:b0:8a5:1570:a298 with SMTP id
 00721157ae682-8b07edfeff1mr40474577b3.50.1791930513249; Tue, 13 Oct 2026
 15:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-9-384af01da3ee@chromium.org> <998a8c7b-82e3-4370-b0f4-765deccdb348@kernel.org>
In-Reply-To: <998a8c7b-82e3-4370-b0f4-765deccdb348@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 15:28:22 -0700
X-Gm-Features: AclHuK9UE5fFXMlu7KAnmwYM6JrldO8UdUyYtEVe8VXlPWtvlfdV-v2OaGNZ5vI
Message-ID: <CAEe3GZEuB+i2XS-GnGsmHaaULzThPL2wKT4j6QdMYbCCz47q8w@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] dt-bindings: input: Document hid-over-spi DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, tfiga@chromium.org, 
	fqwqf@fqwqf.xyz, daleyo@gmail.com, Dmitry Antipov <dmanti@microsoft.com>, 
	Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 11:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 10/10/2026 00:25, Jingyuan Liang wrote:
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> >
> > The properties are common to HID over SPI.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > Tested-by: Dale Whinham <daleyo@gmail.com>
>
> No, fake test.

Will drop the tested-by tag in v6, thanks.

>
> Best regards,
> Krzysztof
