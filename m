Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B48923A9AD
	for <linux-spi@vger.kernel.org>; Thu,  2 Apr 2026 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775094858; cv=pass; b=KmPc3cipCXKVtntOz6Q73WvUHx3N76rUh2Sof33w4+Nq/aZ6m2ZfeXNfIoCkOnw1jO2saq5KrV68qvGND4/EqC/oS2L515BcYXX7j8i2EDwUG+upuSrDL4tm+yMzGiC719U5ad1eL73LqoUcXQx2jHKGw2JcEE+H0q8iTITHujo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775094858; c=relaxed/simple;
	bh=ZgdAy4qNSHyKJtotTutzlKM7jv1dqpgGb4Vak3LPpxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTnfwG9cOA8G//WTZlu/CS95r9uQedOFNE/G6/hL2rghugvS3K4cZHOH4bP/DkdKFtBA0WVLiVAWk34TefUnrvnqFA6SKYjHgCiow1Jcudr0kD+Gsi7IhmK9+p6PrQVRdppp3+SicHrgXJmlmQZ+h1daCrHhk9rZRUmg3p6HbvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ww7PwDxv; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ww7PwDxv"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65006c99d38so416087d50.3
        for <linux-spi@vger.kernel.org>; Wed, 01 Apr 2026 18:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775094855; cv=none;
        d=google.com; s=arc-20240605;
        b=XJUkLrZY3pCykO50ymGzfOnRjPdK0ttPD62Ck5RK15Hs2KXKaTUo08A7pafCQynk0g
         ptk8ypAmGhP68OgC2RbYFW47JcpS9MUZmO0XL1CyWfZXEeGA/GTWonQOrqMdVgdU4UZ0
         72GzJqkkD4+pBzRST+fiTF7IPuoS58xLr5NTn6IjQpaVViIyE28d6japOuspsZWfNqot
         9y0pG7NaTh8fFUrPdUmJ/6PcUk3t+NAdg42XnRfAg2iCVykcuZ+4aPJO3jLIm/24zdmK
         /oywNf8BJj1UR5URnG6QJMcJwyFoXiPXQB/NQ+OGcJKHGna/wEAbnXLHBi8XCYcAvLkk
         RuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kiceuLyx91rPyzndVsPjUqGeAIHXDkrelSUnbkKBTJU=;
        fh=LAysa0ilXHF8pFtBfy3FPb/H3v5UpUl3q9sqFqOC1sc=;
        b=SgNVjESH2FkIFKxMulSXiMTdkXIiPDm5iK0oPedh8rz9VVNGHc2MvA0Zm1FN3IrlKp
         CKihJbduAqt5shgQW6yj0XYuCMAi5xPPCB2L+PUdnY//E1//89xA3H+6/iaCcHrFemUM
         w9FPJH/a9Py9c18r9xzH7bV2pMsDm+JlZErfgxWm1zHnD8sRfft1o9/jz0haIxmoq/WE
         yLRF5oF+KaZPh/XtGVskHi4E2IMwjz6AFmIWSKZje2LCJHtX9A6oI5uMJ2mz0wxrNi2D
         yMgajSiM8ZlOBygCdAeFTIW/gnu2fb5Mj0B+GPoiHQt5k3LjGRVqdTaJiuT8JzRO9WHO
         eQhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775094855; x=1775699655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiceuLyx91rPyzndVsPjUqGeAIHXDkrelSUnbkKBTJU=;
        b=Ww7PwDxv5MVp3tsNlTeE3CT0Oz5MhiebXjUc4q6rFMf/GmFYPBDczuil0bH3TBySVW
         cQ7fkOrw3Fs2HWzDJLfsnjY/hZHPdGI6yfTW7uszLmZv0eLNZdu2a/xGZzT5b/Uebxp/
         Dl/sKqbTT84G8zvSDyy7UpAWWhRqTBa6rXzvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775094855; x=1775699655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiceuLyx91rPyzndVsPjUqGeAIHXDkrelSUnbkKBTJU=;
        b=AeoR2X3XrjEpRVUccpdyZfWKt1Zzi1CFUdGGz9Xo2fh236FYY1s4EXXRPtDUl6Uj8P
         WEixStNKenPFDgRsD5mO5owDG4rGduj1gpk3JHuUsSWy9B53jdiknGrLhqrZF/wtBxt/
         L29DXOiS9AYX8XrehE0ApD3aDqXtmPQkDmLqnm1ZdyymtQuEYHOrTdHA5EpI/syAnlSD
         YKgSNlZ6fZ5TIOMJC94SKdIjFfJbAhhV3La1WwHq3YmsdME0jEVHAurKYxkV1Kl5N6Q1
         ZFWfDQFJxcyyNd/A0s+CPr5LFsI2Is0v/1JiPp1/FIGCJilAxeYJk0obQy229CGb51vX
         9Hcg==
