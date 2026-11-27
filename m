Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772007;
	b=Rxn8lnM3yoqz9eV+FkiLCo/haWh9Zs4K8RmbjBA+IouHntIha0KFKiWzJLMNgLh/fIGL
	 FlThLZJ0YzUWMELEj09soXbZrzyrrRXZYSB0gdpsqjmHSIxj4kQ6Wq8Jog+OORXop+8p7
	 B4pkmipTrA+JP9i8OpwT8GWdyP7GQJ3Dc+fO3QWl06AcmGuObmynwNrUgmV18kzH8uWEe
	 5HZhEUsBIBJPDezQ+Z+vgTNpYEMIwATEAvoDlN1K2qGHePYGDN7UV9a0P+qNitwRp2JX1
	 H1QTOpBkDVFmt58iFQJe3RZZfBSs8Q3h9Ye9SfqgaO4AOFt0qn8fDV9MbPI1cKH10vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=A6uudOphVfwIHGV1M9Y+fTURzZzdu6IHd2WuYguba9o=;
	b=bwj011Y0GMu73vWS+jcJTJQq+Q38B00v3S4M2Jldge0Uf18g23bavm+iDcVyw15F7Jxo
	 cF0+p23XEZM8mjBxOqStTHmrNG/jV0UPzF3ZI9OQbD21b3kPi0Ue7o45Bia5GdS/YZ31n
	 TVtd7Rq8VFGBPa2UOsEMod12QGuvYGjsunGkWVM12D7RuNk3L6FtNAX42WoFnrEywrXxm
	 W0X8Lqt+VSgoA1A16WDJL1n+pRgDxr9uFwjnU85qtPDIXUEcgf2KVzqsMRULDk4f2AJ/G
	 DKcM8YWoAt3SHcU8WdBIL+9owXaog0rhqE/OG2Ep8Y2IXmAptBbRai2pgG/MQ3UrYKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rUPrkvfK;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64240606A31E
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 09:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64240606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rUPrkvfK
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a34ffd3e39so4310965f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 01:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795772001; x=1796376801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A6uudOphVfwIHGV1M9Y+fTURzZzdu6IHd2WuYguba9o=;
        b=rUPrkvfKizuSIqNH8jAU7CLSDMtHnPWScQPWSe7vozOJCzePlZwslsVwhr2heSoEWC
         S9ZDtpfJxfgDsC290pS5b4hhM92cDcmJd2JsC7eBnBBsFyRBFgCacsG5R5DcyKgBOwNi
         mlgYzZS+2yfu0X+Qn09MXDM+nPR4iCL3yKb79nGiecWOAfBfBS8VqZ1IuxLA2NWr+fMb
         rvcAUdRk3a6sHt8XeQ8M3JeOo5wYWAekUX1RLdyWhKirsBtCd7AaLBhp21NI7UxEZnHY
         IclN7pMEHCX4g74wO4cC7iQMd7UkY0zn5nIMMVKdLiNiQQpO3uxt1ZilT9NI7zuZEVgF
         eaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795772001; x=1796376801;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A6uudOphVfwIHGV1M9Y+fTURzZzdu6IHd2WuYguba9o=;
        b=AO/iWUY3FZms5ePt9saf1tRREKD+QdXBBiunAO08g9yWKROK2wVscg+hBTRBozFXPz
         xZhYuJO7JGOWoKJL17rwdltz082dTCwX+Y/niNl8Oc8EsPIPeNWyEWtZzi018sM9SD5p
         ApJhTg3BOgRKMhhxznovOyANsHKY3kvvEmGoyCwgAva4EFBLQFjBrOz21lRrSm7ouaf2
         ATS3iB5wJHp/wf5vz7RX9H5SQoleRlo1CxZM/VcY3KRIRG3hKElgvAVR0Yy7ItBt/vJm
         FO3JPLo+NF61Yp9uIbsOoU+d0K0nk6mas9mVVleNXWDcC4fW3ra8n9PZd1T89VGFlAju
         fMhQ==
X-Forwarded-Encrypted: i=1; AL+hErHTNglUndbCheATMijFGU2S/UlkC0aHtshEh+a7zhfc29OHlnOdUHPbb67bsqGBr9LUaxp1UmZkuoc=@vger.kernel.org
X-Gm-Message-State: APuU4Z952cYPvQIemctddmMhwwev+vYTOLNwv2Xo8Zy+d5pEmQ9ySkry
	+plz5J1USrv8Mik7m3GfDrM8wWTu4Npeo3WClrbfcifT5JAn+H3CHVMl+bfY859VkG0=
X-Gm-Gg: AZFdTZdbZfAtZsVSqlY/TVotdWvUbuoK2Kr57MwGDEwbqa49IgvqPxETrzTCPKj7MqT
	fXb84uPcAro7LNgG53C3ejuGNyxVTOpQpkg4i+cuIvVawd15fTZgjBKCFD6VsuIyAjddRNkvxox
	Se8WoY7yczKNnWZQnmAmhjR6a3CV/QC5fH7NTmMOhg4wmK0QW8LK7+v4iADKJlPJBHAtasw2Pwi
	whN6EgOBRGaiwSYdKL8/0oCayp2unL8jbzYFjGr7/z9Zj3LkW2A83jODZKIILtbApvSLnsGmfqJ
	xLdlknGuf5hnrJoRWq4QbkeGSf/jQ4Nl9jfuW1pqhDU0UNbtnpXIp+JmFvjNE59yKBanqlWIsDk
	ZXfsOHZsTIMRP8ucNrJQRue9F849pD39lo0WQi5dNNUnbJ9Wa4Sq3g7EV8cL+craF9EnWFCFgJ2
	zrCQM5iuVmHnbN9Qvm6h+XtT7AZcqh608meRl+uwJs3XmGL7obwnqBho3kOa/HJAZr/vNus/Pds
	7cBlj5nrzVG+5caVCsx9IzCykIL2M1/FIaQmqtARC8LAPIto3/Y1wfQguUhTh83gB3Vm1viN/Xq
	gJ3INhKhUYqswh3yOvQOLUa3VOFTUPNuXm+fuR4=
X-Received: by 2002:a05:6000:2903:b0:4b7:70aa:4553 with SMTP id ffacd0b85a97d-4b770aa4574mr22944028f8f.38.1795772000643;
        Fri, 27 Nov 2026 01:33:20 -0800 (PST)
Received: from [10.11.12.111] ([79.115.63.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b9add26sm46450336f8f.44.2026.11.27.01.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 01:33:20 -0800 (PST)
Message-ID: <41962155-e78d-46b2-a58d-45282fdf1cca@linaro.org>
Date: Fri, 27 Nov 2026 11:33:09 +0200
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
Subject: Re: [PATCH RFC 00/16] spi: spi-mem: Express the dummy phase using
 cycles when relevant
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
 Feng Chen <feng.chen@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Han Xu <han.xu@nxp.com>, Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Haibo Chen <haibo.chen@nxp.com>, Jyan Chou <jyanchou@realtek.com>,
 Yu-Chun Lin <eleanor.lin@realtek.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alvin Zhou <alvinzhou@mxic.com.tw>, Cheng Ming Lin
 <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 imx@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org
References: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/25/26 7:51 PM, Miquel Raynal wrote:
> This is only build tested for the moment and sent as an RFC because this
> topic has raised a lot of questions, there may be things I have

There's no ambiguity that this is the right direction, change bytes with
cycles. As a matter of fact I tried this in the past as well, posted
something and then couldn't allocate time for a new revision. You may try
to search the set, if you haven't already, and check what the feedback was
at the time.

Cheers.
ta
