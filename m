Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603240;
	b=tJSiswQkyZhag0Ed/POK4N0kPtaeADmZnfw2QrJ12F3ty6DtJKOFuOfm5FuuXlD4QkFx
	 BEXVthW4EFmKoVr71TcJ3HM91fnNz4uvdMHDOs6hFl9PogssoGvnnwDXc4ENS+HHdBNd3
	 TJkofRS6rt2PjbH8Kw35UaQeCk83RrmslWwZlnopK+WwGWdDD+FMbWfhycG+qZ1bUnmbc
	 BxbnkGBEzNE66zzYY9doJyML56YMcB/1dqKlSnHpr6hHXhJnitm9BrGpA55x7yJotI7t4
	 ECgxkHHf1okSMD6cM8LPwlev/a87nX+QFjdLpM7+6z+YTsmAY1NpOnpIK0fzXsTI1WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=4O2iL3RsyxnZ9m4gGTzmFGBt6GQKNa857BfAv3d9rDM=;
	b=dAMkknrjGds9M4p5XglaAf8WIzuGJAtFUENKcEqtHFANnqJ18OoyIc2NfLkaak0TJWOK
	 RQXKD2cWi6Bc69hDy+ofb/yPViqZQtT4UZkAXTSaIvIM+uBmHtKvDPiDfO8iBN+OddT9z
	 Oi6piXgOyn1bkHhVGlgO400RPgDErMXysLinosw9DhHYBCXv4pCGlemkyLmLomNrI2zzo
	 suCNDjBnq/51VTZ8v50myTqaX9MXVUMMv+/qp6enpIRdD35a0SAzIYpkUwGbmn7xKAKAR
	 lka+I3FIMzs1xNJq2/MOksUHX2Ftnn0HvB34kYRBxdyMrXEo5bcOESE8cWy+7kFTBSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vxKUcFah;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A579F606A33D
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 20:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A579F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vxKUcFah
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4919a880834so697212f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 12:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794603238; x=1795208038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4O2iL3RsyxnZ9m4gGTzmFGBt6GQKNa857BfAv3d9rDM=;
        b=vxKUcFah2dEJQJlVcolTIMkDEPayM416prYnDTnrH7qZ08MO5YuChzoPwsEuSiacH1
         fs5EIDUx35jOzPHdrZp6fYyozP3/YONkhrMV49J3e3xArKGBkfGwNNgGQX8SStI3ZGsc
         1fJLZgPHugoMNB/jIZV8gvlfcXgVUa5xz6xkT0HFSQIY2bIpBQvGEyXg/v41FUW/haIO
         12PITto3/lIkbeBoCBM+CBPOmsP6PbFleVv8H51mEfSxrdwPD6qPAsxdr+QKxS9RJ8qE
         p4l5rwKXnM9pfS1mpWMmdKyIziB2dVSW/CIX88ndyk/jvPczWks4Mfrg0+IVHdwURS+5
         BXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794603238; x=1795208038;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4O2iL3RsyxnZ9m4gGTzmFGBt6GQKNa857BfAv3d9rDM=;
        b=R/zEkP1CUDgH5yJlkgdWaUbantyNhYMf1tXNWI71Idz5HZjOo1xpCDeG89+mB/kSx3
         +DlXrAiO3+vndeSnCrD+1isg0WEfbI7+ovIkSo2sGf2/msxnxqAOG5lYRE6UM0VpiCbJ
         PdutLXPI0V8sBPzr1KYtezPJtkll5k9+tK6Nr42v1tUnWX17JDiqJiYucusI6EvwNKb/
         4E/o26wMZFDG2CmJwNt+DLvLqbQspdJiTtAW1f+O0XuMzpQFwBVEUoQMhAt2Jczx0mHi
         Y/3lZ16G+pmcHRs95BSjlA3stUaBSn8wP5gj2+QJMH8GEpylyflr62HnNXWpvY8mGmn8
         jCCQ==
