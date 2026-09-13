Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525973438BE
	for <linux-spi@vger.kernel.org>; Sun, 13 Sep 2026 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331523; cv=pass; b=cOW5exi5Xq4j3XrbMRgYFWSZuAUP+U0FKm9e4L3yavIOS5oiodKMIGzxI0IlKgMY6+c5YnylPSs9JWRoW3b/CD5le4O1bdaV5xO43EWhOgcwaBjpSozpF23SsV59dTY/mrPRr2R1IT9w75i4lruFYQ0Xwbib2ss8eIsRiOpTJAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331523; c=relaxed/simple;
	bh=YqPuY8bjxg2PMPBTTRCR7VVhfztLYnhGPDT7UUbH0mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOLRwE7rYzgaCyK4gYdGM8hNLJ5m5CAieWbqN4p/nsmsmMtI/oeccYi1oJ7Q3Iv3VrNVlVSrbnAhFMoCZFo48VkDlDENy0ORUuLmYXkFZbcgBFRjkI+tRbTwjvUudYIYSO8BXmjxK2ngCJAPCPl9xY7QILX2gfre63/Or+DIk1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlEsPGDk; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlEsPGDk"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2949ed8cc3so430192766b.2
        for <linux-spi@vger.kernel.org>; Sun, 13 Sep 2026 13:31:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789331516; cv=none;
        d=google.com; s=arc-20260327;
        b=I2d/3plF/EhkkPb2t9tX7yzsvy8IHGYP1DnZyiRk97J1DUFGKqugQJaBoj+5NgoYM+
         gVwJWrSmlGcF7xNeLPJqP18eNkVCcqz24GwIQhaDUJrqWAIrcuksQEupuu2lZGcmlvkb
         5VYDXzZfrF0IiRHxeUr9i+q9OJKOPtdyv+0XQdtIPp19f4Jb/eiLKnWm5DxoWLu8lDjm
         htw49fmtQA0riZomjhO2aZlgrOYsy/BNjl81lCaxdp4tU5izp9VKD48t1+faQcfvIPBs
         FZ/UJbJFWfzW6Gk4v4J/a4G7gsHMytolAFGUbM9S7lP0OejJuFDFSb1xxNzEmuhg4DcR
         ju4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YqPuY8bjxg2PMPBTTRCR7VVhfztLYnhGPDT7UUbH0mI=;
        fh=VetNZ39ibfUvvtKhnHwzerzhrVGC80Xae8wfhvuBqCw=;
        b=mAei3sF/STs4ETLwiEkJifMkoiGBs2Qq94MJHZY8JGihDGaLksIHBnLkSZP7lzB8mW
         2etaK5m7bScYZde2Hh6zgGK4A89m2dJjgriirZzM9tGJlYZRIxNxthkK383M+Rgx9WeP
         4mhxKqbMnGZfxERhRnQGjAV1MaE0kyHM/y3ZAs1wOoOsm6Ij3VUOrZEy2Uthf8gLDzy1
         /bcXq9r1NXW7Mq3wczjJx/X1BKrGE0ETLmKwkWKcoMQufxRzbsnnTW8/NuB8xZ7eeqg+
         Z/+sGlP2CUhJvoSWH5XCzil/g//Wlfk7xnI0IMbIJSzwWBmZs/Mh35v8UoVYi7+flUWV
         cg2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331516; x=1789936316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YqPuY8bjxg2PMPBTTRCR7VVhfztLYnhGPDT7UUbH0mI=;
        b=XlEsPGDkX+T0oZxerVgd3xTeyvFY5JPlqU7qEx6dUbN1pUtnDbM0tIZI76TsIkalim
         wirEo2SANyM09D1pFvZwwmX3Iqc7Tqprqf0zRcn68v+9UXrqFNqAyMAfxfdAFoABOpvd
         KDYEVN1lkxbNKLom25bT2plJ2K5E3B0l7SUsFVOD0jE6mRyHK+a5VJOgPSnXCnQ9fak8
         yKEcHIrByb6An66FgSubzpQ/Nww0o/p4g75ioD2/CKAtSJOn0KcXUCrvi1Qwc6eLW7Pj
         8Bw8LAQi9W+ronKyYApcPP7Q9m5XCJ23coKT/OzSEdL2kPUcjkhAiogSoG/TJilUeZjX
         Txew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331516; x=1789936316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YqPuY8bjxg2PMPBTTRCR7VVhfztLYnhGPDT7UUbH0mI=;
        b=AIhXkjmqMpj0E4QLR+idZ+SdOUgOLnVMR7YH/CQLmmGAndCU+NQmI0sxt6lOygEgZ3
         yXayFYdAvtx1lgR5Q9SB2ZX1DMP62NwKeN29z92/CkxgyBhC6AobvGuGNYkcfxsGNd1t
         lG7FHaJyLos14Xf7AYY+jW8OqK2iJN/3fwsN+c1tTglaAxoJC2RSn+B6N0k4iOAJO9lj
         aRs4kjhTiF/zd8JZzyTsHDbV9Sf3YU5V6DzHIfy6b+t2EP5o5beo6y0HSxQtK+Pz1MYE
         FLWNeW+gDlxIyB9qPgML0g2jBbsatFhIlA4fBAWfkTeBw36dfVJl64jHd6W1QaUjFDuP
         0SJA==
