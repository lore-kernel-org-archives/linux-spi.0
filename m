Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794525841;
	b=EmYlhltU7KCxpMIjkMY3k2ZUuYYZZy2MeFVAo1hsRCFxfkQXesxIiTTLqvKNto/2H5Vn
	 B6fODNkWwIJOaIQrahwuUhSYxpWmESi57vzD587f9GIPjKif8dkaEGGnPKubiGslPXKA0
	 XxcCe8wRvkJ8wDu/3I6pOVwP8LJ0SB9NA1Xfts8zIZkCYokbsBEdCNlwupXa3GWrnVY6l
	 AhmRksjTaKSGWRlTsdQTFtfBRUi7X9ceTbJtfV0luCDJrzK/qYrstqqJEH78uVMqi7p7F
	 IzKD+A+4RXLcuHYMti3gO7YGDxBfVsIF0zXnAAhkNIgw2m9t95VAorP8NKXM0i4F73A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794525841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=drls+PXlcGZoLfnoPObObwbc1/HPzgky5rGb/FCeY3w=;
	b=Djlc7mw1gQtmVrxDmDvEB694RZORA9utJ/2HY4iDjNspDrlbohCe9d3dph5t/DZ9+inj
	 uKt5fcMAfMucwbWbjK2ioofziJ0g4iDnSYSsc18V82M/6UbjIyQp2R0mAgU8RfKs2h1yP
	 EYh38D6e8CcFM4LfGsGW7pLKw0OCmmjbOh5VCeqKhswajXZ5FxM56601KFBOzAlSVzqp4
	 vpznCPQCaRrV0xLMqrNy+U0teCUhDpUC0GGaSZ1dbTsQA/QLkglPQ1515lGs55EQF/iTs
	 OJqqozpYhVjvwcMrsexusY0hDIkMoqG0pKKRp60vMD0AhWSXYPwSP4ZXmdiKOjtba3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ausil.us;
	spf=pass smtp.mailfrom=gilmore.net.au;
	dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256 header.s=google header.b=focqTQf7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FAF606A323
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 23:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39FAF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ausil.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gilmore.net.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256 header.s=google header.b=focqTQf7
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-94937a33cfbso47874485a.0
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 15:24:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794525840; cv=none;
        d=google.com; s=arc-20260327;
        b=Pb4LKl0vYtZ8dlepvwsKOfLtac0t03CQSdGW2IGyT8U7v2euopr+2QlEgj/S5cXzdo
         5X0QIEtDw/KltwIaYl4fdmm2QUBf9LTLnL4A38SJ8JTuBX1b42Bxab4ldglLHRhaD29/
         oTiT7eBPbHN+hDX5pwlqyjvOnLZp+/RqjvIsXLbpGi7W9uIO3YlRBlPiGhUnFq8eTBfO
         PWRClGCqTYEJKZ48XoB8Fl9upod5hqwTDm/2TWQqmq9z5jrUzm8UCxUIy/MT/cXXHE5h
         P/AwJp13TK/Dq8ufSk49mrndY+Ol9ps+2d8g5+wfVBUTC5m72AtLlbQ9Xn2zH7cIeQcQ
         tKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=drls+PXlcGZoLfnoPObObwbc1/HPzgky5rGb/FCeY3w=;
        fh=oT4w2wHlWJ0P40yhxsQqFY4vLZ15OlKQXn8phpV4wQ0=;
        b=c8yp8kjan4ZDjQzPUkykID0JkkgS309Ll/BAHjrhLvsgnrx589jhgJbUXZJ7qkBzTn
         pacFl4no7SCpTXoIt3KevB+3MbBFMev0PIxII6bDQMmDDqNPECNcXbwXMHYNPRL5zFAU
         ynY8p9ZJNc/UzjIO4bpA6ehO0tL0OzlDYCS8oQFfKfWJ3qvVYQmWlGJYFgnBzqWXnylD
         mMkeXsxvNWdn5NxUEpBOvCFq4hPyUZu/Q5uEZy3rWoSFKad4NepXC+hBc/2bFzLy5/go
         Ma9peAPuQK1u1qPMktbNVDZRTZK57KLPgK05Crhvc1TNoT7W8o+cBXKAOyzPVRlwrz4V
         MUzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ausil.us; s=google; t=1794525840; x=1795130640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=drls+PXlcGZoLfnoPObObwbc1/HPzgky5rGb/FCeY3w=;
        b=focqTQf7naFVCGV/My2d+xpcLS+yKtintmrypuRzht8YS8h99AlJDL/3AsFgqMzzSq
         LiYGDn8kpDU+Vupp3Eklu4tet98WA+Gg98hsss9HKVRYsSKcuOWLgCqfGsfC9WtJjhFv
         LVwgrg9eok9OlzpqlzH2V2tb6xEKnyNGK9EIbw7aYhPvoo9CRZELkbf0uLrIc2cGVhxU
         6S4QL30WvyiEW8bbRF9PJYgUnokd8ZbLUVvW9iSO395H8jdjvkvbCelBuukjOeNCOIvm
         Fgkyz48jdUU8emc2E0zd2TfHJq+ABdg8by9UYtuG/i481sA94eZ4XT8IFqFFLbKcla+Y
         4srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794525840; x=1795130640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drls+PXlcGZoLfnoPObObwbc1/HPzgky5rGb/FCeY3w=;
        b=WKF01WTt0WVkufML2XWJaJDB0vTYGk0vUCC4gcO6x5dXuAThWRP1vBMfbaE2bjotuV
         GK+6r4A31VANLW58XG0XZ3DBPchFgjGyKMAkMdHZky0iwhK/dW0eySuEFAe34Dc/YT5u
         2AeNMNnuu6cuqnvB/JJnK61QHlT8VItW2M1D2SsNUh2lHfPsx6qt4LbMEja4PdISfQ0+
         WbHZlErPnF4rX5nJg/s87C6Pw6f6DzMgoHe0rov2ThjTOCmKrc7iWfVF1iPyAEC0Wax8
         QJBAMKs1qOZckQm2mjacZWVYfErdpCORxErbt4fsxzDeSHJxiBqjKClZw2LVNavrwuUU
         Ih9Q==