X-Forwarded-Encrypted: i=1; AL+hErH6DhhfbTH+tcafUjiKCewYlyqSv1uBVgolWwSilY6n8v5qJSDH/x+qIljT7S3B6hp1miahJxDDsyw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7flwN7C9hzH66Fs4dsLWrF2hkTSd6htZGnrdfO4MQxomC1rh9
	zK/GuUNO9B+X+xxPrLt65JU8UOgjwX4pTir0YbyKdcS1R3OL5uZUXtIy
X-Gm-Gg: AYBFou0v8ZjacTRdFtUUn8ZxXoSl9juIz64i2jXnqPo9ENtwpV+oAlDVqmoKYi7amDJ
	kmXKaQ2NqEDpFmhRoqqYOR1qTE48qcxzEpJcTMSZ1hVUV3sbBnsX2Nzsm5TAkTb0gwgsw4sPAJB
	RgjcnI4X95H6+gP5+RJQ4PeKnp5WlPSmQOz2rlkwX4U/NGWxSGQc+P/wUxfkHav85SW5geWmz8X
	y6zRxihl4bhwa72tH4kbe38rDUUTKBcfIWfbP6pSNAEkI3mSGQG89VcrXXWAwouobs19x7nqcrb
	usGGC0VZLnD4lxNRIubiwBagQ4rlKOB1YVCH+hU+BEjMva4HJrssjeqTPbdz2GOM+e23qrEWWuN
	RIDzTTrbRwDipz0vpSONfTcVSY5Ky2myALy9+LdayFrwik02dCMKzqLoWjrSTCKbat1WfyiK/we
	xlk9oIeYFL8UlZLnSi3aXjDXR160JMyjVayOpeCWCfk/9WQuLvOCO2hjRgofMu3XMMOTNE1Zc7o
	HuRxeBQihVGUoQD1d96YbTMCaPuJxYdgKGN6o7veclUDiSIL09Ul8M36xEgAkdy59rwyS0F2hDg
	9cIatdaZ4qHLaUGYIUlz3SwaxFxTPBrNEsID8sS1xRDIyljGQz0g8cB4/Mx53KqMYxMk6u3ySOD
	69QNeiQR6MFvmxA==
X-Received: by 2002:a05:6000:46c4:b0:494:bf39:21a5 with SMTP id ffacd0b85a97d-49c70ed910dmr5311677f8f.10.1794603237761;
        Fri, 13 Nov 2026 12:53:57 -0800 (PST)
Received: from ?IPV6:2001:1aeb:1005:d000:cce4:c8f7:ce4e:e9a0? ([2001:1aeb:1005:d000:cce4:c8f7:ce4e:e9a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c607d12c4sm6789427f8f.41.2026.11.13.12.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 12:53:57 -0800 (PST)
Message-ID: <139f1f39-2e0b-4ca1-86bc-db9732f9d351@gmail.com>
Date: Fri, 13 Nov 2026 21:53:58 +0100
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: cs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miroslav Ondra <ondra@faster.cz>,
 hyblmatous@gmail.com
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Subject: eeprom: at25: no module autoload for chip-specific compatibles
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I am facing an "issue" with the at25 driver. We have the driver
compiled as a module and load a device tree overlay with

     compatible = "fujitsu,mb85rs1mt", "atmel,at25";

as required by the at25.yaml binding. However, the module is not
auto-loaded. We have to either modprobe it manually or add a modprobe
alias.

As far as I understand, the SPI core only emits
MODALIAS=spi:<first compatible without vendor prefix>, so the uevent
carries spi:mb85rs1mt. The at25 module only provides spi:at25 and
spi:fm25, added in commit 9e2cd444909b ("eeprom: at25: Add SPI ID
table"), so nothing matches. Once the module is loaded, the device
binds fine through the "atmel,at25" compatible.

Is there a better solution? I thought of adding SPI IDs for the chips
listed in the binding (mb85rs1mt, mb85rs256, ...) to
at25_spi_ids, rather than only at25 and fm25, but I do not know if
that would be acceptable upstream.

Thank you,
Kryštof Černý