X-Forwarded-Encrypted: i=1; AKwUvBxaTlCfvh95hj3CO/DS2AJox8gMxFw5QdOMkaO6UmTFWus+G1AjU1bRgeJek4p72UhRrdBEUVUAYLs=@vger.kernel.org
X-Gm-Message-State: AFuF++nFfN0Xf5F78VEjM0Uz0gstg9klAX7FMvACay36sPYLhJLMHEyB
	Za2NnZALg9mJnc9pG1HwZloRaPEvdx0SL5FkYC7fDmZ1HR0nl2HilEy8H88gaPgR7jatetNcOfq
	JxpBlmE4VKRVKa3oDm6tenerhWbcHeA==
X-Gm-Gg: AYBFou2t80WSfUWCjrOf7cfz7iMsBHbnBwD7K+JMEufxjV2J1E0ScdWyJOOaXh8383+
	aN9BYeizuV0qBzfLOW0pff69p6jbBpE+E0qLDOWaZhg2G3WIwHuhxUwKMFD9OUQzeaEhw9rU7jz
	RJwbTWwY1IsmEWK35Q8uk8VcwieY7PbM+L7eCBKBZMMeUofP9L2AomqAZYiFadafwNskZJuTSCu
	t3SQHt6/ZeG0Ts5b4dgawCQdnBfgobH/y//zAt0YfZDTk5IRFzMb1ZkNKQVGiUxEycZFI1UduW6
	hnZZSEDzkN75jlPpSsOU5AssmvBAETUrQoiRtLtZ1Ewol2lsXLGYGZasrODfDtduZ8FR8h4zBiP
	d9ADJeClOVUkWEbR1tRGjEEfvmhq2xHuzNIRqcBPtxMwI8jJuHRmXkwyXdMYQKmxB9w==
X-Received: by 2002:a17:906:c143:b0:c29:4204:8dbf with SMTP id
 a640c23a62f3a-c2966559aadmr741799066b.7.1789331515865; Sun, 13 Sep 2026
 13:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aqRM17TZ0-5pd6Y0@sirena.org.uk> <20260912190056.42192-1-mhun512@gmail.com>
 <aqaKPEFt7fQe8QQp@sirena.org.uk>
In-Reply-To: <aqaKPEFt7fQe8QQp@sirena.org.uk>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sun, 13 Sep 2026 16:31:43 -0400
X-Gm-Features: AcwNN1XzcLLgpV1RUYtG_pNLmmim_sFz6TTENWG2NHxxEf0dq49kcafrryEazGg
Message-ID: <CAGEsz8Gy5=4msSzPjvRAS88EEbZ0eRvpocu6iHQWv8-48J0dkA@mail.gmail.com>
Subject: Re: [PATCH v2] spi: rockchip-sfc: skip DMA cleanup in PIO mode
To: Mark Brown <broonie@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry about that. I'll send future revisions as new threads.


2026=EB=85=84 9=EC=9B=94 13=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 7:34, M=
ark Brown <broonie@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, Sep 12, 2026 at 03:00:56PM -0400, Myeonghun Pak wrote:
> > With rockchip,sfc-no-dma, probe skips allocating and mapping the transf=
er
> > buffer. However, controller registration failure and driver removal sti=
ll
> > call dma_unmap_single() for that nonexistent mapping.
>
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.