X-Forwarded-Encrypted: i=1; AJvYcCXthISWRTnEAZrIJFp7HbV3XbHTemXf5rNzfsN790yMI7C92rsqF/hebQSP/GJfeEijFrTL6uxBBn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYu8GjXcLvrnYwOWNTgWhm9Faq0vTzIYzgTbuOr8pw3j91PDw
	qheVY/DJ8u9odVRVLFh8BDx9JPxO54bGTDiEpYcRAHDpkjiFJyjSo7Gi+ZQF+t+B0YyDXGoEbYC
	aoUwT4Q9KJn2UFj5DwNWQlXiwXpbpL/ZeFIhIBwbe
X-Gm-Gg: AeBDieuBvt50JG+5IPgVvYLQ8+zYPuKxVdhleMOQMx7BxKqFtkMriyGgCxVdOAoPbc4
	kqHwM43aCCbkFLa/sYbM/ZrEV3CPRYWN3RB6mvPXzWvQFiWVK4DOWqqAUg0nCoO04tmC354f4a2
	MV4Fv93XNlHp90E1xcAuESaEtjeXzUwLGbMaoXV290HsPZR2PzBvaiKyQMzJCDfTScEVqzruT2K
	3SqzUJSkrLI8sQNV2FoUW7ZryNtib0ZwrxK1KECkvhHgKa7CmhUfUhbDpwI0VbgrLcMP3XHV4fR
	Ork2+DziMbQE7K+7unFSMk5s0FKZu38+uap+EEixcg==
X-Received: by 2002:a53:df45:0:b0:64e:abca:564a with SMTP id
 956f58d0204a3-6502fdd0ac9mr5063421d50.22.1775094855220; Wed, 01 Apr 2026
 18:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org> <20260325-naughty-hungry-wapiti-658e83@quoll>
In-Reply-To: <20260325-naughty-hungry-wapiti-658e83@quoll>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Wed, 1 Apr 2026 18:54:03 -0700
X-Gm-Features: AQROBzDfrwBIaLEV9wnEuLry8lUVCQVrP4uxpF2MQpcY1Q98CokyJ5Vf0yATg4k
Message-ID: <CAEe3GZFWiUG5ET2oQ42+KvO-TMy2Eq02tR0UMaTbACJ0=V8D0A@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Add spi-hid transport driver
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
	Jarrett Schultz <jaschultz@microsoft.com>, Dmitry Antipov <dmanti@microsoft.com>, 
	Angela Czubak <acz@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 1:49=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Mar 24, 2026 at 06:39:33AM +0000, Jingyuan Liang wrote:
> > This series picks up the spi-hid driver work originally started by
> > Microsoft. The patch breakdown has been modified and the implementation
> > has been refactored to address upstream feedback and testing issues. We
> > are submitting this as a new series while keeping the original sign-off
> > chain to reflect the history.
> >
> > Same as the original series, there is a change to HID documentation, so=
me
> > HID core changes to support a SPI device, the SPI HID transport driver,
> > and HID over SPI Device Tree binding. We have added the HID over SPI AC=
PI
> > support, power management, panel follower, and quirks for Ilitek touch
> > controllers.
> >
> > Original authors: Jarrett Schultz <jaschultz@microsoft.com>,
> >                 Dmitry Antipov <dmanti@microsoft.com>
> > Link: https://lore.kernel.org/r/86b63b7b-afda-d7f4-7bfa-175085d5a8ef@gm=
ail.com
> >
> > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> > ---
> > Changes in v2:
> > - Fix style problems and remove unnecessary fields from the DT binding =
file
>
> Style and removal? So other comments were skipped?
>
> Please write detailed changelogs, otherwise it feels you just ignore
> parts of the feedback.
>
> Best regards,
> Krzysztof
>

Comments are either resolved or awaiting further confirmation. I will
add more details
to v2 changelog in v3.
