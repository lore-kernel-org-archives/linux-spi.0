Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC143F8CD
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038153; cv=none; b=rvwgdLD5U8nHBw5sPR4xSKxVSS2zeZBNJHH+HOQS0wYEk55ZLo1mXmf8/lVWazcjBqA3yvGpF7A0egCk72bslHyhchqCONOO/fSa/zUx0fvP3u5e6Z9AlH7E1DqnDBqI1/IjqcE2fkjux0Mo2PG5pp0PIgr/jaoOV7yimUYmVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038153; c=relaxed/simple;
	bh=BGRYlrnoFoQ7pTW/B6UO0vhkm8Syrp7s+4wn/p0wjTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrTu54y6SOv0Atvs+UGawbI1R4A2RuyM4EqLjMeMAOmohDZr0OBeza4EaR65aDHdwN49nY+5+RvsrQ+82/dx/YAq4btIGclYhQiXTzrOFpJBDTNza+qeIC3lZG6u5BOslvu5rWTVGb9YE0vuEG9GeNC5oFfsrBcCazi7btwf+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TZ6/7oHl; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TZ6/7oHl"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6611669cd16so1092713d50.0
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784038145; x=1784642945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0vTFWLl+1C9GbVj2qTXjd3Iocy6meSou3dtpLRYspA=;
        b=TZ6/7oHlv7SHIl3jwjl/TaOzZxemPA4We5ndd9FWQgvEqS2MSCL+HQ757oY3Cb0kty
         xQD/GXJQ6DCP6x2yEW0I0phRyK+ExtQBfc3JlpFtsJVUbFqgjGV6wyfLnOP+YuxRnfHq
         kTJsbnPPX3SCyf0GKF+glaCXLtRTcqfXc6jvMahoaXqgevzVJR7OCZAbwdqybUePZ6eP
         ohiQBafCMVxdfnED3YD73n8w5CNX1Gh+bGmXIcWXznGzIe7qB16UQgKzDcFCmlccihgh
         KWBTPHl0wlMpejSNe8RJrLGFNcA+UOrab7CbCu6ZjaU9hz3uanh/vksF9W9PKepxw021
         jqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784038145; x=1784642945;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m0vTFWLl+1C9GbVj2qTXjd3Iocy6meSou3dtpLRYspA=;
        b=jJuus3sUPjRuMabyVfvCfAwi91lPz5KDmP9DVsgzx6ve7mnPfspfXyRom+x8lLYBYG
         LU6ZPzAsgXo1GwCu+m6Nfw+JL2ECHWZUQ6Xl1UGRN1TP8m3K3AuQJhwBAaAOfMEcrQAl
         Oz+NDkhMxTM0aFgsbbhjdzvlZu2maUco+M+YnwzuffQsHjhq1/dByF1jDFNhbNlGMvCB
         /ZRwWuSc2Tl3Z4wvcEq9CbmdJIl3sqwmDQZSpWcCXuq/E5BVJnDf+7Fb7G9jokvf4B5P
         24a+JymwBzrVTHLp6Mu+ID4PBgcg8nyhyA9YO8M2Ww6EnFivaQo9nrFpb0nfXl2uNOBQ
         B3AA==
X-Gm-Message-State: AOJu0YyKRhc540wn7r6vRXmjRCK/XPbWKWSaf+dctGQosPRwf1+sqYVc
	iUYzTAfU8x1LhPlqC4q+ZH1lJ66eZFovVYvQoe7dJ1mPi0RygwpPHXF/yXxXkDfPtiU=
X-Gm-Gg: AfdE7cmtq6ojZMMgcHq2WkPnhWq29+yvdZDft8I1gMw6g1+Mh9szlgAHROgN9HYFkF4
	Y9gczbv2+szp6NnqKFf9pe6zFjTVWVdZchQAod2eM3nRVJqfrxJH0rqMGfzdBcbjQ9kmfb8HEPk
	USF0lsOQx30i9WehSPRyjr0wBbSyeJDRoX/Lcu0sApGD4CN4ZtC94uNelspJ/Tn9rG8MlV7tBCn
	ht2+QY0EPYA4UApNFksjcsJvFkXRz3XW9oJEY8a56ce8wl62FCJRFCLY0XD1CxX3TOhquCOGHip
	qNuf0H9td2Xy+4eJI+9KwLO5yLVX19tc7tn0dzXgYL/1NhsbHD1tchQGfLP5XRfZyBt87EdHSay
	Epfn0fUwfRGJntg+J2eGQxTsx80SJWdvjibwsjjUbMdrG3TZY9Y11cupwmshkWPNpJUUT7YwKuZ
	EGC78MKlKugxm7xLY8eS4Vc4uNjpEUKi4dZGP7JjpZsx3fpQ+/BSVDrTmPbVkTjpw=
X-Received: by 2002:a05:690e:bce:b0:667:9fe4:8d7c with SMTP id 956f58d0204a3-667d7c7b6bfmr8476073d50.90.1784038144687;
        Tue, 14 Jul 2026 07:09:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:280e:69fd:7612:d5a9? ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667877a2db1sm16321661d50.6.2026.07.14.07.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 07:09:03 -0700 (PDT)
Message-ID: <6cf508ec-c139-4969-9342-d5b6717bde21@baylibre.com>
Date: Tue, 14 Jul 2026 09:09:02 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] spi: add multi-CS and per-transfer lane mask support
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, michael.hennerich@analog.com, broonie@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, andy@kernel.org
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <alX58XKU2iD3x9y1@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <alX58XKU2iD3x9y1@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/26 3:57 AM, Andy Shevchenko wrote:
> On Tue, Jul 14, 2026 at 02:55:31AM -0300, Jonathan Santos wrote:
>> This series introduces two SPI subsystem features: per-transfer chipselect
>> masks and multi-CS device support. Together they address the multi-device
>> setup described in [1] and the limitation noted in [2], where no SPI
>> controller completely handles logical chip selects beyond the first one.
>>
>> The first part of the set addresses multi-CS support. Some SPI controllers
>> can assert multiple chip selects simultaneously, but the existing code
>> hardcoded CS index 0 in both spi_set_cs() and of_spi_parse_dt(),
>> preventing this from working.
>>
>> The second part addresses dynamic lane selection for STRIPE mode. In
>> SPI_MULTI_LANE_MODE_STRIPE, all available lanes are currently always
>> active. Some peripherals need to select a different subset of rx/tx lanes
>> per transfer. New fields are added to the spi_transfer struct to allow
>> drivers to specify which lanes to use for each transfer. The documentation
>> is also updated to describe this new behavior.
> 
>> [1]: https://lore.kernel.org/linux-iio/af0EGv172ZMl%2F6N5@JSANTO12-L01.ad.analog.com/T/#t
>> [2]: https://lore.kernel.org/all/20250915183725.219473-1-jonas.gorski@gmail.com/
> 
> Mark usually "merges" a series like this and cover letter goes as merge commit
> message. With that in mind, can we use Link tags for the above? Like
> 
> Link: ... [1]
> Link: ... [2]
> 

Beware, that would cause b4 to add the links to every patch in the series.

