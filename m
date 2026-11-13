Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530267;
	b=4JbrpG/m0zR1PZzKLrjaxjSUI/NJwj2+Vg6W8NgFalRM/1hC6V1cW6I5yfWa94/B7KSN
	 b+y/53BlaFPuvtgA1FkjcN+85kgzQ90e1xKfCPf91x9xOym+ULws5bBoNSmKMb1c9MqPo
	 1umv3vU3GqCsJl9wvh9SvQOlo7RHU/ERur9B2pPC939N+VJvsm825E9AhiYd4ffcXJKhT
	 J94zD0vrj1jI9p5/A/tYWa6VdCjQjTIYxkmIfO/pBwRHyltibBkCWUmGWkvY2Z1iUWNV/
	 K+ZoI0itCInHTYU+5bAEYPUfmzfDSFE1hLGuISZFG3CH25dZZ9/7iqdVQAW3TgNbkRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8LSEo0mNhx+TMG62Egyknhrrk3n9oM++PyBFHpR6AXg=;
	b=Y2Any99s/27T6oWRIoPqaA+YGkJhIl2+j7YE2Oq+toaHzQprlmqkim7b1oaggk9K7BZU
	 jyHeU3FFKzzizRsqpymy7T98NtX+3Rf9j1avOUks8Ze9cXy6gOcgkkhoh/27Sh3Ka20rd
	 obDyWMrWhI6us+hPZY8p8ImFkWckn1E3uK/H/W3tUtFgGKyKqLdCitb4WMNzlsrVzciDR
	 LXbPkZsT+kVQKfscs4VbHPRGtpSrK0aryrRR8PdAsLQpEzh1VAvyydw5+cVfDd4YinH4Z
	 7k1bFJbiPCSNiXmuHn4q4zC9WjCLz8tLf+Ihng8fTX4D6D0NIxkxvFqqO+PjwcwaasA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YrUfbkvR;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095F606B540
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 00:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2095F606B540
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YrUfbkvR
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-49a92144733so121522f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 16:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794530265; x=1795135065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8LSEo0mNhx+TMG62Egyknhrrk3n9oM++PyBFHpR6AXg=;
        b=YrUfbkvRor6M+7mjB5j0TG/memu7CSrlkcJMnKFMHN/MoO7/yUamz5dL43ymRdV6AV
         H2iX3ZSyBB4JnRfQTuYYQKLNh8p6XgHE/iLIbCNg3XZQ8xgsAZRJQ+klwfslVUKotkIF
         0/9d+SgP+zDpFbd5TnNu/YAh1ook7o1NhlZeK63K5z6ksiVHQhGfnn6mwQoDfG9lDMSz
         63XJc7OIj4lp6ZKuwhv4JKfeZaNMokz1e0L8A8e4sJFFb2EXFAwuQvkFpqfXVkVmOP3m
         kyXEY85fyIC4YP65JYywB5vXmkNTqVxXFsCp1aBM8DttfbDi9CReUlYlU1E5fU7PUsBp
         3d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530265; x=1795135065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8LSEo0mNhx+TMG62Egyknhrrk3n9oM++PyBFHpR6AXg=;
        b=knDX9XaG0Pj+rRyvmDU3Sg8VNQHROxsUhewpJIaThFleUgYlKjE1qWnUJ3b6JOUeOK
         UVJDBv/8aZm2Rlgo3qPU1voZnu69fZk8S1FedVMcJycYSNDXXBbO6DMzMPhu6/iSQvAB
         ychh5Xg8onPRKl267+69kusnsX1omidihsE3jbhpv/NTmk2rWmwQCjuDnfczHSKLnf9y
         GGA2zD9DEvmqpDqqgIFAmjdkBsbCn8ysi/tU/7ahkfcShblvxJYqRlBu0Sxvq2OLBl7g
         MD7CrAEjXKru2bp3Z4lCKX3YgMeTv1W1mFI+V34qxovxNtCy23z5qfxlUc0znJWSQVbe
         CjsQ==
X-Forwarded-Encrypted: i=1; AL+hErEY+M+e+9pcKMtgI/v0UljutbTLJGu9CKz/fG5RIHhNwguLjifl2HqzC5d3R2o3nyX1qWEqu/ILYm4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KM23lz81Jsb9fCIVeWd7HcYZA6VTaD3fxGhHSsJ5BkwEC7cSP
	cuQ2WZBW8RiVK21mAeUCVjdPHsuMjwtOpWOY1i7CgzyFfoV+XRX5OpVUZ1HGtka5PBI=
X-Gm-Gg: AYBFou3+fvNpuji4tinIQzvqp0Okf+w4SSuttn4JxUvuv62RICh6tepH9RgG0lL6NFf
	/vcbhrHE7If9ik9QEVxh21/hODGZRigjqrl66NA4A+t7cvXpSr639vPadzif6v2zf06B+xLPFmZ
	5Kwz39LdnKdAvp2MeirSmf6t2DeF5aLTehPYfbV7DKYpSNsSI5hrUXznfTlLWVQ7ZSNQfwVkMwr
	ds5zIrxVpCV7vwvqp2xtFy0cenASz2t90Adsuiz0yRcB7Lr3VwdjeXWt1vwLLRouis8GceuKPNb
	r948z71loNohCYPiWBFd91crgMX/7PtLFA22YW8yQEsmsGGDvJZC75q+XBYH9N0ZgJEgDl033a2
	Ib0JzpZTKskdWxMEcICqBrQiZ4a52bRUvNkC/mgwx+dvicCOOlePw+qMZHYtzhm6OG1yKvBBjTQ
	RNiLLFGHlRaHunIFeK+Y3VJ9uOiPL6OxLCPuvdF6Q6++B6GgGwRkhKLtQq55GD0LOmsouyM6uiD
	KZq97xk6x8bTwwtD5BP7+FZztLgjDiDb2mQW+MixPp5/L2pT40Xq2ePi2Ar/umsoAqDYGlqFAx/
	fKYb/Wn6if9/kmVVWx3JUmnBz5RL/RX+hWX7WBV1IL8MJKWxA+5pQ+ZdkJ1gEwxNNNjt2k11NNT
	Zk83bfvY6WGq/ir5+hs2m5bj11DvjL7Sv8OTl3Vwaey8W2LcMfWusK6ua+Xj2vh9hjiKGKJYcmR
	T1q8r0RfnDC2FIjy8A
X-Received: by 2002:a05:6000:25f1:b0:48a:fba3:d5b1 with SMTP id ffacd0b85a97d-49c7381a73amr2038948f8f.55.1794530265593;
        Thu, 12 Nov 2026 16:37:45 -0800 (PST)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d223a29sm2183440f8f.8.2026.11.12.16.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:37:45 -0800 (PST)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	stefandoesinger@gmail.com,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 20/24] spi: zx: Add ZTE ZX family SPI flash controller driver
Date: Fri, 13 Nov 2026 00:37:44 +0000
Message-ID: <20261113003744.3668464-1-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015-large-mayfly-of-blizzard-bffef6@quoll>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com> <20261014072109.1759502-21-ghahramani.navid@gmail.com> <20261015-large-mayfly-of-blizzard-bffef6@quoll>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Krzysztof Kozlowski wrote:
> Drop such messages from all your code.

I am dropping the SPI driver from my series since Stefan will submit a
driver. I checked the rest of my patches and none of them prints such a
message now.

Best regards,
Navid