X-Forwarded-Encrypted: i=1; AL+hErFPOIvIztiHuF7TmWZODFG64C8b9HAABjEUjJM4CS0h6ZhI3OrOD95He3ru0ezb/OLsjednK9ZQV9s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oRRS6HcMOucC1Z8oyALz8XlP0JuqtL6HKlPQEPLXI6Unwn6Lg
	u7Mhi7TqdHPWOlhiuZsygBWO79zOW5tfgVZ/t7jJqG3194jWfggvIVifF64tR101eoP04M/BsfI
	E5aIrGGlC73ICOAHu3vLM5GDzAZXqJw6qx5uMY7l3oQ==
X-Gm-Gg: AYBFou2A/9RNefKxG0xX5O51yq5t7+Kxym+vgVsVQk1HRkS1fPsjma0D7xTnJZPoMnL
	/h0DkSBUqoLw0+L2l1AJCNpqOz24wkCxVgH0lleTBEPJiVeq2bfD3ef05gC60yA9Z3AZSNgdJax
	tY66GLtyN45S/aC0inzoseqE1Ro25j4nKiSYkDRF0NITdotYQQlTGlb4KKx+8XMdRvPWUENyNbk
	ucQYTqMi+16Ts4aI8nYsOMZUqvlRq6W2zHQ0jSV8S+HicWhgVt+kcQibEMzCK5sQFOo+U0/Ro03
	rNZbTYYA67/pOSuIHqPpj33XNdqCu/NwDsKXXo/HISnxWhbVDGFHPzWiNM4ekjDgrfQHcZU2Ey0
	SfWcguNOHtBOJKUCHH8UD2xNxW4sNZg/Xm3Oy//AFdfew/aevcQwXzp6cbZqGHKR3r8Kt7PrEkS
	eBOtNgqOTOwjlE7U8G8VtFBEFn
X-Received: by 2002:a05:620a:371b:b0:93f:43a4:a48c with SMTP id
 af79cd13be357-9494bc3a400mr175911185a.45.1794525840268; Thu, 12 Nov 2026
 15:24:00 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112025252.71375-1-dennis@ausil.us> <179448342405.66517.5463730214277229760.b4-review@b4>
In-Reply-To: <179448342405.66517.5463730214277229760.b4-review@b4>
From: Dennis Gilmore <dennis@ausil.us>
Date: Thu, 12 Nov 2026 17:23:47 -0600
X-Gm-Features: AclHuK84GnsbCUnbGFWAfzcRIsf9sLCdYOCcLTFaLBRnNzS4e4KBe3sc65us-XE
Message-ID: <CAABkxwsn9bkx37C1oEuMC1o+5Jtf+EnJgw5o7pso8hGxxJx34w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: soc-core: start rtd->num_components at zero
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, kees@kernel.org, 
	gustavoars@kernel.org, linux-sound@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com, 
	linux-spi@vger.kernel.org, miriam.rachel.korenblit@intel.com, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 5:37=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> > Since the conversion to devm_kzalloc_flex(), the allocator sets the
> > __counted_by() counter num_components to the allocated length
> > (num_cpus + num_codecs + num_platforms). This only happens when the
> > compiler supports __builtin_counted_by_ref() (GCC 16 here). With
> > older compilers the counter stays zero, as before.
>
> This doesn't apply against current code, I think this is an issue that
> was already fixed.  Please check and resend if it's still needed.

Looks like it was already fixed in
https://lore.kernel.org/all/20261109102536.357134-1-ghidoliemanuele@gmail.c=
om/
I missed that when looking.

> --
> Mark Brown <broonie@kernel.org>
